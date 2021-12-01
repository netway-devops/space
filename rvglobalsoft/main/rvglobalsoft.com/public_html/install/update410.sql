UPDATE `hb_configuration` SET `value` = '4.1.0' WHERE `setting`= 'Version';
##########
CREATE TABLE `hb_ticket_views` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
    `owner` INT(10) NOT NULL,
	`name` VARCHAR(100) NOT NULL,
	`options` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`columns` INT(11) UNSIGNED NOT NULL DEFAULT '31',
	PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_views_filters` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`view_id` INT(10) NOT NULL,
	`type` INT(10) UNSIGNED NOT NULL,
	`value` TEXT NOT NULL,
	PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_views_columns` (
	`id` INT(10) NOT NULL,
	`view_id` INT(10) NOT NULL,
	`column` INT UNSIGNED NOT NULL,
	PRIMARY KEY (`id`, `view_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_reports` (
`id` ,
`type` ,
`name` ,
`query` ,
`options`
)
VALUES (
NULL , 'Orders', 'All transactions informations in given period with purchased items details', 'SELECT t.trans_id AS `Transaction ID`, t.date AS `Transaction Date`, hb_currency(t.`in`,t.`currency_id`,t.rate) AS `Amount In`, it.description AS `Invoice Item`, hb_currency(t.`fee`,t.`currency_id`,t.rate) AS `Transaction Fees`, CONCAT(d.firstname,'' '',d.lastname) AS `Client`, t.description AS `Transaction Description`, hb_currency(t.`out`,t.`currency_id`,t.rate) AS `Amount Out`, t.client_id AS `Client ID`, t.invoice_id AS `Invoice ID`, m.modname AS `Payment Gateway` FROM hb_transactions t JOIN hb_invoices i ON (i.id=t.invoice_id) JOIN hb_invoice_items it ON (it.invoice_id=i.id) JOIN hb_client_details d ON (d.id=t.client_id) JOIN hb_modules_configuration m ON (m.id=t.`module`) WHERE t.date>= :date_bottom AND t.date<= :date_top ORDER BY t.date DESC', '1'
);