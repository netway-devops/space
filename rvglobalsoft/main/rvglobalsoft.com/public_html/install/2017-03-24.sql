ALTER TABLE `hb_aff_commisions`
ADD COLUMN `otrates` TEXT NULL DEFAULT NULL AFTER `applicable_products`,
ADD COLUMN `autoassign` INT NULL AFTER `enable_overcommission`;
##########
REPLACE INTO hb_configuration VALUES ('AffMultiplePlans', 1), ('AffDefaultPlan', '');