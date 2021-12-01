ALTER TABLE `hb_accounts` CHANGE `username` `username` VARCHAR(32)  CHARACTER SET utf8  COLLATE utf8_general_ci  NOT NULL  DEFAULT '';
##########
ALTER TABLE `hb_accounts` ADD INDEX (`username`);
