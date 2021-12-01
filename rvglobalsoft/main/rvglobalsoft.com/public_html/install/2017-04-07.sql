CREATE TABLE IF NOT EXISTS `hb_aff_orders_items` (
  `aff_order_id` int(11) NOT NULL,
  `type` enum('Domain Register','Domain Transfer','Hosting','Addon') NOT NULL,
  `item_id` int(11) NOT NULL,
  `plan_id` int(11) NOT NULL,
  PRIMARY KEY (`aff_order_id`,`type`,`item_id`),
  KEY `type_item_id` (`type`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
UPDATE hb_email_templates SET tplname='ChargeFailed:CreditCard' WHERE tplname='Details:CreditCard:ChargeFailed' AND `for`='Client';
##########
UPDATE hb_email_templates SET tplname='ChargeFailed:ACH' WHERE tplname='Details:ACHCard:ChargeFailed' AND `for`='Client';
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`) 
VALUES ('ChargeFailed:Other', 'General', 'Client', 1, 'Charge Failed', 'Dear {$client.firstname} {$client.lastname},\r\n\r\n\r\nThis is notification that we were unable to automatically collect payment for invoice {$invoice|@invoice}\r\nPlease verify your payment details in our client section.', '', 1, 1, 1, 0);