CREATE TABLE IF NOT EXISTS `hb_creditcard_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11)  NULL DEFAULT '0',
  `admin_login` VARCHAR(255)  NULL DEFAULT '',
  `client_id` int(11) NOT NULL,
  `ip` varchar(64) NOT NULL,
  `last4` varchar(10) NOT NULL DEFAULT '',
  `tokenized` tinyint(1) NOT NULL DEFAULT '0',
  `gateway_id` int(11) NOT NULL DEFAULT '0',
  `change` text NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'viewCCLog','View Credit Card Log' FROM hb_language WHERE target = 'admin';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',viewCCLog') WHERE access LIKE '%viewCC%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(access, ',viewCCLog') WHERE access LIKE '%viewCC%';