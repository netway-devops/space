ALTER TABLE `hb_transactions`
CHANGE COLUMN `status` `status` ENUM('Success','Processing','Refunded','Chargeback','Draft') NULL DEFAULT 'Success' AFTER `invoice_id`;;
