ALTER TABLE `hb_orders` ADD COLUMN `commitment_date` date DEFAULT NULL AFTER `contract_accepted_by`;
##########
ALTER TABLE `hb_order_drafts` ADD COLUMN `commitment_date` date DEFAULT NULL AFTER `contract_id`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'commitmentdate','Commitment date' FROM hb_language;