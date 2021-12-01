ALTER TABLE `hb_queue_status`
  CHANGE COLUMN `payload` `payload` LONGBLOB NOT NULL AFTER `queue`,
  CHANGE COLUMN `env` `env` BLOB NOT NULL AFTER `human_description`,
  CHANGE COLUMN `notify` `notify` BLOB NULL AFTER `env`;