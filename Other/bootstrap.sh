#!/usr/bin/env bash
echo ">>> Adding PHP7/HAproxy repo and updating aptitude"
apt-get install software-properties-common
apt-get install python-software-properties
add-apt-repository ppa:ondrej/php
add-apt-repository ppa:vbernat/haproxy-1.6
apt-get update
apt-get install liblua5.3-0
apt-get install haproxy
service haproxy stop
apt-get install git -y
apt-get install zip unzip

echo ">>> Installing Apache and PHP7"
apt-get install -y apache2
apt-get install -y libapache2-mod-php7.0 libqdbm14 libssl1.0.0 php-common php7.0-cli php7.0-common php7.0-json php7.0-opcache php7.0-readline php7.0-mysql php-memcached php7.0-curl php7.0-gd php7.0-intl php7.0-sybase php7.0-odbc php7.0-xml php7.0-mcrypt php7.0-mbstring php7.0-zip php7.0-pgsql

#echo "Update PHP to 7.1"

#service apache2 stop
#sudo apt-get install php7.1 php7.1-common
#sudo apt-get install php7.1-curl php7.1-xml php7.1-zip php7.1-gd php7.1-mysql php7.1-mbstring

php -v

#sudo apt-get purge php7.0 php7.0-common

#a2enmod php7.1

cat > /etc/php/7.0/apache2/conf.d/100-phpapi.ini <<EOD
include_path = ".:/var/www/api"
EOD

cp /etc/php/7.0/apache2/conf.d/100-phpapi.ini /etc/php/7.0/cli/php.ini

rm -rf /var/www/html
ln -fs /vagrant /var/www/html
ln -fs /var/www/html/api /var/www/api
service apache2 restart
a2enmod rewrite
a2enmod headers

cp /etc/apache2/ports.conf /etc/apache2/ports.conf.old
cat > /etc/apache2/ports.conf <<EOD
Listen 8081
EOD

cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.old
cat > /etc/apache2/sites-available/000-default.conf <<EOD
<VirtualHost 0.0.0.0:8081>
  DocumentRoot /var/www/html
  SetEnv PHP_ENV dev
  Header set Access-Control-Allow-Origin "*"
  Header set Access-Control-Allow-Headers "authorization, sso, Content-Type"
  Header set Access-Control-Allow-Methods "GET,POST,PUT,DELETE,PATCH,OPTIONS"

  <Directory /var/www/html>
    Options FollowSymLinks
    AllowOverride All
    Order allow,deny
    Allow from all
  </Directory>

  <Directory /var/www/html/ams/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    SetEnv PHP_ENV dev
    RewriteEngine On

    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [QSA,L]
  </Directory>

  <Directory /var/www/html/login/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    SetEnv PHP_ENV dev
    RewriteEngine On

    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [QSA,L]
  </Directory>

  <Directory /var/www/html/annual_meeting/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    SetEnv PHP_ENV dev
    RewriteEngine On

    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [QSA,L]
  </Directory>

  <Directory /var/www/html/playbook/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    SetEnv PHP_ENV dev
    RewriteEngine On

    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [QSA,L]
  </Directory>

   <Directory /var/www/html/cod/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    SetEnv PHP_ENV dev
    RewriteEngine On

    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [QSA,L]
  </Directory>

   <Directory /var/www/html/cme_quiz/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    SetEnv PHP_ENV dev
    RewriteEngine On

    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [QSA,L]
  </Directory>

 <Directory /var/www/html/committee_vol_search/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    SetEnv PHP_ENV dev
    RewriteEngine On

    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [QSA,L]
  </Directory>

 <Directory /var/www/html/image-viewer/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    SetEnv PHP_ENV dev
    RewriteEngine On

    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [QSA,L]
  </Directory>

  <Directory /var/www/html/luxid/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    SetEnv PHP_ENV dev
    RewriteEngine On

    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [QSA,L]
  </Directory>

  <Directory /var/www/html/rep/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    SetEnv PHP_ENV dev
    RewriteEngine On

    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [QSA,L]
  </Directory>

  <Directory /var/www/html/cases/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    SetEnv PHP_ENV dev
    RewriteEngine On

    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [QSA,L]
  </Directory>

  RewriteEngine On

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined

  # For most configuration files from conf-available/, which are
  # enabled or disabled at a global level, it is possible to
  # include a line for only one particular virtual host. For example the
  # following line enables the CGI configuration for this host only
  # after it has been globally disabled with "a2disconf".
  #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
EOD
chmod -c 777 /etc/php/7.0/apache2/conf.d/100-phpapi.ini

service apache2 restart

echo ">>> creating cert directory and self signed wildcard"
mkdir /etc/ssl/rsna.org/
cd /etc/ssl/rsna.org/
openssl req \
    -newkey rsa:2048 \
    -x509 \
    -nodes \
    -keyout "/etc/ssl/rsna.org/rsna.org.key" \
    -new \
    -out "/etc/ssl/rsna.org/rsna.org.crt" \
    -subj /CN=*.rsna.org \
    -reqexts SAN \
    -extensions SAN \
    -config <(cat /etc/ssl/openssl.cnf <(printf '[SAN]\nsubjectAltName=DNS:*.rsna.org')) \
    -sha256 \
    -days 365
cat /etc/ssl/rsna.org/rsna.org.crt /etc/ssl/rsna.org/rsna.org.key | sudo tee /etc/ssl/rsna.org/rsna.org.pem

mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.old
echo ">>> writing haproxy config file"
cat > /etc/haproxy/haproxy.cfg <<EOD
global
    daemon
    maxconn 256
defaults
    mode http
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms
frontend http-in
    bind 0.0.0.0:80
    bind 0.0.0.0:443 ssl crt /etc/ssl/rsna.org/rsna.org.pem
    redirect scheme https if !{ ssl_fc }
    default_backend webservers
backend webservers
    option forwardfor
    server localhost 127.0.0.1:8081  check
EOD
echo ">>> Restarting HAproxy" # and apache server"
service haproxy start
service apache2 restart
# INSTALL COMPOSER
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# INSTALL PHP UNIT
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
mv phpunit.phar /usr/local/bin/phpunit

# INSTALL WATCHER FOR TESTING
sudo gem install watchr

# display IP address
ifconfig eth1 | grep "inet addr"
echo ">>>>>>>> YOUR IP ADDRESS IS $	 <<<<<<<<<<<<<"
ifconfig eth1 | grep "inet addr"
echo ">>> All set!"