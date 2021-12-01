REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('LiveChatGeoIPDBPath', 'includes/libs/geoip');
##########
CREATE TABLE IF NOT EXISTS `hb_notifications` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `client_id` int(10) NOT NULL,
  `rel_type` varchar(127) NOT NULL DEFAULT 'none',
  `rel_id` int(10) NOT NULL DEFAULT '0',
  `seen` tinyint(1) NOT NULL DEFAULT '0',
  `subject` text NULL,
  `body` text NULL,
  `metadata` text NULL,
  `type` enum('direct', 'broadcast') NULL,
  `date_added` datetime NOT NULL,
  `date_seen` datetime NULL,
  PRIMARY KEY (`id`),
  KEY `rel_type` (`rel_type`),
  KEY `rel_id` (`rel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'notifyclients','Notify clients' FROM hb_language WHERE target != 'user'
UNION SELECT id, 'global', 'Notifications','Notifications' FROM hb_language
UNION SELECT id, 'global', 'reltype','Relation type' FROM hb_language
UNION SELECT id, 'global', 'relid','Relation id' FROM hb_language
UNION SELECT id, 'clientarea', 'relatedto','Related to' FROM hb_language
UNION SELECT id, 'global', 'SendNotification','Send Portal Notification' FROM hb_language WHERE target != 'user'
UNION SELECT id, 'logs', 'sentnotificationslog','Sent Portal Notifications Log' FROM hb_language WHERE target != 'user'
UNION SELECT id, 'logs', 'notificationssent','Portal notifications' FROM hb_language WHERE target != 'user';
##########
ALTER TABLE `hb_email_templates` CHANGE `group` `group` ENUM( 'Domain', 'Product', 'Invoice', 'General', 'Support', 'Custom', 'Mobile', 'Notification' ) NULL DEFAULT NULL ;
##########
ALTER TABLE `hb_email_templates` ADD COLUMN `notify` TINYINT(1) NULL DEFAULT 0;
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('EnablePortalNotifications', 'on');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'notify_setting','Email Notifications' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'global', 'notify_billing','Receive emails related to <strong>billing</strong>' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'global', 'notify_support','Receive emails related to <strong>support</strong>' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'global', 'notify_services','Receive emails related to <strong>services</strong>' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'global', 'notify_domains','Receive emails related to <strong>domains</strong>' FROM hb_language WHERE target != 'admin';
##########
REPLACE INTO `hb_configuration`
VALUES ('ClientNotifications','["notify_login", "notify_billing", "notify_support", "notify_services", "notify_domains"]');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'Welcome','Welcome' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'availablecredit','Available credit' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'ccnum','Card number' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'cctype','Card type' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'ccholder','Card holder' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'ccexpiry','Card expiry' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'backtoinvoices','Back to invoices' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'tickets', 'backtotickets','Back to tickets' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'Hide','Hide' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'Help','Help' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'Managee','Manage' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'addaddons','Add addons' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'new','New' FROM hb_language;
##########
UPDATE hb_language_locales s SET s.section = 'global' WHERE keyword = 'browseprod';
##########
UPDATE hb_language_locales s SET s.section = 'global' WHERE keyword = 'yourcartisempty';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'sendmessage', 'notifications_sent','Notifications have been sent' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'sendmessage', 'not_chosen_customer','You have not chosen who the notification should be sent to' FROM hb_language WHERE target = 'admin';
##########
ALTER TABLE `hb_aff` ADD COLUMN `options` INT(5) NOT NULL DEFAULT 0;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'affiliates', 'enternewlandingurl_1','Enter new landing page url, it must start with <b>http://</b> or <b>https://</b>' FROM hb_language WHERE target = 'user';