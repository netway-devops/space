REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'invoices', 'generated_automatically', 'Generated automatically' FROM hb_language WHERE target!='user'
UNION SELECT id, 'invoices', 'generated_automatically_order', 'Generated automatically for order' FROM hb_language WHERE target!='user'
UNION SELECT id, 'invoices', 'created_by_staff', 'Created manually by Staff' FROM hb_language WHERE target!='user'
UNION SELECT id, 'invoices', 'issued_from_recurring', 'Issued from Recuring invoice' FROM hb_language WHERE target!='user';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'product_code', 'Product Code' FROM hb_language WHERE target!='user';
##########
ALTER TABLE hb_products ADD `code` VARCHAR(128) DEFAULT NULL;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'invoices', 'document_origin', 'Document Origin' FROM hb_language WHERE target!='user';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'promotions','Promotions' FROM hb_language
UNION SELECT id, 'global', 'promotionsmanagment','Promotions Managment' FROM hb_language WHERE target !='user'
UNION SELECT id, 'global', 'addnewcode','Add new code' FROM hb_language WHERE target !='user'
UNION SELECT id, 'global', 'creditvouchers','Credit Vouchers' FROM hb_language WHERE target !='user'
UNION SELECT id, 'global', 'vouchercode','Voucher code' FROM hb_language
UNION SELECT id, 'global', 'redeem','Redeem' FROM hb_language
UNION SELECT id, 'global', 'redeemvoucher','Redeem a voucher' FROM hb_language
UNION SELECT id, 'global', 'addnewbatch','Add new vouchers batch' FROM hb_language WHERE target !='user'
UNION SELECT id, 'global', 'managebatch','Manage batch' FROM hb_language WHERE target !='user'
UNION SELECT id, 'global', 'codes','Codes' FROM hb_language WHERE target !='user'
UNION SELECT id, 'global', 'vouchernotfound','This voucher code can not be found' FROM hb_language WHERE target ='user'
UNION SELECT id, 'global', 'voucheralreadyused','This voucher has already been redeemed' FROM hb_language WHERE target ='user'
UNION SELECT id, 'global', 'voucherexpired','This voucher expired on ' FROM hb_language WHERE target ='user'
UNION SELECT id, 'global', 'voucherfornewcusts','This voucher is available only to new customers' FROM hb_language WHERE target ='user'
UNION SELECT id, 'global', 'voucheronepercust','Sorry, only one voucher per customer' FROM hb_language WHERE target ='user'
UNION SELECT id, 'global', 'vouchersuccessredeemed','Success! Voucher code has been redeemed' FROM hb_language WHERE target ='user'
UNION SELECT id, 'creditvouchers', 'cancel','Cancel' FROM hb_language WHERE target !='user'
UNION SELECT id, 'creditvouchers', 'generate','Generate' FROM hb_language WHERE target !='user'
UNION SELECT id, 'creditvouchers', 'createpageheader','Create a new batch of voucher codes' FROM hb_language WHERE target !='user'
UNION SELECT id, 'creditvouchers', 'creditvouchersheader','Manage Credit Vouchers Batches' FROM hb_language WHERE target !='user'
UNION SELECT id, 'creditvouchers', 'creditvouchersdesc','Use this feature to generate batches of vouchers which you can send to customers, enabling them to receive free credit from you.' FROM hb_language
UNION SELECT id, 'creditvouchers', 'batchname','Batch name' FROM hb_language WHERE target !='user'
UNION SELECT id, 'creditvouchers', 'batchsize','Batch size' FROM hb_language WHERE target !='user'
UNION SELECT id, 'creditvouchers', 'vouchercodelayout','Voucher code layout' FROM hb_language WHERE target !='user'
UNION SELECT id, 'creditvouchers', 'codecomplexity','Code complexity' FROM hb_language WHERE target !='user'
UNION SELECT id, 'creditvouchers', 'codeprefix','Code prefix' FROM hb_language WHERE target !='user'
UNION SELECT id, 'creditvouchers', 'vouchervalue','Voucher value' FROM hb_language WHERE target !='user'
UNION SELECT id, 'creditvouchers', 'currency','Currency' FROM hb_language WHERE target !='user'
UNION SELECT id, 'creditvouchers', 'expirydate','Expiry date' FROM hb_language WHERE target !='user'
UNION SELECT id, 'creditvouchers', 'voucherperoneacc','Limit voucher codes to one per account' FROM hb_language WHERE target !='user'
UNION SELECT id, 'creditvouchers', 'vouchertonewacc','Only available to new clients' FROM hb_language WHERE target !='user'
UNION SELECT id, 'creditvouchers', 'usedvouchers','Amount of used vouchers' FROM hb_language WHERE target !='user'
UNION SELECT id, 'creditvouchers', 'generatenewcodes','Generate additional codes' FROM hb_language WHERE target !='user';
##########
CREATE TABLE IF NOT EXISTS `hb_creditvouchers_batches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `prefix` varchar(5) NOT NULL,
  `code_layout` int(2) NOT NULL,
  `complexity` int(2) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `active` int(2) DEFAULT 0,
  `currency_id` int(11) DEFAULT 0,
  `value` decimal(10,2) NOT NULL DEFAULT '0.00',
  `one_per_account` int(2) DEFAULT 0,
  `only_new_clients` int(2) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_creditvouchers_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `batch_id` int(11) NOT NULL,
  `code` varchar(32) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;