CREATE TABLE IF NOT EXISTS `hb_calendar_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `master_id` int(11) NOT NULL,
  `description` text,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `flag` tinyint(4) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `master_id` (`master_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
###
CREATE TABLE IF NOT EXISTS `hb_calendar_event_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `master_id` int(11) NOT NULL,
  `event_id` int(11) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `rel_id` int(11) NOT NULL,
  `flag` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `data` text,
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`),
  KEY `type_rel_id` (`type`,`rel_id`),
  KEY `master_id` (`master_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
###
CREATE TABLE IF NOT EXISTS `hb_calendar_event_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `flag` tinyint(4) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
###
CREATE TABLE IF NOT EXISTS `hb_calendar_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `style` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
###
REPLACE INTO `hb_calendar_groups` (`id`, `name`, `style`) VALUES
(1, 'Default', ''),
(2, 'Red', 'border-color: rgb(239, 82, 80); color: white; background-color: rgb(239, 82, 80);'),
(3, 'Purple', 'border-color: rgb(170, 71, 188); color: white; background-color: rgb(170, 71, 188);'),
(4, 'Teal', 'border-color: rgb(0, 150, 135); color: white; background-color: rgb(0, 150, 135);'),
(5, 'Green', 'border-color: rgb(58, 150, 61); color: white; background-color: rgb(58, 150, 61);'),
(6, 'Light Green', 'border-color: rgb(156, 204, 101); color: black; background-color: rgb(156, 204, 101);'),
(7, 'Yellow', 'border-color: rgb(255, 238, 88); color: black; background-color: rgb(255, 238, 88);'),
(9, 'Orange', 'border-color: rgb(245, 159, 30); color: black; background-color: rgb(245, 159, 30);');
###
ALTER TABLE `hb_calendar_events`  ADD COLUMN `copy_id` INT(11) NOT NULL AFTER `master_id`;
###
ALTER TABLE `hb_calendar_events`  ADD UNIQUE INDEX `master_id_copy_id` (`master_id`, `copy_id`);