ALTER TABLE hb_tickets_predefinied ADD COLUMN sort_order INT(11);
##########
UPDATE hb_tickets_predefinied SET sort_order = id;
##########
ALTER TABLE hb_tickets_predefinied_cats ADD COLUMN sort_order INT(11);
##########
UPDATE hb_tickets_predefinied_cats SET sort_order = id;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'documenthash','Document #' FROM hb_language;
##########
REPLACE INTO `hb_admin_widgets` (`admin_id`, `widget`, `panel`, `collapsed`, `status`, `sort_order`, `autorefresh`)
SELECT
id,  'adminevents.allinpromo', 'left', 0, 1, 1, 0  FROM hb_admin_access WHERE status = 'Active';
