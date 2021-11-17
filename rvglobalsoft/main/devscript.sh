#!/bin/bash
cp /var/www/domains/rvglobalsoftmain/rvglobalsoft.com/patch/public_html/hbf/components/apiutils/class.apistub.php /var/www/domains/rvglobalsoftmain/rvglobalsoft.com/public_html/hbf/components/apiutils/;
cd /var/www/domains/rvglobalsoftmain/rvglobalsoft.com;
git update-index --skip-worktree public_html/hbf/components/apiutils/class.apistub.php;
php /var/www/domains/rvglobalsoftmain/rvglobalsoft.com/migrate/migrate_script.php;
