UPDATE `hb_reports` SET `query` = 'SELECT i.id as `Invoice ID`,\r\n CONCAT(d.firstname,\' \',d.lastname) as `Client`,\r\n i.total as `Invoice Total`,\r\n i.status as `Invoice Status`,\r\n CASE WHEN hbc.value = \'eu\' THEN DATE(i.datepaid) ELSE DATE(i.date) END as `Invoice Date`,\r\n i.credit as `Invoice Credit`,\r\n m.modname as `Gateway Name`,\r\n taxrate as `Tax1 rate`,\r\n taxrate2 as `Tax2 rate`,\r\n tax as `Tax1 Amount`,\r\n tax2 as `Tax2 Amount`,\r\n i.rate as `Exchange Rate`,\r\n DATE(i.duedate) as `Invoice Due Date`,\r\n DATE(i.datepaid) as `Invoice Paid Date`,\r\n t.trans_id as `Related transaction`,\r\n i.client_id as `Client ID`,\r\n ca.email as `Client Email`,\r\n d.phonenumber as `Client Phone`,\r\n d.companyname as `Client Company`,\r\n d.city as `Client City`,\r\n d.country as `Client Country`,\r\n d.address1 as `Client Address`,\r\n d.postcode as `Client ZIP` \r\nFROM hb_invoices i \r\nINNER JOIN hb_client_details d ON (i.client_id = d.id) \r\nINNER JOIN hb_client_access ca ON (i.client_id = ca.id) \r\nLEFT JOIN hb_modules_configuration m ON (m.id = i.payment_module) \r\nLEFT JOIN hb_currencies c ON (c.id = i.currency_id) \r\nLEFT JOIN hb_transactions t ON (t.invoice_id = i.id) \r\nLEFT JOIN hb_configuration hbc ON hbc.setting = \'InvoiceModel\' \r\nWHERE\r\n i.id NOT IN (SELECT invoice_id \r\nFROM hb_invoice_items \r\nWHERE\r\n `type` = \'Invoice\') \r\nAND i.status NOT IN (\'Draft\', \'Recurring\') \r\nAND i.`date` >= :date_bottom \r\nAND i.`date` <= :date_top \r\nAND i.client_id = :client_id \r\n\r\nORDER BY i.id ASC' 
WHERE type='Invoices'  AND name= "Statement of account per customer";
##########
CREATE TABLE IF NOT EXISTS `hb_invoices_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `who` VARCHAR(32) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_id` (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_invoices`
CHANGE COLUMN `status` `status` ENUM('Paid','Unpaid','Cancelled','Draft','Recurring','Refunded','Credited','Creditnote') NOT NULL AFTER `recurring_id`;
##########
ALTER TABLE `hb_notes`
CHANGE COLUMN `type` `type` ENUM('client','account','domain','order','draft','admin','invoice','estimate') NOT NULL DEFAULT 'client' AFTER `id`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'Credited','Credited' FROM hb_language;
