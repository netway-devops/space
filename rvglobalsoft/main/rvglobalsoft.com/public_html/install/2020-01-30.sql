REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configfields', 'select_only_one', 'Select only one as default' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configfields', 'select_only_one_desc', 'If client will have only one matching service it will be selected as default with no option to change' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configfields', 'service_categories', 'Service categories' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configfields', 'service_categories_desc', 'Select related service categories to list in select box. If none selected all will be used' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configfields', 'service_statuses', 'Service statuses' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configfields', 'service_statuses_desc', 'Select what service statuses should be listed' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configfields', 'save_to_set_related_services', 'Save the field to set the <b>Related services</b> settings' FROM hb_language WHERE target='admin';