ALTER TABLE `hb_order_scenarios_steps` ADD COLUMN `config` TEXT NULL AFTER `sort`;
##########
UPDATE `hb_order_scenarios_steps` SET `config`='a:1:{s:15:"enabled_modules";a:1:{i:0;s:3:"all";}}' WHERE `name`='FraudCheck';