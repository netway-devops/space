ALTER TABLE `hb_products` ADD `p_options` INT(3)  NULL  DEFAULT '0'  AFTER `hostname`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'cannot_cancel_this_service','Cancelation of this service is disabled by staff' FROM hb_language  WHERE target!='admin';
