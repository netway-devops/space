ALTER TABLE `hb_notes` CHANGE `type` `type` ENUM('client','account','domain','order','draft','admin','invoice','estimate','rackitem','contracts','workflow') NOT NULL  DEFAULT 'client';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'err_client_does_not_exist','Client does not exist' FROM hb_language
UNION SELECT id, 'global', 'err_client_alread_affiliate','Client is already an affiliate' FROM hb_language;
##########
ALTER TABLE `hb_tickets_attachments`
ADD COLUMN `org_filename` TEXT(65535) NULL AFTER `filename`;