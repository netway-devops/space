UPDATE `hb_configuration` SET `value` = '4.9.0' WHERE `setting`= 'Version';
##########
ALTER TABLE `hb_tickets`
ADD COLUMN `metadata` TEXT NULL AFTER `owner_id`;
