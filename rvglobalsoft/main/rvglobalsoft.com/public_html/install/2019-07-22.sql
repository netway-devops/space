ALTER TABLE `hb_notes` ADD `flags` INT(11) NOT NULL DEFAULT 0;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT `id`, 'clients', 'note_add_to_tickets','Auto-add to tickets' FROM hb_language WHERE target='admin';