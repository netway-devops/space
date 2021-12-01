ALTER TABLE `hb_tickets_predefinied`
ADD COLUMN `notify` TINYINT NOT NULL DEFAULT '1' AFTER `share`;