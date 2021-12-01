CREATE TABLE `hb_prices` (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `rel` ENUM('Product','Addon','Config','Bundled','FResource') NOT NULL,
   `rel_id` INT(11) NOT NULL,
   `type` VARCHAR(20) NOT NULL,
   `price` DECIMAL(10,2) NOT NULL,
   PRIMARY KEY (`id`),
   UNIQUE INDEX `rel_rel_id_type` (`rel`, `rel_id`, `type`),
   INDEX `rel_rel_id` (`rel`, `rel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'upgradefee','Upgrade Fee' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configfields', 'upgradefee_formtip','Flat fee added when client upgrades or downgrades this form.' FROM hb_language  WHERE target!='user';
