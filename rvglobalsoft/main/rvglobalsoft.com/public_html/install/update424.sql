UPDATE `hb_configuration` SET `value` = '4.2.4' WHERE `setting`= 'Version';
##########
ALTER TABLE `hb_accounts` DROP `mod_custom_id`;
##########
CREATE TABLE `hb_accounts2servers` (
 `account_id` int(11) NOT NULL,
 `module_id` int(11) NOT NULL,
 `server_id` int(11) NOT NULL,
 `status` enum('Pending','Active','Suspended','Terminated') NOT NULL,
 `username` text NOT NULL,
 `password` text NOT NULL,
 `rootpassword` text NOT NULL,
 `extra_details` text NOT NULL,
 PRIMARY KEY  (`account_id`,`module_id`),
 KEY `server_id` (`server_id`),
 KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
##########
ALTER TABLE hb_products_modules DROP INDEX module;
##########
ALTER TABLE hb_products_modules DROP PRIMARY KEY;
##########
ALTER TABLE `hb_products_modules` ADD PRIMARY KEY ( `product_id` , `module` ),
ADD `main` TINYINT( 1 ) NOT NULL DEFAULT '1' AFTER `module` ,
ADD INDEX ( `main` ) ;
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',viewEmailLogs') WHERE access LIKE '%viewLogs%';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'viewEmailLogs','Access Email Logs' FROM hb_language WHERE target!='user';
##########
UPDATE hb_language_locales SET `section`='global' WHERE `keyword`='checkingstatus' AND `section`='cart';