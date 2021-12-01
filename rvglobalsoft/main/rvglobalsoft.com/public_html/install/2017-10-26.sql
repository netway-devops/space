ALTER TABLE `hb_api_access` ADD `name` VARCHAR(128)  NULL  DEFAULT 'None'  AFTER `acl`;
##########
ALTER TABLE `hb_api_access` ADD `flags` INT(11)  NULL  DEFAULT '0'  AFTER `name`;
