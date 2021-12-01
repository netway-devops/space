REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('EnableAutoCreation', '0');
##########
REPLACE INTO `hb_automation_settings` (`item_id`, `type`, `setting`, `value`) 
SELECT p.id, 'Hosting', 'EnableAutoCreation', p.autosetup FROM hb_products p
JOIN hb_product_types t ON t.id=p.`type`
WHERE t.`type` != 'DomainsType';
############
REPLACE INTO `hb_automation_settings` (`item_id`, `type`, `setting`, `value`) 
SELECT id, 'Addon', 'EnableAutoCreation', autosetup FROM hb_addons;