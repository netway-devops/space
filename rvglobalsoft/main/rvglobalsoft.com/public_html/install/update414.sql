UPDATE `hb_configuration` SET `value` = '4.1.4' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES
('InvoiceStoreClient', 'off');
##########
ALTER TABLE `hb_api_access` ADD `acl` TEXT NULL;
##########
ALTER TABLE `hb_downloads` ADD `client_id` INT( 11 ) NOT NULL DEFAULT '0',
ADD INDEX ( `client_id` );
##########
ALTER TABLE `hb_invoices` ADD `metadata` TEXT NULL;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'captcha','Image Verification' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'refresh', 'Refresh' FROM hb_language WHERE target='user'
UNION SELECT id, 'downloads', 'myfiles_down', 'My files' FROM hb_language WHERE target='user';
##########
REPLACE INTO `hb_client_fields` (`code`, `name`, `field_type`, `default_value`, `type`, `options`, `description`, `sort_order`, `expression`) 
VALUES ('captcha', 'Image Verification', 'Input', '', 'All', 147, '', 100, NULL);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'InvoiceStoreClient','Store client details in invoice' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'InvoiceStoreClient_descr','Always use actual informations stored in client profile' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'InvoiceStoreClient1_descr','Client profile edits will not change invoice owner details' FROM hb_language WHERE target!='user'
UNION SELECT id, 'invoices', 'setcurrentclient','Click here to set client details on invoice with current client info' FROM hb_language WHERE target!='user'
UNION SELECT id, 'invoices', 'invoice_client_metadata_modified','Invoice owner details updated' FROM hb_language WHERE target!='user';