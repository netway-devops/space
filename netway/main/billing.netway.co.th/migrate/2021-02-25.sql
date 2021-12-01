#เก็บข้อมูล invoice นี้มีการ Convert มาจาก Estimate ไหน
ALTER TABLE `hb_invoices` ADD `estimate_id` INT NOT NULL COMMENT 'Netway' AFTER `po_number`;
#comment field
ALTER TABLE `hb_invoice_items` CHANGE `discount_price_coupon` `discount_price_coupon` DECIMAL(10,2) NOT NULL COMMENT 'Netway';

