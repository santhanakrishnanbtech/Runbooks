### SSH certificates
With SSH certificates, you generate a certificate authority (CA) and then use this to issue and cryptographically sign certificates 
which can authenticate users to hosts, or hosts to users. You can generate a keypair using the ```ssh-keygen``` command, like this:
```
$ RSA
ssh-keygen -m PEM -t rsa -b 4096 -f host_ca -C "your_email@example.com"
$ RSA -> PEM
openssl rsa -in ~/.ssh/id_rsa -outform pem > id_rsa.pem
chmod 600 id_rsa.pem
```
```shell
$ ssh-keygen -t rsa -b 4096 -f host_ca -C host_ca
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in host_ca.
Your public key has been saved in host_ca.pub.
The key fingerprint is:
SHA256:tltbnMalWg+skhm+VlGLd2xHiVPozyuOPl34WypdEO0 host_ca
The key's randomart image is:
+---[RSA 4096]----+
|              +o.|
|            .+..o|
|           o.o.+ |
|          o o.= E|
|        S  o o=o |
|       ....+ = +.|
|       ..=. %.o.o|
|        *o Oo=.+.|
|       .oo=ooo+..|
+----[SHA256]-----+

$ ls -l
total 8
-rw-------. 1 gus gus 3381 Mar 19 14:30 host_ca
-rw-r--r--. 1 gus gus  737 Mar 19 14:30 host_ca.pub
```
The ```host_ca``` file is the host CA’s private key and should be protected. Don’t give it out to anyone, don’t copy it anywhere, and make sure that as few people have access to it as possible. Ideally, it should live on a machine which doesn’t allow direct access and all certificates should be issued by an automated process.

In addition, it’s best practice to generate and use two separate CAs - one for signing host certificates, one for signing user certificates. This is because you don’t want the same processes that add hosts to your fleet to also be able to add users (and vice versa). Using separate CAs also means that in the event of a private key being compromised, you only need to reissue the certificates for either your hosts or your users, not both at once.

As such, we’ll also generate a ```user_ca``` with this command:
```
$ ssh-keygen -t rsa -b 4096 -f user_ca -C user_ca
```
The ```user_ca``` file is the user CA’s private key and should also be protected in the same way as the host CA’s private key.

