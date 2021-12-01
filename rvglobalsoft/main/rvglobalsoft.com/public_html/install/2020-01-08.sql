REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'LateFeeAsSeparateInvoice','Late Fee as separate invoice' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'configuration', 'LateFeeAsSeparateInvoiceNO','add late fees as line to original invoice' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'configuration', 'LateFeeAsSeparateInvoiceYES','add late fees to separate invoice' FROM hb_language WHERE target = 'admin';
##########
REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES ('LateFeeAsSeparateInvoice', 'off');
##########
ALTER TABLE `hb_invoice_items` CHANGE `type` `type` ENUM('Domain Register','Domain Renew','Domain Transfer','Hosting','Addon','Other','Upgrade','Invoice','Config','Credit','FieldUpgrade','Field','Discount','Support','RefundedItem','OSLicense','LateFee')  NOT NULL;