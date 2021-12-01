UPDATE `hb_configuration` SET `value` = '4.3.0' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES
('AutoCancelUnpaidInvoices', 'off');
##########
ALTER TABLE `hb_invoice_items`
CHANGE COLUMN `type` `type` ENUM('Domain Register','Domain Renew','Domain Transfer','Hosting','Addon','Other','Upgrade','Invoice','Config','Credit','FieldUpgrade','Field','Discount') NOT NULL AFTER `invoice_id`;
