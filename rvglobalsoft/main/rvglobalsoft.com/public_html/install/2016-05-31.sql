ALTER TABLE `hb_notes` CHANGE `type` `type` ENUM('client','account','domain','order','draft','admin')  NOT NULL  DEFAULT 'client';
##########
ALTER TABLE `hb_notes` CHANGE `rel_id` `rel_id` INT(10)  NOT NULL  DEFAULT '0';
##########
ALTER TABLE `hb_reports` ADD `state` TEXT  NOT NULL DEFAULT '' AFTER `handler`;
##########
ALTER TABLE `hb_reports` ADD `columns` TEXT  NOT NULL DEFAULT '' AFTER `state`;
##########
CREATE TABLE IF NOT EXISTS `hb_reports_widget` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `report_id` int(11) NOT NULL,
  `name` varchar(127) NOT NULL DEFAULT '',
  `type` varchar(127) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_reports_widget_series` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `reports_widget_id` int(11) NOT NULL,
  `state` text NOT NULL,
  `columns` text NOT NULL,
  `name` varchar(127) NOT NULL DEFAULT 'default',
  PRIMARY KEY (`id`),
  KEY `reports_widget_id` (`reports_widget_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;