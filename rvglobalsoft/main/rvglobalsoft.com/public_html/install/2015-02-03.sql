ALTER TABLE `hb_products` ADD `hostname` TINYINT(1)  NULL  DEFAULT '0'  AFTER `client_limit`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'services', 'require_hostname','Require hostname for this product' FROM hb_language WHERE target!='user';