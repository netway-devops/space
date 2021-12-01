CREATE TABLE IF NOT EXISTS `hb_paysafe_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `profile_id` varchar(255) NULL,
  `address_id` varchar(255) NULL,
  `ach_bankaccount_id` varchar(255) NULL,
  `ach_payment_token` varchar(255) NULL,
  `sepa_bankaccount_id` varchar(255) NULL,
  `sepa_bankaccount_reference` varchar(255) NULL,
  `sepa_payment_token` varchar(255) NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
