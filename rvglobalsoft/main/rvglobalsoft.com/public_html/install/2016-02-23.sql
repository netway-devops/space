REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'measured','Measured' FROM hb_language
UNION SELECT id, 'global', 'accumulated','Accumulated' FROM hb_language;
##########
ALTER TABLE `hb_recurring_invoices`
ADD COLUMN `duedays` TINYINT NULL AFTER `next_invoice`,
ADD COLUMN `paybefore` TINYINT NULL AFTER `duedays`;
