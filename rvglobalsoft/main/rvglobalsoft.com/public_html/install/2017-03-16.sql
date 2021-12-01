ALTER TABLE `hb_client_billing`
ADD COLUMN `disableemails` TINYINT(1) NOT NULL DEFAULT 0 AFTER `taxrate`;