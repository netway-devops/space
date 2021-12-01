CREATE TABLE IF NOT EXISTS `hb_webhooks` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `events` TEXT NOT NULL,
  `content` ENUM('json','form') NOT NULL DEFAULT 'form',
  `options` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `url` TEXT NOT NULL,
  `secret` CHAR(43) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
######
CREATE TABLE IF NOT EXISTS `hb_webhook_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `webhook_id` int(11) NOT NULL,
  `status` smallint(5) unsigned NOT NULL,
  `log` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `webhook_id` (`webhook_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

