REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'voucherexpired','This voucher expired on %s' FROM hb_language;
