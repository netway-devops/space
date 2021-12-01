REPLACE INTO hb_configuration (`value`, `setting`) SELECT CASE WHEN `value` = 'eu' THEN 'off' ELSE 'on' END as `value`, 'DiscountOnInvoice' FROM hb_configuration WHERE `setting` = 'InvoiceModel';
##########
ALTER TABLE `hb_coupons` ADD COLUMN `categories` TEXT  NOT NULL AFTER `products`;

