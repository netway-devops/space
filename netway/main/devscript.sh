#!/bin/bash
cp -a /var/www/domains/netwaymain/billing.netway.co.th/patch/public_html/hbf/components/apiutils/class.apistub.php /var/www/domains/netwaymain/billing.netway.co.th/public_html/hbf/components/apiutils/;
cd /var/www/domains/netwaymain/billing.netway.co.th;
git update-index --skip-worktree public_html/hbf/components/apiutils/class.apistub.php;
php /var/www/domains/netwaymain/billing.netway.co.th/migrate/migrate_script.php;
if [ ! -L "/var/www/domains/netwaymain/billing.netway.co.th/public_html/.htaccess" ];
then
    ln -s /var/www/domains/netwaymain/billing.netway.co.th/public_html/.htaccess.develop /var/www/domains/netwaymain/billing.netway.co.th/public_html/.htaccess;
fi

npm install --prefix /var/www/domains/netwaymain/billing.netway.co.th
npm install pm2@latest -g

if [ -d "/var/www/domains/netwaymain/billing.netway.co.th/frontend-server" ];
then
cp -a /var/www/gitworks/laradock-multisite/apache2/local-ssl-certs/billing.netway.co.th.main-key.pem /var/www/domains/netwaymain/billing.netway.co.th/frontend-server/ssl/;
cp -a /var/www/gitworks/laradock-multisite/apache2/local-ssl-certs/billing.netway.co.th.main.pem /var/www/domains/netwaymain/billing.netway.co.th/frontend-server/ssl/;

npm install --prefix /var/www/domains/netwaymain/billing.netway.co.th/frontend-server
pm2 start "npm run dev --prefix /var/www/domains/netwaymain/billing.netway.co.th/frontend-server" --name frontend-server

fi

if [ -d "/var/www/domains/netwaymain/billing.netway.co.th/hypernova-server" ];
then

cp -a /var/www/gitworks/laradock-multisite/apache2/local-ssl-certs/billing.netway.co.th.main-key.pem /var/www/domains/netwaymain/billing.netway.co.th/hypernova-server/src/ssl/;
cp -a /var/www/gitworks/laradock-multisite/apache2/local-ssl-certs/billing.netway.co.th.main.pem /var/www/domains/netwaymain/billing.netway.co.th/hypernova-server/src/ssl/;

npm install --prefix /var/www/domains/netwaymain/billing.netway.co.th/hypernova-server
pm2 start "npm run dev --prefix /var/www/domains/netwaymain/billing.netway.co.th/hypernova-server" --name hypernove-server

fi
