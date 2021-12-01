ALTER TABLE `hb_aff`
ADD COLUMN `parent_id` INT(11) NOT NULL DEFAULT '0' AFTER `client_id`,
ADD COLUMN `withdraw_method` TINYINT(4) NOT NULL DEFAULT '0' AFTER `total_withdrawn`,
ADD COLUMN `sendreport` TINYINT(4) NOT NULL DEFAULT '0' AFTER `withdraw_method`;
##########
ALTER TABLE `hb_aff_widlog`
ADD COLUMN `method` TINYINT(4) NOT NULL DEFAULT '0' AFTER `note`,
ADD COLUMN `status` TINYINT NOT NULL DEFAULT '1' AFTER `method`;
##########
ALTER TABLE `hb_order_drafts`
ADD COLUMN `affiliate_id` INT(11) NOT NULL DEFAULT '0' AFTER `staff_member_id`;
##########
ALTER TABLE `hb_aff_orders`
ADD COLUMN `date_created` DATETIME NOT NULL AFTER `datepaid`;
##########
UPDATE hb_aff_orders a 
LEFT JOIN hb_orders o ON o.id=a.order_id
SET a.date_created = COALESCE(o.date_created,a.datepaid)
WHERE a.invoice_id=0
##########
UPDATE hb_aff_orders a 
LEFT JOIN hb_invoices i ON i.id=a.invoice_id
SET a.date_created = COALESCE(i.`date`, a.datepaid)
WHERE a.invoice_id!=0
##########
UPDATE `hb_cron_tasks` SET `run_every`='Month', `run_every_time`='1' WHERE `task`='affiliateMonthlyReport';
##########
INSERT INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `run_every`, `run_every_time`) 
VALUES ('affiliateAutoPayout', 'Automatic pay-out for affiliates', '', 1, 'Time', '1200');
##########
UPDATE `hb_email_templates` SET message = 'Dear {$client.firstname} {$client.lastname},\r\n\r\n\r\nThis is your monthly affiliate referrals report. You can view your affiliate statistics by logging in to the client area.\r\n\r\nTotal Visitors : {$affiliate.visits}\r\nCurrent Balance: {$affiliate.balance|price:$affiliate.currency_id}\r\nAmount Withdrawn: {$affiliate.total_withdrawn|price:$affiliate.currency_id}\r\n\r\n{if $affiliate.orders}\r\nNew Signups this Month referred by you:\r\n--\r\n{foreach from=$affiliate.orders item=order}\r\n{if $order.acstatus}Account: {$order.pname}\r\n{/if}{if $order.domstatus}Domain: {$order.domain}\r\n{/if}\r\nOrder Total: {$order.total|price:$affiliate.currency_id} \r\n{if $moredetails}\r\n{if $order.firstname || $order.lastname || $order.companyname}Client Info: {if $order.companyname}{$order.companyname}\r\n{else}{$order.firstname}{$order.lastname}{$order.companyname}\r\n{/if}\r\n{/if}\r\n{if $order.inv_id}Invoice ID: #{if $proforma && ($order.inv_status==\'Paid\' || $order.inv_status==\'Refunded\') && $order.inv_paid!=\'\'}{$order.inv_paid}\r\n{else}{$order.inv_date|invprefix:$prefix:$order.client_id}{$order.inv_id}\r\n{/if}\r\nInvoice Date: {$order.inv_date|dateformat:$date_format}\r\nInvoice Due Date: {$order.inv_due|dateformat:$date_format}\r\nInvoice Total: {$order.inv_total|price:$order.currency_id} \r\n{/if}{/if}\r\nCommission: {$order.commission|price:$affiliate.currency_id}\r\n--\r\n{/foreach}\r\n{/if}\r\nYou can refer new customers using your unique affiliate link: {$affiliate.url}\r\n'
WHERE tplname = 'Affiliate Monthly Report';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'affiliates', 'emailoncemonth','Email me once a month with commissions summary' FROM hb_language WHERE target='user'
UNION SELECT id, 'affiliates', 'receivecommissionsauto','Receive commissions automaticaly' FROM hb_language WHERE target='user'
UNION SELECT id, 'affiliates', 'check','Mailed Check' FROM hb_language WHERE target='user'
UNION SELECT id, 'affiliates', 'credit','Account Credit' FROM hb_language WHERE target='user';