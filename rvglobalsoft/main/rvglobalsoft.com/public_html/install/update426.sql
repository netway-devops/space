UPDATE `hb_configuration` SET `value` = '4.2.6' WHERE `setting`= 'Version';
##########
UPDATE `hb_reports` SET `query`='SELECT\r\ni.id AS `Invoice ID`,\r\nCONCAT(d.firstname,\' \',d.lastname) AS `Client`,\r\nhb_currency(i.total,i.currency_id,i.rate) AS `Invoice Total`,\r\ni.status AS `Invoice Status`,\r\nCASE WHEN hbc.value=\'eu\' THEN hb_date( i.datepaid) ELSE hb_date( i.date) END AS `Invoice Date`,\r\nhb_currency(i.credit,i.currency_id,i.rate) AS `Invoice Credit`,\r\nm.modname AS `Gateway Name`,\r\ntaxrate as `Tax1 rate`,\r\ntaxrate2 as `Tax2 rate`,\r\ntax as `Tax1 Amount`,\r\ntax2 as `Tax2 Amount`,\r\ni.rate AS `Exchange Rate`,\r\nhb_date(i.duedate) AS `Invoice Due Date`,\r\nhb_date(i.datepaid) AS `Invoice Paid Date`,\r\nt.trans_id AS `Related transaction`,\r\nca.email AS `Client Email`,\r\nd.phonenumber AS `Client Phone`,\r\nd.companyname  AS `Client Company`,\r\nd.city AS `Client City`,\r\nd.country AS `Client Country`,\r\nd.address1 AS `Client Address`,\r\nd.postcode AS `Client ZIP`\r\n\r\nFROM hb_invoices i\r\n    JOIN hb_client_details d ON (i.client_id=d.id)\r\n    JOIN hb_client_access ca ON (i.client_id=ca.id)\r\n    LEFT JOIN hb_modules_configuration m ON (m.id=i.payment_module)\r\n    LEFT JOIN hb_currencies c ON (c.id=i.currency_id)\r\n    LEFT JOIN hb_transactions t ON (t.invoice_id=i.id)\r\n    LEFT JOIN hb_configuration hbc ON hbc.setting=\'InvoiceModel\'\r\nWHERE\r\n    i.id NOT IN (\r\n        SELECT invoice_id\r\n        FROM hb_invoice_items\r\n        WHERE `type` = \'Invoice\'\r\n    ) \r\n    AND i.status NOT IN (\'Draft\',\'Recurring\')\r\n   AND ( (hbc.value!=\'eu\' AND i.`date`>=  :date_bottom AND i.`date`<= :date_top ) OR (hbc.value=\'eu\' AND i.`datepaid`>= :date_bottom AND i.`datepaid`<= :date_top) )\r\nORDER BY\r\n	i.id ASC' WHERE  `id`=2;
##########
CREATE TABLE `hb_product_bundles` (
	`product_id` INT(10) NOT NULL,
	`options` TINYINT(4) NOT NULL,
	`valid_from` DATE NOT NULL,
	`valid_to` DATE NOT NULL,
	`draft` INT(10) NULL DEFAULT NULL,
	PRIMARY KEY (`product_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_product_types` (`type`) VALUES ('bundles');
##########
INSERT INTO `hb_configuration` (`setting`, `value`) VALUES ('InvoiceExpectDays', '0');
##########
ALTER TABLE `hb_invoices` ADD `paybefore` DATE NOT NULL AFTER `duedate`;
##########
UPDATE `hb_invoices` SET `paybefore`=`duedate`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'bundles','Package bundles' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'priority','Priority' FROM hb_language WHERE target='user'
UNION SELECT id, 'configuration', 'InvoiceExpectDays','Invoice is expected to be paid ' FROM hb_language WHERE target!='user';
