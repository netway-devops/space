UPDATE `hb_configuration` SET `value` = '4.3.4' WHERE `setting`= 'Version';
##########
CREATE TABLE `hb_config_resources` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`item_id` INT(11) NOT NULL,
	`qty` INT NOT NULL,
	`qty_max` INT NOT NULL,
	PRIMARY KEY (`id`),
	INDEX `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_common`
CHANGE COLUMN `rel` `rel` ENUM('Product','Addon','Config','Bundled','FResource') NOT NULL AFTER `id`;
##########
ALTER TABLE `hb_account_logs`
ADD INDEX `account_id` (`account_id`);
