# ใช้ PHP mail
REPLACE INTO hb_configuration (`value`, `setting`) VALUES ('on', 'EmailSwitch');
REPLACE INTO hb_configuration (`value`, `setting`) VALUES ('on', 'MailUseSMTP');
REPLACE INTO hb_configuration (`value`, `setting`) VALUES ('mailhog', 'MailSMTPHost');
REPLACE INTO hb_configuration (`value`, `setting`) VALUES ('1025', 'MailSMTPPort');
REPLACE INTO hb_configuration (`value`, `setting`) VALUES ('billing@netway.co.th', 'MailSMTPEmail');
REPLACE INTO hb_configuration (`value`, `setting`) VALUES ('', 'MailSMTPUsername');
REPLACE INTO hb_configuration (`value`, `setting`) VALUES ('$1$def502002508eb9d21febdf54646abd0dbb78180f1327c0ada5091d4b48c5d868170f8b569d16a4fbebfcb2930c69ea0838ddcfc09a356cc45a4d4ed226f4c9349c598954dec0c84dbdc7276cfa8b5fc72ea1007', 'MailSMTPPassword');
REPLACE INTO hb_configuration (`value`, `setting`) VALUES ('1', 'MailSMTPPassword_encrypted');

# จบ queue ทั้งหมด
UPDATE `hb_queue_status` SET `status` = '4' ;

# ปิด webhook ทั้งหมด
UPDATE `hb_webhooks` SET `options` = '0' ;

# Disable domain module ทั้งหมด
UPDATE `hb_modules_configuration` SET `active` = '0' WHERE `type` = 'Domain';
# Disable hosting module ทั้งหมด
UPDATE `hb_modules_configuration` SET `active` = '0' WHERE `type` = 'Hosting';
# Disable plugin module ทั้งหมด
UPDATE `hb_modules_configuration` SET `active` = '0' WHERE `type` = 'Other';
# Enable plugin module ที่จำเป็น
UPDATE `hb_modules_configuration` SET `active` = '1' WHERE `module` IN (
    'OpenSRS_DomainSuggestion',
    'CSVExport',
    'DescImgUpload',
    'billingcycle',
    'LimitedServices',
    'invoicefilter',
    'WebHooks',
    'apihandle',
    'DNS_Zone_editor',
    'Autologin',
    'zendeskintegratehandle',
    'dnsservicehandle',
    'servicecataloghandle',
    'getaccountexpirydatehandle',
    'orderdrafthandle',
    'customadminuihandle',
    'none',
    'none',
    'none',
    'none'
);

UPDATE `hb_servers`
SET `password` = '',
    `hash` = ''
WHERE 1;

--
-- Setting isProduction module "Dynamics365 Business Central Integration" to false
--
-- REPLACE INTO `hb_modules_configuration` (`id`, `module`, `type`, `config`, `filename`, `version`, `active`, `modname`, `subtype`, `sort_order`, `settings`, `access`, `team_access`, `remote`) VALUES (218, 'dbc_integration', 'Other', '', 'class.dbc_integration.php', '1.0', 1, 'Dynamics365 Business Central Integration', 0, 100, '|extras_menu|haveapi|haveadmin|havetpl|', '', '', NULL);

UPDATE `dbc_webhooks` SET `url` = 'https://prod-31.southeastasia.logic.azure.com:443/workflows/65253a4b5af44553bd10b89ac5d83113/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=Ig8EYKX_1Dx2plrydqruNccVVU_gb3LbeUnuG2ZnCQo' WHERE id = 1;
UPDATE `dbc_webhooks` SET `url` = 'https://prod-06.southeastasia.logic.azure.com:443/workflows/cb879b473ad349ef8562af73db380d74/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=j529YLEPANdmqhSjh_O3PXbbIBn79loR0tL_0GhFXbQ' WHERE id = 2;
UPDATE `dbc_webhooks` SET `url` = 'https://prod-03.southeastasia.logic.azure.com:443/workflows/c39789ca04284890a756fa55df449ecd/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=Vg7nrHfzc5QyORQwkThcTckP79qRwgzj882sjX5nnkQ' WHERE id = 3;
-- UPDATE `dbc_webhooks` SET `url` = 'https://prod-24.southeastasia.logic.azure.com:443/workflows/a589474a33414915801786f3eb673018/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=GCAhhYwiERCCPeJQ5rvEzcaDk4LWGDqj26f-ZL-HMks' WHERE id = 2;
-- UPDATE `dbc_webhooks` SET `url` = 'https://prod-14.southeastasia.logic.azure.com:443/workflows/0f7688a9aee64187a1f6b5cadfd23aa9/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=Hi1Og1JXvnMRTfHG0O3oDc-6PulxlywKEfc_Io0mEoc' WHERE id = 3;
-- UPDATE `dbc_webhooks` SET `url` = 'https://prod-06.southeastasia.logic.azure.com:443/workflows/cb879b473ad349ef8562af73db380d74/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=j529YLEPANdmqhSjh_O3PXbbIBn79loR0tL_0GhFXbQ' WHERE id = 4;
-- UPDATE `dbc_webhooks` SET `url` = 'https://prod-29.southeastasia.logic.azure.com:443/workflows/2a0699d7ef8c49d29e5fb629956b7739/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=pAr-CcE24Hw3buucZoIY2wSfPP-bQEZiYVSsozSSrhs' WHERE id = 5;
-- UPDATE `dbc_webhooks` SET `url` = 'https://prod-08.southeastasia.logic.azure.com:443/workflows/dde426c8e5f74abbaba12e39f34b40f5/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=QjI3Lm1oYsFRvjLqPyh5h8PB0l4N0S-P3mvqBYc7xUk' WHERE id = 61;
