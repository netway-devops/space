REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'orders', 'send_notification', 'Send Notification' FROM hb_language WHERE target='admin'
UNION SELECT id, 'orders', 'notification_sent', 'The notification has been sent' FROM hb_language WHERE target='admin'
UNION SELECT id, 'orders', 'notification_error', 'There was a problem sending the notification' FROM hb_language WHERE target='admin';
##########
UPDATE hb_client_fields
SET `options` = (
    CASE
        WHEN `options` = 25 THEN 15
        WHEN `options` = 57 THEN 47
        ELSE 15
    END)
WHERE `code` = 'type';
