#!/bin/bash
cp -a /var/www/domains/netwaymain/billing.netway.co.th/patch/public_html/hbf/components/apiutils/class.apistub.php /var/www/domains/netwaymain/billing.netway.co.th/public_html/hbf/components/apiutils/;
php /var/www/domains/netwaymain/billing.netway.co.th/migrate/migrate_script.php;

if [ ! -L "/var/www/domains/netwaymain/billing.netway.co.th/public_html/.htaccess" ];
then
    ln -s /var/www/domains/netwaymain/billing.netway.co.th/public_html/.htaccess.develop /var/www/domains/netwaymain/billing.netway.co.th/public_html/.htaccess;
fi