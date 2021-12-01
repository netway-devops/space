ALTER TABLE `hb_tickets` ADD `parent_id` INT(11)  NOT NULL   DEFAULT '0' AFTER `id`,
ADD INDEX (`parent_id`);
