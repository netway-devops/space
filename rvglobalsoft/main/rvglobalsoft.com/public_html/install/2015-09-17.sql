REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'affiliates', 'enableovercommission','Allow commission higher than order total' FROM hb_language WHERE target!='user';
##########
ALTER TABLE `hb_aff_commisions` ADD `enable_overcommission` TINYINT(1)  NOT NULL  DEFAULT '0'  AFTER `notes`;
