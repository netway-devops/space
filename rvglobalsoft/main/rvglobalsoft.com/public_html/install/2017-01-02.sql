CREATE TABLE IF NOT EXISTS `hb_dns_dnssec_keys` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `domain_id` INT(11) NOT NULL,
  `id_tag` INT(11) NOT NULL,
  `flag` ENUM('KSK','ZSK') NOT NULL,
  `algorithm` SMALLINT UNSIGNED NOT NULL,
  `key_tag` SMALLINT UNSIGNED NOT NULL,
  `public_key` TEXT NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_dns_dnssec_ds` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `domain_id` INT(11) NOT NULL,
  `key_tag` SMALLINT UNSIGNED NOT NULL,
  `algorithm` SMALLINT UNSIGNED NOT NULL,
  `digest_type` TINYINT UNSIGNED NOT NULL,
  `digest` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;