ALTER TABLE `hb_task_list`
  ADD COLUMN `conditions` TEXT NULL AFTER `action_config`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'pass_generator','Password generator' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'copied','Copied' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'wrong_copy','Could not copy' FROM hb_language WHERE target!='user';