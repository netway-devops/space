-- Update SSL Database

CREATE TABLE IF NOT EXISTS `hb_ssl_order_contact` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `client_id` int(7) NOT NULL,
  `order_id` int(10) NOT NULL COMMENT 'id order product',
  `csr_md5` varchar(40) NOT NULL,
  `domain_name` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `firstname` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lastname` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `job` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `telephone` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `phone` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email_approval` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `time_verify` datetime NOT NULL COMMENT 'GMT +0',
  PRIMARY KEY (`id`)
);



ALTER TABLE `hb_ssl` ADD `ssl_assurance` VARCHAR( 20 ) NOT NULL;

UPDATE `hb_ssl` SET `ssl_assurance` = 'Medium' WHERE `hb_ssl`.`ssl_id` = 1;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Medium' WHERE `hb_ssl`.`ssl_id` = 2;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Low' WHERE `hb_ssl`.`ssl_id` = 3;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Medium' WHERE `hb_ssl`.`ssl_id` = 4;
UPDATE `hb_ssl` SET `ssl_assurance` = '' WHERE `hb_ssl`.`ssl_id` = 5;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Very High' WHERE `hb_ssl`.`ssl_id` = 6;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Very High' WHERE `hb_ssl`.`ssl_id` = 7;
UPDATE `hb_ssl` SET `ssl_assurance` = 'High' WHERE `hb_ssl`.`ssl_id` = 8;
UPDATE `hb_ssl` SET `ssl_assurance` = 'High' WHERE `hb_ssl`.`ssl_id` = 9;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Medium' WHERE `hb_ssl`.`ssl_id` = 10;
UPDATE `hb_ssl` SET `ssl_assurance` = '' WHERE `hb_ssl`.`ssl_id` = 11;
UPDATE `hb_ssl` SET `ssl_assurance` = '' WHERE `hb_ssl`.`ssl_id` = 12;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Highest' WHERE `hb_ssl`.`ssl_id` = 13;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Highest' WHERE `hb_ssl`.`ssl_id` = 14;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Very High' WHERE `hb_ssl`.`ssl_id` = 15;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Very High' WHERE `hb_ssl`.`ssl_id` = 16;
UPDATE `hb_ssl` SET `ssl_assurance` = '' WHERE `hb_ssl`.`ssl_id` = 17;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Very High' WHERE `hb_ssl`.`ssl_id` = 18;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Very High' WHERE `hb_ssl`.`ssl_id` = 19;
UPDATE `hb_ssl` SET `ssl_assurance` = 'High' WHERE `hb_ssl`.`ssl_id` = 20;
UPDATE `hb_ssl` SET `ssl_assurance` = '' WHERE `hb_ssl`.`ssl_id` = 21;
UPDATE `hb_ssl` SET `ssl_assurance` = '' WHERE `hb_ssl`.`ssl_id` = 22;
UPDATE `hb_ssl` SET `ssl_assurance` = '' WHERE `hb_ssl`.`ssl_id` = 23;
UPDATE `hb_ssl` SET `ssl_assurance` = 'High' WHERE `hb_ssl`.`ssl_id` = 24;
UPDATE `hb_ssl` SET `ssl_assurance` = '' WHERE `hb_ssl`.`ssl_id` = 25;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Low' WHERE `hb_ssl`.`ssl_id` = 26;
UPDATE `hb_ssl` SET `ssl_assurance` = '' WHERE `hb_ssl`.`ssl_id` = 27;
UPDATE `hb_ssl` SET `ssl_assurance` = '' WHERE `hb_ssl`.`ssl_id` = 28;
UPDATE `hb_ssl` SET `ssl_assurance` = '' WHERE `hb_ssl`.`ssl_id` = 29;
UPDATE `hb_ssl` SET `ssl_assurance` = '' WHERE `hb_ssl`.`ssl_id` = 30;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Very High' WHERE `hb_ssl`.`ssl_id` = 31;
UPDATE `hb_ssl` SET `ssl_assurance` = 'High' WHERE `hb_ssl`.`ssl_id` = 32;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Medium' WHERE `hb_ssl`.`ssl_id` = 33;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Highest' WHERE `hb_ssl`.`ssl_id` = 34;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Very High' WHERE `hb_ssl`.`ssl_id` = 35;
UPDATE `hb_ssl` SET `ssl_assurance` = '' WHERE `hb_ssl`.`ssl_id` = 36;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Very High' WHERE `hb_ssl`.`ssl_id` = 37;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Very High' WHERE `hb_ssl`.`ssl_id` = 38;
UPDATE `hb_ssl` SET `ssl_assurance` = '' WHERE `hb_ssl`.`ssl_id` = 39;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Highest' WHERE `hb_ssl`.`ssl_id` = 40;
UPDATE `hb_ssl` SET `ssl_assurance` = '' WHERE `hb_ssl`.`ssl_id` = 41;
UPDATE `hb_ssl` SET `ssl_assurance` = 'Very High' WHERE `hb_ssl`.`ssl_id` = 42;

