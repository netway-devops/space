ALTER TABLE `hb_invoices`
ADD COLUMN `taxexempt` TINYINT NOT NULL DEFAULT '0' AFTER `taxrate2`;