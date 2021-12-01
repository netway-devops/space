ALTER TABLE `hb_email_log` ADD `flag` ENUM('email', 'notification') NOT NULL DEFAULT 'email';
##########
UPDATE hb_email_log SET `flag` = 'notification' WHERE `email` = '' AND `subject` LIKE 'Mobile:%';
##########
ALTER TABLE `hb_servers`
ADD `ns5` VARCHAR (128) AFTER `ns4`,
ADD `ns6` VARCHAR (128) AFTER `ns5`,
ADD `ns7` VARCHAR (128) AFTER `ns6`,
ADD `ns8` VARCHAR (128) AFTER `ns7`,
ADD `ip5` VARCHAR (128) AFTER `ip4`,
ADD `ip6` VARCHAR (128) AFTER `ip5`,
ADD `ip7` VARCHAR (128) AFTER `ip6`,
ADD `ip8` VARCHAR (128) AFTER `ip7`;
##########
REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES ('TaxRounding', 'item');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'affiliates', 'commission_plans', 'Commission plans' FROM hb_language;