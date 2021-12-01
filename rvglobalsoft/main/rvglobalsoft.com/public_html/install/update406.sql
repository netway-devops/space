UPDATE `hb_configuration` SET `value` = '4.0.6' WHERE `setting`= 'Version';
##########
ALTER TABLE `hb_knowledgebase`
CHANGE COLUMN `registered` `registered` TINYINT(1) NOT NULL AFTER `body`,
ADD COLUMN `options` TINYINT(1) NOT NULL AFTER `registered`;
##########
REPLACE INTO `hb_reports` VALUES (2, 'Invoices', 'List of all invoices in given period', 'SELECT\r\ni.id AS `Invoice ID`,\r\nCONCAT(d.firstname,\' \',d.lastname) AS `Client`,\r\nhb_currency(i.total,i.currency_id,i.rate) AS `Invoice Total`,\r\ni.status AS `Invoice Status`,\r\nhb_date(i.date) AS `Invoice Date`,\r\nhb_currency(i.credit,i.currency_id,i.rate) AS `Invoice Credit`,\r\nm.modname AS `Gateway Name`,\r\ntaxrate as `Tax1 rate`,\r\ntaxrate2 as `Tax2 rate`,\r\ntax as `Tax1 Amount`,\r\ntax2 as `Tax2 Amount`,\r\ni.rate AS `Exchange Rate`,\r\nhb_date(i.duedate) AS `Invoice Due Date`,\r\nhb_date(i.datepaid) AS `Invoice Paid Date`,\r\nt.trans_id AS `Related transaction`,\r\nca.email AS `Client Email`,\r\nd.phonenumber AS `Client Phone`,\r\nd.companyname  AS `Client Company`,\r\nd.city AS `Client City`,\r\nd.country AS `Client Country`,\r\nd.address1 AS `Client Address`,\r\nd.postcode AS `Client ZIP`\r\n\r\nFROM hb_invoices i\r\n    JOIN hb_client_details d ON (i.client_id=d.id)\r\n    JOIN hb_client_access ca ON (i.client_id=ca.id)\r\n    LEFT JOIN hb_modules_configuration m ON (m.id=i.payment_module)\r\n    LEFT JOIN hb_currencies c ON (c.id=i.currency_id)\r\n    LEFT JOIN hb_transactions t ON (t.invoice_id=i.id)\r\nWHERE\r\n    i.id NOT IN (\r\n        SELECT invoice_id\r\n        FROM hb_invoice_items\r\n        WHERE `type` = \'Invoice\'\r\n    ) \r\n    AND i.status NOT IN (\'Draft\',\'Recurring\')\r\n    AND i.`date`>= :date_bottom\r\n    AND i.`date`<= :date_top\r\n\r\nORDER BY\r\n	i.id ASC', 1);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'openstacktype_hosting','OpenStack' FROM hb_language WHERE target!='user'
UNION SELECT id, 'cart', 'optimalchoicefor','optimal choice for' FROM hb_language WHERE target='user';
