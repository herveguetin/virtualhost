#!/bin/bash
 
# This script creates virtual hosts.
# you should put it under /usr/local/bin/
# and run it with sudo newvhost
 
# Set the path to your localhost
www=/var/www
echo "Enter directory name under $www"
read sn
 
# Create the file with VirtualHost configuration in /etc/apache2/site-available/
echo "<VirtualHost *:80>
        DocumentRoot /var/www/$sn/
        ServerName $sn.local.com
        <Directory /var/www/$sn/>
                # FollowSymlinks is needed for usage with modman
                # MultiViews must be disabled to ensure Magento API works
                Options -Indexes +FollowSymLinks -MultiViews
                ServerSignature Off
                AllowOverride All
                Order allow,deny
                allow from all
        </Directory>
</VirtualHost>" > /etc/apache2/sites-available/$sn
 
 
# Add the host to the hosts file
#echo 127.0.0.1 $sn.local.com >> /etc/hosts
 
 
# Enable the site
a2ensite $sn
 
 
# Reload Apache2
/etc/init.d/apache2 restart
 
echo "Your new site is available at http://$sn.local.com. Please make sure to create /var/www/$sn/ dir if it does not exist yet. "
