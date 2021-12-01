### 
ALTER TABLE `hb_order_drafts` ADD `billing_contact_id` INT NOT NULL;
ALTER TABLE `hb_order_drafts` ADD `billing_address` VARCHAR(255) NOT NULL;
###

### 
ALTER TABLE `hb_estimates` ADD `billing_contact_id` INT NOT NULL;
ALTER TABLE `hb_estimates` ADD `billing_address` VARCHAR(255) NOT NULL;
###
