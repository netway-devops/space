ALTER TABLE `hb_admin_details` ADD COLUMN `ui_config` TEXT NULL;
##########
UPDATE `hb_admin_details` SET ui_config='a:2:{s:18:"clienttabs_visible";a:11:{i:0;s:8:"Contacts";i:1;s:9:"Contracts";i:2;s:6:"Orders";i:3;s:8:"Services";i:4;s:7:"Domains";i:5;s:8:"Invoices";i:6;s:9:"Estimates";i:7;s:18:"Recurring Invoices";i:8;s:12:"Transactions";i:9;s:7:"Tickets";i:10;s:4:"Logs";}s:9:"search_on";a:11:{i:0;s:7:"Clients";i:1;s:8:"Contacts";i:2;s:6:"Orders";i:3;s:8:"Accounts";i:4;s:7:"Domains";i:5;s:3:"DNS";i:6;s:8:"Invoices";i:7;s:9:"Estimates";i:8;s:12:"Transactions";i:9;s:7:"Tickets";i:10;s:8:"Products";}}';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'cart', 'ssl_country_placeholder', 'US' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'ssl_state_placeholder', 'Texas' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'ssl_city_placeholder', 'Austin' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'ssl_organization_name_placeholder', 'Company' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'ssl_organization_unit_placeholder', 'IT' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'ssl_common_name_placeholder', 'example.com' FROM hb_language WHERE target='user';
##########
ALTER TABLE `hb_accounts_tags`
CHANGE COLUMN `target_id` `target_id` VARCHAR(200) NOT NULL DEFAULT '0' AFTER `account_id`;
##########
UPDATE `hb_language_locales` SET `section`='global' WHERE `section`='configuration' AND `keyword`='changecontract';
##########
ALTER TABLE `hb_tickets` ADD INDEX (`owner_id`);
##########
CREATE index hb_tickets_status_dept_owner on hb_tickets (status, dept_id, owner_id);