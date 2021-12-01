--
-- Enable module dbc_integration
--
REPLACE INTO `hb_modules_configuration` (`id`, `module`, `type`, `config`, `filename`, `version`, `active`, `modname`, `subtype`, `sort_order`, `settings`, `access`, `team_access`, `remote`) VALUES (218, 'dbc_integration', 'Other', '', 'class.dbc_integration.php', '1.0', 1, 'Dynamics365 Business Central Integration', 0, 100, '|extras_menu|haveapi|haveadmin|havetpl|', '', '', NULL);

--
-- เปลี่ยน hb_categories.dbcCategoryId to varchar(36) เพื่อให้มีตัวอักษรเท่ากับ Data Type ของ DBC
--
ALTER TABLE `hb_categories` CHANGE `dbcCategoryId` `dbcCategoryId` VARCHAR(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

--
-- เปลี่ยน hb_categories.name to varchar(100) เพื่อให้มีตัวอักษรเท่ากับ Data Type ของ DBC
--
ALTER TABLE `hb_categories` CHANGE `name` `name` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

ALTER TABLE `hb_products` CHANGE `dbcItemId` `dbcItemId` VARCHAR(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

ALTER TABLE `hb_products` CHANGE `baseUnitOfMeasureId` `baseUnitOfMeasureId` VARCHAR(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

--
-- Table structure for table `dbc_unitofmeasure`
-- ใช้สำหรับเก็บข้อมูล DBC unitOfMeasure
--

CREATE TABLE IF NOT EXISTS `dbc_unitofmeasure` (
  `id` varchar(36) NOT NULL,
  `code` varchar(10) NOT NULL,
  `displayName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `dbc_unitofmeasure`
  ADD PRIMARY KEY (`id`);


--
-- Table structure for table `dbc_webhooks`
--

CREATE TABLE `dbc_webhooks` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `method` varchar(6) NOT NULL,
  `url` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `dbc_webhooks`
  ADD PRIMARY KEY (`id`);


--
-- Import DBC unit of measure
--
REPLACE INTO `dbc_unitofmeasure` (`id`, `code`, `displayName`) VALUES ('CAFEEEF4-4647-EB11-BF6C-000D3AC8F2C9', 'DAY', 'วัน');
REPLACE INTO `dbc_unitofmeasure` (`id`, `code`, `displayName`) VALUES ('759873B0-B0A0-EB11-8CE6-0022485645EC', 'EA', 'EA');
REPLACE INTO `dbc_unitofmeasure` (`id`, `code`, `displayName`) VALUES ('07BDA36F-B541-EA11-A812-000D3AA2F4CE', 'LICENSE', 'License');
REPLACE INTO `dbc_unitofmeasure` (`id`, `code`, `displayName`) VALUES ('09BDA36F-B541-EA11-A812-000D3AA2F4CE', 'LIC-M', 'LIC-MONTH');
REPLACE INTO `dbc_unitofmeasure` (`id`, `code`, `displayName`) VALUES ('0BBDA36F-B541-EA11-A812-000D3AA2F4CE', 'LIC-T', 'LIC-TIME');
REPLACE INTO `dbc_unitofmeasure` (`id`, `code`, `displayName`) VALUES ('0DBDA36F-B541-EA11-A812-000D3AA2F4CE', 'LIC-Y', 'LIC-YEAR');
REPLACE INTO `dbc_unitofmeasure` (`id`, `code`, `displayName`) VALUES ('0FBDA36F-B541-EA11-A812-000D3AA2F4CE', 'MANDAY', 'MANDAY');
REPLACE INTO `dbc_unitofmeasure` (`id`, `code`, `displayName`) VALUES ('11BDA36F-B541-EA11-A812-000D3AA2F4CE', 'MONTH', 'เดือน');
REPLACE INTO `dbc_unitofmeasure` (`id`, `code`, `displayName`) VALUES ('13BDA36F-B541-EA11-A812-000D3AA2F4CE', 'PCS', 'ชิ้น');
REPLACE INTO `dbc_unitofmeasure` (`id`, `code`, `displayName`) VALUES ('15BDA36F-B541-EA11-A812-000D3AA2F4CE', 'SET', 'ชุด');
REPLACE INTO `dbc_unitofmeasure` (`id`, `code`, `displayName`) VALUES ('17BDA36F-B541-EA11-A812-000D3AA2F4CE', 'TIME', 'ครั้ง');
REPLACE INTO `dbc_unitofmeasure` (`id`, `code`, `displayName`) VALUES ('19BDA36F-B541-EA11-A812-000D3AA2F4CE', 'USER-M', 'User Month');
REPLACE INTO `dbc_unitofmeasure` (`id`, `code`, `displayName`) VALUES ('1BBDA36F-B541-EA11-A812-000D3AA2F4CE', 'USER-T', 'User Time');
REPLACE INTO `dbc_unitofmeasure` (`id`, `code`, `displayName`) VALUES ('1DBDA36F-B541-EA11-A812-000D3AA2F4CE', 'USER-Y', 'User Year');
REPLACE INTO `dbc_unitofmeasure` (`id`, `code`, `displayName`) VALUES ('1FBDA36F-B541-EA11-A812-000D3AA2F4CE', 'YEAR', 'ปี');

--
-- Update DBC Item Category ID to hb_categories.dbcCategoryId with codeName
--
UPDATE `hb_categories` SET dbcCategoryId = '819F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'ALIB';
UPDATE `hb_categories` SET dbcCategoryId = '7F9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'ALIBABA';
UPDATE `hb_categories` SET dbcCategoryId = 'FC5A7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'AWS';
UPDATE `hb_categories` SET dbcCategoryId = 'FE5A7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'AWS-OVER';
UPDATE `hb_categories` SET dbcCategoryId = '005B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'AWS-S';
UPDATE `hb_categories` SET dbcCategoryId = '025B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'AWS-T';
UPDATE `hb_categories` SET dbcCategoryId = '045B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'AWS-U';
UPDATE `hb_categories` SET dbcCategoryId = '779F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'AZ';
UPDATE `hb_categories` SET dbcCategoryId = '065B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'AZCSP';
UPDATE `hb_categories` SET dbcCategoryId = '085B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'AZ-CSP';
UPDATE `hb_categories` SET dbcCategoryId = '0A5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'AZ-OA';
UPDATE `hb_categories` SET dbcCategoryId = '0C5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'AZOLP';
UPDATE `hb_categories` SET dbcCategoryId = '759F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'AZU';
UPDATE `hb_categories` SET dbcCategoryId = '0E5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'AZURE';
UPDATE `hb_categories` SET dbcCategoryId = '105B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'BASIC VPS';
UPDATE `hb_categories` SET dbcCategoryId = '125B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'BU1';
UPDATE `hb_categories` SET dbcCategoryId = '145B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'BU1CS';
UPDATE `hb_categories` SET dbcCategoryId = '165B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'BU1SERVICE';
UPDATE `hb_categories` SET dbcCategoryId = '185B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'BU2';
UPDATE `hb_categories` SET dbcCategoryId = '1A5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'BU2SERVICE';
UPDATE `hb_categories` SET dbcCategoryId = '1C5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'BU3';
UPDATE `hb_categories` SET dbcCategoryId = '1E5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'BU4';
UPDATE `hb_categories` SET dbcCategoryId = '679F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'CFSH';
UPDATE `hb_categories` SET dbcCategoryId = 'B39F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'CHU';
UPDATE `hb_categories` SET dbcCategoryId = '839F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'COL';
UPDATE `hb_categories` SET dbcCategoryId = '205B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'COLO';
UPDATE `hb_categories` SET dbcCategoryId = '225B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'CO-LO';
UPDATE `hb_categories` SET dbcCategoryId = '245B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'COLOCATION';
UPDATE `hb_categories` SET dbcCategoryId = '739F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'COMPUTING';
UPDATE `hb_categories` SET dbcCategoryId = '659F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'COULDFILE';
UPDATE `hb_categories` SET dbcCategoryId = '265B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'CRM';
UPDATE `hb_categories` SET dbcCategoryId = '285B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'CRMADD';
UPDATE `hb_categories` SET dbcCategoryId = '2A5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'CRMAPP';
UPDATE `hb_categories` SET dbcCategoryId = '2C5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'CRMCS';
UPDATE `hb_categories` SET dbcCategoryId = '2E5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'D- GTLD';
UPDATE `hb_categories` SET dbcCategoryId = '305B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'D365-CRM';
UPDATE `hb_categories` SET dbcCategoryId = '325B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'D365-ERP';
UPDATE `hb_categories` SET dbcCategoryId = '345B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'D-ADDFUND';
UPDATE `hb_categories` SET dbcCategoryId = '365B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'D-CCTLD';
UPDATE `hb_categories` SET dbcCategoryId = '385B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'DED- LINUX';
UPDATE `hb_categories` SET dbcCategoryId = '3A5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'DED-HIDDEN';
UPDATE `hb_categories` SET dbcCategoryId = '3C5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'DEDICATED';
UPDATE `hb_categories` SET dbcCategoryId = '3E5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'DEDICATED SERVER';
UPDATE `hb_categories` SET dbcCategoryId = '405B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'DED-LINUX';
UPDATE `hb_categories` SET dbcCategoryId = '425B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'DED-OTHER';
UPDATE `hb_categories` SET dbcCategoryId = '445B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'DED-WINDOW';
UPDATE `hb_categories` SET dbcCategoryId = '465B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'D-ERP-CRM';
UPDATE `hb_categories` SET dbcCategoryId = '485B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'D-GTLD';
UPDATE `hb_categories` SET dbcCategoryId = 'A19F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'DOM';
UPDATE `hb_categories` SET dbcCategoryId = '4A5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'DOMAIN';
UPDATE `hb_categories` SET dbcCategoryId = '4C5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'D-RESELLER';
UPDATE `hb_categories` SET dbcCategoryId = '7F3D9BB0-F193-EA11-A813-000D3AC839DB' WHERE codeName = 'D-RESTORE';
UPDATE `hb_categories` SET dbcCategoryId = '4E5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'D-TLD';
UPDATE `hb_categories` SET dbcCategoryId = '505B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'D-TRANSFER';
UPDATE `hb_categories` SET dbcCategoryId = 'B99F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'DYNA';
UPDATE `hb_categories` SET dbcCategoryId = '525B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'DYNAMIC365';
UPDATE `hb_categories` SET dbcCategoryId = '0E5C3341-6E47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'EM';
UPDATE `hb_categories` SET dbcCategoryId = '545B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'EZYADMIN';
UPDATE `hb_categories` SET dbcCategoryId = '565B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'EZY-ADMIN';
UPDATE `hb_categories` SET dbcCategoryId = '5F9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'FLH';
UPDATE `hb_categories` SET dbcCategoryId = '799F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'G CLOUD';
UPDATE `hb_categories` SET dbcCategoryId = '585B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'GCP';
UPDATE `hb_categories` SET dbcCategoryId = '5A5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'G-C-P';
UPDATE `hb_categories` SET dbcCategoryId = '5C5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'GOOGAPP';
UPDATE `hb_categories` SET dbcCategoryId = '5E5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'GOOGLE-C';
UPDATE `hb_categories` SET dbcCategoryId = '605B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'GOOGLE-GCP';
UPDATE `hb_categories` SET dbcCategoryId = '625B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'GS-A';
UPDATE `hb_categories` SET dbcCategoryId = '645B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'GS-C';
UPDATE `hb_categories` SET dbcCategoryId = '665B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'GS-SETUP';
UPDATE `hb_categories` SET dbcCategoryId = '979F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'GSU';
UPDATE `hb_categories` SET dbcCategoryId = '685B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'GSUITE';
UPDATE `hb_categories` SET dbcCategoryId = '6A5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'G-SUITE';
UPDATE `hb_categories` SET dbcCategoryId = '6C5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'GSUITEADD';
UPDATE `hb_categories` SET dbcCategoryId = '6E5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'GS-UPGRADE';
UPDATE `hb_categories` SET dbcCategoryId = '2BD3ED25-EFEC-EA11-AA60-00224855F50C' WHERE codeName = 'HARDDISK-BU2';
UPDATE `hb_categories` SET dbcCategoryId = '7D9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'HUAW';
UPDATE `hb_categories` SET dbcCategoryId = '7B9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'HUAWEI';
UPDATE `hb_categories` SET dbcCategoryId = '9F9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'HYBR';
UPDATE `hb_categories` SET dbcCategoryId = '9D9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'HYBRID';
UPDATE `hb_categories` SET dbcCategoryId = 'A79F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'IDN';
UPDATE `hb_categories` SET dbcCategoryId = 'DA718AA2-EEEC-EA11-AA60-00224855F50C' WHERE codeName = 'INV-BU2';
UPDATE `hb_categories` SET dbcCategoryId = '705B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'IP';
UPDATE `hb_categories` SET dbcCategoryId = '619F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'LARAVEL';
UPDATE `hb_categories` SET dbcCategoryId = '859F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'LD';
UPDATE `hb_categories` SET dbcCategoryId = '599F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'LH';
UPDATE `hb_categories` SET dbcCategoryId = '5D9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'LHOLD';
UPDATE `hb_categories` SET dbcCategoryId = 'AB9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'LICENSING';
UPDATE `hb_categories` SET dbcCategoryId = 'B59F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'LOBA';
UPDATE `hb_categories` SET dbcCategoryId = 'B79F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'LOVM';
UPDATE `hb_categories` SET dbcCategoryId = '639F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'LRV';
UPDATE `hb_categories` SET dbcCategoryId = '8D9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'LVM';
UPDATE `hb_categories` SET dbcCategoryId = '899F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'LVPS';
UPDATE `hb_categories` SET dbcCategoryId = '9B9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'M365';
UPDATE `hb_categories` SET dbcCategoryId = '579F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'MA';
UPDATE `hb_categories` SET dbcCategoryId = '725B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'MA SERVER';
UPDATE `hb_categories` SET dbcCategoryId = '745B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'MA-AWS';
UPDATE `hb_categories` SET dbcCategoryId = '765B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'MA-EZY';
UPDATE `hb_categories` SET dbcCategoryId = '785B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'MA-HIDDEN';
UPDATE `hb_categories` SET dbcCategoryId = '959F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'MAIL';
UPDATE `hb_categories` SET dbcCategoryId = '7A5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'MAILCHIMP';
UPDATE `hb_categories` SET dbcCategoryId = '7C5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'MAIL-CHIMP';
UPDATE `hb_categories` SET dbcCategoryId = '7E5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'MA-LINUX';
UPDATE `hb_categories` SET dbcCategoryId = '805B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'MA-SERVER';
UPDATE `hb_categories` SET dbcCategoryId = '825B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'MA-SV-ADD';
UPDATE `hb_categories` SET dbcCategoryId = '845B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'MA-WINDOW';
UPDATE `hb_categories` SET dbcCategoryId = 'AF9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'MON';
UPDATE `hb_categories` SET dbcCategoryId = '999F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'MS365';
UPDATE `hb_categories` SET dbcCategoryId = '865B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'MSFPP';
UPDATE `hb_categories` SET dbcCategoryId = '885B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'MSOLP';
UPDATE `hb_categories` SET dbcCategoryId = '8A5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'MSSPLA';
UPDATE `hb_categories` SET dbcCategoryId = '0C5C3341-6E47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'NES';
UPDATE `hb_categories` SET dbcCategoryId = '8C5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'NETWAYSITE';
UPDATE `hb_categories` SET dbcCategoryId = '8E5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'NONMS';
UPDATE `hb_categories` SET dbcCategoryId = '6D9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'NWS';
UPDATE `hb_categories` SET dbcCategoryId = '905B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'NWSITE';
UPDATE `hb_categories` SET dbcCategoryId = '925B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'O365';
UPDATE `hb_categories` SET dbcCategoryId = '945B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'O365ADD';
UPDATE `hb_categories` SET dbcCategoryId = '965B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'O365CS';
UPDATE `hb_categories` SET dbcCategoryId = '985B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'O365-EDU';
UPDATE `hb_categories` SET dbcCategoryId = '9A5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'O365-ETP';
UPDATE `hb_categories` SET dbcCategoryId = '9C5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'O365-EXCH';
UPDATE `hb_categories` SET dbcCategoryId = '9E5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'O365-HOME';
UPDATE `hb_categories` SET dbcCategoryId = 'C79C22CD-395D-EA11-A812-000D3AA19D7D' WHERE codeName = 'O365-OTHER';
UPDATE `hb_categories` SET dbcCategoryId = 'A05B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'O365-SCS';
UPDATE `hb_categories` SET dbcCategoryId = 'A25B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'O365-SME';
UPDATE `hb_categories` SET dbcCategoryId = 'A45B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'O365-UPG';
UPDATE `hb_categories` SET dbcCategoryId = 'BB9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'OTHER';
UPDATE `hb_categories` SET dbcCategoryId = 'A65B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'OTHER INCOME';
UPDATE `hb_categories` SET dbcCategoryId = 'A85B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PC-LICENSE';
UPDATE `hb_categories` SET dbcCategoryId = 'AA5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PC-L-ISP';
UPDATE `hb_categories` SET dbcCategoryId = 'AC5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PC-L-KAS';
UPDATE `hb_categories` SET dbcCategoryId = 'AE5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PC-L-LSP';
UPDATE `hb_categories` SET dbcCategoryId = 'B05B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PC-L-MC';
UPDATE `hb_categories` SET dbcCategoryId = 'B25B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PC-L-MCA';
UPDATE `hb_categories` SET dbcCategoryId = 'B45B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PC-L-NT';
UPDATE `hb_categories` SET dbcCategoryId = 'B65B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PC-L-PDF';
UPDATE `hb_categories` SET dbcCategoryId = 'B85B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PC-L-SAM';
UPDATE `hb_categories` SET dbcCategoryId = 'BA5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PC-L-SKYPE';
UPDATE `hb_categories` SET dbcCategoryId = 'BC5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PC-L-SM';
UPDATE `hb_categories` SET dbcCategoryId = 'BE5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PC-L-STCL';
UPDATE `hb_categories` SET dbcCategoryId = 'C05B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PC-L-TWPS';
UPDATE `hb_categories` SET dbcCategoryId = 'C25B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PC-L-VIS';
UPDATE `hb_categories` SET dbcCategoryId = 'C45B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PC-L-VMW';
UPDATE `hb_categories` SET dbcCategoryId = 'C65B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PIPED-CRM';
UPDATE `hb_categories` SET dbcCategoryId = 'C85B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'PIPEDRIVE';
UPDATE `hb_categories` SET dbcCategoryId = 'BF9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'PJ';
UPDATE `hb_categories` SET dbcCategoryId = '699F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'PLATFORM';
UPDATE `hb_categories` SET dbcCategoryId = 'C19F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'REBATE';
UPDATE `hb_categories` SET dbcCategoryId = 'A59F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'RES';
UPDATE `hb_categories` SET dbcCategoryId = 'A39F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'RSTD';
UPDATE `hb_categories` SET dbcCategoryId = '6B9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'RVSB';
UPDATE `hb_categories` SET dbcCategoryId = 'CA5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'RV-SB';
UPDATE `hb_categories` SET dbcCategoryId = 'CC5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'RVSITEB';
UPDATE `hb_categories` SET dbcCategoryId = '0A5C3341-6E47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'RVSK';
UPDATE `hb_categories` SET dbcCategoryId = 'CE5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'RV-SK';
UPDATE `hb_categories` SET dbcCategoryId = 'D05B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'RVSKIN';
UPDATE `hb_categories` SET dbcCategoryId = 'D25B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SECSSL';
UPDATE `hb_categories` SET dbcCategoryId = 'BD9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'SERV';
UPDATE `hb_categories` SET dbcCategoryId = '05B62913-EFEC-EA11-AA60-00224855F50C' WHERE codeName = 'SERVER-BU2';
UPDATE `hb_categories` SET dbcCategoryId = 'D65B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SERVER-L';
UPDATE `hb_categories` SET dbcCategoryId = 'BCC5D121-375D-EA11-A812-000D3AA19D7D' WHERE codeName = 'SFL-BI';
UPDATE `hb_categories` SET dbcCategoryId = 'D85B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-BI-CSP';
UPDATE `hb_categories` SET dbcCategoryId = 'DA5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-CSP';
UPDATE `hb_categories` SET dbcCategoryId = 'DC5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-FPP';
UPDATE `hb_categories` SET dbcCategoryId = 'DE5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SF-LICENSE';
UPDATE `hb_categories` SET dbcCategoryId = 'E05B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-KAS';
UPDATE `hb_categories` SET dbcCategoryId = 'E25B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-MCA';
UPDATE `hb_categories` SET dbcCategoryId = 'E45B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-MCAF';
UPDATE `hb_categories` SET dbcCategoryId = 'E65B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-MOL';
UPDATE `hb_categories` SET dbcCategoryId = 'E85B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-MSPLA';
UPDATE `hb_categories` SET dbcCategoryId = 'EA5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-MSSQL';
UPDATE `hb_categories` SET dbcCategoryId = 'EC5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-NORTON';
UPDATE `hb_categories` SET dbcCategoryId = 'EE5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-NT';
UPDATE `hb_categories` SET dbcCategoryId = 'F05B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-P-CSP';
UPDATE `hb_categories` SET dbcCategoryId = 'F25B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-PDF';
UPDATE `hb_categories` SET dbcCategoryId = 'F45B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-SAS';
UPDATE `hb_categories` SET dbcCategoryId = 'F65B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-SKYPE';
UPDATE `hb_categories` SET dbcCategoryId = 'F85B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-SM';
UPDATE `hb_categories` SET dbcCategoryId = 'FA5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-SYMT';
UPDATE `hb_categories` SET dbcCategoryId = 'FC5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-TWPS';
UPDATE `hb_categories` SET dbcCategoryId = 'FE5B7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-VIS';
UPDATE `hb_categories` SET dbcCategoryId = '005C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-VISUAL';
UPDATE `hb_categories` SET dbcCategoryId = '025C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-VMW';
UPDATE `hb_categories` SET dbcCategoryId = '6F3AF15D-375D-EA11-A812-000D3AA19D7D' WHERE codeName = 'SFL-VS VSTECS';
UPDATE `hb_categories` SET dbcCategoryId = '045C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-VS6';
UPDATE `hb_categories` SET dbcCategoryId = '065C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-VS-CSP';
UPDATE `hb_categories` SET dbcCategoryId = '085C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SFL-VWPP';
UPDATE `hb_categories` SET dbcCategoryId = '0A5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SHARE HOST';
UPDATE `hb_categories` SET dbcCategoryId = '0C5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SH-LINUX';
UPDATE `hb_categories` SET dbcCategoryId = '0E5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SH-LINUX-F';
UPDATE `hb_categories` SET dbcCategoryId = '16EB8E36-32C0-EA11-A813-000D3AC7D473' WHERE codeName = 'SH-OTHER';
UPDATE `hb_categories` SET dbcCategoryId = '105C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SH-WINDOW';
UPDATE `hb_categories` SET dbcCategoryId = '125C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SH-WP';
UPDATE `hb_categories` SET dbcCategoryId = '145C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-CLOUD';
UPDATE `hb_categories` SET dbcCategoryId = '165C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-CP';
UPDATE `hb_categories` SET dbcCategoryId = '185C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-DA';
UPDATE `hb_categories` SET dbcCategoryId = '1A5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-EZY';
UPDATE `hb_categories` SET dbcCategoryId = '1C5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-IP';
UPDATE `hb_categories` SET dbcCategoryId = '1E5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-ISP';
UPDATE `hb_categories` SET dbcCategoryId = '205C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-KAS';
UPDATE `hb_categories` SET dbcCategoryId = '225C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-KERN';
UPDATE `hb_categories` SET dbcCategoryId = '245C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-KNC';
UPDATE `hb_categories` SET dbcCategoryId = '265C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-LITES';
UPDATE `hb_categories` SET dbcCategoryId = '285C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-MC';
UPDATE `hb_categories` SET dbcCategoryId = '2C5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-MSPLA';
UPDATE `hb_categories` SET dbcCategoryId = '2E5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-MSSQL';
UPDATE `hb_categories` SET dbcCategoryId = '305C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-PLESK';
UPDATE `hb_categories` SET dbcCategoryId = '325C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-SOFTA';
UPDATE `hb_categories` SET dbcCategoryId = '345C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-VL';
UPDATE `hb_categories` SET dbcCategoryId = '365C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-L-VZ';
UPDATE `hb_categories` SET dbcCategoryId = '385C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'S-SERVER-L';
UPDATE `hb_categories` SET dbcCategoryId = '3A5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SSL';
UPDATE `hb_categories` SET dbcCategoryId = 'A99F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'SSLCERT';
UPDATE `hb_categories` SET dbcCategoryId = '3C5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SSL-CS';
UPDATE `hb_categories` SET dbcCategoryId = '3E5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SSL-DV';
UPDATE `hb_categories` SET dbcCategoryId = '405C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SSL-EV';
UPDATE `hb_categories` SET dbcCategoryId = '425C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SSL-IN';
UPDATE `hb_categories` SET dbcCategoryId = '445C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SSL-OTHER';
UPDATE `hb_categories` SET dbcCategoryId = '465C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SSL-OV';
UPDATE `hb_categories` SET dbcCategoryId = '485C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SSL-SETUP';
UPDATE `hb_categories` SET dbcCategoryId = '4A5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SSL-SGC';
UPDATE `hb_categories` SET dbcCategoryId = '4C5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SV-BU1';
UPDATE `hb_categories` SET dbcCategoryId = '4E5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'SV-BU2';
UPDATE `hb_categories` SET dbcCategoryId = 'AD9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'SWL';
UPDATE `hb_categories` SET dbcCategoryId = '505C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'VIRTUALIZE';
UPDATE `hb_categories` SET dbcCategoryId = '919F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'VIRTUALP';
UPDATE `hb_categories` SET dbcCategoryId = '525C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'VM-L-DED';
UPDATE `hb_categories` SET dbcCategoryId = '545C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'VM-LICENSE';
UPDATE `hb_categories` SET dbcCategoryId = '565C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'VM-LINUX';
UPDATE `hb_categories` SET dbcCategoryId = '585C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'VMWARE';
UPDATE `hb_categories` SET dbcCategoryId = '5A5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'VM-W-DED';
UPDATE `hb_categories` SET dbcCategoryId = '5C5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'VM-WINDOW';
UPDATE `hb_categories` SET dbcCategoryId = '939F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'VP';
UPDATE `hb_categories` SET dbcCategoryId = '5E5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'VPS';
UPDATE `hb_categories` SET dbcCategoryId = '605C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'VPS-CLOUDLINUX';
UPDATE `hb_categories` SET dbcCategoryId = '625C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'VPS-HIDDEN';
UPDATE `hb_categories` SET dbcCategoryId = '645C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'VPS-LINUX';
UPDATE `hb_categories` SET dbcCategoryId = '665C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'VPS-OTHER';
UPDATE `hb_categories` SET dbcCategoryId = '685C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'VPS-WINDOW';
UPDATE `hb_categories` SET dbcCategoryId = '879F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'WD';
UPDATE `hb_categories` SET dbcCategoryId = '5B9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'WH';
UPDATE `hb_categories` SET dbcCategoryId = '6F9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'WORDPRESS';
UPDATE `hb_categories` SET dbcCategoryId = '719F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'WPST';
UPDATE `hb_categories` SET dbcCategoryId = '8F9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'WVM';
UPDATE `hb_categories` SET dbcCategoryId = '8B9F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'WVPS';
UPDATE `hb_categories` SET dbcCategoryId = 'B19F5B62-6C47-EB11-BF6C-000D3AC8F2C9' WHERE codeName = 'ZEN';
UPDATE `hb_categories` SET dbcCategoryId = '6A5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'ZENDESK';
UPDATE `hb_categories` SET dbcCategoryId = '6C5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'ZENDESK-A';
UPDATE `hb_categories` SET dbcCategoryId = '6E5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'ZENDESK-C';
UPDATE `hb_categories` SET dbcCategoryId = '705C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'ZENDESK-CS';
UPDATE `hb_categories` SET dbcCategoryId = '725C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'ZENDESK-G';
UPDATE `hb_categories` SET dbcCategoryId = '745C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'ZENDESK-MA';
UPDATE `hb_categories` SET dbcCategoryId = '765C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'ZENDESK-S';
UPDATE `hb_categories` SET dbcCategoryId = '785C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'ZENDESK-SV';
UPDATE `hb_categories` SET dbcCategoryId = '7A5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'ZENDESK-T';
UPDATE `hb_categories` SET dbcCategoryId = '7C5C7E5B-B841-EA11-A812-000D3AA2F4CE' WHERE codeName = 'ZENDESK-TN';


--
-- Update DBC Item ID to hb_products.dbcItemId with codeName
--

-- 
-- DBC Item name: AWS Server - License Usage
-- DBC CodeName: AWS.965.AWS1
-- HB Product ID: 965
-- 
UPDATE `hb_products` SET dbcItemId = '7FC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '965';
-- 
-- DBC Item name: AWS Server - License Management Fee
-- DBC CodeName: AWS.966.AWS2
-- HB Product ID: 966
-- 
UPDATE `hb_products` SET dbcItemId = '81C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '966';
-- 
-- DBC Item name: AWS Server - Managed Server Service
-- DBC CodeName: AWS.967.AWS3
-- HB Product ID: 967
-- 
UPDATE `hb_products` SET dbcItemId = '83C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '967';
-- 
-- DBC Item name: Azure server - Token
-- DBC CodeName: AZ.923.TOKE
-- HB Product ID: 923
-- 
UPDATE `hb_products` SET dbcItemId = '5DC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '923';
-- 
-- DBC Item name: Azure Token - Single Coin
-- DBC CodeName: AZU.1062.AZ01
-- HB Product ID: 1062
-- 
UPDATE `hb_products` SET dbcItemId = 'BBC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1062';
-- 
-- DBC Item name: Azure Token - 10 Coins
-- DBC CodeName: AZU.1063.AZ02
-- HB Product ID: 1063
-- 
UPDATE `hb_products` SET dbcItemId = 'BDC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1063';
-- 
-- DBC Item name: Azure Token - 20 Coins
-- DBC CodeName: AZU.1064.AZ03
-- HB Product ID: 1064
-- 
UPDATE `hb_products` SET dbcItemId = 'BFC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1064';
-- 
-- DBC Item name: Azure Token - 30 Coins
-- DBC CodeName: AZU.1065.AZ04
-- HB Product ID: 1065
-- 
UPDATE `hb_products` SET dbcItemId = 'C1C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1065';
-- 
-- DBC Item name: Azure Token - 40 Coins
-- DBC CodeName: AZU.1066.AZ05
-- HB Product ID: 1066
-- 
UPDATE `hb_products` SET dbcItemId = 'C3C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1066';
-- 
-- DBC Item name: Azure Token - 50 Coins
-- DBC CodeName: AZU.1067.AZ06
-- HB Product ID: 1067
-- 
UPDATE `hb_products` SET dbcItemId = 'C5C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1067';
-- 
-- DBC Item name: Azure Token - 60 Coins
-- DBC CodeName: AZU.1068.AZ07
-- HB Product ID: 1068
-- 
UPDATE `hb_products` SET dbcItemId = 'C7C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1068';
-- 
-- DBC Item name: Azure Token - 70 Coins
-- DBC CodeName: AZU.1069.AZ08
-- HB Product ID: 1069
-- 
UPDATE `hb_products` SET dbcItemId = 'C9C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1069';
-- 
-- DBC Item name: Azure Token - 80 Coins
-- DBC CodeName: AZU.1070.AZ09
-- HB Product ID: 1070
-- 
UPDATE `hb_products` SET dbcItemId = 'CBC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1070';
-- 
-- DBC Item name: Azure Token - 90 Coins
-- DBC CodeName: AZU.1071.AZ10
-- HB Product ID: 1071
-- 
UPDATE `hb_products` SET dbcItemId = 'CDC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1071';
-- 
-- DBC Item name: Azure Token - 100 Coins (Full Token)
-- DBC CodeName: AZU.1072.AZ11
-- HB Product ID: 1072
-- 
UPDATE `hb_products` SET dbcItemId = 'CFC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1072';
-- 
-- DBC Item name: Azure Token - 1000 Golden Coins
-- DBC CodeName: AZU.1073.AZ12
-- HB Product ID: 1073
-- 
UPDATE `hb_products` SET dbcItemId = 'D1C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1073';
-- 
-- DBC Item name: Azure Token - 1200 Golden Coins
-- DBC CodeName: AZU.1074.AZ13
-- HB Product ID: 1074
-- 
UPDATE `hb_products` SET dbcItemId = 'D3C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1074';
-- 
-- DBC Item name: Azure Token - 12+1 SME Token (First Year Entry)
-- DBC CodeName: AZU.1075.AZ14
-- HB Product ID: 1075
-- 
UPDATE `hb_products` SET dbcItemId = 'D5C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1075';
-- 
-- DBC Item name: Azure Token - 10K Platinum Coins
-- DBC CodeName: AZU.1076.AZ15
-- HB Product ID: 1076
-- 
UPDATE `hb_products` SET dbcItemId = 'D7C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1076';
-- 
-- DBC Item name: Azure Token - 12K Platinum Coins
-- DBC CodeName: AZU.1077.AZ16
-- HB Product ID: 1077
-- 
UPDATE `hb_products` SET dbcItemId = 'D9C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1077';
-- 
-- DBC Item name: Azure Token - 12+1 Enterprise Token (First Year Entry)
-- DBC CodeName: AZU.1078.AZ17
-- HB Product ID: 1078
-- 
UPDATE `hb_products` SET dbcItemId = 'DBC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1078';
-- 
-- DBC Item name: Azure Token - Azure Open Token (100 USD)
-- DBC CodeName: AZU.1094.AZ18
-- HB Product ID: 1094
-- 
UPDATE `hb_products` SET dbcItemId = 'EFC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1094';
-- 
-- DBC Item name: Cloud File Sharing - CF5
-- DBC CodeName: CFSH.1245.CF1
-- HB Product ID: 1245
-- 
UPDATE `hb_products` SET dbcItemId = '63C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1245';
-- 
-- DBC Item name: Cloud File Sharing - CF10
-- DBC CodeName: CFSH.1246.CF2
-- HB Product ID: 1246
-- 
UPDATE `hb_products` SET dbcItemId = '65C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1246';
-- 
-- DBC Item name: Cloud File Sharing - CF20
-- DBC CodeName: CFSH.1247.CF3
-- HB Product ID: 1247
-- 
UPDATE `hb_products` SET dbcItemId = '67C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1247';
-- 
-- DBC Item name: Cloud File Sharing - CF30
-- DBC CodeName: CFSH.1248.CF4
-- HB Product ID: 1248
-- 
UPDATE `hb_products` SET dbcItemId = '69C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1248';
-- 
-- DBC Item name: MS License Check-up - License Check-up 75 max For PC (SAM-Software Asset Management)
-- DBC CodeName: CHU.1028.CHU1
-- HB Product ID: 1028
-- 
UPDATE `hb_products` SET dbcItemId = 'A7C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1028';
-- 
-- DBC Item name: MS License Check-up - License Check-up 200 max For PC (SAM-Software Asset Management)
-- DBC CodeName: CHU.1029.CHU2
-- HB Product ID: 1029
-- 
UPDATE `hb_products` SET dbcItemId = 'A9C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1029';
-- 
-- DBC Item name: Colocation Server - 1U Rack Server _x000D_ + IP
-- DBC CodeName: COL.189.CORI
-- HB Product ID: 189
-- 
UPDATE `hb_products` SET dbcItemId = 'FBC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '189';
-- 
-- DBC Item name: Colocation Server - 2U Rack Server
-- DBC CodeName: COL.668.CO2R
-- HB Product ID: 668
-- 
UPDATE `hb_products` SET dbcItemId = 'B3C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '668';
-- 
-- DBC Item name: Colocation Server - 1U Rack Server
-- DBC CodeName: COL.669.CO1U
-- HB Product ID: 669
-- 
UPDATE `hb_products` SET dbcItemId = 'B5C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '669';
-- 
-- DBC Item name: Colocation Server - Rack (2U)
-- DBC CodeName: COL.71.CO2U
-- HB Product ID: 71
-- 
UPDATE `hb_products` SET dbcItemId = 'B7C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '71';
-- 
-- DBC Item name: Colocation Server - Tower
-- DBC CodeName: COL.90.COLT
-- HB Product ID: 90
-- 
UPDATE `hb_products` SET dbcItemId = 'BBC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '90';
-- 
-- DBC Item name: Upgrade CPU VPS
-- DBC CodeName: CVPS.1269.CVPS
-- HB Product ID: 1269
-- 
UPDATE `hb_products` SET dbcItemId = '25E652BA-8CA1-EB11-8CE6-0022485645EC', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1269';
-- 
-- DBC Item name: Domain Names - .com
-- DBC CodeName: DOM.1.COM
-- HB Product ID: 1
-- 
UPDATE `hb_products` SET dbcItemId = '83C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1';
-- 
-- DBC Item name: Domain Names - .asia
-- DBC CodeName: DOM.10.ASIA
-- HB Product ID: 10
-- 
UPDATE `hb_products` SET dbcItemId = '8FC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '10';
-- 
-- DBC Item name: Domain Names - .app
-- DBC CodeName: DOM.1032.APP
-- HB Product ID: 1032
-- 
UPDATE `hb_products` SET dbcItemId = 'ABC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1032';
-- 
-- DBC Item name: Domain Names - .io
-- DBC CodeName: DOM.1053.IO
-- HB Product ID: 1053
-- 
UPDATE `hb_products` SET dbcItemId = 'B7C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1053';
-- 
-- DBC Item name: Domain Names - .uk
-- DBC CodeName: DOM.11.UK
-- HB Product ID: 11
-- 
UPDATE `hb_products` SET dbcItemId = '91C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '11';
-- 
-- DBC Item name: Domain Names - .tech
-- DBC CodeName: DOM.1198.TECH
-- HB Product ID: 1198
-- 
UPDATE `hb_products` SET dbcItemId = '3FC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1198';
-- 
-- DBC Item name: Domain Names - .co.th
-- DBC CodeName: DOM.12.COTH
-- HB Product ID: 12
-- 
UPDATE `hb_products` SET dbcItemId = '93C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '12';
-- 
-- DBC Item name: Domain Names - .in.th
-- DBC CodeName: DOM.13.INTH
-- HB Product ID: 13
-- 
UPDATE `hb_products` SET dbcItemId = '95C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '13';
-- 
-- DBC Item name: Domain Names - .ac.th
-- DBC CodeName: DOM.14.ACTH
-- HB Product ID: 14
-- 
UPDATE `hb_products` SET dbcItemId = '97C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '14';
-- 
-- DBC Item name: Domain Names - .city
-- DBC CodeName: DOM.1462.CITY
-- HB Product ID: 1462
-- 
UPDATE `hb_products` SET dbcItemId = '322715A7-05DE-EB11-86DF-00224857C2C7', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1462';
-- 
-- DBC Item name: Domain Names - .app
-- DBC CodeName: DOM.1471.DEV
-- HB Product ID: 1471
-- 
UPDATE `hb_products` SET dbcItemId = '2E356460-C9F4-EB11-A1DE-002248559070', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1471';
-- 
-- DBC Item name: Domain Names - .go.th
-- DBC CodeName: DOM.15.GOTH
-- HB Product ID: 15
-- 
UPDATE `hb_products` SET dbcItemId = '99C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '15';
-- 
-- DBC Item name: Domain Names - .or.th
-- DBC CodeName: DOM.16.ORTH
-- HB Product ID: 16
-- 
UPDATE `hb_products` SET dbcItemId = '9BC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '16';
-- 
-- DBC Item name: Domain Names - .cc
-- DBC CodeName: DOM.19.CC
-- HB Product ID: 19
-- 
UPDATE `hb_products` SET dbcItemId = '9DC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '19';
-- 
-- DBC Item name: Domain Names - .net
-- DBC CodeName: DOM.2.NET
-- HB Product ID: 2
-- 
UPDATE `hb_products` SET dbcItemId = '85C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '2';
-- 
-- DBC Item name: Domain Names - .tv
-- DBC CodeName: DOM.20.TV
-- HB Product ID: 20
-- 
UPDATE `hb_products` SET dbcItemId = '9FC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '20';
-- 
-- DBC Item name: Domain Names - .com.cn
-- DBC CodeName: DOM.285.COCN
-- HB Product ID: 285
-- 
UPDATE `hb_products` SET dbcItemId = '0DC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '285';
-- 
-- DBC Item name: Domain Names - .com.co
-- DBC CodeName: DOM.289.COCO
-- HB Product ID: 289
-- 
UPDATE `hb_products` SET dbcItemId = '0FC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '289';
-- 
-- DBC Item name: Domain Names - .org
-- DBC CodeName: DOM.3.ORG
-- HB Product ID: 3
-- 
UPDATE `hb_products` SET dbcItemId = '87C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '3';
-- 
-- DBC Item name: Domain Names - .net.cn
-- DBC CodeName: DOM.337.NECN
-- HB Product ID: 337
-- 
UPDATE `hb_products` SET dbcItemId = '2FC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '337';
-- 
-- DBC Item name: Domain Names - .org.cn
-- DBC CodeName: DOM.338.ORCN
-- HB Product ID: 338
-- 
UPDATE `hb_products` SET dbcItemId = '31C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '338';
-- 
-- DBC Item name: Domain Names - .cn.com
-- DBC CodeName: DOM.340.CNCO
-- HB Product ID: 340
-- 
UPDATE `hb_products` SET dbcItemId = '33C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '340';
-- 
-- DBC Item name: Domain Names - .jp
-- DBC CodeName: DOM.341.JP
-- HB Product ID: 341
-- 
UPDATE `hb_products` SET dbcItemId = '35C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '341';
-- 
-- DBC Item name: Domain Names - .com.vn
-- DBC CodeName: DOM.343.COVN
-- HB Product ID: 343
-- 
UPDATE `hb_products` SET dbcItemId = '37C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '343';
-- 
-- DBC Item name: Domain Names - .ph
-- DBC CodeName: DOM.347.PH
-- HB Product ID: 347
-- 
UPDATE `hb_products` SET dbcItemId = '39C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '347';
-- 
-- DBC Item name: Domain Names - .com.au
-- DBC CodeName: DOM.351.COAU
-- HB Product ID: 351
-- 
UPDATE `hb_products` SET dbcItemId = '3BC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '351';
-- 
-- DBC Item name: Domain Names - .net.au
-- DBC CodeName: DOM.352.NETA
-- HB Product ID: 352
-- 
UPDATE `hb_products` SET dbcItemId = '3DC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '352';
-- 
-- DBC Item name: Domain Names - .co
-- DBC CodeName: DOM.358.CO
-- HB Product ID: 358
-- 
UPDATE `hb_products` SET dbcItemId = '3FC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '358';
-- 
-- DBC Item name: Domain Names - .com.tw
-- DBC CodeName: DOM.386.COTW
-- HB Product ID: 386
-- 
UPDATE `hb_products` SET dbcItemId = '49C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '386';
-- 
-- DBC Item name: Domain Names - .biz
-- DBC CodeName: DOM.4.BIZ
-- HB Product ID: 4
-- 
UPDATE `hb_products` SET dbcItemId = '89C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '4';
-- 
-- DBC Item name: Domain Names - .in
-- DBC CodeName: DOM.415.IN
-- HB Product ID: 415
-- 
UPDATE `hb_products` SET dbcItemId = '55C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '415';
-- 
-- DBC Item name: Domain Names - .cn
-- DBC CodeName: DOM.427.CN
-- HB Product ID: 427
-- 
UPDATE `hb_products` SET dbcItemId = '57C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '427';
-- 
-- DBC Item name: Domain Names - .co.id
-- DBC CodeName: DOM.433.COID
-- HB Product ID: 433
-- 
UPDATE `hb_products` SET dbcItemId = '59C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '433';
-- 
-- DBC Item name: Domain Names - .com.ph
-- DBC CodeName: DOM.435.COPH
-- HB Product ID: 435
-- 
UPDATE `hb_products` SET dbcItemId = '5BC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '435';
-- 
-- DBC Item name: Domain Names - .hk
-- DBC CodeName: DOM.441.HK
-- HB Product ID: 441
-- 
UPDATE `hb_products` SET dbcItemId = '5DC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '441';
-- 
-- DBC Item name: Domain Names - .technology
-- DBC CodeName: DOM.486.TENO
-- HB Product ID: 486
-- 
UPDATE `hb_products` SET dbcItemId = '67C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '486';
-- 
-- DBC Item name: Domain Names - .ventures
-- DBC CodeName: DOM.487.VENT
-- HB Product ID: 487
-- 
UPDATE `hb_products` SET dbcItemId = '69C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '487';
-- 
-- DBC Item name: Domain Names - .lighting
-- DBC CodeName: DOM.493.LIGH
-- HB Product ID: 493
-- 
UPDATE `hb_products` SET dbcItemId = '6BC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '493';
-- 
-- DBC Item name: Domain Names - .gallery
-- DBC CodeName: DOM.495.GALL
-- HB Product ID: 495
-- 
UPDATE `hb_products` SET dbcItemId = '6DC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '495';
-- 
-- DBC Item name: Domain Names - .today
-- DBC CodeName: DOM.498.TODA
-- HB Product ID: 498
-- 
UPDATE `hb_products` SET dbcItemId = '6FC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '498';
-- 
-- DBC Item name: Domain Names - .info
-- DBC CodeName: DOM.5.INFO
-- HB Product ID: 5
-- 
UPDATE `hb_products` SET dbcItemId = '8BC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '5';
-- 
-- DBC Item name: Domain Names - .guru
-- DBC CodeName: DOM.501.GURU
-- HB Product ID: 501
-- 
UPDATE `hb_products` SET dbcItemId = '71C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '501';
-- 
-- DBC Item name: Domain Names - .clothing
-- DBC CodeName: DOM.502.CLOT
-- HB Product ID: 502
-- 
UPDATE `hb_products` SET dbcItemId = '73C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '502';
-- 
-- DBC Item name: Domain Names - .company
-- DBC CodeName: DOM.514.COMP
-- HB Product ID: 514
-- 
UPDATE `hb_products` SET dbcItemId = '75C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '514';
-- 
-- DBC Item name: Domain Names - .club
-- DBC CodeName: DOM.524.CLUB
-- HB Product ID: 524
-- 
UPDATE `hb_products` SET dbcItemId = '77C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '524';
-- 
-- DBC Item name: Domain Names - .la
-- DBC CodeName: DOM.534.LA
-- HB Product ID: 534
-- 
UPDATE `hb_products` SET dbcItemId = '7DC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '534';
-- 
-- DBC Item name: Domain Names - .com.hk
-- DBC CodeName: DOM.576.COHK
-- HB Product ID: 576
-- 
UPDATE `hb_products` SET dbcItemId = '9BC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '576';
-- 
-- DBC Item name: Domain Names - .us
-- DBC CodeName: DOM.8.US
-- HB Product ID: 8
-- 
UPDATE `hb_products` SET dbcItemId = '8DC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '8';
-- 
-- DBC Item name: Domain Names - .cloud
-- DBC CodeName: DOM.834.CLOD
-- HB Product ID: 834
-- 
UPDATE `hb_products` SET dbcItemId = '13C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '834';
-- 
-- DBC Item name: Domain Names - .domains
-- DBC CodeName: DOM.852.DOMA
-- HB Product ID: 852
-- 
UPDATE `hb_products` SET dbcItemId = '1FC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '852';
-- 
-- DBC Item name: Domain Names - .hosting
-- DBC CodeName: DOM.853.HOST
-- HB Product ID: 853
-- 
UPDATE `hb_products` SET dbcItemId = '21C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '853';
-- 
-- DBC Item name: Domain Names - .software
-- DBC CodeName: DOM.854.SOFT
-- HB Product ID: 854
-- 
UPDATE `hb_products` SET dbcItemId = '23C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '854';
-- 
-- DBC Item name: Domain Names - .website
-- DBC CodeName: DOM.858.WEBS
-- HB Product ID: 858
-- 
UPDATE `hb_products` SET dbcItemId = '25C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '858';
-- 
-- DBC Item name: Domain Names - .site
-- DBC CodeName: DOM.859.SITE
-- HB Product ID: 859
-- 
UPDATE `hb_products` SET dbcItemId = '27C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '859';
-- 
-- DBC Item name: Domain Names - .life
-- DBC CodeName: DOM.889.LIFE
-- HB Product ID: 889
-- 
UPDATE `hb_products` SET dbcItemId = '45C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '889';
-- 
-- DBC Item name: Domain Names - .pro
-- DBC CodeName: DOM.891.PRO
-- HB Product ID: 891
-- 
UPDATE `hb_products` SET dbcItemId = '49C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '891';
-- 
-- DBC Item name: Domain Names - .group
-- DBC CodeName: DOM.892.GROP
-- HB Product ID: 892
-- 
UPDATE `hb_products` SET dbcItemId = '4BC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '892';
-- 
-- DBC Item name: Domain Names - .work
-- DBC CodeName: DOM.893.WORK
-- HB Product ID: 893
-- 
UPDATE `hb_products` SET dbcItemId = '4DC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '893';
-- 
-- DBC Item name: Domain Names - .shop
-- DBC CodeName: DOM.894.SHOP
-- HB Product ID: 894
-- 
UPDATE `hb_products` SET dbcItemId = '4FC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '894';
-- 
-- DBC Item name: Domain Names - .works
-- DBC CodeName: DOM.895.WORS
-- HB Product ID: 895
-- 
UPDATE `hb_products` SET dbcItemId = '51C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '895';
-- 
-- DBC Item name: Upgrade DISK 50 GB. VPS
-- DBC CodeName: DVPS.1282.DVPS
-- HB Product ID: 1282
-- 
UPDATE `hb_products` SET dbcItemId = 'AE0930B2-89B7-EB11-9B52-000D3AC76976', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1282';
-- 
-- DBC Item name: Dynamics365 - Business Central Essential (Annually)
-- DBC CodeName: DYNA.1125.DYN3
-- HB Product ID: 1125
-- 
UPDATE `hb_products` SET dbcItemId = '0BC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1125';
-- 
-- DBC Item name: Dynamics365 - Dynamics 365 Business Central Team Member
-- DBC CodeName: DYNA.1132.D365
-- HB Product ID: 1132
-- 
UPDATE `hb_products` SET dbcItemId = '15C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1132';
-- 
-- DBC Item name: Email Marketing - MailChimp - 50K Package
-- DBC CodeName: EM.1116.MCP3
-- HB Product ID: 1116
-- 
UPDATE `hb_products` SET dbcItemId = 'FBC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1116';
-- 
-- DBC Item name: Email Marketing - MailChimp - 10K Package
-- DBC CodeName: EM.1123.MCP4
-- HB Product ID: 1123
-- 
UPDATE `hb_products` SET dbcItemId = '07C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1123';
-- 
-- DBC Item name: Email Marketing - Clean Email 20,000 Mail
-- DBC CodeName: EM.875.CEM
-- HB Product ID: 875
-- 
UPDATE `hb_products` SET dbcItemId = '3BC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '875';
-- 
-- DBC Item name: Email Marketing - MailChimp - 25K Package  
-- DBC CodeName: EM.998.MCP2
-- HB Product ID: 998
-- 
UPDATE `hb_products` SET dbcItemId = '9FC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '998';
-- 
-- DBC Item name: Email Marketing - MailChimp - S Package (Monthly)
-- DBC CodeName: EM.999.MCP1
-- HB Product ID: 999
-- 
UPDATE `hb_products` SET dbcItemId = 'A1C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '999';
-- 
-- DBC Item name: Foreign-Linux Hosting - Economy Plan
-- DBC CodeName: FLH.1153.FS01
-- HB Product ID: 1153
-- 
UPDATE `hb_products` SET dbcItemId = '27C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1153';
-- 
-- DBC Item name: Foreign-Linux Hosting - Standard Plan
-- DBC CodeName: FLH.1154.FS02
-- HB Product ID: 1154
-- 
UPDATE `hb_products` SET dbcItemId = '29C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1154';
-- 
-- DBC Item name: Foreign-Linux Hosting - Premium Plan
-- DBC CodeName: FLH.1155.FS03
-- HB Product ID: 1155
-- 
UPDATE `hb_products` SET dbcItemId = '2BC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1155';
-- 
-- DBC Item name: Foreign-Linux Hosting - Corporate Plan
-- DBC CodeName: FLH.1157.FS04
-- HB Product ID: 1157
-- 
UPDATE `hb_products` SET dbcItemId = '2DC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1157';
-- 
-- DBC Item name: Foreign-Linux Hosting - Ultimate Plan
-- DBC CodeName: FLH.1158.FS05
-- HB Product ID: 1158
-- 
UPDATE `hb_products` SET dbcItemId = '2FC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1158';
-- 
-- DBC Item name: GSuite - Basic (over 20 Seats)
-- DBC CodeName: GSU.1195.GSU2
-- HB Product ID: 1195
-- 
UPDATE `hb_products` SET dbcItemId = '3DC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1195';
-- 
-- DBC Item name: GSuite - Business (over 20 Seats)
-- DBC CodeName: GSU.1223.GSU7
-- HB Product ID: 1223
-- 
UPDATE `hb_products` SET dbcItemId = '5DC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1223';
-- 
-- DBC Item name: Google Workspace Business Starter
-- DBC CodeName: GSU.1249.GSW1
-- HB Product ID: 1249
-- 
UPDATE `hb_products` SET dbcItemId = '3C2006C3-EB4F-EB11-AF23-000D3AC907E2', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1249';
-- 
-- DBC Item name: Google Workspace Business Standard 
-- DBC CodeName: GSU.1250.GSW2
-- HB Product ID: 1250
-- 
UPDATE `hb_products` SET dbcItemId = 'BDFD7EA7-EC4F-EB11-AF23-000D3AC907E2', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1250';
-- 
-- DBC Item name: Google Workspace Business Plus
-- DBC CodeName: GSU.1251.GSW3
-- HB Product ID: 1251
-- 
UPDATE `hb_products` SET dbcItemId = '308796CA-EC4F-EB11-AF23-000D3AC907E2', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1251';
-- 
-- DBC Item name: Google Workspace Business Starter  (Over 20 Seats)
-- DBC CodeName: GSU.1252.GSW4
-- HB Product ID: 1252
-- 
UPDATE `hb_products` SET dbcItemId = 'D37A0B40-B750-EB11-AF23-000D3AC907E2', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1252';
-- 
-- DBC Item name: Google Workspace Business Standard  (Over 20 Seats) 
-- DBC CodeName: GSU.1253.GSW5
-- HB Product ID: 1253
-- 
UPDATE `hb_products` SET dbcItemId = 'E1C5D8B9-B750-EB11-AF23-000D3AC907E2', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1253';
-- 
-- DBC Item name: Google Workspace Business Plus  (Over 20 Seats) 
-- DBC CodeName: GSU.1254.GSW6
-- HB Product ID: 1254
-- 
UPDATE `hb_products` SET dbcItemId = '4BC784A6-B750-EB11-AF23-000D3AC907E2', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1254';
-- 
-- DBC Item name: GSuite - Basic
-- DBC CodeName: GSU.152.GSU1
-- HB Product ID: 152
-- 
UPDATE `hb_products` SET dbcItemId = 'C9C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '152';
-- 
-- DBC Item name: GSuite - Additional Storage 200 GB
-- DBC CodeName: GSU.624.GSA2
-- HB Product ID: 624
-- 
UPDATE `hb_products` SET dbcItemId = 'A3C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '624';
-- 
-- DBC Item name: GSuite - Business
-- DBC CodeName: GSU.688.GSU4
-- HB Product ID: 688
-- 
UPDATE `hb_products` SET dbcItemId = 'C1C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1BBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '688';
-- 
-- DBC Item name: GSuite - Additional Storage 20 GB
-- DBC CodeName: GSU.730.GSA1
-- HB Product ID: 730
-- 
UPDATE `hb_products` SET dbcItemId = 'D1C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '730';
-- 
-- DBC Item name: GSuite - Vault
-- DBC CodeName: GSU.748.GOOV
-- HB Product ID: 748
-- 
UPDATE `hb_products` SET dbcItemId = 'D9C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '748';
-- 
-- DBC Item name: GSuite - Basic (Monthly) 
-- DBC CodeName: GSU.754.GSU3
-- HB Product ID: 754
-- 
UPDATE `hb_products` SET dbcItemId = 'E1C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1BBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '754';
-- 
-- DBC Item name: GSuite - Business (Monthly)
-- DBC CodeName: GSU.755.GSU6
-- HB Product ID: 755
-- 
UPDATE `hb_products` SET dbcItemId = 'E3C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '755';
-- 
-- DBC Item name: GSuite - Additional Storage 50 GB
-- DBC CodeName: GSU.869.GSA
-- HB Product ID: 869
-- 
UPDATE `hb_products` SET dbcItemId = '33C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '869';
-- 
-- DBC Item name: Internationalized Domain Names - .com
-- DBC CodeName: IDN.1189.IDN1
-- HB Product ID: 1189
-- 
UPDATE `hb_products` SET dbcItemId = '37C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1189';
-- 
-- DBC Item name: Internationalized Domain Names - .net
-- DBC CodeName: IDN.1192.IDN2
-- HB Product ID: 1192
-- 
UPDATE `hb_products` SET dbcItemId = '39C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1192';
-- 
-- DBC Item name: Value Plan
-- DBC CodeName: LD.1217.DED6
-- HB Product ID: 1217
-- 
UPDATE `hb_products` SET dbcItemId = '57C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1217';
-- 
-- DBC Item name: Linux Dedicated Server - Standard Server 1U - 500G-2T
-- DBC CodeName: LD.149.DED2
-- HB Product ID: 149
-- 
UPDATE `hb_products` SET dbcItemId = 'C7C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '149';
-- 
-- DBC Item name: Linux Dedicated Server - High performance server 2U -  80G
-- DBC CodeName: LD.369.DED4
-- HB Product ID: 369
-- 
UPDATE `hb_products` SET dbcItemId = '41C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '369';
-- 
-- DBC Item name: Flexible
-- DBC CodeName: LD.674.DED1
-- HB Product ID: 674
-- 
UPDATE `hb_products` SET dbcItemId = 'B7C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '674';
-- 
-- DBC Item name: Enterprise Plan
-- DBC CodeName: LD.676.DED5
-- HB Product ID: 676
-- 
UPDATE `hb_products` SET dbcItemId = 'B9C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '676';
-- 
-- DBC Item name: Linux Hosting - Email - Economy plan
-- DBC CodeName: LH.1034.EECO
-- HB Product ID: 1034
-- 
UPDATE `hb_products` SET dbcItemId = 'ADC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1034';
-- 
-- DBC Item name: Linux Hosting - Economy plan
-- DBC CodeName: LH.22.ECO
-- HB Product ID: 22
-- 
UPDATE `hb_products` SET dbcItemId = 'A1C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '22';
-- 
-- DBC Item name: Linux Hosting - Standard Plan
-- DBC CodeName: LH.23.STAD
-- HB Product ID: 23
-- 
UPDATE `hb_products` SET dbcItemId = 'A3C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '23';
-- 
-- DBC Item name: Linux Hosting - Premium Plan
-- DBC CodeName: LH.24.PREM
-- HB Product ID: 24
-- 
UPDATE `hb_products` SET dbcItemId = 'A5C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '24';
-- 
-- DBC Item name: Linux Hosting - Ecommerce Plan
-- DBC CodeName: LH.25.ECOM
-- HB Product ID: 25
-- 
UPDATE `hb_products` SET dbcItemId = 'A7C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '25';
-- 
-- DBC Item name: Linux Hosting - IP-Address
-- DBC CodeName: LH.283.IP
-- HB Product ID: 283
-- 
UPDATE `hb_products` SET dbcItemId = '09C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '283';
-- 
-- DBC Item name: Linux Hosting - Extra-1
-- DBC CodeName: LH.295.EXT1
-- HB Product ID: 295
-- 
UPDATE `hb_products` SET dbcItemId = '11C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '295';
-- 
-- DBC Item name: Linux Hosting - Extra-2
-- DBC CodeName: LH.296.EXT2
-- HB Product ID: 296
-- 
UPDATE `hb_products` SET dbcItemId = '13C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '296';
-- 
-- DBC Item name: Linux Hosting - Compact Plan WN
-- DBC CodeName: LH.297.CPWN
-- HB Product ID: 297
-- 
UPDATE `hb_products` SET dbcItemId = '15C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '297';
-- 
-- DBC Item name: Linux Hosting - Standard Plan WN
-- DBC CodeName: LH.298.STWN
-- HB Product ID: 298
-- 
UPDATE `hb_products` SET dbcItemId = '17C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '298';
-- 
-- DBC Item name: Linux Hosting - Extra Plan WN
-- DBC CodeName: LH.299.EXWN
-- HB Product ID: 299
-- 
UPDATE `hb_products` SET dbcItemId = '19C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '299';
-- 
-- DBC Item name: Linux Hosting - E-mail Mini Plan
-- DBC CodeName: LH.302.EMIN
-- HB Product ID: 302
-- 
UPDATE `hb_products` SET dbcItemId = '1DC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '302';
-- 
-- DBC Item name: Linux Hosting - E-mail Excellent Plan WN
-- DBC CodeName: LH.304.EEWN
-- HB Product ID: 304
-- 
UPDATE `hb_products` SET dbcItemId = '1FC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '304';
-- 
-- DBC Item name: Linux Hosting - Combo Plan
-- DBC CodeName: LH.313.COWN
-- HB Product ID: 313
-- 
UPDATE `hb_products` SET dbcItemId = '29C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '313';
-- 
-- DBC Item name: Linux Hosting - Reseller-15GB
-- DBC CodeName: LH.316.RS15
-- HB Product ID: 316
-- 
UPDATE `hb_products` SET dbcItemId = '2BC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '316';
-- 
-- DBC Item name: Linux Hosting - Corporate Plan
-- DBC CodeName: LH.59.CORP
-- HB Product ID: 59
-- 
UPDATE `hb_products` SET dbcItemId = 'A9C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '59';
-- 
-- DBC Item name: Linux Hosting - Ultimate Plan
-- DBC CodeName: LH.60.ULTI
-- HB Product ID: 60
-- 
UPDATE `hb_products` SET dbcItemId = 'ABC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '60';
-- 
-- DBC Item name: Linux Hosting - Enterprise Plan
-- DBC CodeName: LH.61.ENTP
-- HB Product ID: 61
-- 
UPDATE `hb_products` SET dbcItemId = 'ADC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '61';
-- 
-- DBC Item name: Linux Hosting - Old NC1-1000MB
-- DBC CodeName: LH.751.HNC1
-- HB Product ID: 751
-- 
UPDATE `hb_products` SET dbcItemId = 'DDC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '751';
-- 
-- DBC Item name: Loadbalancer Basic - LB Standard Plan 1
-- DBC CodeName: LOBA.1086.LBB1
-- HB Product ID: 1086
-- 
UPDATE `hb_products` SET dbcItemId = 'DFC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1086';
-- 
-- DBC Item name: Loadbalancer Basic - LB Standard Plan 2
-- DBC CodeName: LOBA.1087.LBB2
-- HB Product ID: 1087
-- 
UPDATE `hb_products` SET dbcItemId = 'E1C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1087';
-- 
-- DBC Item name: Loadbalancer Basic - LB Standard Plan 3
-- DBC CodeName: LOBA.1088.LBB3
-- HB Product ID: 1088
-- 
UPDATE `hb_products` SET dbcItemId = 'E3C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1088';
-- 
-- DBC Item name: Loadbalancer VMware - LB High (HA) Plan 1
-- DBC CodeName: LOVM.1089.LBV1
-- HB Product ID: 1089
-- 
UPDATE `hb_products` SET dbcItemId = 'E5C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1089';
-- 
-- DBC Item name: Loadbalancer VMware - LB High (HA) Plan 2
-- DBC CodeName: LOVM.1090.LBV2
-- HB Product ID: 1090
-- 
UPDATE `hb_products` SET dbcItemId = 'E7C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1090';
-- 
-- DBC Item name: Loadbalancer VMware - LB High (HA) Plan 3
-- DBC CodeName: LOVM.1091.LBV3
-- HB Product ID: 1091
-- 
UPDATE `hb_products` SET dbcItemId = 'E9C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1091';
-- 
-- DBC Item name: Flexible - cloudvps.phuketdir.com
-- DBC CodeName: LVM.883.24753
-- HB Product ID: 883
-- 
UPDATE `hb_products` SET dbcItemId = '7B0AF74F-DC4F-EB11-AF23-000D3AC907E2', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '883';
-- 
-- DBC Item name: Flexible
-- DBC CodeName: LVM.883.LVMW
-- HB Product ID: 883
-- 
UPDATE `hb_products` SET dbcItemId = '3FC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '883';
-- 
-- DBC Item name: Flexible
-- DBC CodeName: LVPS.882.LVPS
-- HB Product ID: 882
-- 
UPDATE `hb_products` SET dbcItemId = '3DC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '882';
-- 
-- DBC Item name: Microsoft 365 - Exchange Online (Plan 2)
-- DBC CodeName: M365.1051.M3E2
-- HB Product ID: 1051
-- 
UPDATE `hb_products` SET dbcItemId = 'B5C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1051';
-- 
-- DBC Item name: Microsoft 365 - Exchange Online Advanced Threat Protection
-- DBC CodeName: M365.1085.M3ET
-- HB Product ID: 1085
-- 
UPDATE `hb_products` SET dbcItemId = 'DDC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1085';
-- 
-- DBC Item name: Microsoft 365 - Power BI Pro
-- DBC CodeName: M365.1093.PWB2
-- HB Product ID: 1093
-- 
UPDATE `hb_products` SET dbcItemId = 'EDC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1BBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1093';
-- 
-- DBC Item name: Microsoft 365 - Power BI Pro for faculty 
-- DBC CodeName: M365.1124.PWB3
-- HB Product ID: 1124
-- 
UPDATE `hb_products` SET dbcItemId = '09C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1124';
-- 
-- DBC Item name: Microsoft 365 - OneDrive for Business (Plan 2)
-- DBC CodeName: M365.1194.ODP2
-- HB Product ID: 1194
-- 
UPDATE `hb_products` SET dbcItemId = '3BC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1194';
-- 
-- DBC Item name: Microsoft 365 - Business Voice (without calling plan)
-- DBC CodeName: M365.1213.M3BV
-- HB Product ID: 1213
-- 
UPDATE `hb_products` SET dbcItemId = '4FC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1213';
-- 
-- DBC Item name: Microsoft 365 - Project Pro for Office 365
-- DBC CodeName: M365.1482.M3P6
-- HB Product ID: 1482
-- 
UPDATE `hb_products` SET dbcItemId = 'AA348C8B-8704-EC11-86BC-002248559070', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1482';
-- 
-- DBC Item name: Microsoft 365 - Office 365 E3
-- DBC CodeName: M365.677.M3E3
-- HB Product ID: 677
-- 
UPDATE `hb_products` SET dbcItemId = 'BBC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1BBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '677';
-- 
-- DBC Item name: Microsoft 365 - Exchange Online (Plan1)
-- DBC CodeName: M365.682.M3C1
-- HB Product ID: 682
-- 
UPDATE `hb_products` SET dbcItemId = 'BDC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1BBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '682';
-- 
-- DBC Item name: Microsoft 365 - Exchange Online Kiosk
-- DBC CodeName: M365.684.M3EK
-- HB Product ID: 684
-- 
UPDATE `hb_products` SET dbcItemId = 'BFC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '684';
-- 
-- DBC Item name: Microsoft 365 - Project Pro for Office 365
-- DBC CodeName: M365.696.M3P1
-- HB Product ID: 696
-- 
UPDATE `hb_products` SET dbcItemId = 'C3C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '696';
-- 
-- DBC Item name: Microsoft 365 - Apps for business
-- DBC CodeName: M365.707.M3AB
-- HB Product ID: 707
-- 
UPDATE `hb_products` SET dbcItemId = 'C5C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1BBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '707';
-- 
-- DBC Item name: Microsoft 365 - Business Basic 
-- DBC CodeName: M365.708.M3B1
-- HB Product ID: 708
-- 
UPDATE `hb_products` SET dbcItemId = 'C7C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '708';
-- 
-- DBC Item name: Microsoft 365 - Business Standard
-- DBC CodeName: M365.709.M3B2
-- HB Product ID: 709
-- 
UPDATE `hb_products` SET dbcItemId = 'C9C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '709';
-- 
-- DBC Item name: Microsoft 365 - Office 365 Enterprise E1
-- DBC CodeName: M365.710.M3E1
-- HB Product ID: 710
-- 
UPDATE `hb_products` SET dbcItemId = 'CBC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '710';
-- 
-- DBC Item name: Microsoft 365 - Apps For Enterprise
-- DBC CodeName: M365.714.M3AE
-- HB Product ID: 714
-- 
UPDATE `hb_products` SET dbcItemId = 'CDC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '714';
-- 
-- DBC Item name: Microsoft 365 - Visio Pro for Office 365
-- DBC CodeName: M365.724.M3VS
-- HB Product ID: 724
-- 
UPDATE `hb_products` SET dbcItemId = 'CFC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '724';
-- 
-- DBC Item name: Microsoft 365 - Exchange Online (Plan1) Monthly
-- DBC CodeName: M365.752.M3EM
-- HB Product ID: 752
-- 
UPDATE `hb_products` SET dbcItemId = 'DFC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '752';
-- 
-- DBC Item name: Microsoft 365 - Business Basic (Monthly)
-- DBC CodeName: M365.758.M3BM
-- HB Product ID: 758
-- 
UPDATE `hb_products` SET dbcItemId = 'E5C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '19BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '758';
-- 
-- DBC Item name: Microsoft 365 - App for Business (Monthly)
-- DBC CodeName: M365.759.M3AM
-- HB Product ID: 759
-- 
UPDATE `hb_products` SET dbcItemId = 'E7C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '19BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '759';
-- 
-- DBC Item name: Microsoft 365 - Business Standard (Monthly)
-- DBC CodeName: M365.760.M3SM
-- HB Product ID: 760
-- 
UPDATE `hb_products` SET dbcItemId = 'E9C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '19BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '760';
-- 
-- DBC Item name: Microsoft 365 - Project Plan 5 (Monthly)
-- DBC CodeName: M365.769.M3P2
-- HB Product ID: 769
-- 
UPDATE `hb_products` SET dbcItemId = 'EBC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '769';
-- 
-- DBC Item name: Microsoft 365 - Project Plan 1
-- DBC CodeName: M365.871.M3P3
-- HB Product ID: 871
-- 
UPDATE `hb_products` SET dbcItemId = '35C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '871';
-- 
-- DBC Item name: Microsoft 365 - Project Plan 3
-- DBC CodeName: M365.872.M3P4
-- HB Product ID: 872
-- 
UPDATE `hb_products` SET dbcItemId = '37C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '872';
-- 
-- DBC Item name: Microsoft 365 - Project Plan 5
-- DBC CodeName: M365.873.M3P5
-- HB Product ID: 873
-- 
UPDATE `hb_products` SET dbcItemId = '39C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '873';
-- 
-- DBC Item name: Microsoft 365 -  Exchange Online Archiving
-- DBC CodeName: M365.901.M3EA
-- HB Product ID: 901
-- 
UPDATE `hb_products` SET dbcItemId = '55C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '901';
-- 
-- DBC Item name: Microsoft 365 - Power BI Pro
-- DBC CodeName: M365.924.PWB1
-- HB Product ID: 924
-- 
UPDATE `hb_products` SET dbcItemId = '5FC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '924';
-- 
-- DBC Item name: Microsoft 365 - OneDrive for business (Plan 1)
-- DBC CodeName: M365.955.ODP1
-- HB Product ID: 955
-- 
UPDATE `hb_products` SET dbcItemId = '7BC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '955';
-- 
-- DBC Item name: Microsoft 365 - Office 365 A1 for students
-- DBC CodeName: M365.975.O3A1
-- HB Product ID: 975
-- 
UPDATE `hb_products` SET dbcItemId = '91C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '975';
-- 
-- DBC Item name: Microsoft 365 -  Visio Plan 2
-- DBC CodeName: M365.984.VIS2
-- HB Product ID: 984
-- 
UPDATE `hb_products` SET dbcItemId = '97C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '984';
-- 
-- DBC Item name: Microsoft 365 -  Visio Plan 1
-- DBC CodeName: M365.985.VIS1
-- HB Product ID: 985
-- 
UPDATE `hb_products` SET dbcItemId = '99C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '985';
-- 
-- DBC Item name: Managed Server Services - Standard
-- DBC CodeName: MA.1183.MAN1
-- HB Product ID: 1183
-- 
UPDATE `hb_products` SET dbcItemId = '31C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1183';
-- 
-- DBC Item name: Managed Server Services - External For VPS server
-- DBC CodeName: MA.398.MAN3
-- HB Product ID: 398
-- 
UPDATE `hb_products` SET dbcItemId = '53C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '398';
-- 
-- DBC Item name: Managed Server Services - External For dedicated server
-- DBC CodeName: MA.82.MAN2
-- HB Product ID: 82
-- 
UPDATE `hb_products` SET dbcItemId = 'B9C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '82';
-- 
-- DBC Item name: Managed Server Services - Managed Zabbix Set up fee
-- DBC CodeName: MA.898.MAN4
-- HB Product ID: 898
-- 
UPDATE `hb_products` SET dbcItemId = '53C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '898';
-- 
-- DBC Item name: Managed Server Services - External standard
-- DBC CodeName: MA.918.MAN5
-- HB Product ID: 918
-- 
UPDATE `hb_products` SET dbcItemId = '59C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '918';
-- 
-- DBC Item name: Monitoring Services - Monitoring
-- DBC CodeName: MON.394.MONT
-- HB Product ID: 394
-- 
UPDATE `hb_products` SET dbcItemId = '4FC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '394';
-- 
-- DBC Item name: Monitoring Services - SMS Extension - Max 300 SMS
-- DBC CodeName: MON.395.SMS
-- HB Product ID: 395
-- 
UPDATE `hb_products` SET dbcItemId = '51C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '395';
-- 
-- DBC Item name: Netway.Site - Starter
-- DBC CodeName: NES.1023.NWS1
-- HB Product ID: 1023
-- 
UPDATE `hb_products` SET dbcItemId = 'A5C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1023';
-- 
-- DBC Item name: A3 for Faculty
-- DBC CodeName: O365.1151.A3F
-- HB Product ID: 1151
-- 
UPDATE `hb_products` SET dbcItemId = '23C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1DBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1151';
-- 
-- DBC Item name: A3 for students
-- DBC CodeName: O365.979.O3A3
-- HB Product ID: 979
-- 
UPDATE `hb_products` SET dbcItemId = '95C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '979';
-- 
-- DBC Item name: Projects - REGO Project MA
-- DBC CodeName: PJ.526.REGO
-- HB Product ID: 526
-- 
UPDATE `hb_products` SET dbcItemId = '79C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '526';
-- 
-- DBC Item name: Reseller Domain - Package 10 Domains
-- DBC CodeName: RES.582.RSD1
-- HB Product ID: 582
-- 
UPDATE `hb_products` SET dbcItemId = '9DC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '582';
-- 
-- DBC Item name: Restore domain - .redemption
-- DBC CodeName: RSTD.128.REDE
-- HB Product ID: 128
-- 
UPDATE `hb_products` SET dbcItemId = 'C5C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '128';
-- 
-- DBC Item name: Upgrade RAM VPS
-- DBC CodeName: RVPS.1268.RVPS
-- HB Product ID: 1268
-- 
UPDATE `hb_products` SET dbcItemId = 'CFB4973D-8CA1-EB11-8CE6-0022485645EC', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1268';
-- 
-- DBC Item name: Services - Backup Data
-- DBC CodeName: SERV.103.BACU
-- HB Product ID: 103
-- 
UPDATE `hb_products` SET dbcItemId = 'BFC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '103';
-- 
-- DBC Item name: Services - Configuration and Setup
-- DBC CodeName: SERV.1110.CFG2
-- HB Product ID: 1110
-- 
UPDATE `hb_products` SET dbcItemId = 'F1C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1110';
-- 
-- DBC Item name: Services - External Backup
-- DBC CodeName: SERV.1127.ETNB
-- HB Product ID: 1127
-- 
UPDATE `hb_products` SET dbcItemId = '0DC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1127';
-- 
-- DBC Item name: Services - Dedicated IP Address
-- DBC CodeName: SERV.119.IPAD
-- HB Product ID: 119
-- 
UPDATE `hb_products` SET dbcItemId = 'C1C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '119';
-- 
-- DBC Item name: Services - Migrate + First Installation
-- DBC CodeName: SERV.125.MIGI
-- HB Product ID: 125
-- 
UPDATE `hb_products` SET dbcItemId = 'C3C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '125';
-- 
-- DBC Item name: Solution Service
-- DBC CodeName: SERV.1259.HWD2
-- HB Product ID: 1259
-- 
UPDATE `hb_products` SET dbcItemId = '622457FC-9E5B-EB11-AF25-000D3AC907E2', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1259';
-- 
-- DBC Item name: Implement AD
-- DBC CodeName: SERV.1260.HWD3
-- HB Product ID: 1260
-- 
UPDATE `hb_products` SET dbcItemId = '2FA7A699-9F5B-EB11-AF25-000D3AC907E2', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1260';
-- 
-- DBC Item name: Onsite Service
-- DBC CodeName: SERV.1261.HWD4
-- HB Product ID: 1261
-- 
UPDATE `hb_products` SET dbcItemId = '3634EEBF-9F5B-EB11-AF25-000D3AC907E2', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1261';
-- 
-- DBC Item name: Services - Installation Service
-- DBC CodeName: SERV.284.INST
-- HB Product ID: 284
-- 
UPDATE `hb_products` SET dbcItemId = '0BC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '284';
-- 
-- DBC Item name: Onsite Training Service
-- DBC CodeName: SERV.454.ONSI
-- HB Product ID: 454
-- 
UPDATE `hb_products` SET dbcItemId = '1E0BF2B8-D8A0-EB11-8CE6-0022485645EC', baseUnitOfMeasureId = 'CAFEEEF4-4647-EB11-BF6C-000D3AC8F2C9' WHERE id = '454';
-- 
-- DBC Item name: Services - Configuration Service
-- DBC CodeName: SERV.477.CFG1
-- HB Product ID: 477
-- 
UPDATE `hb_products` SET dbcItemId = '65C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '477';
-- 
-- DBC Item name: Services - Email Migrate Service
-- DBC CodeName: SERV.743.EMGS
-- HB Product ID: 743
-- 
UPDATE `hb_products` SET dbcItemId = 'D3C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '743';
-- 
-- DBC Item name: Onsite Training Service
-- DBC CodeName: SERV.745.ONSI
-- HB Product ID: 745
-- 
UPDATE `hb_products` SET dbcItemId = 'D5C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = 'CAFEEEF4-4647-EB11-BF6C-000D3AC8F2C9' WHERE id = '745';
-- 
-- DBC Item name: Services - Managed Service for Emails
-- DBC CodeName: SERV.890.MSFE
-- HB Product ID: 890
-- 
UPDATE `hb_products` SET dbcItemId = '47C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '890';
-- 
-- DBC Item name: Services - Domestic Bandwidth Unlimited
-- DBC CodeName: SERV.930.DMBN
-- HB Product ID: 930
-- 
UPDATE `hb_products` SET dbcItemId = '65C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '930';
-- 
-- DBC Item name: Services - Firewall Service
-- DBC CodeName: SERV.95.FIRW
-- HB Product ID: 95
-- 
UPDATE `hb_products` SET dbcItemId = 'BDC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '95';
-- 
-- DBC Item name: SSL Certificates -  Entrust EV Code Signing
-- DBC CodeName: SSL.1000.SE09
-- HB Product ID: 1000
-- 
UPDATE `hb_products` SET dbcItemId = 'A3C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1000';
-- 
-- DBC Item name: SSL Certificates - Entrust Document Signing
-- DBC CodeName: SSL.1044.SE07
-- HB Product ID: 1044
-- 
UPDATE `hb_products` SET dbcItemId = 'B1C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1044';
-- 
-- DBC Item name: SSL Certificates -  Entrust Code Signing
-- DBC CodeName: SSL.1047.SE08
-- HB Product ID: 1047
-- 
UPDATE `hb_products` SET dbcItemId = 'B3C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1047';
-- 
-- DBC Item name: SSL Certificates - Basic EV - Digicert EV Multi-Domain
-- DBC CodeName: SSL.1117.SD08
-- HB Product ID: 1117
-- 
UPDATE `hb_products` SET dbcItemId = 'FDC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1117';
-- 
-- DBC Item name: SSL Certificates - Basic EV - Digicert EV Multi-Domain (Additional Certificate)
-- DBC CodeName: SSL.1118.SD09
-- HB Product ID: 1118
-- 
UPDATE `hb_products` SET dbcItemId = 'FFC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1118';
-- 
-- DBC Item name: SSL Certificates - Digicert Timestamp Authority
-- DBC CodeName: SSL.1186.SD10
-- HB Product ID: 1186
-- 
UPDATE `hb_products` SET dbcItemId = '33C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1186';
-- 
-- DBC Item name: SSL Certificates - Digicert  LTANS Adobe Signing
-- DBC CodeName: SSL.1187.SD11
-- HB Product ID: 1187
-- 
UPDATE `hb_products` SET dbcItemId = '35C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1187';
-- 
-- DBC Item name: SSL Certificates - CPAC Basic
-- DBC CodeName: SSL.1199.SO07
-- HB Product ID: 1199
-- 
UPDATE `hb_products` SET dbcItemId = '41C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1199';
-- 
-- DBC Item name: SSL Certificates - GeoTrust DV SSL - QuickSSL Premium (Additional Certificate)
-- DBC CodeName: SSL.1203.SG02
-- HB Product ID: 1203
-- 
UPDATE `hb_products` SET dbcItemId = '47C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1203';
-- 
-- DBC Item name: SSL Certificates - GeoTrust TrueBusiness ID OV (Additional Certificate)
-- DBC CodeName: SSL.1204.SG09
-- HB Product ID: 1204
-- 
UPDATE `hb_products` SET dbcItemId = '49C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1204';
-- 
-- DBC Item name: SSL Certificates - GeoTrust TrueBusiness ID EV (Additional Certificate)
-- DBC CodeName: SSL.1205.SG06
-- HB Product ID: 1205
-- 
UPDATE `hb_products` SET dbcItemId = '4BC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1205';
-- 
-- DBC Item name: SSL Certificates -  Digicert Code Signing
-- DBC CodeName: SSL.1206.SD13
-- HB Product ID: 1206
-- 
UPDATE `hb_products` SET dbcItemId = 'F98D2F6C-68B4-EB11-9B52-000D3AC6C873', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1206';
-- 
-- DBC Item name: SSL Certificates - DigiCert Document Signing Individual (2000)
-- DBC CodeName: SSL.1207.SD12
-- HB Product ID: 1207
-- 
UPDATE `hb_products` SET dbcItemId = '4DC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1207';
-- 
-- DBC Item name: SSL Certificates - Thawte SSL123 DV  (Additional Certificate)
-- DBC CodeName: SSL.1218.ST02
-- HB Product ID: 1218
-- 
UPDATE `hb_products` SET dbcItemId = '59C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1218';
-- 
-- DBC Item name: SSL Certificates - Digicert Standard SSL (Additional Certificate)
-- DBC CodeName: SSL.1228.SD02
-- HB Product ID: 1228
-- 
UPDATE `hb_products` SET dbcItemId = '5FC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1228';
-- 
-- DBC Item name: SSL Certificates - Digicert EV SSL (Additional Certificate)
-- DBC CodeName: SSL.1230.SD05
-- HB Product ID: 1230
-- 
UPDATE `hb_products` SET dbcItemId = '61C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1230';
-- 
-- DBC Item name: SSL Certificates - GeoTrust DV SSL - QuickSSL Premium
-- DBC CodeName: SSL.153.SG01
-- HB Product ID: 153
-- 
UPDATE `hb_products` SET dbcItemId = 'CBC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '153';
-- 
-- DBC Item name: SSL Certificates - RapidSSL Standard DV
-- DBC CodeName: SSL.154.SR01
-- HB Product ID: 154
-- 
UPDATE `hb_products` SET dbcItemId = 'CDC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '154';
-- 
-- DBC Item name: SSL Certificates - Thawte SSL123 DV
-- DBC CodeName: SSL.165.ST01
-- HB Product ID: 165
-- 
UPDATE `hb_products` SET dbcItemId = 'CFC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '165';
-- 
-- DBC Item name: SSL Certificates - Basic OV - Digicert Standard
-- DBC CodeName: SSL.166.SD01
-- HB Product ID: 166
-- 
UPDATE `hb_products` SET dbcItemId = 'D1C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '166';
-- 
-- DBC Item name: SSL Certificates - Godaddy Standard SSL (Starfield Technologies) (DV)
-- DBC CodeName: SSL.167.SO01
-- HB Product ID: 167
-- 
UPDATE `hb_products` SET dbcItemId = 'D3C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '167';
-- 
-- DBC Item name: SSL Certificates - GeoTrust TrueBusiness ID OV
-- DBC CodeName: SSL.168.SG07
-- HB Product ID: 168
-- 
UPDATE `hb_products` SET dbcItemId = 'D5C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '168';
-- 
-- DBC Item name: SSL Certificates - Thawte SSL Webserver OV
-- DBC CodeName: SSL.169.ST07
-- HB Product ID: 169
-- 
UPDATE `hb_products` SET dbcItemId = 'D7C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '169';
-- 
-- DBC Item name: SSL Certificates - Secure Site OV
-- DBC CodeName: SSL.170.SS01
-- HB Product ID: 170
-- 
UPDATE `hb_products` SET dbcItemId = 'D9C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '170';
-- 
-- DBC Item name: SSL Certificates - Secure Site Pro SSL
-- DBC CodeName: SSL.171.SS04
-- HB Product ID: 171
-- 
UPDATE `hb_products` SET dbcItemId = 'DBC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '171';
-- 
-- DBC Item name: SSL Certificates - Sectigo InstantSSL
-- DBC CodeName: SSL.172.SC01
-- HB Product ID: 172
-- 
UPDATE `hb_products` SET dbcItemId = 'DDC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '172';
-- 
-- DBC Item name: SSL Certificates - Sectigo InstantSSL Premium
-- DBC CodeName: SSL.173.SC02
-- HB Product ID: 173
-- 
UPDATE `hb_products` SET dbcItemId = 'DFC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '173';
-- 
-- DBC Item name: SSL Certificates - Sectigo InstantSSL Pro
-- DBC CodeName: SSL.174.SC03
-- HB Product ID: 174
-- 
UPDATE `hb_products` SET dbcItemId = 'E1C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '174';
-- 
-- DBC Item name: SSL Certificates - Secure Site EV
-- DBC CodeName: SSL.175.SS08
-- HB Product ID: 175
-- 
UPDATE `hb_products` SET dbcItemId = 'E3C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '175';
-- 
-- DBC Item name: SSL Certificates - Secure Site Pro EV SSL
-- DBC CodeName: SSL.176.SS06
-- HB Product ID: 176
-- 
UPDATE `hb_products` SET dbcItemId = 'E5C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '176';
-- 
-- DBC Item name: SSL Certificates - Thawte SSL Webserver EV
-- DBC CodeName: SSL.177.ST05
-- HB Product ID: 177
-- 
UPDATE `hb_products` SET dbcItemId = 'E7C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '177';
-- 
-- DBC Item name: SSL Certificates - Sectigo EV SSL
-- DBC CodeName: SSL.179.SC13
-- HB Product ID: 179
-- 
UPDATE `hb_products` SET dbcItemId = 'E9C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '179';
-- 
-- DBC Item name: SSL Certificates - Basic EV - Digicert EV
-- DBC CodeName: SSL.180.SD04
-- HB Product ID: 180
-- 
UPDATE `hb_products` SET dbcItemId = 'EBC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '180';
-- 
-- DBC Item name: SSL Certificates - GeoTrust TrueBusiness ID EV
-- DBC CodeName: SSL.181.SG05
-- HB Product ID: 181
-- 
UPDATE `hb_products` SET dbcItemId = 'EDC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '181';
-- 
-- DBC Item name: SSL Certificates - Thawte SSL Webserver Wildcard OV
-- DBC CodeName: SSL.182.ST04
-- HB Product ID: 182
-- 
UPDATE `hb_products` SET dbcItemId = 'EFC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '182';
-- 
-- DBC Item name: SSL Certificates - Sectigo Premium Wildcard SSL
-- DBC CodeName: SSL.184.SC06
-- HB Product ID: 184
-- 
UPDATE `hb_products` SET dbcItemId = 'F1C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '184';
-- 
-- DBC Item name: SSL Certificates - WildCard - Digicert Wildcard
-- DBC CodeName: SSL.185.SD03
-- HB Product ID: 185
-- 
UPDATE `hb_products` SET dbcItemId = 'F3C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '185';
-- 
-- DBC Item name: SSL Certificates - GeoTrust TrueBusiness ID OV - Wildcard
-- DBC CodeName: SSL.186.SG08
-- HB Product ID: 186
-- 
UPDATE `hb_products` SET dbcItemId = 'F5C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '186';
-- 
-- DBC Item name: SSL Certificates - Godaddy Standard WildCard SSL (Starfield Technologies) (DV)
-- DBC CodeName: SSL.187.SO02
-- HB Product ID: 187
-- 
UPDATE `hb_products` SET dbcItemId = 'F7C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '187';
-- 
-- DBC Item name: SSL Certificates - RapidSSL Wildcard DV
-- DBC CodeName: SSL.188.SR02
-- HB Product ID: 188
-- 
UPDATE `hb_products` SET dbcItemId = 'F9C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '188';
-- 
-- DBC Item name: SSL Certificates - GeoTrust TrueBusinessID EV SAN
-- DBC CodeName: SSL.227.SS10
-- HB Product ID: 227
-- 
UPDATE `hb_products` SET dbcItemId = 'FDC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '227';
-- 
-- DBC Item name: SSL Certificates - GeoTrust TrueBusinessID SAN
-- DBC CodeName: SSL.228.SS12
-- HB Product ID: 228
-- 
UPDATE `hb_products` SET dbcItemId = 'FFC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '228';
-- 
-- DBC Item name: SSL Certificates - GeoTrust TrueBusinessID SAN (Additional Certificate)
-- DBC CodeName: SSL.233.SS13
-- HB Product ID: 233
-- 
UPDATE `hb_products` SET dbcItemId = '01C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '233';
-- 
-- DBC Item name: SSL Certificates - Basic OV - Digicert Multi-Domain
-- DBC CodeName: SSL.234.SD07
-- HB Product ID: 234
-- 
UPDATE `hb_products` SET dbcItemId = '03C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '234';
-- 
-- DBC Item name: SSL Certificates - Basic OV - Digicert Multi-Domain (Additional Certificate)
-- DBC CodeName: SSL.235.SD06
-- HB Product ID: 235
-- 
UPDATE `hb_products` SET dbcItemId = '05C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '235';
-- 
-- DBC Item name: SSL Certificates - Thawte Code Signing
-- DBC CodeName: SSL.240.ST09
-- HB Product ID: 240
-- 
UPDATE `hb_products` SET dbcItemId = '07C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '240';
-- 
-- DBC Item name: SSL Certificates - Secure Site OV - Wildcard
-- DBC CodeName: SSL.317.SS03
-- HB Product ID: 317
-- 
UPDATE `hb_products` SET dbcItemId = '2DC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '317';
-- 
-- DBC Item name: SSL Certificates - CSR Generating Service
-- DBC CodeName: SSL.372.SO03
-- HB Product ID: 372
-- 
UPDATE `hb_products` SET dbcItemId = '43C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '372';
-- 
-- DBC Item name: SSL Certificates - Installation Service
-- DBC CodeName: SSL.373.SO04
-- HB Product ID: 373
-- 
UPDATE `hb_products` SET dbcItemId = '45C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '373';
-- 
-- DBC Item name: SSL Certificates - Generating & Installation SSL Service
-- DBC CodeName: SSL.374.SO05
-- HB Product ID: 374
-- 
UPDATE `hb_products` SET dbcItemId = '47C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '374';
-- 
-- DBC Item name: SSL Certificates - GeoTrust  QuickSSL Premium SAN Package (DV)
-- DBC CodeName: SSL.536.SG03
-- HB Product ID: 536
-- 
UPDATE `hb_products` SET dbcItemId = '7FC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '536';
-- 
-- DBC Item name: SSL Certificates - Secure Site OV (Additional Certificate)
-- DBC CodeName: SSL.540.SS02
-- HB Product ID: 540
-- 
UPDATE `hb_products` SET dbcItemId = '81C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '540';
-- 
-- DBC Item name: SSL Certificates - Secure Site Pro SSL (Additional Certificate)
-- DBC CodeName: SSL.541.SS05
-- HB Product ID: 541
-- 
UPDATE `hb_products` SET dbcItemId = '83C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '541';
-- 
-- DBC Item name: SSL Certificates - Secure Site EV (Additional Certificate)
-- DBC CodeName: SSL.542.SS09
-- HB Product ID: 542
-- 
UPDATE `hb_products` SET dbcItemId = '85C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '542';
-- 
-- DBC Item name: SSL Certificates - Secure Site Pro EV SSL (Additional Certificate)
-- DBC CodeName: SSL.543.SS07
-- HB Product ID: 543
-- 
UPDATE `hb_products` SET dbcItemId = '87C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '543';
-- 
-- DBC Item name: SSL Certificates - Sectigo PositiveSSL
-- DBC CodeName: SSL.546.SC04
-- HB Product ID: 546
-- 
UPDATE `hb_products` SET dbcItemId = '89C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '546';
-- 
-- DBC Item name: SSL Certificates - Sectigo PositiveSSL Wildcard
-- DBC CodeName: SSL.547.SC05
-- HB Product ID: 547
-- 
UPDATE `hb_products` SET dbcItemId = '8BC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '547';
-- 
-- DBC Item name: SSL Certificates - Sectigo PositiveSSL Multi-Domain
-- DBC CodeName: SSL.548.SC07
-- HB Product ID: 548
-- 
UPDATE `hb_products` SET dbcItemId = '8DC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '548';
-- 
-- DBC Item name: SSL Certificates - Sectigo PositiveSSL Multi-Domain (Additional Certificate)
-- DBC CodeName: SSL.549.SC08
-- HB Product ID: 549
-- 
UPDATE `hb_products` SET dbcItemId = '8FC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '549';
-- 
-- DBC Item name: SSL Certificates - Sectigo Essential SSL
-- DBC CodeName: SSL.550.SC11
-- HB Product ID: 550
-- 
UPDATE `hb_products` SET dbcItemId = '91C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '550';
-- 
-- DBC Item name: SSL Certificates - Sectigo Essential Wildcard SSL
-- DBC CodeName: SSL.551.SC12
-- HB Product ID: 551
-- 
UPDATE `hb_products` SET dbcItemId = '93C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '551';
-- 
-- DBC Item name: SSL Certificates - Sectigo SSL UCC DV
-- DBC CodeName: SSL.552.SC14
-- HB Product ID: 552
-- 
UPDATE `hb_products` SET dbcItemId = '95C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '552';
-- 
-- DBC Item name: SSL Certificates - Sectigo SSL UCC DV (Additional Certificate)
-- DBC CodeName: SSL.553.SC15
-- HB Product ID: 553
-- 
UPDATE `hb_products` SET dbcItemId = '97C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '553';
-- 
-- DBC Item name: SSL Certificates - GeoTrust TrueBusinessID EV SAN (Additional Certificate)
-- DBC CodeName: SSL.554.SS11
-- HB Product ID: 554
-- 
UPDATE `hb_products` SET dbcItemId = '99C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '554';
-- 
-- DBC Item name: SSL Certificates - Thawte SSL Webserver OV  (Additional Certificate)
-- DBC CodeName: SSL.618.ST08
-- HB Product ID: 618
-- 
UPDATE `hb_products` SET dbcItemId = '9FC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '618';
-- 
-- DBC Item name: SSL Certificates - Thawte SSL Webserver EV  (Additional Certificate)
-- DBC CodeName: SSL.620.ST06
-- HB Product ID: 620
-- 
UPDATE `hb_products` SET dbcItemId = 'A1C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '620';
-- 
-- DBC Item name: SSL Certificates - Entrust Standard SSL (OV)
-- DBC CodeName: SSL.634.SE01
-- HB Product ID: 634
-- 
UPDATE `hb_products` SET dbcItemId = 'A5C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '634';
-- 
-- DBC Item name: SSL Certificates - Entrust Advantage SSL (OV)
-- DBC CodeName: SSL.635.SE06
-- HB Product ID: 635
-- 
UPDATE `hb_products` SET dbcItemId = 'A7C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '635';
-- 
-- DBC Item name: SSL Certificates - Entrust UC Multi-Domain (OV)
-- DBC CodeName: SSL.637.SE05
-- HB Product ID: 637
-- 
UPDATE `hb_products` SET dbcItemId = 'A9C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '637';
-- 
-- DBC Item name: SSL Certificates - Entrust EV Multi-Domain
-- DBC CodeName: SSL.638.SE03
-- HB Product ID: 638
-- 
UPDATE `hb_products` SET dbcItemId = 'ABC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '638';
-- 
-- DBC Item name: SSL Certificates - Entrust EV Multi-Domain (Additional Certificate)
-- DBC CodeName: SSL.639.SE04
-- HB Product ID: 639
-- 
UPDATE `hb_products` SET dbcItemId = 'ADC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '639';
-- 
-- DBC Item name: SSL Certificates - Entrust Wildcard (OV)
-- DBC CodeName: SSL.640.SE02
-- HB Product ID: 640
-- 
UPDATE `hb_products` SET dbcItemId = 'AFC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '640';
-- 
-- DBC Item name: SSL Certificates - Sectigo PositiveSSL Multi-Domain Wildcard
-- DBC CodeName: SSL.864.SC09
-- HB Product ID: 864
-- 
UPDATE `hb_products` SET dbcItemId = '2BC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '864';
-- 
-- DBC Item name: SSL Certificates - GeoTrust DV SSL - QuickSSL Premium Wildcard
-- DBC CodeName: SSL.885.SG04
-- HB Product ID: 885
-- 
UPDATE `hb_products` SET dbcItemId = '41C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '885';
-- 
-- DBC Item name: SSL Certificates - Thawte SSL123 Wildcard DV
-- DBC CodeName: SSL.886.ST03
-- HB Product ID: 886
-- 
UPDATE `hb_products` SET dbcItemId = '43C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '886';
-- 
-- DBC Item name: SSL Certificates - SSL Implementation and Lifecycle Service
-- DBC CodeName: SSL.953.SO06
-- HB Product ID: 953
-- 
UPDATE `hb_products` SET dbcItemId = '77C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '953';
-- 
-- DBC Item name: SSL Certificates - Sectigo PositiveSSL Multi-Domain Wildcard  (Additional Certificate)
-- DBC CodeName: SSL.954.SC10
-- HB Product ID: 954
-- 
UPDATE `hb_products` SET dbcItemId = '79C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '954';
-- 
-- DBC Item name: Software License - PDFelement Professional 6 for Windows
-- DBC CodeName: SWL.1039.SFP5
-- HB Product ID: 1039
-- 
UPDATE `hb_products` SET dbcItemId = 'AFC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1039';
-- 
-- DBC Item name: Software License - MS Visio 2019 Professional (OLP) D87-07499  
-- DBC CodeName: SWL.1092.SFV4
-- HB Product ID: 1092
-- 
UPDATE `hb_products` SET dbcItemId = 'EBC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1092';
-- 
-- DBC Item name: Software License - MS Project 2019 Professional (OLP) 076-05829
-- DBC CodeName: SWL.1112.SPJ3
-- HB Product ID: 1112
-- 
UPDATE `hb_products` SET dbcItemId = 'F3C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1112';
-- 
-- DBC Item name: Software License - Windows Server Standard 2019 (OLP) 9EM-00653
-- DBC CodeName: SWL.1113.SFW9
-- HB Product ID: 1113
-- 
UPDATE `hb_products` SET dbcItemId = 'F5C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1113';
-- 
-- DBC Item name: Software License - Windows Server DvcCAL 2019 (OLP) R18-05767
-- DBC CodeName: SWL.1114.SFW7
-- HB Product ID: 1114
-- 
UPDATE `hb_products` SET dbcItemId = 'F7C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1114';
-- 
-- DBC Item name: Software License - Windows Server UsrCAL 2019 SNGL(OLP) NL R18-05768
-- DBC CodeName: SWL.1115.SFWU
-- HB Product ID: 1115
-- 
UPDATE `hb_products` SET dbcItemId = 'F9C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1115';
-- 
-- DBC Item name: Software License - MS Project 2019 Standard (FPP)
-- DBC CodeName: SWL.1122.SPJ4
-- HB Product ID: 1122
-- 
UPDATE `hb_products` SET dbcItemId = '05C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1122';
-- 
-- DBC Item name: Software License - Plesk Web HOST edition For VPS
-- DBC CodeName: SWL.1128.SFP3
-- HB Product ID: 1128
-- 
UPDATE `hb_products` SET dbcItemId = '0FC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1128';
-- 
-- DBC Item name: Software License - cPanel Pro Cloud For VPS (Up to 30 Accounts) External
-- DBC CodeName: SWL.1135.SFC4
-- HB Product ID: 1135
-- 
UPDATE `hb_products` SET dbcItemId = '17C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1135';
-- 
-- DBC Item name: Software License - cPanel Premier Cloud For VPS (Up to 100 Accounts) External
-- DBC CodeName: SWL.1136.SFC1
-- HB Product ID: 1136
-- 
UPDATE `hb_products` SET dbcItemId = '19C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1136';
-- 
-- DBC Item name: Software License - cPanel Premier Cloud For VPS (Each Account above 100 Accounts) External
-- DBC CodeName: SWL.1137.SFC2
-- HB Product ID: 1137
-- 
UPDATE `hb_products` SET dbcItemId = '1BC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1137';
-- 
-- DBC Item name: Software License - cPanel Admin Cloud For VPS (Up to 5 Accounts) Internal
-- DBC CodeName: SWL.1141.SCI6
-- HB Product ID: 1141
-- 
UPDATE `hb_products` SET dbcItemId = '1DC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1141';
-- 
-- DBC Item name: Software License - cPanel Pro Cloud For VPS (Up to 30 Accounts) Internal
-- DBC CodeName: SWL.1142.SCI4
-- HB Product ID: 1142
-- 
UPDATE `hb_products` SET dbcItemId = '1FC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1142';
-- 
-- DBC Item name: Software License - cPanel Premierr Metal For Dedicated (Up to 100 cPanel accounts) Internal
-- DBC CodeName: SWL.1147.SCI3
-- HB Product ID: 1147
-- 
UPDATE `hb_products` SET dbcItemId = '21C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1147';
-- 
-- DBC Item name: Software License - Kernelcare
-- DBC CodeName: SWL.1152.SFKN
-- HB Product ID: 1152
-- 
UPDATE `hb_products` SET dbcItemId = '25C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1152';
-- 
-- DBC Item name: Software License - Plesk Web Admin Up to 10 Account For VPS
-- DBC CodeName: SWL.1200.SFP1
-- HB Product ID: 1200
-- 
UPDATE `hb_products` SET dbcItemId = '43C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1200';
-- 
-- DBC Item name: Software License - Plesk Web Pro Up to 30 Account For VPS
-- DBC CodeName: SWL.1201.SFP4
-- HB Product ID: 1201
-- 
UPDATE `hb_products` SET dbcItemId = '45C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1201';
-- 
-- DBC Item name: Software License - 7NQ-01564  MS SQL Server Standard Core - SQLSvrStdCore 2019 SNGL OLP 2Lic 
-- DBC CodeName: SWL.1219.SFMQ
-- HB Product ID: 1219
-- 
UPDATE `hb_products` SET dbcItemId = '5BC6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1219';
-- 
-- DBC Item name: Softaculous for Dedicated
-- DBC CodeName: SWL.1255.SFSC
-- HB Product ID: 1255
-- 
UPDATE `hb_products` SET dbcItemId = '0398A69F-B254-EB11-AF23-000D3AC907E2', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1255';
-- 
-- DBC Item name: Antivirus- Kaspersky Endpoint Security Cloud 130 license
-- DBC CodeName: SWL.1257.HWD1
-- HB Product ID: 1257
-- 
UPDATE `hb_products` SET dbcItemId = '79D899EB-9E5B-EB11-AF25-000D3AC907E2', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1257';
-- 
-- DBC Item name: Software License - cPanel Premier Cloud For VPS (Each Account above 100 Accounts) External
-- DBC CodeName: SWL.1278.SFC4
-- HB Product ID: 1278
-- 
UPDATE `hb_products` SET dbcItemId = 'ACD6219F-89AD-EB11-9B52-000D3AC81122', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1278';
-- 
-- DBC Item name: Software License - Kernelcare
-- DBC CodeName: SWL.1472.SFIM
-- HB Product ID: 1472
-- 
UPDATE `hb_products` SET dbcItemId = 'D7F6D311-C103-EC11-86BC-002248559070', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1472';
-- 
-- DBC Item name: Software License - cPanel Premierr Metal For Dedicated (Up to 100 cPanel accounts) External
-- DBC CodeName: SWL.389.SFC3
-- HB Product ID: 389
-- 
UPDATE `hb_products` SET dbcItemId = '4BC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '389';
-- 
-- DBC Item name: Software License - cPanel Admin Cloud For VPS (Up to 5 Accounts) External
-- DBC CodeName: SWL.390.SFC5
-- HB Product ID: 390
-- 
UPDATE `hb_products` SET dbcItemId = '4DC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '390';
-- 
-- DBC Item name: Software License - DirectAdmin Internal License (Lifetime), Unlimited Domains (License Only)
-- DBC CodeName: SWL.462.SDAI
-- HB Product ID: 462
-- 
UPDATE `hb_products` SET dbcItemId = '5FC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '462';
-- 
-- DBC Item name: Software License - cPanel internal license (Developer License)
-- DBC CodeName: SWL.470.SCI2
-- HB Product ID: 470
-- 
UPDATE `hb_products` SET dbcItemId = '61C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '470';
-- 
-- DBC Item name: Software License - cPanel & WHM VPS License, Unlimited Domains (Internal Server)
-- DBC CodeName: SWL.472.SCI5
-- HB Product ID: 472
-- 
UPDATE `hb_products` SET dbcItemId = '63C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '472';
-- 
-- DBC Item name: Software License - DirectAdmin External License (Lifetime), Unlimited Domains (License Only)
-- DBC CodeName: SWL.529.SFDA
-- HB Product ID: 529
-- 
UPDATE `hb_products` SET dbcItemId = '7BC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '529';
-- 
-- DBC Item name: Family
-- DBC CodeName: SWL.664.SFF
-- HB Product ID: 664
-- 
UPDATE `hb_products` SET dbcItemId = 'B1C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '664';
-- 
-- DBC Item name: Software License - Windows 10 Pro 64/32-bit (OLP)
-- DBC CodeName: SWL.746.SFW4
-- HB Product ID: 746
-- 
UPDATE `hb_products` SET dbcItemId = 'D7C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '746';
-- 
-- DBC Item name: Personal
-- DBC CodeName: SWL.749.SFP
-- HB Product ID: 749
-- 
UPDATE `hb_products` SET dbcItemId = 'DBC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '749';
-- 
-- DBC Item name: Software License - Windows 10 Home 64-bit (OEM)
-- DBC CodeName: SWL.770.SFW2
-- HB Product ID: 770
-- 
UPDATE `hb_products` SET dbcItemId = 'EDC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '770';
-- 
-- DBC Item name: Software License - Windows 10 Pro 64-bit (OEM)
-- DBC CodeName: SWL.772.SFW5
-- HB Product ID: 772
-- 
UPDATE `hb_products` SET dbcItemId = 'EFC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '772';
-- 
-- DBC Item name: Software License - Windows 10 Home 64/32-bit (FPP)
-- DBC CodeName: SWL.774.SFW1
-- HB Product ID: 774
-- 
UPDATE `hb_products` SET dbcItemId = 'F1C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '774';
-- 
-- DBC Item name: Software License - Windows 10 Pro 64/32-bit (FPP)
-- DBC CodeName: SWL.775.SFW3
-- HB Product ID: 775
-- 
UPDATE `hb_products` SET dbcItemId = 'F3C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '775';
-- 
-- DBC Item name: Software License - MS Office 2019 Home and Student
-- DBC CodeName: SWL.776.SFHS
-- HB Product ID: 776
-- 
UPDATE `hb_products` SET dbcItemId = 'F5C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '776';
-- 
-- DBC Item name: Software License - MS Office 2019 Home and Business
-- DBC CodeName: SWL.777.SFHB
-- HB Product ID: 777
-- 
UPDATE `hb_products` SET dbcItemId = 'F7C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '777';
-- 
-- DBC Item name: Software License - MS Office 2019 Mac Home and Student
-- DBC CodeName: SWL.778.SFMS
-- HB Product ID: 778
-- 
UPDATE `hb_products` SET dbcItemId = 'F9C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '778';
-- 
-- DBC Item name: Software License - MS Office 2019 Standard (OLP)
-- DBC CodeName: SWL.780.SFSD
-- HB Product ID: 780
-- 
UPDATE `hb_products` SET dbcItemId = 'FBC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '780';
-- 
-- DBC Item name: Software License - MS Office 2019 Professional Plus (OLP)
-- DBC CodeName: SWL.781.SFPP
-- HB Product ID: 781
-- 
UPDATE `hb_products` SET dbcItemId = 'FDC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '781';
-- 
-- DBC Item name: Software License - MS Project 2019 Professional (FPP)
-- DBC CodeName: SWL.784.SPJ2
-- HB Product ID: 784
-- 
UPDATE `hb_products` SET dbcItemId = 'FFC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '784';
-- 
-- DBC Item name: Software License - MS Visio 2019 Standard (FPP)
-- DBC CodeName: SWL.785.SFV5
-- HB Product ID: 785
-- 
UPDATE `hb_products` SET dbcItemId = '01C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '785';
-- 
-- DBC Item name: Software License - MS Visio 2019 Professional (FPP)
-- DBC CodeName: SWL.786.SFV3
-- HB Product ID: 786
-- 
UPDATE `hb_products` SET dbcItemId = '03C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '786';
-- 
-- DBC Item name: Software License - Windows Server Essentials (FPP)
-- DBC CodeName: SWL.792.SFW8
-- HB Product ID: 792
-- 
UPDATE `hb_products` SET dbcItemId = '05C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '792';
-- 
-- DBC Item name: Software License - Windows Server UsrCAL (OLP)
-- DBC CodeName: SWL.800.SFU2
-- HB Product ID: 800
-- 
UPDATE `hb_products` SET dbcItemId = '07C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '800';
-- 
-- DBC Item name: Software License - MS Exchange Standard Edition 2019 SNGL (OLP) 312-04405
-- DBC CodeName: SWL.806.SFD3
-- HB Product ID: 806
-- 
UPDATE `hb_products` SET dbcItemId = '09C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '806';
-- 
-- DBC Item name: Software License - MS Exchange Standard 2019 DvcCAL (OLP) 381-04491 
-- DBC CodeName: SWL.809.SFD2
-- HB Product ID: 809
-- 
UPDATE `hb_products` SET dbcItemId = '0BC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '809';
-- 
-- DBC Item name: Software License - MS Exchange Enterprise DvcCAL
-- DBC CodeName: SWL.812.SFD1
-- HB Product ID: 812
-- 
UPDATE `hb_products` SET dbcItemId = '0DC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '812';
-- 
-- DBC Item name: Softaculous for VPS
-- DBC CodeName: SWL.826.SFSL
-- HB Product ID: 826
-- 
UPDATE `hb_products` SET dbcItemId = '0FC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '826';
-- 
-- DBC Item name: Software License - CloudLinux(cPanel Server)
-- DBC CodeName: SWL.827.SFC6
-- HB Product ID: 827
-- 
UPDATE `hb_products` SET dbcItemId = '11C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '827';
-- 
-- DBC Item name: Software License - Kaspersky Anti-Virus (1 PC)
-- DBC CodeName: SWL.835.SFK1
-- HB Product ID: 835
-- 
UPDATE `hb_products` SET dbcItemId = '15C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '835';
-- 
-- DBC Item name: Software License - Kaspersky Anti-Virus (3 PC)
-- DBC CodeName: SWL.836.SFK2
-- HB Product ID: 836
-- 
UPDATE `hb_products` SET dbcItemId = '17C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '836';
-- 
-- DBC Item name: Software License - Kaspersky Internet Security (1 PC)
-- DBC CodeName: SWL.839.SFK4
-- HB Product ID: 839
-- 
UPDATE `hb_products` SET dbcItemId = '19C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '839';
-- 
-- DBC Item name: Software License - Kaspersky Internet Security (3 PC)
-- DBC CodeName: SWL.840.SFK5
-- HB Product ID: 840
-- 
UPDATE `hb_products` SET dbcItemId = '1BC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '840';
-- 
-- DBC Item name: Software License - Kaspersky Internet Security (Renewal 3 PC)
-- DBC CodeName: SWL.842.SFK6
-- HB Product ID: 842
-- 
UPDATE `hb_products` SET dbcItemId = '1DC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '842';
-- 
-- DBC Item name: Software License - Visual Studio Professional with MSDN - SA (77D-00095)
-- DBC CodeName: SWL.862.SFVS
-- HB Product ID: 862
-- 
UPDATE `hb_products` SET dbcItemId = '29C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '862';
-- 
-- DBC Item name: Software License - Plesk Web HOST edition For Dedicated Server
-- DBC CodeName: SWL.866.SFP2
-- HB Product ID: 866
-- 
UPDATE `hb_products` SET dbcItemId = '2DC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '866';
-- 
-- DBC Item name: Software License - Kaspersky Anti-Virus End Point Security (Windows)
-- DBC CodeName: SWL.867.SFK3
-- HB Product ID: 867
-- 
UPDATE `hb_products` SET dbcItemId = '2FC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '07BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '867';
-- 
-- DBC Item name: Software License - Windows Server Standard, SPLA (2processor)
-- DBC CodeName: SWL.868.SFU1
-- HB Product ID: 868
-- 
UPDATE `hb_products` SET dbcItemId = '31C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '868';
-- 
-- DBC Item name: Software License - MS SQL Server CAL - L+SA (EDU)
-- DBC CodeName: SWL.911.SFQ5
-- HB Product ID: 911
-- 
UPDATE `hb_products` SET dbcItemId = '57C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '911';
-- 
-- DBC Item name: Software License - VMware vSphere 6 Essentials Kit for 3 hosts (Max 2 processors per host)
-- DBC CodeName: SWL.921.SFVM
-- HB Product ID: 921
-- 
UPDATE `hb_products` SET dbcItemId = '5BC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '921';
-- 
-- DBC Item name: Software License - MS SQL Server Standard (SPLA)
-- DBC CodeName: SWL.937.SFQ6
-- HB Product ID: 937
-- 
UPDATE `hb_products` SET dbcItemId = '67C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '937';
-- 
-- DBC Item name: Software License - 7NQ-01158#99543  SQLSvrStdCore 2017 SNGL OLP 2Lic NL CoreLic Qlfd
-- DBC CodeName: SWL.956.SFQ4
-- HB Product ID: 956
-- 
UPDATE `hb_products` SET dbcItemId = '7DC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '956';
-- 
-- DBC Item name: Software License - 228-09538 MicrosoftSQLServerStandardEdition AllLng License
-- DBC CodeName: SWL.968.SFQ1
-- HB Product ID: 968
-- 
UPDATE `hb_products` SET dbcItemId = '85C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '968';
-- 
-- DBC Item name: Software License - 359-05416 MicrosoftSQLCAL AllLng License
-- DBC CodeName: SWL.969.SFA2
-- HB Product ID: 969
-- 
UPDATE `hb_products` SET dbcItemId = '87C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '969';
-- 
-- DBC Item name: Software License - 9EM-00294 MicrosoftWindowsServerSTDCORE AllLng License
-- DBC CodeName: SWL.970.SFA3
-- HB Product ID: 970
-- 
UPDATE `hb_products` SET dbcItemId = '89C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '970';
-- 
-- DBC Item name: Software License - R18-03499 MicrosoftWindowsServerCAL AllLng License
-- DBC CodeName: SWL.971.SFA5
-- HB Product ID: 971
-- 
UPDATE `hb_products` SET dbcItemId = '8BC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '971';
-- 
-- DBC Item name: Software License - 2FJ-00005 MicrosoftOfficeProPlusEducation AllLng License
-- DBC CodeName: SWL.972.SFA1
-- HB Product ID: 972
-- 
UPDATE `hb_products` SET dbcItemId = '8DC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '972';
-- 
-- DBC Item name: Software License - KW5-00359 MicrosoftWINEDUE3 AllLng
-- DBC CodeName: SWL.974.SFA4
-- HB Product ID: 974
-- 
UPDATE `hb_products` SET dbcItemId = '8FC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '974';
-- 
-- DBC Item name: Software License - Visual Studio Subscription (Professional) 
-- DBC CodeName: SWL.976.VSSS
-- HB Product ID: 976
-- 
UPDATE `hb_products` SET dbcItemId = '93C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '976';
-- 
-- DBC Item name: Virtual Private Cloud - Essential
-- DBC CodeName: VP.1214.VPC1
-- HB Product ID: 1214
-- 
UPDATE `hb_products` SET dbcItemId = '51C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1214';
-- 
-- DBC Item name: Virtual Private Cloud - Business
-- DBC CodeName: VP.1215.VPC2
-- HB Product ID: 1215
-- 
UPDATE `hb_products` SET dbcItemId = '53C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1215';
-- 
-- DBC Item name: Virtual Private Cloud - Enterprise
-- DBC CodeName: VP.1216.VPC3
-- HB Product ID: 1216
-- 
UPDATE `hb_products` SET dbcItemId = '55C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1216';
-- 
-- DBC Item name: Windows Dedicated Server - Dedicated Value Server
-- DBC CodeName: WD.1054.WDED
-- HB Product ID: 1054
-- 
UPDATE `hb_products` SET dbcItemId = 'B9C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1054';
-- 
-- DBC Item name: Windows Hosting - Compact Plan WN
-- DBC CodeName: WH.301.WCWN
-- HB Product ID: 301
-- 
UPDATE `hb_products` SET dbcItemId = '1BC4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '301';
-- 
-- DBC Item name: Windows Hosting - Standard Plan WN
-- DBC CodeName: WH.305.WSWN
-- HB Product ID: 305
-- 
UPDATE `hb_products` SET dbcItemId = '21C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '305';
-- 
-- DBC Item name: Windows Hosting - Reseller Plan RE-WIN2
-- DBC CodeName: WH.309.WRWI
-- HB Product ID: 309
-- 
UPDATE `hb_products` SET dbcItemId = '23C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '17BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '309';
-- 
-- DBC Item name: Windows Hosting - Tiny Plan
-- DBC CodeName: WH.310.WTIN
-- HB Product ID: 310
-- 
UPDATE `hb_products` SET dbcItemId = '25C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '310';
-- 
-- DBC Item name: Windows Hosting - Combo Plan
-- DBC CodeName: WH.312.WCOB
-- HB Product ID: 312
-- 
UPDATE `hb_products` SET dbcItemId = '27C4C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '312';
-- 
-- DBC Item name: Windows Hosting - Advance Plan
-- DBC CodeName: WH.62.WADV
-- HB Product ID: 62
-- 
UPDATE `hb_products` SET dbcItemId = 'AFC3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '62';
-- 
-- DBC Item name: Windows Hosting - Small Plan
-- DBC CodeName: WH.63.WSM
-- HB Product ID: 63
-- 
UPDATE `hb_products` SET dbcItemId = 'B1C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '63';
-- 
-- DBC Item name: Windows Hosting - Maximum Plan
-- DBC CodeName: WH.68.WMXM
-- HB Product ID: 68
-- 
UPDATE `hb_products` SET dbcItemId = 'B3C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '68';
-- 
-- DBC Item name: Windows Hosting - Business Plan
-- DBC CodeName: WH.69.WBSI
-- HB Product ID: 69
-- 
UPDATE `hb_products` SET dbcItemId = 'B5C3C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '69';
-- 
-- DBC Item name: Flexible
-- DBC CodeName: WVM.993.WVMW
-- HB Product ID: 993
-- 
UPDATE `hb_products` SET dbcItemId = '9DC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '993';
-- 
-- DBC Item name: Flexible
-- DBC CodeName: WVPS.988.WVPS
-- HB Product ID: 988
-- 
UPDATE `hb_products` SET dbcItemId = '9BC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '11BDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '988';
-- 
-- DBC Item name: Zendesk - Explore - Lite Plan
-- DBC CodeName: ZEN.1120.ZE01
-- HB Product ID: 1120
-- 
UPDATE `hb_products` SET dbcItemId = '01C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1120';
-- 
-- DBC Item name: Zendesk - Collaboration Addons
-- DBC CodeName: ZEN.1121.ZCB2
-- HB Product ID: 1121
-- 
UPDATE `hb_products` SET dbcItemId = '03C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1121';
-- 
-- DBC Item name: Zendesk - Approval Apps for Zendesk
-- DBC CodeName: ZEN.1130.ZAAP
-- HB Product ID: 1130
-- 
UPDATE `hb_products` SET dbcItemId = '11C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1130';
-- 
-- DBC Item name: Zendesk - Lovely View Plus for Zendesk
-- DBC CodeName: ZEN.1131.ZLVP
-- HB Product ID: 1131
-- 
UPDATE `hb_products` SET dbcItemId = '13C6C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '1131';
-- 
-- DBC Item name: Zendesk - System Integration for Zendesk
-- DBC CodeName: ZEN.925.ZSYS
-- HB Product ID: 925
-- 
UPDATE `hb_products` SET dbcItemId = '61C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '925';
-- 
-- DBC Item name: Zendesk - Premium Service (1 Year)
-- DBC CodeName: ZEN.928.ZPMS
-- HB Product ID: 928
-- 
UPDATE `hb_products` SET dbcItemId = '63C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '928';
-- 
-- DBC Item name: Zendesk - Support - Professional Plan
-- DBC CodeName: ZEN.940.ZS03
-- HB Product ID: 940
-- 
UPDATE `hb_products` SET dbcItemId = '69C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '940';
-- 
-- DBC Item name: Zendesk - Support - Enterprise Plan
-- DBC CodeName: ZEN.941.ZS04
-- HB Product ID: 941
-- 
UPDATE `hb_products` SET dbcItemId = '6BC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '941';
-- 
-- DBC Item name: Zendesk - Guide - Professional Plan
-- DBC CodeName: ZEN.943.ZG01
-- HB Product ID: 943
-- 
UPDATE `hb_products` SET dbcItemId = '6DC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '943';
-- 
-- DBC Item name: Zendesk - Guide - Lite Plan
-- DBC CodeName: ZEN.944.ZG02
-- HB Product ID: 944
-- 
UPDATE `hb_products` SET dbcItemId = '6FC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '944';
-- 
-- DBC Item name: Zendesk - Chat - Lite Plan
-- DBC CodeName: ZEN.945.ZC01
-- HB Product ID: 945
-- 
UPDATE `hb_products` SET dbcItemId = '71C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '945';
-- 
-- DBC Item name: Zendesk - Chat - Professional Plan
-- DBC CodeName: ZEN.947.ZC03
-- HB Product ID: 947
-- 
UPDATE `hb_products` SET dbcItemId = '73C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '947';
-- 
-- DBC Item name: Zendesk - Chat - Enterprise Plan
-- DBC CodeName: ZEN.948.ZC04
-- HB Product ID: 948
-- 
UPDATE `hb_products` SET dbcItemId = '75C5C59A-4B47-EB11-BF6C-000D3AC8F2C9', baseUnitOfMeasureId = '1FBDA36F-B541-EA11-A812-000D3AA2F4CE' WHERE id = '948';

--
-- dbc_webhooks
--

REPLACE INTO `dbc_webhooks` (`id`, `name`, `method`, `url`) VALUES ('1', 'Create/Update Category', 'POST', '');
REPLACE INTO `dbc_webhooks` (`id`, `name`, `method`, `url`) VALUES ('2', 'Create/Update Product', 'POST', '');
--
-- REPLACE INTO `dbc_webhooks` (`id`, `name`, `method`, `url`) VALUES ('2', 'Update Product Category', 'PUT', '');
-- REPLACE INTO `dbc_webhooks` (`id`, `name`, `method`, `url`) VALUES ('3', 'Delete Product Category', 'DELETE', '');
-- REPLACE INTO `dbc_webhooks` (`id`, `name`, `method`, `url`) VALUES ('4', 'Create Product', 'POST', '');
-- REPLACE INTO `dbc_webhooks` (`id`, `name`, `method`, `url`) VALUES ('5', 'Update Product', 'PUT', '');
-- REPLACE INTO `dbc_webhooks` (`id`, `name`, `method`, `url`) VALUES ('6', 'Delete Product', 'DELETE', '');
