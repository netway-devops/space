ALTER TABLE `hb_invoices` ADD `rate3` DECIMAL(10,4) NOT NULL DEFAULT '1.0000' AFTER `rate2`;
##########
UPDATE hb_invoices SET rate3=rate2/rate WHERE rate!=0;
##########
ALTER TABLE `hb_currency_cache` ADD `base_currency_id` INT(11) NOT NULL DEFAULT '0' AFTER `currency_id`, ADD INDEX (`base_currency_id`) ;