apt-get install libmagick-dev libmysqlclient-dev libmagickwand-dev libssl-dev build-essentials

mkdir /opt/redmine24/
chown helpdesk:helpdesk /opt/redmine24/

cd ~
wget http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p353.tar.gz
tar -xzvf ruby-2.0.0-p353.tar.gz
cd ruby-2.0.0-p353/
./configure --prefix=/opt/redmine24/ruby && make && make install

cd /opt/redmine24
wget http://www.redmine.org/releases/redmine-2.4.1.tar.gz
tar -xzvf redmine-2.4.1.tar.gz
cd redmine-2.4.1
/opt/redmine24/ruby/bin/ruby /opt/redmine24/ruby/bin/rake generate_secret_token
/opt/redmine24/ruby/bin/gem install bundler
/opt/redmine24/ruby/bin/bundle install --without development test

../ruby/bin/ruby ../ruby/bin/rake generate_secret_token
../ruby/bin/gem install passenger
../ruby/bin/gem install mysql2

apt-get remove redmine libapache2-mod-passenger
apt-get install libcurl4-openssl-dev apache2-dev libapr1-dev libaprutil1-dev

Configure
---------

Copy /etc/redmine/default/* to config.

database.yml::

    production:
      adapter: mysql2
      database: redmine
      host: localhost
      username: redmine
      password: <super secret>

email.yml::

    production:
       delivery_method: :smtp
       smtp_settings:
          address: "smtp.gmail.com"
          port: '495'
          domain: "???"
          authentication: :plain




RAILS_ENV=production ../ruby/bin/passenger start

Migrate DB
----------

/opt/redmine24/ruby/bin/rake db:migrate RAILS_ENV=production
/opt/redmine24/ruby/bin/rake tmp:cache:clear
/opt/redmine24/ruby/bin/rake tmp:sessions:clear

Configure apache with mod_passenger
------------------------------------

Install mod_passenger::
    apt-get install libapache2-mod-passenger

The config file::

    <VirtualHost *:80>
            RewriteEngine On

            # Redirect any non HTTPS requests to the HTTPS server
            RewriteCond %{SERVER_PORT} ^80$
            RewriteRule ^(.*)$ https://redmine24.myserver.com$1 [L,R]

    </VirtualHost>

    <VirtualHost *:443>
            DocumentRoot /opt/redmine24/redmine-2.4.1/public
            <Directory />
                    Options FollowSymLinks
                    RailsBaseURI /
                    PassengerResolveSymlinksinDocumentRoot on
                    AllowOverride None
            </Directory>

            ErrorLog /error.log

            # Possible values include: debug, info, notice, warn, error, crit,
            # alert, emerg.
            LogLevel warn

            CustomLog /access.log combined

            # enable ssl
            SSLEngine on
            SSLCertificateFile /etc/ssl/certs/helpdesk.myserver.com.crt
            SSLCertificateKeyFile /etc/ssl/private/helpdesk.myserver.com.key
    </VirtualHost>


Copiar configuration.yml.example a configuration.yml
Configurar el path de archivos