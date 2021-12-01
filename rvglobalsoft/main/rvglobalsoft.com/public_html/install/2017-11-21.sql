ALTER TABLE `hb_invoices` ADD `contact_id` INT(11)  NULL  DEFAULT '0' AFTER `client_id`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'selectbillingcontact', 'Select billing contact' FROM hb_language WHERE target='user';