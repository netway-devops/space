UPDATE `hb_configuration` SET `value` = '4.9.8' WHERE `setting`= 'Version';
##########
CREATE TABLE `hb_client_credit_log` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `date` datetime NOT NULL,
 `client_id` int(11) NOT NULL,
 `in` decimal(10,2) NOT NULL DEFAULT '0.00',
 `out` decimal(10,2) NOT NULL DEFAULT '0.00',
 `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
 `description` varchar(255) NOT NULL,
 `transaction_id` VARCHAR(32) NOT NULL DEFAULT '',
 `invoice_id` int(11) NOT NULL DEFAULT '0',
 `admin_id` int(11) NOT NULL DEFAULT '0',
 `admin_name` varchar(70) NOT NULL DEFAULT '',
 PRIMARY KEY (`id`),
 KEY `client_id` (`client_id`),
 KEY `transaction_id` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'logs', 'clientcreditlog','Client Credit Log' FROM hb_language WHERE target!='user';
##########
ALTER TABLE `hb_ticket_status`
ADD COLUMN `color` VARCHAR(7) NOT NULL DEFAULT '000000' AFTER `options`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'popularcategories','Popular categories' FROM hb_language WHERE target='user';
