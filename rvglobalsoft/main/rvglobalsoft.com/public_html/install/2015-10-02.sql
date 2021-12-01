CREATE TABLE IF NOT EXISTS `hb_client_ach` (
  `client_id` int(11) NOT NULL,
  `type` enum('checkings','savings','business_checking') NOT NULL,
  `account` blob NOT NULL,
  `routing` blob NOT NULL,
  `token` blob NOT NULL,
  `token_gateway_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
  SELECT id, 'configuration', 'ACHAllowRemove','Allow to remove bank account details' FROM hb_language WHERE target='admin'
  UNION SELECT id, 'configuration', 'ACHAllowRemove_dscr1','Clients are not allowed to remove bank account details' FROM hb_language WHERE target='admin'
  UNION SELECT id, 'configuration', 'ACHAllowRemove_dscr2','Clients can remove their  bank account details' FROM hb_language WHERE target='admin'
  UNION SELECT id, 'configuration', 'ACHAdminInfo','Note: Clients are able to manage their bank account details only if eCheck/ACH payment module is enabled' FROM hb_language WHERE target='admin'
  UNION SELECT id, 'configuration', 'ACHChargeAuto','Charge bank accounts' FROM hb_language WHERE target='admin'
  UNION SELECT id, 'configuration', 'ACHChargeAuto_dscr','Charge automatically stored  bank accounts' FROM hb_language WHERE target='admin'
  UNION SELECT id, 'global', 'ACHecheck','eCheck/ACH' FROM hb_language
  UNION SELECT id, 'configuration', 'ACHAttemptOnce2','Retry charging account for' FROM hb_language WHERE target='admin'
  UNION SELECT id, 'clients', 'ccardach','Credit Card/ACH' FROM hb_language WHERE target='admin'
  UNION SELECT id, 'global', 'ach_information','Bank Account Information' FROM hb_language
  UNION SELECT id, 'global', 'savings','Savings' FROM hb_language
  UNION SELECT id, 'global', 'checkings','Checking' FROM hb_language
  UNION SELECT id, 'global', 'business_checking','Business Checking' FROM hb_language
  UNION SELECT id, 'global', 'ach_account_number','Account Number' FROM hb_language
  UNION SELECT id, 'global', 'ach_routing_number','Routing Number' FROM hb_language
  UNION SELECT id, 'global', 'changeach','Update ACH details' FROM hb_language
  UNION SELECT id, 'global', 'removeach','Remove ACH details' FROM hb_language
  UNION SELECT id, 'global', 'removeach_confirm','Are you sure you wish to remove ACH details?' FROM hb_language
  UNION SELECT id, 'global', 'noachyet','You did not stored your Bank account details yet' FROM hb_language
  UNION SELECT id, 'global', 'newach','Store ACH details' FROM hb_language
  UNION SELECT id, 'global', 'changeachdesc','Please provide your bank details below' FROM hb_language
  UNION SELECT id, 'global', 'invalid_routing_num','Routing number provided is invalid' FROM hb_language
  UNION SELECT id, 'global', 'invalid_account_num','Account number is invalid' FROM hb_language;
##########
REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES
('ACHChargeAuto', 'on'),
('ACHChargeAutoDays', '7'),
('ACHRetryForDays', '3'),
('ACHAllowRemove', 'off'),
('ACHAllowStorage', 'on'),
('ACHReChargeAuto', 'on');
##########
INSERT INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`, `run_every_time`) VALUES
  ('chargeACH', 'Process ACH/eChecks Charges', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1100');
##########
INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `send`, `plain`, `system`, `hidden`) VALUES
(NULL, 'Details:ACHCard:ChargeFailed', 'General', 'Client', 1, 'Account/eCheck Charge Failed', 'Dear {$details.firstname} {$details.lastname},\r\n\r\n\r\nThis is notification that we were unable to automatically charge your bank account ({$details.account}).\r\nPlease verify bank details in our client section.', 1, 1, 1, 0);
