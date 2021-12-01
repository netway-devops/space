ALTER TABLE `hb_aff`
ADD COLUMN `status` ENUM('Active','Disabled') NOT NULL DEFAULT 'Active' AFTER `client_id`;
