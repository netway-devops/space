ALTER TABLE `hb_system_log` ADD `ip` VARCHAR(32)  NOT NULL  DEFAULT ''  AFTER `item_id`;
##########
ALTER TABLE `hb_client_activity_log` ADD `ip` VARCHAR(32)  NOT NULL  DEFAULT ''  AFTER `event`;

