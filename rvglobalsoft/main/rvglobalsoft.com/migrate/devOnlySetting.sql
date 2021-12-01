# ใช้ PHP mail
REPLACE INTO hb_configuration (`value`, `setting`) VALUES ('off', 'MailUseSMTP');

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
    'Autologin',
    'splitinvoicehandle',
    'orderhandle',
    'ipproductlicense',
    'GeoLocation',
    'state_province_select',
    'none'
);


UPDATE `hb_servers`
SET `password` = '',
    `hash` = ''
WHERE 1;

