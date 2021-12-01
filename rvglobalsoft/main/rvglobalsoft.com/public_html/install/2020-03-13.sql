ALTER TABLE `hb_coupons` ADD COLUMN `status` ENUM('Active', 'Archived') NOT NULL DEFAULT 'Active' AFTER `code`;
##########
UPDATE hb_coupons SET `status` = 'Archived' WHERE expires < NOW() AND expires <> '0000-00-00';