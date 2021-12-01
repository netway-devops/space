ALTER TABLE `hb_knowledgebase_cat` ADD `admin_only` TINYINT(1)  NOT NULL  DEFAULT '0'  AFTER `sort_order`;
##########
ALTER TABLE `hb_knowledgebase_cat` ADD INDEX (`parent_cat`);
##########
ALTER TABLE `hb_knowledgebase_cat` ADD INDEX (`admin_only`);
