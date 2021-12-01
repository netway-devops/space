REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'domains', 'renewdomconfirm','Are you sure? This will immediately renew domain at registrar end, without issuing order in HostBill for domain renewal' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'domains', 'orderrenewdomconfirm','Are you sure? This will generate invoice for domain renewal for its original period' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'domains', 'orderrenew','Generate renewal order' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'domains', 'orderrenewerror','An error occurred while generating the order' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'reviewTickets','Review Tickets' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'reviewOrders','Review Orders' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'pendingReview','Pending review' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'EnableSuperVisorReviews','Enable supervisor ticket reviews' FROM hb_language WHERE target = 'admin';
##########
UPDATE hb_admin_access SET `access` = CONCAT(access, ',reviewTickets') WHERE `access` LIKE '%departmentSettings%';
##########
UPDATE hb_admin_access SET `access` = CONCAT(access, ',reviewOrders') WHERE `access` LIKE '%deleteOrders%';