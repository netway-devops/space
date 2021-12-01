ALTER TABLE `hb_tags_items` CHANGE `rel` `rel` ENUM('Product','Account','Domain','Knowledgebase')  NOT NULL DEFAULT 'Product';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'estimates','Estimates' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'expiration_date','Expiration date' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clients', 'billing_estimate','View/Accept estimates' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'profiles', 'billing_estimate','View/Accept estimates' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'servers', 'duplicate_connection','Duplicate connection' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'formgroups','Form groups' FROM hb_language WHERE target != 'user'
UNION SELECT id, 'global', 'formgroupsdesc','Form Groups feature allows you to connect multiple forms across different products together for the ease of editing. <br>Updating one field connected into group will result in updating all other fields in this group.' FROM hb_language WHERE target != 'user'
UNION SELECT id, 'global', 'formitemgroups','Form item groups' FROM hb_language WHERE target != 'user'
UNION SELECT id, 'global', 'formitemgroupsdesc','Form Item Groups feature lets you connect items within selection forms (ie dropdown boxes) across different products for the ease of editing. <br>Updating one form item connected into group will result in updating all other items in this group.' FROM hb_language WHERE target != 'user'
UNION SELECT id, 'global', 'addformgroup','Add form group' FROM hb_language WHERE target != 'user'
UNION SELECT id, 'global', 'addformitemgroup','Add form item group' FROM hb_language WHERE target != 'user';
##########
ALTER TABLE `hb_config_items` ADD `group_id` INT(11)  NULL  DEFAULT '0';
##########
ALTER TABLE `hb_config_items_cat` ADD `group_id` INT(11)  NULL  DEFAULT '0';
##########
ALTER TABLE `hb_config_items` ADD `copy_of` INT(11)  NULL  DEFAULT '0';
##########
UPDATE hb_config_items SET copy_of = id;
##########
UPDATE hb_config_items_cat SET copy_of = id;
##########
CREATE TABLE IF NOT EXISTS `hb_config_items_cat_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NULL,
  `options` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `type_id` (`type_id`),
  INDEX `options` (`options`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_config_items_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NULL,
  `options` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `options` (`options`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;