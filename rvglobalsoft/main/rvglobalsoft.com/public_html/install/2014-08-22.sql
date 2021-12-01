UPDATE hb_ticket_views SET `options` = (`options` & ~2) WHERE !(`options` & 4);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'requestepp','Request Auth Info / Epp code' FROM hb_language WHERE target='user';
##########
ALTER TABLE `hb_client_billing`
ADD COLUMN `overideautosusp` TINYINT(1) NOT NULL AFTER `overideduenotices`;