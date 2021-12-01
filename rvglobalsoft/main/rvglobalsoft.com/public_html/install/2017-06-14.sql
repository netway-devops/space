REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'changelabel_widget','Change Label' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'changelabel_guide','Enter new label for this service' FROM hb_language  WHERE target!='admin';