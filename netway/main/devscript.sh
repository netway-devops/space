#!/bin/bash

#patch license
cp -a /var/www/domains/netwaymain/billing.netway.co.th/patch/public_html/hbf/components/apiutils/class.apistub.php /var/www/domains/netwaymain/billing.netway.co.th/public_html/hbf/components/apiutils/;

cd /var/www/domains/netwaymain/billing.netway.co.th;
#skip patch file
git update-index --skip-worktree public_html/hbf/components/apiutils/class.apistub.php;

#migrate
php /var/www/domains/netwaymain/billing.netway.co.th/migrate/migrate_script.php;

#htaccess
if [ ! -L "/var/www/domains/netwaymain/billing.netway.co.th/public_html/.htaccess" ];
then
    ln -s /var/www/domains/netwaymain/billing.netway.co.th/public_html/.htaccess.develop /var/www/domains/netwaymain/billing.netway.co.th/public_html/.htaccess;
fi

#install pm2 global
npm install --prefix /var/www/domains/netwaymain/billing.netway.co.th
npm install pm2@latest -g

#start nodejs frontend-server
if [ -d "/var/www/domains/netwaymain/billing.netway.co.th/frontend-server" ];
then
cp -a /var/www/gitworks/laradock-multisite/apache2/local-ssl-certs/billing.netway.co.th.main-key.pem /var/www/domains/netwaymain/billing.netway.co.th/frontend-server/ssl/;
cp -a /var/www/gitworks/laradock-multisite/apache2/local-ssl-certs/billing.netway.co.th.main.pem /var/www/domains/netwaymain/billing.netway.co.th/frontend-server/ssl/;

#copy env-example to .env
if [ ! -f "/var/www/domains/netwaymain/billing.netway.co.th/frontend-server/.env" ];
then
cp -a /var/www/domains/netwaymain/billing.netway.co.th/frontend-server/.env.example /var/www/domains/netwaymain/billing.netway.co.th/frontend-server/.env
fi

npm install --prefix /var/www/domains/netwaymain/billing.netway.co.th/frontend-server
pm2 start "npm run dev --prefix /var/www/domains/netwaymain/billing.netway.co.th/frontend-server" --name frontend-server
fi

#start nodejs api-billing
local-ssl-certs/billing.netway.co.th.main-key.pem
if [ -d "/var/www/domains/netwaymain/billing.netway.co.th/api-server" ];
then
cp -a /var/www/gitworks/laradock-multisite/apache2/local-ssl-certs/billing.netway.co.th.main-key.pem /var/www/domains/netwaymain/billing.netway.co.th/api-server/ssl/;
cp -a /var/www/gitworks/laradock-multisite/apache2/local-ssl-certs/billing.netway.co.th.main.pem /var/www/domains/netwaymain/billing.netway.co.th/api-server/ssl/;

#copy env-example to .env
if [ ! -f "/var/www/domains/netwaymain/billing.netway.co.th/api-server/.env" ];
then
cp -a /var/www/domains/netwaymain/billing.netway.co.th/api-server/.env.example /var/www/domains/netwaymain/billing.netway.co.th/api-server/.env
fi

npm install --prefix /var/www/domains/netwaymain/billing.netway.co.th/api-server
pm2 start "npm run dev --prefix /var/www/domains/netwaymain/billing.netway.co.th/api-server" --name api-server --watch
fi

# #start nodejs api-3rdpart
# if [ -d "/var/www/domains/netwaymain/billing.netway.co.th/3rdpart-api-server" ];
# then
# cp -a /var/www/gitworks/laradock-multisite/apache2/local-ssl-certs/billing.netway.co.th.main-key.pem /var/www/domains/netwaymain/billing.netway.co.th/3rdpart-api-server/ssl/;
# cp -a /var/www/gitworks/laradock-multisite/apache2/local-ssl-certs/billing.netway.co.th.main.pem /var/www/domains/netwaymain/billing.netway.co.th/3rdpart-api-server/ssl/;

# npm install --prefix /var/www/domains/netwaymain/billing.netway.co.th/3rdpart-api-server
# pm2 start "npm run dev --prefix /var/www/domains/netwaymain/billing.netway.co.th/3rdpart-api-server" --name 3rdpart-api-server --watch
# fi