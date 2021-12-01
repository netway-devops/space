UPDATE `hb_admin_access` SET access = CONCAT(access, ',viewKBase') WHERE access LIKE '%editKBase%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(access, ',viewKBase') WHERE access LIKE '%editKBase%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',viewOthersOnline') WHERE access LIKE '%viewLogs%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(access, ',viewOthersOnline') WHERE access LIKE '%viewLogs%';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'viewKBase','View Knowledgebase' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'viewOthersOnline','See Other Staff online' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'lackpriviliges_action','Your current admin role does not allow to take this action' FROM hb_language WHERE target != 'user';