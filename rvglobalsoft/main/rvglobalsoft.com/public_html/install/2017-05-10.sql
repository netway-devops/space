ALTER TABLE `hb_graphs` ADD `hash` VARCHAR(32)  NOT NULL  DEFAULT ''  AFTER `metadata`;
##########
ALTER TABLE `hb_graphs` DROP INDEX `rel_type_rel_id_switch_id_port_id_server_id`;
##########
ALTER TABLE `hb_graphs` ADD UNIQUE INDEX `rel_type_rel_id_switch_id_port_id_server_id_hash` (`rel_type`, `rel_id`, `device_id`, `port_id`, `server_id`, `hash`);
##########
ALTER TABLE `hb_graphs` ADD `show_client` TINYINT(1)  NOT NULL  DEFAULT 1  AFTER `name`;
##########
ALTER TABLE `hb_graphs` ADD  INDEX `show_client` (`show_client`);