ALTER TABLE `hb_task_log`
CHANGE COLUMN `status` `status` ENUM('Pending','OK','Failed','Canceled','Expired','Archived') NOT NULL DEFAULT 'Pending' AFTER `date_execute`;