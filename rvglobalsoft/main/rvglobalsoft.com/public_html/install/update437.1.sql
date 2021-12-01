ALTER TABLE `hb_transactions` ADD `fee_code` CHAR( 4 ) NOT NULL AFTER `fee` ,
ADD `fee_message` VARCHAR( 64 ) NOT NULL AFTER `fee_code` 
