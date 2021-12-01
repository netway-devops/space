CREATE TABLE IF NOT EXISTS `hb_theme_configs` (
`id` int(255) NOT NULL AUTO_INCREMENT,
`name` varchar(255) DEFAULT NULL,
`theme` varchar(255) NOT NULL,
`configuration` text DEFAULT '',
`active` tinyint(1) NOT NULL DEFAULT 0,
`created_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
`updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
`updated_by` varchar(255) NOT NULL DEFAULT '',
PRIMARY KEY (`id`),
KEY `theme` (`theme`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8