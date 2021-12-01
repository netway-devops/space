ALTER TABLE `hb_ticket_departments`
ADD COLUMN `sendername` VARCHAR(256) NOT NULL AFTER `senderemail`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'cart', 'out_of_stock','%s plan is currently unavailable' FROM hb_language WHERE target='user';
