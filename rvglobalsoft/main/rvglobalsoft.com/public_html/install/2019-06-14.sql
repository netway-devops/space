CREATE TABLE IF NOT EXISTS `hb_currency_background_cache` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) unsigned NOT NULL,
  `amount_out` decimal(12,2) NOT NULL,
  `amount_in` decimal(12,2) NOT NULL,
  `date` date NOT NULL,
  `currency_in` int(11) NOT NULL DEFAULT '0',
  `currency_out` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;