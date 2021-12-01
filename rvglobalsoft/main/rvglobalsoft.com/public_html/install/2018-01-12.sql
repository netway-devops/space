UPDATE `hb_ticket_status` SET `options`=9 WHERE `status`='Sent-Out';
##########
REPLACE INTO hb_language_locales(`language_id`,`section`,`keyword`,`value`)
SELECT `language_id`,'global','Sent-Out','Sent-Out' FROM  hb_language_locales;
##########
ALTER TABLE `hb_security_rules` ADD `description` TEXT  NULL  AFTER `options`;
##########
ALTER TABLE `hb_reports` ADD `displayname` VARCHAR(255)  NULL  DEFAULT NULL  AFTER `columns`;
##########
UPDATE `hb_reports` SET `displayname`  = `name`;