REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
  SELECT id, 'cart', 'reccuringprice','Recurring' FROM hb_language WHERE target != 'admin';