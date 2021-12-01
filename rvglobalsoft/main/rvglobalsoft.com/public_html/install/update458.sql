UPDATE `hb_configuration` SET `value` = '4.5.8' WHERE `setting`= 'Version';
##########
ALTER TABLE  `hb_invoices` ADD  `rate2` DECIMAL( 10, 4 ) NOT NULL DEFAULT  '0.0000' AFTER  `rate`;
##########
REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES
('StorePDFInvoice', 'off'),
('AttachPDFCopy', 'off'),
('StorePDFPath', '');
##########
CREATE TABLE IF NOT EXISTS `hb_currency_cache` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `currency_id` int(11) NOT NULL,
 `rate` DECIMAL( 10, 4 ) NOT NULL DEFAULT  '0.0000',
 `comment` varchar(127) NOT NULL,
 `date` date NOT NULL,
 PRIMARY KEY (`id`,`currency_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_templates` (`id`, `parent_id`, `name`, `target`, `created`, `updated`) VALUES
(100, 0, 'EU Invoicing', 'invoice', '2013-05-16 03:30:01', '2013-05-16 03:30:01');
##########
REPLACE INTO `hb_template_content` (`id`, `template_id`, `name`, `content`, `checksum`, `updated`) VALUES
(100, 100, 'EU Invoicing', '<style type="text/css"><!--\r\n    body {\r\n        font-family: Verdana, Arial, Helvetica;\r\n    }\r\n    #invoice-content #invoice-table {\r\n        padding-top:40px !important;\r\n    }\r\n    .fs_11 {\r\n        font-size:11px;\r\n    }\r\n    #invoice-items-table{\r\n        border-collapse: collapse;\r\n    }\r\n    .fullborder {\r\n        border:solid 1px #000;\r\n    }\r\n    .rowspace td {\r\n        height:2px;padding:0px;\r\n    }\r\n    .doubleborder {\r\n        border:solid 2px #000; font-weight:bold;\r\n    }\r\n    .noborder {\r\n        border:none;\r\n    }\r\n--></style>\r\n<div id="invoice-table" style="padding: 20px; font-family: Verdana, Arial, Helvetica;">\r\n<table style="width: 100%; margin-bottom: 20px;" border="0" cellspacing="0">\r\n<tbody>\r\n<tr id="invoicetitle">\r\n<td style="border-bottom: solid 1px #000;" colspan="3" align="right" valign="middle" width="66%"><em style="font-size: 18px; font-weight: bold;">{$invoice.number}</em></td>\r\n</tr>\r\n<tr id="invoice-dateinfo">\r\n<td class="fs_11" colspan="3" align="right">{$lang.original}<br />{$lang.invoice_date}: {$invoice.date}</td>\r\n</tr>\r\n<tr id="invoice-spacer">\r\n<td colspan="3">&nbsp;</td>\r\n</tr>\r\n<tr id="invoice-details">\r\n<td style="border: solid 1px #000;" valign="top" width="45%"><span style="font-size: 12px; font-weight: bold;">{$lang.invoice_from}</span></td>\r\n<td align="left" valign="top" width="10%">&nbsp;</td>\r\n<td style="border: solid 1px #000;" valign="top" width="45%"><span style="font-size: 12px; font-weight: bold;">{$lang.invoice_to}</span> <br /> <span style="font-size: 11px;">{if $client.companyname}{$client.companyname}, {/if}{$client.firstname} {$client.lastname}<br /> {$client.address1} {if $client.address2}, {$client.address2}{/if}{if $client.postcode}, {$client.postcode}{/if} {$client.city} {if $client.country}, {$client.country}{/if}{if $client.vateu}<br />{$lang.vateu}: {$client.vateu}{/if}</span></td>\r\n</tr>\r\n<tr id="invoice-spacer">\r\n<td colspan="3">&nbsp;</td>\r\n</tr>\r\n<tr id="invoice-payinfo">\r\n<td class="fs_11" colspan="3" align="left">{$lang.paymethod}: {$invoice.paymentgw}<br /> {$lang.dateofsale}: {$invoice.date}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<span style="font-size: 11px;">{foreach from=$transactions item=trans}{$lang.trans_id} {$trans.trans_id}{break}{/foreach}</span>{if $invoice.notes}{/if}\r\n<table id="invoice-items-table" class="invoice-table" style="width: 100%;" border="0" cellspacing="0" cellpadding="6">\r\n<tbody>\r\n<tr>\r\n<td class="fullborder" align="left" valign="middle" bgcolor="#f0f0f0"><span style="font-size: 11px; font-weight: bold;">{$lang.invoice_desc}</span></td>\r\n<td class="fullborder" style="width: 8%;" align="right" valign="middle" bgcolor="#f0f0f0"><span style="font-size: 11px; font-weight: bold;">{$lang.qty}</span></td>\r\n<td class="fullborder" style="width: 11%;" align="right" valign="middle" bgcolor="#f0f0f0"><span style="font-size: 11px; font-weight: bold;">{$lang.unitcost}</span></td>\r\n<td class="fullborder" style="width: 11%;" align="right" valign="middle" bgcolor="#f0f0f0"><span style="font-size: 11px; font-weight: bold;">{$lang.netprice}</span></td>\r\n<td class="fullborder" style="width: 8%;" align="right" valign="middle" bgcolor="#f0f0f0"><span style="font-size: 11px; font-weight: bold;">{$lang.tax}</span></td>\r\n<td class="fullborder" style="width: 11%;" align="right" valign="middle" bgcolor="#f0f0f0"><span style="font-size: 11px; font-weight: bold;">{$lang.taxamount}</span></td>\r\n<td class="fullborder" style="width: 11%;" align="right" valign="middle" bgcolor="#f0f0f0"><span style="font-size: 11px; font-weight: bold;">{$lang.grossprice}</span></td>\r\n</tr>\r\n<tr>\r\n<td class="fullborder" valign="middle"><span style="font-size: 11px;">{$item.description}</span></td>\r\n<td class="fullborder" align="right" valign="middle"><span style="font-size: 11px;">{$item.qty}</span></td>\r\n<td class="fullborder" align="right" valign="middle"><span style="font-size: 11px;">{$item.amount}</span></td>\r\n<td class="fullborder" align="right" valign="middle"><span style="font-size: 11px;">{$item.linetotal}</span></td>\r\n<td class="fullborder" align="right" valign="middle"><span style="font-size: 11px;">{if !$item.tax_rate}{$lang.nottaxed}{else}{$item.tax_rate}%{/if}</span></td>\r\n<td class="fullborder" align="right" valign="middle"><span style="font-size: 11px;">{$item.tax_amount}</span></td>\r\n<td class="fullborder" align="right" valign="middle"><span style="font-size: 11px;">{$item.linetaxed}</span></td>\r\n</tr>\r\n<tr>\r\n<td colspan="2" valign="middle"><span style="font-size: 12px; font-weight: bold;">{$lang.invoicedue}: {$invoice.total}</span></td>\r\n<td align="right" valign="middle"><span style="font-size: 12px; font-weight: bold;">{$lang.total}</span></td>\r\n<td class="fullborder" align="right" valign="middle"><span style="font-size: 11px;">{$invoice.subtotal}</span></td>\r\n<td class="fullborder" align="right" valign="middle">&nbsp;</td>\r\n<td class="fullborder" align="right" valign="middle"><span style="font-size: 11px;">{$invoice.tax}</span></td>\r\n<td class="doubleborder" align="right" valign="middle"><span style="font-size: 11px;">{$invoice.total}</span></td>\r\n</tr>\r\n<tr class="rowspace">\r\n<td colspan="7">&nbsp;</td>\r\n</tr>\r\n<tr>\r\n<td colspan="2" valign="middle">&nbsp;</td>\r\n<td align="right" valign="middle">{if $smarty.foreach.taxloop.first}<span style="font-size: 12px; font-weight: bold;">{$lang.including}</span>{/if}</td>\r\n<td class="fullborder" align="right" valign="middle"><span style="font-size: 11px;">{$taxitm.subtotal}</span></td>\r\n<td class="fullborder" align="right" valign="middle"><span style="font-size: 11px;">{if !$taxitm.name}{$lang.nottaxed}{else}{$taxitm.name}%{/if}</span></td>\r\n<td class="fullborder" align="right" valign="middle"><span style="font-size: 11px;">{$taxitm.tax}</span></td>\r\n<td class="fullborder" align="right" valign="middle"><span style="font-size: 11px;">{$taxitm.total}</span></td>\r\n</tr>\r\n<tr>\r\n<td style="font-size: 12px;" colspan="3" valign="middle">{$lang.Paid}: {$totalpaid}<br /> {$lang.leftunpaid}: {$transbalance}</td>\r\n<td colspan="4" valign="middle">&nbsp;</td>\r\n</tr>\r\n<tr>\r\n<td colspan="3" valign="middle">&nbsp;</td>\r\n<td style="font-size: 11px; border: solid 1px #000;" colspan="4" valign="middle">{$lang.notes}<br />{$invoice.notes}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table style="margin-top: 50px; width: 100%;" border="0" cellspacing="0" cellpadding="0">\r\n<tbody>\r\n<tr>\r\n<td style="width: 100%;" align="left" valign="middle"><span style="font-size: 11px;">{$lang.pdfagreement}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table style="margin-top: 50px; width: 100%;" border="0" cellspacing="0" cellpadding="0">\r\n<tbody>\r\n<tr>\r\n<td style="border-top: 1px solid #F0F0F0; padding-top: 10px; width: 100%;" align="right"><span style="font-size: 11px; color: #a4a4a4;">Invoice footer text</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>', 'b3d83359bb9fd7290243d07b6a9a8176', '2013-05-16 13:04:47');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'StorePDFInvoice','Store PDF invoice' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'dateofsale','Date of sale' FROM hb_language 
UNION SELECT id, 'global', 'vateu','VAT' FROM hb_language 
UNION SELECT id, 'global', 'pdfagreement','Sent in PDF form, as agreed in Terms and Conditions' FROM hb_language 
UNION SELECT id, 'global', 'taxamount','Tax Amount' FROM hb_language 
UNION SELECT id, 'global', 'grossprice','Total gross price' FROM hb_language
UNION SELECT id, 'global', 'netprice','Total net price' FROM hb_language 
UNION SELECT id, 'global', 'original','Original' FROM hb_language
UNION SELECT id, 'global', 'copy','Copy' FROM hb_language
UNION SELECT id, 'global', 'invoicedue','Total due' FROM hb_language 
UNION SELECT id, 'global', 'nottaxed','-' FROM hb_language 
UNION SELECT id, 'global', 'leftunpaid','Left to pay' FROM hb_language 
UNION SELECT id, 'global', 'including','Including' FROM hb_language 
UNION SELECT id, 'configuration', 'StorePDFInvoice_descr','store final PDF invoice under: ' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'AttachPDFCopy_descr1','only original should go into PDF' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'AttachPDFCopy_descr','add copy as second invoice page' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'AttachPDFCopy','Original and copy in one pdf' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'StorePDFInvoice_descr1','dont store, generate pdf each time its requested' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'StorePDFInvoice_descr2','Provide full path to folder where HostBill should store your PDF invoices, it should have same chmod/owner as templates_c folder' FROM hb_language WHERE target='admin'
UNION SELECT id, 'clientarea', 'haenabled','HA-Enabled' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'newrootpasword','Click here to generate root pasword' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'snapshots','Snapshots' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'snapshotconversion_description','Snapshot conversion lets you create a Template from an existing Virtual Machine configuration, which you can then use to redeploy new Virtual Machines. To convert your Backup, enter a Label name for your new template and click the Convert Backup button.' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'alocateaddresserror','Can\'t alocate IP address' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'noavailablenetworks','No available networks' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'nobuckups','Backups not available for this VPS' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'resourcelimitreached','Resource limit reached' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'firewallrulecheduledrem','Selected firewall rule has been scheduled for removal' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'rulebeenscheduledcreation','Rule has been scheduled for creation' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'rulescheduledremoval','Selected rule has been scheduled for removal' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'associateaddresserror','Could not associate ip address' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'obitainassociatederror','Could not obitain associated ip address' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'removeaddresserror','Could not remove ip address' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'disablestaticnaterror','Could not disable Static NAT' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'pickfirst','Pick VM first' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'networkinterfacebeenupdated','Selected network interface has been updated' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'networkinterfacewillremoved','Selected network interface will be removed shortly' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'vmbeenscheduledreboot','VM has been scheduled for reboot.' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'backupbeenscheduledremoval','Backup has been scheduled for removal' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'templatecreationbeenscheduled','Template creation has been scheduled' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'vmbeenscheduledstartup','VM has been scheduled for startup.' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'templatescheduledremoval','Template is scheduled for removal' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'diskbeenscheduledbackup','Disk has been scheduled for backup' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'vmbeeensheduledstop','Virtual machine will be stopped shortly' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'vmbeenscheduleddestruction','VM has been scheduled for destruction.' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'vmrebuildbeenscheduled','VM Rebuild has been scheduled' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'creatingrootpassword','Creating root password' FROM hb_language WHERE target='user';
##########
CREATE TABLE `hb_notes` (
    `id` INT(10) NOT NULL AUTO_INCREMENT,
    `type` ENUM('client','account','domain','order') NOT NULL,
    `rel_id` INT(10) NOT NULL,
    `admin_id` INT(10) NOT NULL,
    `date` DATETIME NOT NULL,
    `note` TEXT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `type` (`type`),
    INDEX `rel_id` (`rel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_notes` (`type`, `rel_id`, `admin_id`, `note`) 
SELECT 'account', a.id, 1, a.notes FROM hb_accounts a WHERE a.notes!=''
UNION SELECT 'domain', d.id, 1, d.notes FROM hb_domains d WHERE d.notes!=''
UNION SELECT 'client', c.id, 1, c.notes FROM hb_client_details c WHERE c.notes!=''
UNION SELECT 'order', o.id, 1, o.notes FROM hb_orders o WHERE o.notes!='';
##########
INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `send`, `plain`, `system`, `hidden`) VALUES
(NULL, 'Notes:Change', 'General', 'Admin', 1, 'Notes for {$type}: #{$id} updated', 'Note has just been updated for {$type} #{$id}\r\n\r\n{if $notes}\r\n{foreach from=$notes item=entry}\r\n----------------------------------------------------------------\r\n{$entry.date|dateformat:$date_format}\r\n{$entry.note}\r\n{/foreach}\r\n----------------------------------------------------------------\r\n{/if}\r\n\r\n{if $note}\r\n{if $note.action==\'add\'}New note:{else}Updated note:{/if}\r\n----------------------------------------------------------------\r\n{$note.date|dateformat:$date_format}\r\n{$note.note}\r\n{/if}\r\nURL: {$url}', 1, 1, 1, 0);

