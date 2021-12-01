UPDATE hb_language_locales 
SET `value`="Your support ticket has been created. We will get back to you as soon as possible - you will receive notification on email address you've provided." 
WHERE keyword = 'tcreatednfo' AND `value` LIKE "%notifiation%";
##########
UPDATE hb_language_locales 
SET `value`="All of your tickets can be managed from here." 
WHERE keyword = 'ticketsfromehere' AND `value` LIKE "%managed frome here%";
