ALTER TABLE `hb_order_drafts`
ADD COLUMN `metadata` TEXT NOT NULL AFTER `scenario_id`;

