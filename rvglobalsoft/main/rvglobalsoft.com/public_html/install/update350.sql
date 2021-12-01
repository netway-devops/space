UPDATE `hb_configuration` SET `value` = '3.5.0' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'access_blocked','You dont have access to this section' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'back','Back' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'my_services','My services' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'my_servicesinfo','Your current services with us' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'servicesintroduction','You currently don\'t have any services with us. Make sure to check our amazing offers in order section' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'profiles', 'editcontact','Edit contact' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'profiles', 'loginascontact','Login as this contact' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'tcreatednfo','Your support ticket has been created. We will get back to you as soon as possible - you will receive notifiation on email address you\'ve provided.' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'reportproblem','Provide ticket details below. When reporting a problem make sure to provide as much relevant information as possible' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'domainpendinginfo','Domain is pending registration. Once we will receive payment for order it will be processed automatically - you will be notified about domain registration progress by email.' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'domainpendingtransferinfo','Domain is pending transfer. Once we will receive payment for order it will be processed automatically - you will be notified about domain registration progress by email.' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'domainexpiredinfo','This domain has expired. You can use renew option to renew this domain - only if it wasn\'t registered somewhere else already. Hurry - dont loose your domain name!' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'managedomain','Manage domain' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'ca_search','Clientarea search' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'ca_createticket','Create new ticket' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'viewalltickets','View all tickets' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'quicklinks','Quick Links' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'manage','Manage' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'dashboard_phrase_1','Contact us to get help.' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'dashboard_phrase_2','Get your services renew automatically, add funds to your account' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'dashboard_phrase_3','Provide additional access to your services and tickets' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'dashboard_phrase_4','Restrict access to your services to certain IP addresses' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'dashboard_phrase_5','Browse articles written by our staff members' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'dashboard_phrase_6','Check our network/servers statuses' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'tickets_opened', 'Tickets opened:' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'tickets_closed', 'Tickets closed:' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'wereherephrase', 'We\'re here to help you.' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'checkoffersphrase', 'Check our amazing offers' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'proceedtocart', 'Proceed to cart' FROM hb_language WHERE target!='admin';
##########
UPDATE `hb_language_locales`  SET `section`='global' WHERE (`keyword`='forgetthanks2' OR `keyword`='forgetthanks') AND `section`='root';
##########
CREATE TABLE IF NOT EXISTS `hb_dns_domains` (
	`account_id` INT(11) NOT NULL,
	`domain_id` INT(11) NOT NULL,
	`domain` VARCHAR(255) NOT NULL,
	`created` DATETIME NOT NULL,
	PRIMARY KEY (`domain_id`, `account_id`),
	INDEX `account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_dns_templates` (
    `id` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `product_id` INT (11) NOT NULL,
    `template` VARCHAR(30) NOT NULL,
    KEY `product_id`(`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_dns_templates_records` (
    `id` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `template_id` INT(11) NULL DEFAULT NULL,
    `name` VARCHAR(255) NULL DEFAULT NULL,
    `type` VARCHAR(6) NULL DEFAULT NULL,
    `content` VARCHAR(255) NULL DEFAULT NULL,
    `ttl` INT(11) NULL DEFAULT NULL,
    `prio` INT(11) NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_cron_tasks` ADD `name` VARCHAR( 255 ) NOT NULL AFTER `task` ;
##########
ALTER TABLE `hb_cron_tasks` ADD `metadata` TEXT NOT NULL ,
ADD `output` TEXT NOT NULL ,
ADD `run_every` ENUM( 'Run', 'Time', 'Week', 'Month', 'Hour' ) NOT NULL ,
ADD `run_every_time` VARCHAR( 5 ) NOT NULL;
##########
ALTER TABLE `hb_cron_tasks` CHANGE `task` `task` VARCHAR( 40 );
##########
DELETE FROM `hb_cron_tasks` WHERE `task`='customModules';
##########
UPDATE hb_email_templates SET message=CONCAT(message,'\r\n\r\n {$output}') WHERE `tplname`='Cron Results';
