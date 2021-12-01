ALTER TABLE `hb_automation_settings` CHANGE `type` `type` ENUM('Hosting','Addon','Domain','ClientGroup','Client') NOT NULL  DEFAULT 'Hosting';
