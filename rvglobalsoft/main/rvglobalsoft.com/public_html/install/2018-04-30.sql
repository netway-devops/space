CREATE TABLE IF NOT EXISTS `hb_client_details_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `name` varchar(100) NOT NULL,
  `purpose` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `admin_id` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
  SELECT id, 'clients', 'AnonymizeAccount','Anonymize Profile' FROM hb_language WHERE target='admin'
  UNION SELECT id, 'clients', 'anonymizeheading','Anonymize client profile' FROM hb_language WHERE target='admin'
  UNION SELECT id, 'clients', 'GDPRDetailsRequest','GDPR Details request' FROM hb_language WHERE target='admin'
  UNION SELECT id, 'global', 'gdprrequests', 'GDPR Requests' FROM hb_language WHERE target='admin'
  UNION SELECT id, 'global', 'PendingRemoval', 'Pending removal' FROM hb_language WHERE target='admin'
  UNION SELECT id, 'clientarea', 'delete_account','Delete my account / forget my data' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'delete_account_immediate','Are you sure? This request is processed immediately, you won\'t be able to go back.' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'delete_account_delay','Are you sure? Your account will be deactivated and permanently deleted after %s days. <br />If you change your mind before that time please contact us to reactivate it.' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'delete_account_result','Once account is deleted your active services will be terminated. Unused account credit will be lost and you will not be able to login to our client portal again.' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'yes_delete_account','Yes I want to delete my account' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'delete_account_unpaid','Following invoices cannot be automatically cancelled' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'delete_account_contact','Please contact us to resolve this and have your data removed' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'delete_account_goodbye','Your account was marked for deletion.' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'overview','Overview' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'overview_d','View your accounts details' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'information_type','Information type' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'purpose','Purpose' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'clientdata','Data' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'download_overview_json','You can download information we\'ve stored about you in machine-readable format (json) by clicking on the button below' FROM hb_language WHERE target='user'
  UNION SELECT id, 'global', 'completeorder','Complete Order' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'change_csr','Change CSR' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'cert_csr_title','Confirm Your Information' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'cert_csr_descr','The following info is what we were able to see contained within your CSR. In case if you need to correct those details simply replace your CSR with new one.' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'cert_conf_descr','This page will guide you trough certificate configuration. Once all details are filled out you will be able to submit your order to CA vendor.' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'cert_invoice_unpaid','Invoice %s needs to be paid before we can issue your certificate' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'cert_san_title','Subject alternative Names (SAN)' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'cert_san_descr','This certificate allows you to secure additional domains, please enter the domain(s) that you wish to be included in your new certificate.' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'san_item','SAN item' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'cert_dcv_title','Domain Control Validation (DCV)' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'cert_dcv_descr','DCV is a mechanism used to prove ownership or control of a registered domain name.' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'dcv_method','Validation Method' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'approver_email_for','Approval email for <strong>%s</strong>' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'cert_csr_guide','Paste your CSR in the form below, make sure to include the complete header and footer, \"BEGIN\" and \"END\" lines' FROM hb_language WHERE target='user';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES
  ('RemoveEmptyClients', 'off'),
  ('RemoveEmptyClientsDelay', '6'),
  ('RemoveInactiveClients', 'off'),
  ('RetainBillingMonths', '120'),
  ('EnableClientSelfDelete', 'off'),
  ('ClientDeleteDelay', '30'),
  ('GDPRExport', '["contacts","services","domains","log","transactions","invoices","tickets"]');
##########
INSERT INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`, `run_every_time`, `profile_id`)
VALUES ('removeClients', 'Remove Inactive / Empty client profiles', NOW(), 1, 0, '', '', 'Time', '1800', 1);
##########
INSERT INTO `hb_templates` (`parent_id`, `name`, `target`, `created`, `updated`) VALUES (0, 'GDPRDetails', 'admin', NOW(), NOW());
##########
INSERT INTO `hb_template_content` (`template_id`, `name`, `content`, `checksum`, `updated`)
SELECT id, 'GDPRDetails', '<style type="text/css"><!--\r\nbody {\r\n    font-family: Arial;\r\n}\r\n--></style>\r\n<div style="padding: 40px; font-size: 18px;">\r\n<table style="width: 100%;">\r\n<tbody>\r\n<tr>\r\n<td><strong style="font-size: 18px;">{$business_name}</strong></td>\r\n<td align="right"><span style="font-size: 18px;">{$report.date|dateformat:$date_format}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p align="center" style="padding: 20px;"><strong>Information about the content of the data filing system</strong></p>\r\n<div style="padding-bottom: 10px;">In response to your request of {$report.requester} for information related to the  personal data processed by {$business_name}, we inform you that our company process your personal data.</div>\r\n<div style="padding-bottom: 10px;">The data filing system of {$business_name} contains the following information about your person:\r\n<ul>{foreach from=$report.data item=data}\r\n<li><strong>{$data.name}: </strong> <span>{$data.value}</span></li>\r\n{/foreach}</ul>\r\n</div>\r\n<div style="padding-bottom: 10px;">We inform you additionally that:<ol>\r\n<li>Your personal data are processed for the purpose of billing for services you’ve ordered from us.</li>\r\n<li>Your personal data will be stored for the period of ENTER PERIOD HERE.</li>\r\n<li>{if !$report.previous} Your personal data have not been disclosed to any recipient {else} Your personal data have been / will be disclosed to {$report.previous.name} on its request of {$report.previous.purpose} on the day of {$report.previous.date} {/if}</li>\r\n<li>You have the right to request rectification or erasure of your personal data or restriction of processing of your personal data or to object to such processing.</li>\r\n<li>If you consider that our processing of your personal information infringes data protection laws you are entitled to complain to the Supervisory Authority competent for your habitual residence, your place of work or the place of the alleged infringement.</li>\r\n</ol></div>\r\n</div>', 'bb8d3923c2b43d831b1aa7890f15f7e8', NOW()
FROM `hb_templates` WHERE name = 'GDPRDetails';
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`)
VALUES ('Details:Delete', 'General', 'Client', 1, 'Account delete request', 'Dear {$client.firstname} {$client.lastname},<br />\r\n<br />\r\nAs per your request we deactivated and marked your account for deletion.<br />\r\n{if $delay}<br />\r\nYour account will be permanently deleted after {$delay} days. If you change your mind before that time please contact us to reactivate it.<br />\r\n{/if}', '', 1, 1, 1, 0);
##########
ALTER TABLE `hb_client_access`
  CHANGE COLUMN `status` `status` ENUM('Active','Closed','Closing','PendingRemoval') NOT NULL DEFAULT 'Active' AFTER `host`;
##########
ALTER TABLE `hb_invoices`
ADD INDEX `contact_id` (`contact_id`);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'terms',"Terms" FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'terms_accept',"Client has to accept following terms" FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'RedirectAfterPayment',"Redirect after payment" FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'RedirectAfterPayment_desc',"After client submits payment using offsite processing gateway, redirect him to this URL" FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'CurrentLogo',"Current logo" FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'NewLogo',"Upload new logo" FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'InvoiceTemplate',"Invoice template" FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'EstimateTemplate',"Estimate template" FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'CreditNoteTemplate',"Credit note template" FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'CreditReceiptTemplate',"Credit receipt template" FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'WrapPlainTextEmails',"Wrap plain text emails" FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'EmailSignature_desc',"Note: HTML tags will be removed from signatures attached to plain text emails" FROM hb_language WHERE target='admin';