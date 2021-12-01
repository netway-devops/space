#!/usr/bin/perl

=begin comment

By P' Boom
	co rvglobalsoft.com/public_html
	crack
	open url rvglobalsoft.com/public_html
		auto redirect to rvglobalsoft.com/public_html/install/index.php
		install (db confi same production)
		change url step to 2
	force import db to localhost
	svn revert to latest (remove crack)

	Settings > General Settings > Other > SEO URLs settings:	(*) Default

----------------------------------------------------------------------------

By Amarin

dev_ip=192.168.1.73
dev_name=amarin
dev_pass=amarin

hb_path=/home/amarin/public_html/works/rvglobalsoft.com

hbdb_name=rvglobal_hostbill
hbdb_user=rvglobal_hostbill
hbdb_pass=899lpk,vbog9viNFVl9NvkiN;u899


On server1.rvglobalsoft.net
	cd /home/amarin/
	mysqldump --default-character-set=utf8 --skip-set-charset rvglobal_hostbill > /home/amarin/rvglobal_hostbill.sql
	bzip2 rvglobal_hostbill.sql
	curl -T rvglobal_hostbill.sql.bz2 ftp://svnimport.svn.rvglobalsoft.net --user svnimpor:y0Kt6uKLf+h
On svn.rvglobalsoft.net
	Login to cPanel and download though file manager
	svnimport.svn.rvglobalsoft.net
	svnimpor
	y0Kt6uKLf+h

	curl -T ftp://svnimport.svn.rvglobalsoft.net/rvglobal_hostbill.sql.bz2 --user svnimpor:y0Kt6uKLf+h -o ~/rvglobal_hostbill.sql.bz2

	bunzip2 ~/rvglobal_hostbill.sql.bz2

	mysql -h localhost -u root -pamarin -e "DROP DATABASE rvglobal_hostbill;";

	mysql -h localhost -u root -pamarin -e "CREATE DATABASE rvglobal_hostbill;";

	mysql -uroot -pamarin -hlocalhost rvglobal_hostbill < ~/rvglobal_hostbill.sql

	mysql -h localhost -u root -pamarin -e "GRANT ALL PRIVILEGES ON rvglobal_hostbill.* TO 'rvglobal_admin'@'localhost' IDENTIFIED BY '899lpk,vbog9viNFVl9NvkiN;u899';"

	mysql -h localhost -u root -pamarin -e "GRANT ALL PRIVILEGES ON rvglobal_hostbill.* TO 'rvglobal_admin'@'192.168.1.73' IDENTIFIED BY '899lpk,vbog9viNFVl9NvkiN;u899';"


CREATE USER 'tatest'@'%' IDENTIFIED BY  '***';
GRANT ALL PRIVILEGES ON * . * TO  'tatest'@'%' IDENTIFIED BY  '***' WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;
GRANT ALL PRIVILEGES ON  `rvglobal_hostbill` . * TO  'tatest'@'%';

	cp rvglobalsoft.com/documents/settup/class.apistub.php rvglobalsoft.com/public_html/hbf/components/apiutils/

	cp rvglobalsoft.com/documents/settup/My_Flipping_HostBill_Licence.php rvglobalsoft.com/public_html/includes/

	sudo chattr +i rvglobalsoft.com/public_html/hbf/components/apiutils/class.apistub.php

	rm -f rvglobalsoft.com/public_html/.htaccess

	 templates_c


rsync -avzh --exclude=.svn* /home/amarin/public_html/works/rvglobalsoft.com /home/amarin/public_html/demo/

rsync -avzh --exclude=.svn* /home/amarin/public_html/works/rvglobalsoft.com/public_html/ /home/amarin/public_html/demo/rvglobalsoft.com/public_html

=end comment

=cut



