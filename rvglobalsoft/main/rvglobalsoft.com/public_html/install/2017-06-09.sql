UPDATE hb_email_templates SET  plain=1 WHERE `group`='Mobile';
##########
ALTER TABLE `hb_system_log` CHANGE `type` `type` VARCHAR(32)   NOT NULL  DEFAULT 'none';
##########
ALTER TABLE `hb_system_log` ADD INDEX (`type`);
##########
REPLACE INTO hb_configuration (`setting`, `value`)
VALUES ('LoggerLevel', '200');
##########
CREATE TABLE IF NOT EXISTS `hb_aff_clients` (
  `aff_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `by` varchar(50) NOT NULL,
  PRIMARY KEY (`aff_id`,`client_id`),
  KEY `aff_id` (`aff_id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;