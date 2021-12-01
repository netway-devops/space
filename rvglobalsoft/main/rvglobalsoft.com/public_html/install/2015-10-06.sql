CREATE TABLE IF NOT EXISTS `hb_declined_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_hash` char(40) NOT NULL,
  `client_id` int(11) NOT NULL,
  `card` char(16) NOT NULL,
  `date` datetime NOT NULL,
  `reason` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `card_hash` (`card_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_ssh_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `key` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_localcloud` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `flag` int(11) unsigned NOT NULL,
  `server_id` varchar(200) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id_server_id` (`account_id`,`server_id`),
  KEY `account_id` (`account_id`),
  KEY `account_id_flag` (`account_id`,`flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########