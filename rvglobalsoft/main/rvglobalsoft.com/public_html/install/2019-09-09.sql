REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT `id`, 'coupons', 'coupontype','Coupon type' FROM hb_language WHERE target = 'admin';
##########
ALTER TABLE `hb_coupons` ADD `coupon_type` ENUM('cart', 'invoice') DEFAULT 'cart' AFTER `code`;
##########
ALTER TABLE `hb_coupons_log` ADD `invoice_id` INT(11) NULL DEFAULT 0 AFTER `order_id`;