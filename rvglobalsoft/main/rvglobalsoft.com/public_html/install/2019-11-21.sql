ALTER TABLE `hb_creditvouchers_codes` DROP INDEX `code`;
##########
ALTER TABLE `hb_creditvouchers_batches` CHANGE COLUMN `prefix` `prefix` VARCHAR(32) NOT NULL AFTER `name`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'orderorfunds','You need add funds first or have active order to redeem this voucher' FROM hb_language WHERE target = 'user';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('PayBeforeVoucher', 'off');