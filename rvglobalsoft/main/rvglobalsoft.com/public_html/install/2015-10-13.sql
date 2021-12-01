ALTER TABLE `hb_transactions`
CHANGE COLUMN `trans_id` `trans_id` VARCHAR(64) NOT NULL AFTER `out`;