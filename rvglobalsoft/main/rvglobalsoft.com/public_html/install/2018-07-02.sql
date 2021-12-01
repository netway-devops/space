ALTER TABLE `hb_aff_orders` ADD COLUMN `description` TEXT DEFAULT NULL;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'editCommissionBalance','Edit commission balance' FROM hb_language WHERE target='admin';