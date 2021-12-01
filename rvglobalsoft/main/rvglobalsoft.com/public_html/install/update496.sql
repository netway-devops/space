UPDATE `hb_configuration` SET `value` = '4.9.6' WHERE `setting`= 'Version';
##########
ALTER TABLE  `hb_invoices` CHANGE  `status`  `status` ENUM(  'Paid',  'Unpaid',  'Cancelled',  'Draft',  'Recurring',  'Refunded',  'Creditnote' ) NOT NULL;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'creditnote','Credit Note' FROM hb_language
UNION SELECT id, 'global', 'Creditnote','Credit Note' FROM hb_language
UNION SELECT id, 'global', 'Creditnotes','Credit Notes' FROM hb_language
UNION SELECT id, 'global', 'creditnote_date','Date issued' FROM hb_language
UNION SELECT id, 'global', 'related_invoice','Related invoice' FROM hb_language
UNION SELECT id, 'configuration', 'CNoteNumerationFormat','Credit note numeration format' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'CNoteNumerationFrom', 'Next credit note number' FROM hb_language WHERE target!='user';
##########
CREATE TABLE `hb_creditnotes` (
 `invoice_id` int(11) NOT NULL,
 `credit_note_id` int(11) NOT NULL,
 `invoice_item_id` int(11) NOT NULL DEFAULT '0',
 `credit_item_id` int(11) NOT NULL DEFAULT '0',
 PRIMARY KEY (`invoice_id`,`credit_note_id`,`invoice_item_id`),
 KEY `credit_item_id` (`credit_item_id`)
) ENGINE=InnoDB;
##########
ALTER TABLE  `hb_templates` CHANGE  `target`  `target` ENUM(  'admin',  'user',  'invoice',  'estimate',  'creditnote' ) NOT NULL;
##########
INSERT INTO  `hb_templates` (  `id` ,  `parent_id` ,  `name` ,  `target` ,  `created` ,  `updated` ) 
VALUES (
NULL , 0,  'Default',  'creditnote', NOW( ) , NOW( )
);
##########
INSERT INTO `hb_template_content` (`id`, `template_id`, `name`, `content`, `checksum`, `updated`) 
SELECT NULL, `id`, 'Default', '<style type="text/css"><!--\r\n    body {\r\n        font-family: Arial;\r\n    }\r\n--></style>\r\n<div id="invoice-table" style="padding: 40px; font-family: Arial;">\r\n<table style="width: 100%;" border="0" cellspacing="0">\r\n<tbody>\r\n<tr id="invoice-header">\r\n<td style="padding-left: 10px;" colspan="2" align="left" valign="middle" width="66%"><span style="font-size: 18px; font-weight: bold; color: #484740;">{$companylogo}</span> <span style="font-size: 18px; font-weight: bold; color: #a4a4a4;">{$invoice.number}</span></td>\r\n<td align="right" valign="middle">\r\n<table border="0" cellspacing="0" cellpadding="2">\r\n<tbody>\r\n<tr>\r\n<td align="right"><span style="font-size: 12px; font-weight: bold;">{$lang.creditnote}</span></td>\r\n<td align="left"><span style="font-size: 12px;">{$invoice.id}</span></td>\r\n</tr>\r\n<tr>\r\n<td align="right"><span style="font-size: 12px; font-weight: bold;">{$lang.creditnote_date}</span></td>\r\n<td align="left"><span style="font-size: 12px;">{$invoice.date}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr id="invoice-details">\r\n<td style="padding-top: 40px;" valign="top" width="33%"><span style="font-size: 12px; font-weight: bold;">{$lang.invoice_to}</span><br /> <span style="font-size: 11px;">{$client.companyname}<br /> {$client.firstname} {$client.lastname}<br /> {$client.address1} <br /> {$client.address2}<br /> {$client.city}, {$client.state}{$client.postcode}<br /> {$client.country} </span></td>\r\n<td style="padding-top: 40px;" valign="top" width="33%"><span style="font-size: 12px; font-weight: bold;">{$lang.invoice_from}</span><br /> <span style="font-size: 11px;">HostBill Demo</span></td>\r\n<td style="padding-top: 40px;" align="left" valign="top" width="33%">\r\n<table border="0" cellspacing="0" cellpadding="2">\r\n<tbody>\r\n<tr>\r\n<td align="right"><span style="font-size: 12px; font-weight: bold;">{$lang.balance}:</span></td>\r\n<td align="left"><span style="font-size: 12px; font-weight: bold;">{$transbalance}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<!--{if $invoice.related_invoice_number}--><span style="font-size: 11px; font-weight: bold;">{$lang.related_invoice} {$invoice.related_invoice_number} {$lang.from} {$invoice.related_invoice_date}</span><!--{/if}-->\r\n<table class="invoice-table" style="margin-top: 50px; width: 100%;" border="0" cellspacing="0" cellpadding="6">\r\n<tbody>\r\n<tr>\r\n<td align="left" valign="middle" bgcolor="#f0f0f0"><span style="font-size: 11px; font-weight: bold;">{$lang.invoice_desc}</span></td>\r\n<td style="width: 7%;" align="center" valign="middle" bgcolor="#f0f0f0"><span style="font-size: 11px; font-weight: bold;">{$lang.invoice_tax}</span></td>\r\n<td style="width: 15%;" align="right" valign="middle" bgcolor="#f0f0f0"><span style="font-size: 11px; font-weight: bold;">{$lang.unitcost}</span></td>\r\n<td style="width: 7%;" align="center" valign="middle" bgcolor="#f0f0f0"><span style="font-size: 11px; font-weight: bold;">{$lang.qty}</span></td>\r\n<td style="width: 15%;" align="right" valign="middle" bgcolor="#f0f0f0"><span style="font-size: 11px; font-weight: bold;">{$lang.price}</span></td>\r\n</tr>\r\n<tr>\r\n<td style="border-bottom: 1px solid #F0F0F0;" valign="middle"><span style="font-size: 11px;">{$item.description}</span></td>\r\n<td style="border-bottom: 1px solid #F0F0F0;" align="center" valign="middle"><span style="font-size: 11px;">{$item.taxed}</span></td>\r\n<td style="border-bottom: 1px solid #F0F0F0;" align="right" valign="middle"><span style="font-size: 11px;">{$item.amount}</span></td>\r\n<td style="border-bottom: 1px solid #F0F0F0;" align="center" valign="middle"><span style="font-size: 11px;">{$item.qty}</span></td>\r\n<td style="border-bottom: 1px solid #F0F0F0;" align="right" valign="middle"><span style="font-size: 11px;">{$item.linetotal}</span></td>\r\n</tr>\r\n<tr>\r\n<td>&nbsp;</td>\r\n<td colspan="2" align="right" valign="middle"><span style="font-size: 12px; font-weight: bold;">{$lang.subtotal}</span></td>\r\n<td colspan="2" align="right" valign="middle"><span style="font-size: 12px;">{$invoice.subtotal}</span></td>\r\n</tr>\r\n<tr>\r\n<td>&nbsp;</td>\r\n<td colspan="2" align="right" valign="middle"><span style="font-size: 12px; font-weight: bold;">{$lang.tax} ({$invoice.taxrate}%)</span></td>\r\n<td colspan="2" align="right" valign="middle"><span style="font-size: 12px;">{$invoice.tax}</span></td>\r\n</tr>\r\n<tr>\r\n<td>&nbsp;</td>\r\n<td colspan="2" align="right" valign="middle"><span style="font-size: 12px; font-weight: bold;">{$lang.tax} ({$invoice.taxrate2}%)</span></td>\r\n<td colspan="2" align="right" valign="middle"><span style="font-size: 12px;">{$invoice.tax2}</span></td>\r\n</tr>\r\n<tr>\r\n<td>&nbsp;</td>\r\n<td colspan="2" align="right" valign="middle"><span style="font-size: 14px; font-weight: bold;">{$lang.total}</span></td>\r\n<td colspan="2" align="right" valign="middle"><span style="font-size: 14px; font-weight: bold;">{$invoice.total}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table style="margin-top: 50px; width: 100%;" border="0" cellspacing="0" cellpadding="0">\r\n<tbody>\r\n<tr>\r\n<td style="width: 100%;" align="left" valign="middle"><span style="font-size: 11px;"><em>{$invoice.notes}</em></span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table style="margin-top: 50px; width: 100%;" border="0" cellspacing="0" cellpadding="0">\r\n<tbody>\r\n<tr>\r\n<td style="border-top: 1px solid #F0F0F0; padding-top: 10px; width: 100%;" align="center"><span style="font-size: 11px; color: #a4a4a4;">Invoice footer text</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>',
 '93fc76301bc84500e071b1b69a73f098',NOW() FROM `hb_templates` WHERE `name`='Default' AND `target`='creditnote';
