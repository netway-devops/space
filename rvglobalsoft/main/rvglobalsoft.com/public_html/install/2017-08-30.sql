REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'editadmins', 'clientBalance', 'See Client Balance' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'editSupportRates', 'Edit Ticket Billing Settings' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'viewSupportRates', 'View Ticket Billing Rates' FROM hb_language WHERE target='admin';
##########
UPDATE hb_admin_access set `access` = CONCAT(`access`,',clientBalance') WHERE `access` LIKE '%listClients%';
##########
UPDATE hb_admin_access set `access` = CONCAT(`access`,',editSupportRates,viewSupportRates') WHERE `access` LIKE '%viewTickets%';

