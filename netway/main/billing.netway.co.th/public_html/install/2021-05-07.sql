CREATE TABLE IF NOT EXISTS `hb_client_fields_groups` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`name` VARCHAR(255) NOT NULL,
`description` TEXT NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_client_fields` ADD COLUMN `group_id` INT(11) NOT NULL DEFAULT '0' AFTER `name`;