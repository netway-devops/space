CREATE TABLE IF NOT EXISTS `hb_clientarea_filters` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `client_id` INT NOT NULL,
    `filter` TEXT NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO hb_clientarea_filters (`client_id`, `filter`)
SELECT SUBSTR(`setting`, 18),`value` FROM hb_configuration WHERE `setting` LIKE "Services:Filters:%";
##########
DELETE FROM hb_configuration WHERE `setting` LIKE 'Services:Filters:%';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'contract_templates', 'Contract templates' FROM hb_language
UNION SELECT id, 'configuration', 'agreements_contracts', 'Agreements & Contract templates' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'contract_generation', 'Contract Generation' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'default_contract_template', 'Default contract template' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'GenerateContractForEachNewClient', 'Generate new contract for each new client order' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'AttemptToReuseDefaultContract', 'Attempt to re-use customer default contract' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'changecontract', 'Change Contract' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'newcontract', 'New Contract' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'DontMergeServicesDiffContracts', 'Do not merge services with different contracts' FROM hb_language  WHERE target!='user'
UNION SELECT id, 'contracts', 'public_notes', 'Public notes' FROM hb_language
UNION SELECT id, 'accounts', 'account_contract_changed', 'Account&#39;s contract id changed to: %s' FROM hb_language  WHERE target!='user'
UNION SELECT id, 'domains', 'domain_contract_changed', 'Domain&#39;s contract id changed to: %s' FROM hb_language  WHERE target!='user'
UNION SELECT id, 'editadmins', 'viewContracts', 'View Contracts' FROM hb_language WHERE target!='user'
UNION SELECT id, 'editadmins', 'editContracts', 'Edit Contracts' FROM hb_language WHERE target!='user'
UNION SELECT id, 'editadmins', 'deleteContracts', 'Delete Contracts' FROM hb_language WHERE target!='user';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('ContractGeneration', 'default'),
('DefaultContractTemplate', '0');
##########
ALTER TABLE `hb_accounts` ADD `contract_id` INT(11) UNSIGNED NULL;
##########
ALTER TABLE `hb_accounts_addons` ADD `contract_id` INT(11) UNSIGNED NULL;
##########
ALTER TABLE `hb_domains` ADD `contract_id` INT(11) UNSIGNED NULL;
##########
ALTER TABLE `hb_order_drafts` ADD `contract_id` INT(11) UNSIGNED NULL;
##########
CREATE TABLE IF NOT EXISTS `hb_client_contracts` (
    `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `number` varchar(32) NOT NULL,
    `client_id` int(11) UNSIGNED NOT NULL,
    `template_id` int(11) UNSIGNED NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `accepted_at` datetime NULL,
    `expires` datetime NULL,
    `accepted_by` varchar(255) NULL,
    `status` enum('Draft', 'Pending', 'Active', 'Expired', 'Canceled') NOT NULL DEFAULT 'Draft',
    `flags` int(11) UNSIGNED DEFAULT 0,
    `public_notes` TEXT NULL,
    PRIMARY KEY (`id`),
    KEY (`number`),
    KEY (`client_id`),
    KEY (`template_id`),
    KEY (`flags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_order_contracts` (
     `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
     `order_id` int(11) UNSIGNED NOT NULL,
     `contract_id` int(11) UNSIGNED NOT NULL,
     PRIMARY KEY (`id`),
     KEY (`order_id`),
     KEY (`contract_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_notes` CHANGE `type` `type` ENUM('client','account','domain','order','draft','admin','invoice','estimate','rackitem','contracts')   NOT NULL  DEFAULT 'client';
##########
REPLACE INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`,`run_every_time`, `profile_id`)
VALUES ('cancelExpiredContracts', 'Cancel Expired Contracts', NOW(), 1, 0, '', '', 'Time', '1200', 1);
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',viewContracts,editContracts,deleteContracts') WHERE access LIKE '%editClients%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(access, ',viewContracts,editContracts,deleteContracts') WHERE access LIKE '%editClients%';
##########
CREATE TABLE IF NOT EXISTS `hb_tickets_emails_stats` (
    `email` VARCHAR(254) NOT NULL,
    `last_success` DATETIME NULL DEFAULT NULL,
    `last_reject` DATETIME NULL DEFAULT NULL,
    `last_reject_status` INT(11) NULL,
    PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
