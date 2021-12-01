CREATE TABLE IF NOT EXISTS `hb_mettered_sync` (
  `account_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
