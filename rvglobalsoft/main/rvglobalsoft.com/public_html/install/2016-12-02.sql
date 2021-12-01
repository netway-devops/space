INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`, `state`, `columns`)
VALUES
	(NULL, 'Invoices', 'All transactions in given period', 'SELECT t.trans_id as `Transaction ID`,\r\n t.date as `Transaction Date`,\r\n t.`in` as `Amount In`,\r\n t.`fee` as `Transaction Fees`,\r\n CONCAT(d.firstname,\' \',d.lastname) as `Client`,\r\n t.description as `Transaction Description`,\r\n t.`out` as `Amount Out`,\r\n t.client_id as `Client ID`,\r\n t.rate as `Currency Conversion Rate`,\r\n t.invoice_id as `Invoice ID`,\r\n COALESCE(cx.iso,\'Main Currency\') as `Currency`,\r\n m.modname as `Payment Gateway` \r\nFROM hb_transactions t \r\nINNER JOIN hb_client_details d ON (d.id = t.client_id) \r\nINNER JOIN hb_modules_configuration m ON (m.id = t.`module`) \r\nLEFT JOIN hb_currencies cx ON cx.id = t.currency_id \r\nWHERE\r\n t.date >= :date_bottom \r\nAND t.date <= :date_top \r\n\r\nORDER BY t.date DESC', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:10:{i:0;s:14:\"Transaction ID\";i:1;s:16:\"Transaction Date\";i:2;s:9:\"Amount In\";i:3;s:16:\"Transaction Fees\";i:4;s:10:\"Amount Out\";i:5;s:6:\"Client\";i:6;s:9:\"Client ID\";i:7;s:8:\"Currency\";i:8;s:24:\"Currency Conversion Rate\";i:9;s:15:\"Payment Gateway\";}');
##########
INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`, `state`, `columns`)
VALUES
	(NULL, 'Orders', 'Number of cancelations per customer in given period', 'SELECT cd.id as `Client ID`,\r\n CONCAT(cd.firstname,\' \',cd.lastname) as `Client`,\r\n COUNT(c.id) as `Cancellations Count` \r\nFROM hb_cancel_requests c \r\nINNER JOIN hb_accounts a ON a.id = c.account_id \r\nINNER JOIN hb_client_details cd ON cd.id = a.client_id \r\nWHERE\r\n c.date >= :date_bottom \r\nAND c.date <= :date_top \r\nGROUP BY cd.id', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:3:{i:0;s:9:\"Client ID\";i:1;s:6:\"Client\";i:2;s:19:\"Cancellations Count\";}');
##########
INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`, `state`, `columns`)
VALUES
	(NULL, 'Orders', 'Number of cancelations per product in given period', 'SELECT cd.id as `Product ID`,\r\n cd.name as `Product Name`,\r\n cat.name as `Category Name`,\r\n COUNT(c.id) as `Cancellations Count` \r\nFROM hb_cancel_requests c \r\nINNER JOIN hb_accounts a ON a.id = c.account_id \r\nINNER JOIN hb_products cd ON cd.id = a.product_id \r\nINNER JOIN hb_categories cat ON cat.id = cd.category_id \r\nWHERE\r\n c.date >= :date_bottom \r\nAND c.date <= :date_top \r\nGROUP BY cd.id', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:4:{i:0;s:10:\"Product ID\";i:1;s:12:\"Product Name\";i:2;s:13:\"Category Name\";i:3;s:19:\"Cancellations Count\";}');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'changeowner_widget','Change Owner' FROM hb_language WHERE target!='admin'
UNION SELECT id,
'clientarea',
'changeowner_invoiceinfo',
'Changing owner is not possible, if last invoice for this service is unpaid.'
FROM hb_language  WHERE target!='admin'
UNION SELECT id,
'clientarea',
'changeowner_ok',
'Owner successfully changed'
FROM hb_language  WHERE target!='admin'
UNION SELECT id,
'clientarea',
'changeowner_guide',
'Using this tool you can transfer this service to other account that exists in our system. Please enter new owner email address below to transfer'
FROM hb_language  WHERE target!='admin'
UNION SELECT id,
'clientarea',
'new_owner_email',
'New owner\'s email address'
FROM hb_language  WHERE target!='admin';