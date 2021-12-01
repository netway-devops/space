CREATE TABLE IF NOT EXISTS `hb_event_handles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(250) NOT NULL,
  `handle_type` enum('module','class') NOT NULL,
  `module_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `module_id` (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;