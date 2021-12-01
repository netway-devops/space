REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'autoapplycredit','Auto-apply credit' FROM hb_language
UNION SELECT id, 'global', 'creditreceipts','Credit Receipts' FROM hb_language;
##########
ALTER TABLE `hb_client_fields` CHANGE COLUMN `name` `name` VARCHAR(42) NOT NULL;