UPDATE `hb_configuration` SET `value` = '3.9.0' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'upgrade_not_available','It\'s not possible to upgrade this package at this moment. Please contact us to change your resource limits.' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'invalid_hostname','Invalid hostname' FROM hb_language
UNION SELECT id, 'global', 'invalid_template','Invalid OS template' FROM hb_language
UNION SELECT id, 'tickets', 'filtertickets','Search your tickets...' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'print_invoice','Print Invoice' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'download_pdf','Download PDF' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'ordermore','Order more' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'vpslimit','VPS limit' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'exp_date_empty','Expiration date must be provided' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'exp_date_invalid','Expiration date is not valid' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'unsupported_cc','Unsupported credit card type' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'invalid_ccnum','Invalid credit card number' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ticketdepts', 'newticketemail','New Ticket email' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'CCAllowRemove','Allow to remove CC' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'CCAllowRemove_dscr1','Clients are not allowed to remove their credit cards' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'CCAllowRemove_dscr2','Clients can remove their credit cards' FROM hb_language WHERE target='admin';
##########
UPDATE `hb_language_locales` SET `section` = 'global' 
WHERE (`keyword` = 'techinfo' AND `section` = 'clientarea') 
OR (`keyword` = 'billinginfo' AND `section` = 'clientarea')
OR (`keyword` = 'registrantinfo' AND `section` = 'clientarea')
OR (`keyword` = 'seconds' AND `section` = 'stats');
##########
UPDATE `hb_email_templates` SET `message`='Dear {$client.firstname} {$client.lastname}, \r\n\r\nINVOICE  #{$invoice.id} \r\nSTATUS: {$invoice.status}\r\nAMOUNT DUE: {$invoice.total|price:$currency}\r\nDUE DATE: {$invoice.duedate|dateformat:$date_format}\r\nGENERATE ON: {$invoice.date|dateformat:$date_format}.\r\n\r\nPAYMENT METHOD:\r\n {$invoice.gateway}\r\n\r\nInvoice Items\r\n{foreach from=$invoiceitems item=item}\r\n {$item.description}  {if $item.qty}{$item.qty} x {/if}{$item.amount|price:$currency}\r\n{/foreach}\r\n------------------------------------------------------\r\n\r\nPAY LINK:\r\n {$invoices_url}\r\n\r\n' 
WHERE MD5(message) = 'dbe04f4b988cc7f55002c0c8cb50efd0';
##########
ALTER TABLE `hb_client_billing` ADD `token` BLOB NOT NULL ,
ADD `token_gateway_id` INT( 11 ) NOT NULL DEFAULT '0';
##########
ALTER TABLE `hb_knowledgebase`
ADD COLUMN `language_id` INT(11) NOT NULL DEFAULT '1' AFTER `id`,
DROP PRIMARY KEY, ADD PRIMARY KEY (`id`, `language_id`);
##########
REPLACE INTO `hb_configuration` (`setting`,`value`) VALUES ('CCAllowRemove', 'on');
##########
ALTER TABLE `hb_email_assign` CHANGE COLUMN `rel` `rel` ENUM('Product','Addon','Department') NOT NULL DEFAULT 'Product' AFTER `id`;
##########
UPDATE `hb_ticket_filter_items` SET `content`='/eval\\s*\\(\\s*base64_decode/i' WHERE `content`='/eval\\s*(\\s*base64_decode/i' LIMIT 1;
##########
UPDATE hb_email_templates SET message=CONCAT('{$failed_tasks}\r\n',message) WHERE `tplname`='Cron Results';
