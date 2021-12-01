ALTER TABLE `hb_security_rules`
CHANGE COLUMN `rule` `rule` VARCHAR(128) NOT NULL AFTER `id`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'ip_notallowed','This IP (%s) is not authorized to access' FROM hb_language WHERE target!='user';
##########
ALTER TABLE `hb_coupons`
ADD COLUMN `options` INT NOT NULL DEFAULT '7' AFTER `cycle`;