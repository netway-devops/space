ALTER TABLE `hb_graphs` ADD `type` varchar(32)  NOT NULL DEFAULT 'traffic' AFTER `billed`;
##########
ALTER TABLE `hb_graphs` ADD `metadata` TEXT  NOT NULL DEFAULT ''  AFTER `type`;
##########
UPDATE `hb_cron_tasks` SET `run_every`='Run', `run_every_time`='1200' 
WHERE  `task`='automaticSynchronizePendingDomains';
