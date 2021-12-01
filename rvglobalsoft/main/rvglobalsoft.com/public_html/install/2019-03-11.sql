REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'cart', 'selectproduct','Select product' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'cart', 'checkunall','Check/Uncheck all' FROM hb_language;

##########
UPDATE hb_invoices SET sortid = SUBSTR(sortid,7) WHERE sortid!=id AND sortid > 9999999;
##########
UPDATE hb_invoices SET sortid = 0  WHERE sortid=id;