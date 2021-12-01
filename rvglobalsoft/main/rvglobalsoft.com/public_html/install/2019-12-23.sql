ALTER TABLE `hb_client_access` CHANGE COLUMN `status` `status` ENUM('Active','Closed','Closing','PendingRemoval','Archived') NOT NULL DEFAULT 'Active';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'Archived','Archived' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'clients', 'archiveheading','Archive client profile' FROM hb_language WHERE target='admin'
UNION SELECT id, 'clients', 'client_account_archived','Client #%s account archived' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'viewArchivedClients','View Archived Clients' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'ArchiveAccount','Archive Profile' FROM hb_language WHERE target = 'admin';
##########
INSERT INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`, `run_every_time`, `profile_id`)
VALUES ('archiveClients', 'Archive Inactive client profiles', NOW(), 1, 0, '', '', 'Time', '1800', 1);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'email_sent_failed', 'Email sent to %s %s failed' FROM hb_language WHERE target = 'user';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',viewArchivedClients') WHERE access LIKE '%editClients%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(access, ',viewArchivedClients') WHERE access LIKE '%editClients%';
