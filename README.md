# Nagios-docker
To create nagios docker container running as root and have all required nagios plugins

Before running nagios, make sure below folders are created
```
mkdir /nagios-data
mkdir /nagios-data/nagios
mkdir /nagios-data/log
mkdir /nagios-data/log/archives
chmod -R 0755 /nagios-data/log
```

Change password for admin before login
```
htpasswd -c /nagios-data/nagios/passwd nagiosadmin
```
Make sure all nagios conf files are inside /nagios-data/nagios with the below structure (additional config is in conf.d folder)
```
[root@test ~]# ll /nagios-data/nagios
total 92
-rw-r--r-- 1 root root   12696 May  4 15:56 cgi.cfg
drwxr-xr-x 5 root root    4096 May  4 11:48 conf.d
-rw-r--r-- 1 root root   45682 May  4 11:35 nagios.cfg
drwxrwxr-x 2 root root    4096 May  4 11:49 objects
-rw-r--r-- 1 root apache    50 May  4 14:11 passwd
drwxrwxr-x 2 root root    4096 May  4 10:36 private
[root@test ~]# ll /nagios-data/nagios/objects
total 84
-rw-r--r-- 1 root root 25544 May  4 15:32 commands.cfg
-rw-r--r-- 1 root root  3187 May  4 11:49 contactgroups.cfg
-rw-r--r-- 1 root root  9121 May  4 11:49 contacts.cfg
-rw-r--r-- 1 root root  2657 May  4 11:49 hostgroups.cfg
-rw-r--r-- 1 root root   855 May  4 15:34 misccommands.cfg
-rw-r--r-- 1 root root 18521 May  4 11:49 services.cfg
-rw-r--r-- 1 root root  6970 May  4 11:49 templates.cfg
-rw-r--r-- 1 root root   224 May  4 11:49 timeperiods.cfg
[root@test~]# ll /nagios-data/nagios/private/
total 4
-rw-r----- 1 root root 1335 May  4 10:36 resource.cfg
```
To build the docker image
```
docker build -t nagios .
```
To run the docker image
```
docker run -v /nagios-data/nagios:/etc/nagios -v /nagios-data/log:/var/log/nagios -p 8080:80 -d nagios
```
