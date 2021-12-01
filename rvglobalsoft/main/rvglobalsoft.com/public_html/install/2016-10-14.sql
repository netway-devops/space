ALTER TABLE `hb_tickets`
ADD COLUMN `bcc` MEDIUMTEXT NULL AFTER `cc`;
##########
ALTER TABLE `hb_ticket_billing_items`
ADD COLUMN `type` ENUM('hourly','flat') NOT NULL AFTER `rate`;
##########
ALTER TABLE `hb_ticket_billing`
ADD COLUMN `type` ENUM('hourly','flat') NOT NULL AFTER `name`;