---
title: Create your own private egg repository on amazon EC2
layout: post
categories: Python
---

I want a private Python egg repository (basic authentication) and I want it on
the cloud. Let's see how it goes.

## Intro

We are starting to do more plone development. I started to learn and use
[jarn.mkrelease](http://pypi.python.org/pypi/jarn.mkrelease) so I can properly
package my code and publish it on PyPI and re-use in different projects. But
I've yet to solve the problem of non-public code. So I found that
[`zc.buildout` might be able to open a pasword protected URL]
(http://stackoverflow.com/questions/4066571/using-custom-packages-on-my-python-project).

The idea is simple: setup a private package repository (a simple web server,
with a directory listing that's pasword protected) and use zest.releaser to
upload eggs to the webserver using sftp, scp or something like that.

The web server can be anywere, so I created one on AWS.

## Building the webserver

So I went to create a new account on Amazon EC2 in order to take advantage of
the Free Usage Tier that's already available.

Once I finished the process, It was time to select the AMI. I had to read
through Ubuntu's [EC2 Starters Guide](https://help.ubuntu.com/community/EC2StartersGuide) 
to figure out which AMI to install.
Copying and Pasting Ubuntu's Amazon ID into the "Community AMIs" search box
helped me to narrow the possible options. So, just for the fun of it, I
selected the latest natty server image for i386 (ami-0476846d).

All the rest of the steps are very straightforward: setup the server size
(t1.micro), create the server key and configure the firewall (allow SSH, HTTP
and HTTPS). After some seconds the instance is up and running.

This AMI image uses 8GB of EBS storage to "persist" it's configuration. That
leaves me 2 GB for a stand-alone AMI image. I will use this image to store all
the eggs for my private repository.

So I went to "EBS Volumes" in the control panel, created the 2 GB volume (need
to be careful to select the same zone as the AMI EBS storage) and, when
finally available (blue dot), right click on it and select "Attach", select
the AMI instance and the filesystem node and restart the instance.

Next, we need to make the partition and format the new available volume. I
used `cfdisk` to create the partition,

```bash
sudo cfdisk /dev/xvdb
sudo mkfs.ext3 /dev/xvdb1
```

Finally, modify `/etc/fstab` to mount `/dev/xvdb1` onto `/var/www`:

```bash
sudo mkdir /var/www
sudo nano /etc/fstab
cat /etc/fstab | grep -v "#"
proc             /proc   proc    nodev,noexec,nosuid    0       0
LABEL=uec-rootfs /       ext4    defaults               0       0
/dev/xvdb1      /var/www ext3   defaults,noatime,noexec 0       0
```
*Note*: I used noatime option in order to avoid double writes to the EBS volume.

Now it is time to setup the webserver. I like nginx and
[there's a PPA for it](https://launchpad.net/~nginx/+archive/stable).
So this one-liner installs it:

```bash
sudo add-apt-repository ppa:nginx/stable && sudo apt-get update && sudo apt-get -y install nginx
```
Now let's do the nginx configuration. nginx runs as the `www-data` user

I want to have the logs on the separate EBS volume, So, let's change
`/etc/nginx/nginx.conf` and set the the path of the logfiles to:

```nginx
access_log /var/www/logs/access.log;
error_log /var/www/logs/error.log;
```

Then, let's setup the root directory and enable index listing by changing the
lines. For the root directory, I changed this line:

```nginx
root /var/www/webfiles;
```

And to enable index listing I have to modify `/etc/nginx/sites-
available/default` :

```nginx
location / {
 try_files $uri $uri/ /index.html;
 autoindex on;
 }
```

Next, I mannually created the directories that will be used for files and logs.

```bash
sudo mkdir -p /var/www/webfiles
sudo mkdir -p /var/www/logs
```

By default these directories are owned by root, so we have to give permissions
to the ubuntu user in the `webfiles/` directory and permissions to `ww-data` on
`webfiles/`.

```bash
sudo chown -R www-data /var/www/logs/
sudo chown -R ubuntu /var/www/webfiles
```

It's also very wise to create a skeleton directory to hold out packages:

```bash
mkdir -p /var/www/webfiles/public
mkdir -p /var/www/webfiles/private/customerA
mkdir -p /var/www/webfiles/private/customerB
```

Finally restart the nginx server.

```bash
sudo service nginx restart
```

### Assign a DNS Name

I had two options: 1) Add a CNAME record that points to the DNS name of the
EC2-Instance or 2) Allocate 1 Elastic IP, associate/route it to the EC-2
instance and use an A Record.

I choosed option 2 because I want to treat this EC2 Instance as somethig
disposable. The Amazon free tier covers the first 100 remaps for each elastic
IP. I'm pretty sure we will be way below this level. Password-protected
directories on nginx

The repository will have public and private areas. For example:
`http://dist.myserver.com/public` and `http://dist.myserver.com/private`. First,
let's modify `/etc/nginx/sites-available/default` and add the following:

```nginx
location ^~ /private/ {
 autoindex on;
 auth_basic            "Restricted";
 auth_basic_user_file  /etc/nginx/htpasswd;
 }
```

The first line inside the `location` directive turns on automatic indexing. The
second and third line enable the
[basic authentication mechanism of nginx](http://wiki.nginx.org/HttpAuthBasicModule).

To generate the `htpasswd` file we can use [this script](http://trac.edgewall.org/browser/trunk/contrib/htpasswd.py).

```bash
python htpasswd.py -c -b htpasswordfile secretuser supersecretpassword
```

Once generated, copy the htpasswd file to `/etc/nginx` and fix the permissions ...

```bash
sudo chown -R www-data:root htpasswd
sudo chmod 600 htpasswd
```

... create the public and private directorties....

```bash
sudo mkdir /var/www/webfiles/{public,private}
```

.... and restart the webserver.

```bash
sudo service nginx restart
```

## Releasing eggs to the repository

First we need to automate the login procedure to the Amazon EC2 instance.
Normally, I would use this to login without password:

```bash
ssh -i /path/to/server_key.pem ubuntu@myserver.com
```

But some programs might not be able to give you options to include a ssh key.
The solution, then is to tell openssh that it should use that key whenever we
login to myserver.com.

First copy the `.pem` key to `~/.ssh` , then edit `~/.ssh/config` and add the
following lines:

```ssh
Host dist.myserver.com
    IdentityFile ~/.ssh/server_key.pem
```

Now we need to install `jarn.mkrelease`. I used buildout; I just added the
following lines and included mkrelease in the parts section on `[buildout]`.

```ini
[buildout]
parts =
    ...
    mkrelease

[mkrelease]
    recipe = zc.recipe.egg
    eggs = jarn.mkrelease
```

That installs mkrelease in `bin/` directory of buildout. Now it's time to
configure `jarn.mkrelease` to upload eggs to our new repository by adding the
following configuration to `~/.mkrelease`:

```ini
[aliases]
plone =
 pypi
 ploneorg

myserver_public =
 user@dist.myserver.com:/var/www/webfiles/public
clientA =
 user@dist.iservices.com:/var/www/webfiles/private/clientA
```

**Note: Do not forget to create the directorties and set the appropiate
**permissions to `/var/www/webfiles`.

Let's also configure `~/.pypirc` with the information about pypi and plone.org:

```ini
[distutils]
index-servers =
 pypi
 ploneorg

[pypi]
username = mysuer
password = password

[ploneorg]
repository = http://plone.org/products
username = myuser
password = password
```

Finally, in order to release eggs to the different repositories we will use
various commands. So let's suppose we are inside a directory that contains the
code for one egg and it's a git repository:

```bash
cd my.product/
ls
  docs  my  my.product.egg-info README.rst  setup.cfg  setup.py
```

To release to pypi and plone.org:

```bash
bin/mkrelease -T -d pypi .
bin/mkrelease -T -d ploneorg .
```

To release to `myserver_public` :

```bash
bin/mkrelease -T -d myserver_public .
```
And finally, releasing to clientA :

```bash
bin/mkrelease -T -d clientA .
```

## Using the private and public repository

Once you've released your eggs to your public and private repositories, it's
time to use them in your buildout. And turns out to be brain-dead easy.

Public repo:

```ini
[buildout]
find-links =
    ...
    http://dist.myserver.com/public 
```
And for the private repo:

```ini
[buildout]
find-links =
    ...
    http://username:password@dist.myserver.com/private
    http://username:passowrd@dist.myserver.com/private/clientA
```

The End.