### Enforce the use of a bastion host
Another way to improve your SSH security is to enforce the use of a [bastion host](https://en.wikipedia.org/wiki/Bastion_host) - a server which is specifically designed to be the only gateway for access to your infrastructure. Lessening the size of any potential attack surface through the use of firewalls enables you to keep a better eye on who is accessing what.

Switching to the use of a bastion host doesn’t have to be an arduous task, especially if you’re using SSH certificates. By setting up your local ```~/.ssh/config``` file, you can automatically configure all connections to hosts within a certain domain to go through the bastion.

Here’s a very quick example of how to force SSH access to any host in the example.com domain to be routed through a bastion host, ```bastion.example.com```:
```
Host *.example.com
    ProxyJump bastion.example.com
    IdentityFile ~/user-key

Host bastion.example.com
    ProxyJump none
    IdentityFile ~/user-key

Host uat-bastion
    User          ec2-user
    HostName      15.206.127.253
    IdentityFile  ~/.ssh/management.pem
    
Host uat_app_server_0
  User          ec2-user
  HostName      10.0.0.10
  IdentityFile  ~/.ssh/UAT.pem
  ProxyCommand ssh uat-bastion -W %h:%p
```
Once you’re using the bastion host for your connections, you can use ```iptables``` (or another *nix firewall configuration tool of your choosing) on servers behind the bastion to block all other incoming SSH connections. Here’s a rough example using ```iptables```:
```
$ iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
$ iptables -A INPUT -p tcp --dport 22 -s <public IP of the bastion> -j ACCEPT
$ iptables -A INPUT -p tcp --dport 22 -j DROP
```
It’s a good idea to leave a second SSH session connected to the bastion while running these commands so that if you inadvertently input the wrong IP address or command, you should still have working access to the bastion to fix it via the already-established connection.

### Add 2-factor authentication to your SSH logins
2-factor authentication makes it more difficult for bad actors to log into your systems by enforcing the need for two different “factors” or methods to be able to successfully authenticate.

This usually comes down to needing both “something you know” (like a password, or SSH certificate in our example) and “something you have” (like a token from an app installed on your phone, or an SMS with a unique code). One other possibility is requiring the use of “something you are” - for example a fingerprint, or your voice.

In this example, we’ll install the google-authenticator pluggable authentication module, which will require users to input a code from the Google Authenticator app on their phone in order to log in successfully. You can download the app for [iOS](https://apps.apple.com/us/app/google-authenticator/id388497605) here and [Android](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2) here.

#### Install google-authenticator
On RHEL/CentOS based systems, you can install the ```google-authenticator``` module from the EPEL repository:
```
$ sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm # for RHEL/CentOS 7, change for other versions
$ sudo yum install google-authenticator
```
For Debian/Ubuntu-based systems, this is available as the ```libpam-google-authenticator``` package:
```
$ sudo apt-get install libpam-google-authenticator
```
The google-authenticator module has many options you can set which are [documented here](https://github.com/google/google-authenticator-libpam/blob/master/man/google-authenticator.1.md). In the interest of saving time, we are going to use some sane defaults in this example: disallow reuse of the same token twice, issue time-based rather than counter-based codes, and limit the user to a maximum of three logins every 30 seconds. To set up Google 2-factor authentication with these settings, a user should run this command:
```
$ google-authenticator -d -f -t -r 3 -R 30 -W
```
You can also run google-authenticator with no flags and answer some prompts to set up interactively if you prefer.

This will output a QR code that the user can scan with the app on their phone, plus some backup codes which they can use if they lose access to the app. These codes should be stored offline in a secure location.

Scan the generated QR code for your user now with the Google Authenticator app and make sure that you have a 6-digit code displayed. If you need to edit or change any settings in future, or remove the functionality completely, the configuration will be stored under ```~/.google_authenticator```.

#### Configure PAM for 2-factor authentication
To make the system enforce the use of these OTP (one-time password) codes, we’ll first need to edit the PAM configuration for the ```sshd``` service (```/etc/pam.d/sshd```) and add this line to the end of the file:
```
auth required pam_google_authenticator.so nullok
```
The ```nullok``` at the end of this line means that users who don’t have a second factor configured yet will still be allowed to log in so that they can set one up. Once you have 2-factor set up for all your users, you should remove ```nullok``` from this line to properly enforce the use of a second factor.
We also need to change the default authentication methods so that SSH won’t prompt users for a password if they don’t present a 2-factor token. These changes are also made in the ```/etc/pam.d/sshd``` file:

On RHEL/CentOS-based systems, comment out ```auth substack password-auth``` by adding a # to the beginning of the line: ```#auth substack password-auth```
On Debian/Ubuntu-based systems, comment out ```@include common-auth``` by adding a ```#``` to the beginning of the line: ```#@include common-auth```
Save the ```/etc/pam.d/sshd``` file once you’re done.

#### Configure SSH for 2-factor authentication
We also need to tell SSH to require the use of 2-factor authentication. To do this, we make a couple of changes to the ```/etc/ssh/sshd_config``` file.

Firstly, we need to change ```ChallengeResponseAuthentication no``` to ```ChallengeResponseAuthentication yes``` to allow the use of PAM for credentials.

We also need to set the list of acceptable methods for authentication by adding this line to the end of the file (or editing the line if it already exists):
```
AuthenticationMethods publickey,keyboard-interactive
```
This tells SSH that it should require both a public key (which we are going to be satisfying using an SSH certificate) and a keyboard-interactive authentication (which will be provided and satisfied by the ```sshd``` PAM stack). Save the ```/etc/ssh/sshd_config``` file once you’re done.

At this point, you should restart ```sshd``` with ```systemctl restart sshd```. Make sure to leave an SSH connection open so that you can fix any errors if you need to. Restarting SSH will leave existing connections active, but new connections may not be allowed if there is a configuration problem.

#### Test it out
Connect to your bastion host directly and you should see a prompt asking you for your 2-factor code:
```
$ ssh bastion.example.com
Verification code: 
```
Type the code presented by your Google Authenticator app and your login should proceed normally.

If you check the ```sshd``` log with ```journalctl -u sshd```, you should see a line indicating that your login succeeded:
```
Mar 23 16:51:13 ip-172-31-33-142.ec2.internal sshd[29340]: Accepted keyboard-interactive/pam for gus from 1.2.3.4 port 42622 ssh2
```

