#เช็คการสร้าง Deal ไม่ให้ซ้ำเมื่อ gen invoice
ALTER TABLE `hb_estimates` ADD `deal_id` VARCHAR(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Netway' AFTER `options`;