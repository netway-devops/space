REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('TicketContactVisibility', 'on'),
('AdminTemplate', 'default'),
('AdminLogoPath','admin/templates/default/img/hostbill-logo.png'),
('AdminFavicon', ''),
('AdminCustomTitle', ''),
('SearchResults', '5'),
('SearchTicketReplies', 'off');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'billingcontact_widget','Billing Contact' FROM hb_language WHERE target!='admin'

UNION SELECT id,
'clientarea',
'billingcontact_ok',
'Billing contact changed'
FROM hb_language  WHERE target!='admin'
UNION SELECT id,
'clientarea',
'new_contact',
'New contact'
FROM hb_language  WHERE target!='admin'

UNION SELECT id,
'clientarea',
'billingcontact_guide',
'Use this tool to change billing contact details for this service'
FROM hb_language  WHERE target!='admin';