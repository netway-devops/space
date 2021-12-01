ALTER TABLE `hb_account_logs`
  ADD COLUMN `ip` VARCHAR(45) NOT NULL DEFAULT '' AFTER `event`;
##########
ALTER TABLE `hb_domain_logs`
  ADD COLUMN `ip` VARCHAR(45) NOT NULL DEFAULT '' AFTER `event`;
##########
ALTER TABLE `hb_api_log`
  CHANGE COLUMN `ip` `ip` VARCHAR(45) NOT NULL AFTER `date`;
##########
ALTER TABLE `hb_client_activity_log`
  CHANGE COLUMN `ip` `ip` VARCHAR(45) NOT NULL DEFAULT '' AFTER `event`;
##########
ALTER TABLE `hb_system_log`
  CHANGE COLUMN `ip` `ip` VARCHAR(45) NOT NULL DEFAULT '' AFTER `item_id`;
##########
ALTER TABLE `hb_vps_details`
  CHANGE COLUMN `ip` `ip` VARCHAR(45) NOT NULL AFTER `type`;
##########
ALTER TABLE `hb_domains`
  CHANGE COLUMN `status` `status` VARCHAR(32) NOT NULL DEFAULT 'Pending' AFTER `type`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
  SELECT id, 'clientarea', 'syncdomain', 'Check domain status' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'syncdomain_transfer', 'Domain status will be updated automatically once it is validated and confirmed in both registries. This process may tak up to few days. If you did confirm this domain transfer in your registry or if you feel that it is taking to long you can request domain status check manually.' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'syncdomain_register', 'Domain status will be updated automatically once it is validated and confirmed in our registry. If you feel that it is taking to long you can request domain status check manually.' FROM hb_language WHERE target='user'
  UNION SELECT id, 'global', 'TransferredOut', 'Transferred Out' FROM hb_language WHERE 1;