##########
REPLACE INTO hb_configuration (`setting`, `value`) SELECT 'CNoteTemplate', `id` FROM `hb_templates` WHERE `name`='Default' AND `target`='creditnote';
##########
REPLACE INTO hb_configuration (`setting`, `value`) SELECT 'CNoteTemplate', `id` FROM `hb_templates` WHERE `name`='Default' AND `target`='creditnote';
##########
REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES
('CnoteEnable', 'off'),
('CNoteNumerationPaid', '1'),
('CNoteNumerationFormat', '{$number}/{$y}');
##########
INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `send`, `plain`, `system`, `hidden`) VALUES
(NULL, 'CreditNote:New', 'Invoice', 'Client', 1, 'New Credit Note Created', 'Dear {$client.firstname} {$client.lastname}, \r\n\r\nCredit Note  #{$invoice.id} \r\nAMOUNT: {$invoice.total|price:$currency}\r\nGENERATED ON: {$invoice.date|dateformat:$date_format}.\r\n\r\nItems\r\n{foreach from=$invoiceitems item=item}\r\n {$item.description}  {if $item.qty}{$item.qty} x {/if}{$item.amount|price:$currency}\r\n{/foreach}\r\n\r\n', 1, 1, 1, 0);
##########
ALTER TABLE `hb_client_activity_log`
ADD COLUMN `admin_id` INT(11) NOT NULL DEFAULT '0' AFTER `client_id`,
ADD COLUMN `admin_name` VARCHAR(50) NOT NULL DEFAULT '' AFTER `admin_id`,
ADD COLUMN `event` VARCHAR(100) NOT NULL DEFAULT '' AFTER `admin_name`;
##########
ALTER TABLE `hb_order_log`
ADD COLUMN `type` VARCHAR(100) NOT NULL DEFAULT '' AFTER `date`;