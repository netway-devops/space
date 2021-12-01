UPDATE `hb_configuration` SET `value` = '4.6.4' WHERE `setting`= 'Version';
##########
ALTER TABLE `hb_coupons`
ADD COLUMN `applyto` ENUM('price','setupfee','both') NOT NULL DEFAULT 'price' AFTER `type`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'taxconfig', 'TaxFunds3','Apply tax "Add funds" invoices, add gross amount to client credit' FROM hb_language WHERE target='admin'
UNION SELECT id, 'taxconfig', 'TaxFunds1','Apply tax "Add funds" invoices, add net amount to client credit' FROM hb_language WHERE target='admin';