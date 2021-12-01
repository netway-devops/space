REPLACE INTO hb_configuration VALUES ('RecurringBillingType', 'PrePaid');
##########
ALTER TABLE `hb_accounts`
ADD COLUMN `billingtype` ENUM('PrePay', 'PostPay') NOT NULL DEFAULT 'PrePay' AFTER `billingcycle`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'PostPay', 'Post-Paid' FROM hb_language WHERE 1
UNION SELECT id, 'global', 'PrePay', 'Pre-Paid' FROM hb_language WHERE 1;
##########
ALTER TABLE `hb_invoice_items_queue`
ADD COLUMN `status` ENUM('Draft','Pending','Added','Cancelled') NOT NULL DEFAULT 'Pending' AFTER `qty`,
ADD INDEX `client_id_status` (`client_id`, `status`),
ADD INDEX `rel_id_rel_type_status` (`rel_id`, `rel_type`, `status`);
##########
ALTER TABLE `hb_upgrades`
ADD COLUMN `old_product_id` INT(11) NOT NULL AFTER `product_id`,
ADD COLUMN `old_value` DECIMAL(12,2) NOT NULL AFTER `total`,
ADD INDEX `client_id` (`client_id`),
ADD INDEX `order_id` (`order_id`),
ADD INDEX `product_id` (`product_id`),
ADD INDEX `old_product_id` (`old_product_id`);
##########
ALTER TABLE `hb_config_upgrades`
ADD INDEX `new_config_id` (`new_config_id`),
ADD INDEX `old_config_id` (`old_config_id`);
##########
UPDATE `hb_accounts` SET `billingtype` = 'PrePay' WHERE 1;
##########
UPDATE `hb_invoice_items_queue` SET `status` = 'Pending' WHERE 1;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'total_postpay', 'Charge on invoice' FROM hb_language WHERE target='user'