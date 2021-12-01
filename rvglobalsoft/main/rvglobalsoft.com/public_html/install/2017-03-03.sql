CREATE TABLE `hb_graphs` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
	`rel_type` ENUM('Hosting','RackItem') NOT NULL DEFAULT 'Hosting',
	`rel_id` INT(11) NOT NULL,
	`server_id` INT(11) NOT NULL,
	`device_id` VARCHAR(50) NOT NULL,
	`port_id` VARCHAR(32) NOT NULL,
	`name` VARCHAR(127) NOT NULL DEFAULT '',
	`cache` TEXT NOT NULL,
	`modified` DATETIME NOT NULL,
	`billed` TINYINT(1) NOT NULL DEFAULT '1',
	PRIMARY KEY (`id`),
	UNIQUE INDEX `rel_type_rel_id_switch_id_port_id_server_id` (`rel_type`, `rel_id`, `device_id`, `port_id`, `server_id`),
	INDEX `billed` (`billed`),
	INDEX `switch_id_port_id_server_id` (`device_id`, `port_id`, `server_id`),
	INDEX `server_id` (`server_id`),
	INDEX `rel_type_rel_id` (`rel_type`, `rel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;