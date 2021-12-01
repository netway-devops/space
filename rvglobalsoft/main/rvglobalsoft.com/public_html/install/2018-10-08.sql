REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'vouchercode','Voucher code' FROM hb_language
UNION SELECT id, 'global', 'redeem','Redeem' FROM hb_language
UNION SELECT id, 'global', 'redeemvoucher','Redeem a voucher' FROM hb_language;