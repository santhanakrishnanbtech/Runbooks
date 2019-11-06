# Galera Cluster installation in CentOS 7

# Prerequisites
# Server minimum 1GBRAM, 1CPUCore

# Aplication Details
# MariaDB Version
mysql -e 'show global variables like "version";'
+---------------+----------------+
| Variable_name | Value          |
+---------------+----------------+
| version       | 10.4.9-MariaDB |
+---------------+----------------+

# Server Details
# 192.168.86.133 galera-1 galera-1.example.com
# 192.168.86.134 galera-2 galera-2.example.com
# 192.168.86.135 galera-3 galera-3.example.com

# Updating the server
yum update

# Install syncing software for database synchronization
yum -y install rsync

# Create a repo "mariadb.repo" to install mariadb server
vi /etc/yum.repos.d/mariadb.repo

# MariaDB 10.4 CentOS repository list - created 2019-11-05 15:56 UTC
# http://downloads.mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.4/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1

# Install mariadb server
sudo yum install MariaDB-server MariaDB-client galera-4

# Start the server
systemctl start mariadb

# Configure MariaDB Server
mysql_secure_installation

NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user. If you've just installed MariaDB, and
haven't set the root password yet, you should just press enter here.

Enter current password for root (enter for none):<ROOT-PASSWORD-OF-YOUR-CHOICE>
OK, successfully used password, moving on...

Setting the root password or using the unix_socket ensures that nobody
can log into the MariaDB root user without the proper authorisation.

You already have your root account protected, so you can safely answer 'n'.

Switch to unix_socket authentication [Y/n] n
 ... skipping.

You already have your root account protected, so you can safely answer 'n'.

Change the root password? [Y/n] n
 ... skipping.

By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n] y
 ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n] y
 ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n] y
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n] y
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!

# We stop MariaDB
systemctl stop mariadb

# Configuring the galera cluster
# Backing up the config file
cp /etc/my.cnf.d/server.cnf /etc/my.cnf.d/server.cnf.bak

# Modifying the config file
vi /etc/my.cnf.d/server.cnf

[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
bind-address=0.0.0.0
user=mysql
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
innodb_flush_log_at_trx_commit=0
innodb_buffer_pool_size=128M
binlog_format=ROW
log-error=/var/log/mysqld.log

[galera]
# Mandatory settings
wsrep_on=ON
wsrep_provider=/usr/lib64/galera-4/libgalera_smm.so
wsrep_node_name='galera-1'            # IP-WHERE-YOUR-WORKING ON-ALL-NODES-UNIQUE
wsrep_node_address='192.168.86.133'   # IP-WHERE-YOUR-WORKING ON-ALL-NODES-UNIQUE
wsrep_cluster_name='galera-cluster'   # CLUSTER-NAME-OF-YOUR-CHOICE ON-ALL-NODES-SAME
wsrep_cluster_address="gcomm://192.168.86.133,192.168.86.134,192.168.86.135"
wsrep_provider_options="gcache.size=300M;gcache.page_size=300M"
wsrep_slave_threads=4
wsrep_sst_method=rsync

# NOTE
# MariaDB is stopped on all the nodes
# On Primary server out case "192.168.86.133" we run below
galera_new_cluster

mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 16
Server version: 10.4.9-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> SHOW GLOBAL STATUS LIKE 'wsrep_cluster_size';
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| wsrep_cluster_size | 1     |
+--------------------+-------+
1 row in set (0.001 sec)

MariaDB [(none)]> quit
Bye

# On other servers 192.168.86.134,192.168.86.135 start mariadb
systemctl start mariadb

# On any server please login to mysql and run same command
[root@galera-1 ~]# mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 16
Server version: 10.4.9-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> SHOW GLOBAL STATUS LIKE 'wsrep_cluster_size';
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| wsrep_cluster_size | 3     |
+--------------------+-------+
1 row in set (0.001 sec)

MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
+--------------------+
3 rows in set (0.000 sec)


# On any server we take galera-3 create a databse 192.168.86.135

[root@galera-3 ~]# mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 18
Server version: 10.4.9-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
+--------------------+
3 rows in set (0.002 sec)

MariaDB [(none)]> CREATE DATABASE santhanakrishnan;
Query OK, 1 row affected (0.004 sec)

MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| santhanakrishnan   |
+--------------------+
4 rows in set (0.001 sec)

MariaDB [(none)]> quit
Bye

# Now check in other servers

[root@galera-2 ~]# mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 18
Server version: 10.4.9-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| santhanakrishnan   |
+--------------------+
4 rows in set (0.001 sec)

# Troubleshooting steps
# ---------------------
# When cluster mariadb is restarted the cluster wont start in that case STOP all mariadb service on all nodes and perform below

[root@galera-1 ~]# cat /var/lib/mysql/grastate.dat
# GALERA saved state
version: 2.1
uuid:    9b210f35-0072-11ea-92d1-1ee49517afed
seqno:   -1
safe_to_bootstrap: 0

# Change safe_to_boostrap: 0 to safe_to_boostrap: 1 then restart the cluster service
