#เก็บข้อมูลInvoice Renew เพื่อไม่ให้การสร้าง Deal บน Clickup ของ product บางประเภท
ALTER TABLE `hb_invoices` ADD `is_skip_deal` TINYINT(1) NOT NULL COMMENT 'Netway' AFTER `estimate_id`;
#กำหนด กลุ่ม product ที่ไม่ให้การสร้าง Deal บน Clickup เมื่อ Invoice เป็นประเภท Renew
REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES ('nwSkipRenewDealFromCategory', '1,2,4');