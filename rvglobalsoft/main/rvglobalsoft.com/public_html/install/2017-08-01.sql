REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'cancelation_pending_for_account','Cancelation request was placed for this account and it is going to be terminated soon. If this was done by mistake please open a support ticket to notify us immediately' FROM hb_language WHERE target='user';