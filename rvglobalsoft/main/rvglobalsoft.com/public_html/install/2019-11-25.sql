ALTER TABLE `hb_invoices`
ADD COLUMN `grandtotal` DECIMAL(12,2) NOT NULL DEFAULT '0.00' AFTER `total`;
##########
UPDATE `hb_invoices` i LEFT JOIN hb_configuration c ON c.setting='TaxCredited'
SET i.`grandtotal` = CASE WHEN c.`value`='on' THEN i.`total` ELSE i.`total` + i.`credit` END
WHERE 1;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'dns_template_reset','Reset existing records for selected zone' FROM hb_language WHERE target='user';