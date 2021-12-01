ALTER TABLE `hb_config_items` ADD `options` INT(11)  NULL  DEFAULT '0'  AFTER `sort_order`;
##########
ALTER TABLE `hb_config_items` ADD INDEX (`options`);
