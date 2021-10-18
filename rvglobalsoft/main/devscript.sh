#!/bin/bash
cp /var/www/domains/rvglobalsoftdevelop/rvglobalsoft.com/patch/public_html/hbf/components/apiutils/class.apistub.php /var/www/domains/rvglobalsoftdevelop/rvglobalsoft.com/public_html/hbf/components/apiutils/;
git update-index --skip-worktree /var/www/domains/rvglobalsoftdevelop/rvglobalsoft.com/public_html/hbf/components/apiutils/class.apistub.php;
php /var/www/domains/rvglobalsoftdevelop/rvglobalsoft.com/migrate/migrate_script.php;
