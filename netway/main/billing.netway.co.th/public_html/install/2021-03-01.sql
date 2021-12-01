CREATE TABLE IF NOT EXISTS `hb_reports_snapshots` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `report_id` INT (11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'default',
  `frequency` ENUM ('Demand','Daily', 'Weekly', 'Monthly') NOT NULL DEFAULT 'Demand',
  `day` INT (11) NULL,
  `time` TEXT (11) NULL,
  `target` ENUM ('None','Filesystem', 'Email') NOT NULL DEFAULT 'None',
  `target_ids` TEXT NOT NULL DEFAULT '',
  `data_to_retain` int(11) NOT NULL DEFAULT 0,
  `state` TEXT NOT NULL DEFAULT '',
  `columns` TEXT NOT NULL DEFAULT '',
  `generated_at` timestamp NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_reports_snapshots_data` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `snapshot_id` INT (11) NOT NULL,
  `data` longtext NULL,
  `email_sent` INT (1) NOT NULL DEFAULT 0,
  `attachment` VARCHAR (255) NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `snapshot_id` (`snapshot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'editadmins', 'createReportSnapshots','Create Report Snapshots' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'removeReportSnapshots','Remove Report Snapshots' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'viewReportSnapshots','View Report Snapshots' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'generateReportSnapshots','Generate Report Snapshots' FROM hb_language WHERE target='admin';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',createReportSnapshots,removeReportSnapshots,viewReportSnapshots,generateReportSnapshots') WHERE access LIKE '%viewStats%';
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`) VALUES
('Reports:Auto-export', 'General', 'Admin', 1, 'Report Snapshot: #{$snapshot.name}: auto-export has been created', '<h1>Report Snapshot: #{$snapshot.name}: auto-export has been created</h1>\r\n\r\n<h2>Details</h2>\r\n<p>\r\n    <b>Related report:</b> {$report.name}<br>\r\n    <b>Related snapshot:</b> {$snapshot.name}<br>\r\n    <b>Auto-export created at:</b> {$snapshot_data.created_at}<br>\r\n</p>\r\n', 'Report Snapshot: #{$snapshot.name}: auto-export has been created\r\n\r\n---------------------------------------------------------------\r\nDetails\r\n---------------------------------------------------------------\r\n# Related report: {$report.name}\r\n# Related snapshot: {$snapshot.name}\r\n# Auto-export created at: {$snapshot_data.created_at}', 1, 2, 1, 0);
##########
INSERT INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`, `run_every_time`)
VALUES ('automaticExportReports', 'Auto-export report snapshots', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200');
##########
ALTER TABLE `hb_reports_widget_series` ADD COLUMN `snapshot_data_id` INT(11) NULL;
