ALTER TABLE `hb_accounts`
ADD COLUMN `label` VARCHAR(40) NOT NULL AFTER `status`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'editlabel','Edit Label' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'label','Label' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'servicelabel','Service Label' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'updatelabel','Update Label' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'label_updated','Label updated' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'servicelabeldscr','Enter new label for your service' FROM hb_language WHERE target='user';
##########
ALTER TABLE `hb_tickets_tags`
ADD INDEX `tag_id` (`tag_id`),
ADD INDEX `ticket_id` (`ticket_id`);