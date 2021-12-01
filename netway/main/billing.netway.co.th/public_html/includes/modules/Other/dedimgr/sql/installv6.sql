CREATE TABLE IF NOT EXISTS `tb_server_pool` (
`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`name` varchar(64) NOT NULL DEFAULT '',
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
`updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##--------
ALTER TABLE `tb_rack_item` ADD `pool_id` INT(11)  NOT NULL  DEFAULT '0'  AFTER `isblade`;
##--------
ALTER TABLE `tb_rack_item` ADD INDEX `pool_id` (`pool_id`);
