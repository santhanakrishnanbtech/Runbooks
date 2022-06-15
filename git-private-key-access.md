##### # git access with private key
```shell
$ touch ~/.ssh/config
$ chmod 644 ~/.ssh/config
$ vim ~/.ssh/config
  Host <hostname-to-call-from-git>
    HostName github.com
    User git
    IdentityFile ~/keys/<path-to-private-key>
```
##### # example
```shell
$ vim ~/.ssh/config
  Host personal
    HostName github.com
    User git
    IdentityFile ~/keys/private-key
```
##### # cloning repository
```shell
$ git clone git@personal:github-username/repository.git
```
