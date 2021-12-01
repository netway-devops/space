ALTER TABLE `hb_tickets` ADD `request_type` ENUM('General','Incident','Problem','Task','Question')  NULL  DEFAULT 'General' AFTER `type`;
##########
ALTER TABLE `hb_tickets` ADD INDEX (`request_type`);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'tickets', 'General', 'General' FROM hb_language WHERE target!='user'
UNION SELECT id, 'tickets', 'Incident', 'Incident' FROM hb_language WHERE target!='user'
UNION SELECT id, 'tickets', 'Problem', 'Problem' FROM hb_language WHERE target!='user'
UNION SELECT id, 'tickets', 'Question', 'Question' FROM hb_language WHERE target!='user'
UNION SELECT id, 'tickets', 'Task', 'Task' FROM hb_language WHERE target!='user'
UNION SELECT id, 'tickets', 'request_type', 'Type' FROM hb_language WHERE target!='user';
