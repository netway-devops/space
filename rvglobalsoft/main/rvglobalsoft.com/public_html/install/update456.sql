UPDATE `hb_configuration` SET `value` = '4.5.6' WHERE `setting`= 'Version';
##########
INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`) VALUES
(NULL, 'Orders', 'Number of sales per product in given period', 'SELECT c.name as `Category Name`,\r\np.name as `Product Name`,\r\nCOUNT(a.id) as `Items Sold`,\r\np.id as `Product ID` \r\nFROM hb_invoices `i` \r\nINNER JOIN hb_invoice_items `it` ON (it.invoice_id = i.id) \r\nINNER JOIN hb_accounts `a` ON (a.id = it.item_id \r\nAND it.type = ''Hosting'') \r\nINNER JOIN hb_products `p` ON (a.product_id = p.id) \r\nINNER JOIN hb_categories `c` ON (c.id = p.category_id) \r\nWHERE\r\n i.status = ''Paid'' \r\nAND i.datepaid > :date_bottom \r\nAND i.datepaid < :date_top \r\nAND i.id IN (SELECT invoice_id \r\nFROM hb_orders) \r\nGROUP BY p.id \r\n\r\nORDER BY `Items Sold` DESC', 1);
##########
CREATE TABLE IF NOT EXISTS `hb_client_changes_log` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `client_id` int(11) NOT NULL,
 `who` varchar(127) NOT NULL DEFAULT '',
 `change` text NOT NULL,
 `date` datetime NOT NULL,
 PRIMARY KEY (`id`),
 KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'logs', 'clientchangeslog','Client profile changes log' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'affiliate_description','Center of built-in comprehensive affiliate system.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'deleteselected','Delete selected' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'lastestanswer','Lastest Answer' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'lastestanswer','Lastest Answer' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'account_descr','Your account details and settings' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'clickheretoaddmore','Click here to add new services and domains' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'currentbalancestatus','Current status of your invoices and ballance status.' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'ticketsfromehere','All of your tickets can be managed frome here.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'all','All' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'createnew','Create new' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'closeissue','Close issue' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'accounthistory','Account History' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'previous','Previous' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'next','Next' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'accountlogssectionhistory','Account logs section and history.' FROM hb_language WHERE target='user'
UNION SELECT id, 'downloads', 'files','Files' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'categories','Categories' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'elements','Elements' FROM hb_language WHERE target='user'
UNION SELECT id, 'knowledgebase', 'welcomekb','Welcome to our <strong>Knowledgebase</strong>' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'youhere','you are here' FROM hb_language WHERE target='user'
UNION SELECT id, 'netstat', 'showscurrentstatusyourservers','Shows current status of your servers.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'menu','Menu' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'listallyoursdomain','List of all yours domains. ' FROM hb_language WHERE target='user'
UNION SELECT id, 'affiliates', 'affiliatespanel','Affiliates Panel' FROM hb_language WHERE target='user'
UNION SELECT id, 'affiliates', 'basicaffilliatesinformations','Basic affilliates informations.' FROM hb_language WHERE target='user'
UNION SELECT id, 'affiliates', 'unpaidcommissions','Unpaid commissions' FROM hb_language WHERE target='user'
UNION SELECT id, 'affiliates', 'mostimportantlinks','Affiliates most important links.' FROM hb_language WHERE target='user'
UNION SELECT id, 'affiliates', 'mostimportantlinksss','Affiliates most important links.s}s.' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'accountinfo','Account Info' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'basicinfoaboutyouraccount','Basic info about your account.' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'importantlinks','Most important links for your account.' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'invoicespanel','Invoices Panel' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'paysearchyourinvoiceshere','Pay and search your invoices here.' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'addservice','Add new service' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'servicepanel','Service Panel' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'basiciformations','Basic informations.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'supportsmostimportantlinks','Support\'s most important links.' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'ticketspanel','Tickets Panel' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'searchcreatedeleteticketshere','Search, create and delete tickets here.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'supportpanel','Support Panel' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'newticket','New Ticket' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'submitreply','Submit reply' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'searchservices','Search yor services..' FROM hb_language WHERE target='user'
UNION SELECT id, 'knowledgebase', 'stillcantfind','Still can\'t find what you\'re looking for? Please <a href=\"{$ca_url}tickets/new/\" class=\"bold\">send us a message.' FROM hb_language WHERE target='user';
