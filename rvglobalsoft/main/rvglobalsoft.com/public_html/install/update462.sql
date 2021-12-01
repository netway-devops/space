UPDATE `hb_configuration` SET `value` = '4.6.2' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'ticketdept_dontexists','Department does not exist' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'configuration', 'InvoiceDelay_descr','Generate final invoice right after payment' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'InvoiceDelay_descr1','Wait ' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'InvoiceDelay_descr2',' days until final invoice generation, and send PDF with Invoice:Final email' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'InvoiceDelay','Final Invoice Delay' FROM hb_language WHERE target='admin';
##########
CREATE TABLE `hb_admin_failed_login` (
    `id` INT(10) NOT NULL AUTO_INCREMENT,
    `date` DATETIME NOT NULL,
    `login` VARCHAR(255) NOT NULL,
    `ip` VARBINARY(16) NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `ip` (`ip`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES
('InvoiceDelay', 'off'),
('InvoiceDelayDays', '0'),
('CancelInvoicesOnTerminate', 'off');
##########
ALTER TABLE `hb_aff_orders`
ADD COLUMN `invoice_id` INT(11) NOT NULL AFTER `order_id`;
##########
INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `send`, `plain`, `system`, `hidden`) VALUES
(NULL, 'Invoice:Final', 'Invoice', 'Client', 1, 'Invoice #{$invoice.id} generated', 'Dear {$client.firstname} {$client.lastname}, \r\n\r\nFinal invoice has been generated to your recent payment\r\n\r\nINVOICE  #{$invoice.id} \r\n\r\n\r\n\r\n\r\n\r\nINVOICE HISTORY: {$clientarea_url}\r\n', 1, 1, 1, 0);
