ALTER TABLE `hb_reports_widget_series` ADD `sort_order` INT(3) DEFAULT '0';
##########
UPDATE `hb_reports_widget_series` SET `sort_order` = `id` WHERE `id` IS NOT NULL;
##########
ALTER TABLE `hb_reports_widget_series` ADD `color` VARCHAR (10) DEFAULT NULL;