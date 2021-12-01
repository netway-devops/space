ALTER TABLE `hb_mettered_variables`
CHANGE COLUMN `scheme` `scheme` VARCHAR(50) NOT NULL DEFAULT 'unit' AFTER `cycle`;
