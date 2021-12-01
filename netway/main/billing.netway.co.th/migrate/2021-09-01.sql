
ALTER TABLE `hb_products` ADD `dimensionCodeBUId` VARCHAR(36) NOT NULL AFTER `codeName`;


CREATE TABLE IF NOT EXISTS `dbc_dimension` (
  `id` varchar(36) NOT NULL,
  `code` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `dbc_dimension`
  ADD PRIMARY KEY (`id`);

REPLACE INTO `dbc_dimension` (`id`, `code`, `name`) VALUES ('ECD9CC09-B741-EA11-A812-000D3AA2F4CE', 'AMORTIZED-INCOMES', 'Amortized Incomes');
REPLACE INTO `dbc_dimension` (`id`, `code`, `name`) VALUES ('EED9CC09-B741-EA11-A812-000D3AA2F4CE', 'BU', 'Business Unit');
REPLACE INTO `dbc_dimension` (`id`, `code`, `name`) VALUES ('F0D9CC09-B741-EA11-A812-000D3AA2F4CE', 'DEPARTMENT', 'Department');
REPLACE INTO `dbc_dimension` (`id`, `code`, `name`) VALUES ('F2D9CC09-B741-EA11-A812-000D3AA2F4CE', 'MARKETING CHANNEL', 'Marketing Channel');
REPLACE INTO `dbc_dimension` (`id`, `code`, `name`) VALUES ('F4D9CC09-B741-EA11-A812-000D3AA2F4CE', 'NEW-RENEW', 'Invoice New and Invoice Renew');
REPLACE INTO `dbc_dimension` (`id`, `code`, `name`) VALUES ('F6D9CC09-B741-EA11-A812-000D3AA2F4CE', 'PL-PERIOD', 'Period Time');
REPLACE INTO `dbc_dimension` (`id`, `code`, `name`) VALUES ('F8D9CC09-B741-EA11-A812-000D3AA2F4CE', 'PROJECT', 'Project');
REPLACE INTO `dbc_dimension` (`id`, `code`, `name`) VALUES ('FAD9CC09-B741-EA11-A812-000D3AA2F4CE', 'SALESPERSON', 'Sales Person');


-- 
-- DBC Item Code: AWS.965.AWS1
-- HB Product ID: 965
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'EB9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '965';
-- 
-- DBC Item Code: AWS.966.AWS2
-- HB Product ID: 966
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'ED9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '966';
-- 
-- DBC Item Code: AWS.967.AWS3
-- HB Product ID: 967
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'EF9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '967';
-- 
-- DBC Item Code: AZ.923.TOKE
-- HB Product ID: 923
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'F59BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '923';
-- 
-- DBC Item Code: AZU.1062.AZ01
-- HB Product ID: 1062
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'F79BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1062';
-- 
-- DBC Item Code: AZU.1063.AZ02
-- HB Product ID: 1063
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'F99BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1063';
-- 
-- DBC Item Code: AZU.1064.AZ03
-- HB Product ID: 1064
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'FB9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1064';
-- 
-- DBC Item Code: AZU.1065.AZ04
-- HB Product ID: 1065
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'FD9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1065';
-- 
-- DBC Item Code: AZU.1066.AZ05
-- HB Product ID: 1066
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'FF9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1066';
-- 
-- DBC Item Code: AZU.1067.AZ06
-- HB Product ID: 1067
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '019CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1067';
-- 
-- DBC Item Code: AZU.1068.AZ07
-- HB Product ID: 1068
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '039CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1068';
-- 
-- DBC Item Code: AZU.1069.AZ08
-- HB Product ID: 1069
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '059CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1069';
-- 
-- DBC Item Code: AZU.1070.AZ09
-- HB Product ID: 1070
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '079CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1070';
-- 
-- DBC Item Code: AZU.1071.AZ10
-- HB Product ID: 1071
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '099CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1071';
-- 
-- DBC Item Code: AZU.1072.AZ11
-- HB Product ID: 1072
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '0B9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1072';
-- 
-- DBC Item Code: AZU.1073.AZ12
-- HB Product ID: 1073
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '0D9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1073';
-- 
-- DBC Item Code: AZU.1074.AZ13
-- HB Product ID: 1074
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '0F9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1074';
-- 
-- DBC Item Code: AZU.1075.AZ14
-- HB Product ID: 1075
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '119CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1075';
-- 
-- DBC Item Code: AZU.1076.AZ15
-- HB Product ID: 1076
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '139CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1076';
-- 
-- DBC Item Code: AZU.1077.AZ16
-- HB Product ID: 1077
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '159CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1077';
-- 
-- DBC Item Code: AZU.1078.AZ17
-- HB Product ID: 1078
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '179CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1078';
-- 
-- DBC Item Code: AZU.1094.AZ18
-- HB Product ID: 1094
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '199CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1094';
-- 
-- DBC Item Code: CFSH.1245.CF1
-- HB Product ID: 1245
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '8F9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1245';
-- 
-- DBC Item Code: CFSH.1246.CF2
-- HB Product ID: 1246
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '919BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1246';
-- 
-- DBC Item Code: CFSH.1247.CF3
-- HB Product ID: 1247
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '939BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1247';
-- 
-- DBC Item Code: CFSH.1248.CF4
-- HB Product ID: 1248
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '959BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1248';
-- 
-- DBC Item Code: CHU.1028.CHU1
-- HB Product ID: 1028
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'ED9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1028';
-- 
-- DBC Item Code: CHU.1029.CHU2
-- HB Product ID: 1029
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'EF9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1029';
-- 
-- DBC Item Code: COL.189.CORI
-- HB Product ID: 189
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C39BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '189';
-- 
-- DBC Item Code: COL.668.CO2R
-- HB Product ID: 668
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C59BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '668';
-- 
-- DBC Item Code: COL.669.CO1U
-- HB Product ID: 669
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C79BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '669';
-- 
-- DBC Item Code: COL.71.CO2U
-- HB Product ID: 71
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C99BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '71';
-- 
-- DBC Item Code: COL.90.COLT
-- HB Product ID: 90
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'CB9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '90';
-- 
-- DBC Item Code: CVPS.1269.CVPS
-- HB Product ID: 1269
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'D39BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1269';
-- 
-- DBC Item Code: DOM.1.COM
-- HB Product ID: 1
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '9B9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1';
-- 
-- DBC Item Code: DOM.10.ASIA
-- HB Product ID: 10
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A79CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '10';
-- 
-- DBC Item Code: DOM.1032.APP
-- HB Product ID: 1032
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '099DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1032';
-- 
-- DBC Item Code: DOM.1053.IO
-- HB Product ID: 1053
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '0B9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1053';
-- 
-- DBC Item Code: DOM.11.UK
-- HB Product ID: 11
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A99CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '11';
-- 
-- DBC Item Code: DOM.1198.TECH
-- HB Product ID: 1198
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '0D9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1198';
-- 
-- DBC Item Code: DOM.12.COTH
-- HB Product ID: 12
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'AB9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '12';
-- 
-- DBC Item Code: DOM.13.INTH
-- HB Product ID: 13
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'AD9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '13';
-- 
-- DBC Item Code: DOM.14.ACTH
-- HB Product ID: 14
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'AF9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '14';
-- 
-- DBC Item Code: DOM.1462.CITY
-- HB Product ID: 1462
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'B99CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1462';
-- 
-- DBC Item Code: DOM.1471.DEV
-- HB Product ID: 1471
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '099DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1471';
-- 
-- DBC Item Code: DOM.15.GOTH
-- HB Product ID: 15
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'B19CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '15';
-- 
-- DBC Item Code: DOM.16.ORTH
-- HB Product ID: 16
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'B39CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '16';
-- 
-- DBC Item Code: DOM.19.CC
-- HB Product ID: 19
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'B59CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '19';
-- 
-- DBC Item Code: DOM.2.NET
-- HB Product ID: 2
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '9D9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '2';
-- 
-- DBC Item Code: DOM.20.TV
-- HB Product ID: 20
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'B79CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '20';
-- 
-- DBC Item Code: DOM.285.COCN
-- HB Product ID: 285
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'B99CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '285';
-- 
-- DBC Item Code: DOM.289.COCO
-- HB Product ID: 289
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'BB9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '289';
-- 
-- DBC Item Code: DOM.3.ORG
-- HB Product ID: 3
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '9F9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '3';
-- 
-- DBC Item Code: DOM.337.NECN
-- HB Product ID: 337
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'BD9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '337';
-- 
-- DBC Item Code: DOM.338.ORCN
-- HB Product ID: 338
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'BF9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '338';
-- 
-- DBC Item Code: DOM.340.CNCO
-- HB Product ID: 340
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C19CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '340';
-- 
-- DBC Item Code: DOM.341.JP
-- HB Product ID: 341
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C39CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '341';
-- 
-- DBC Item Code: DOM.343.COVN
-- HB Product ID: 343
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C59CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '343';
-- 
-- DBC Item Code: DOM.347.PH
-- HB Product ID: 347
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C79CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '347';
-- 
-- DBC Item Code: DOM.351.COAU
-- HB Product ID: 351
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C99CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '351';
-- 
-- DBC Item Code: DOM.352.NETA
-- HB Product ID: 352
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'CB9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '352';
-- 
-- DBC Item Code: DOM.358.CO
-- HB Product ID: 358
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'CD9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '358';
-- 
-- DBC Item Code: DOM.386.COTW
-- HB Product ID: 386
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'CF9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '386';
-- 
-- DBC Item Code: DOM.4.BIZ
-- HB Product ID: 4
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A19CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '4';
-- 
-- DBC Item Code: DOM.415.IN
-- HB Product ID: 415
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'D19CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '415';
-- 
-- DBC Item Code: DOM.427.CN
-- HB Product ID: 427
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'D39CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '427';
-- 
-- DBC Item Code: DOM.433.COID
-- HB Product ID: 433
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'D59CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '433';
-- 
-- DBC Item Code: DOM.435.COPH
-- HB Product ID: 435
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'D79CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '435';
-- 
-- DBC Item Code: DOM.441.HK
-- HB Product ID: 441
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'D99CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '441';
-- 
-- DBC Item Code: DOM.486.TENO
-- HB Product ID: 486
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'DB9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '486';
-- 
-- DBC Item Code: DOM.487.VENT
-- HB Product ID: 487
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'DD9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '487';
-- 
-- DBC Item Code: DOM.493.LIGH
-- HB Product ID: 493
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'DF9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '493';
-- 
-- DBC Item Code: DOM.495.GALL
-- HB Product ID: 495
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'E19CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '495';
-- 
-- DBC Item Code: DOM.498.TODA
-- HB Product ID: 498
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'E39CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '498';
-- 
-- DBC Item Code: DOM.5.INFO
-- HB Product ID: 5
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A39CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '5';
-- 
-- DBC Item Code: DOM.501.GURU
-- HB Product ID: 501
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'E59CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '501';
-- 
-- DBC Item Code: DOM.502.CLOT
-- HB Product ID: 502
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'E79CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '502';
-- 
-- DBC Item Code: DOM.514.COMP
-- HB Product ID: 514
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'E99CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '514';
-- 
-- DBC Item Code: DOM.524.CLUB
-- HB Product ID: 524
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'EB9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '524';
-- 
-- DBC Item Code: DOM.534.LA
-- HB Product ID: 534
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'ED9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '534';
-- 
-- DBC Item Code: DOM.576.COHK
-- HB Product ID: 576
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'EF9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '576';
-- 
-- DBC Item Code: DOM.8.US
-- HB Product ID: 8
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A59CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '8';
-- 
-- DBC Item Code: DOM.834.CLOD
-- HB Product ID: 834
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'F19CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '834';
-- 
-- DBC Item Code: DOM.852.DOMA
-- HB Product ID: 852
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'F39CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '852';
-- 
-- DBC Item Code: DOM.853.HOST
-- HB Product ID: 853
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'F59CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '853';
-- 
-- DBC Item Code: DOM.854.SOFT
-- HB Product ID: 854
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'F79CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '854';
-- 
-- DBC Item Code: DOM.858.WEBS
-- HB Product ID: 858
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'F99CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '858';
-- 
-- DBC Item Code: DOM.859.SITE
-- HB Product ID: 859
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'FB9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '859';
-- 
-- DBC Item Code: DOM.889.LIFE
-- HB Product ID: 889
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'FD9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '889';
-- 
-- DBC Item Code: DOM.891.PRO
-- HB Product ID: 891
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'FF9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '891';
-- 
-- DBC Item Code: DOM.892.GROP
-- HB Product ID: 892
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '019DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '892';
-- 
-- DBC Item Code: DOM.893.WORK
-- HB Product ID: 893
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '039DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '893';
-- 
-- DBC Item Code: DOM.894.SHOP
-- HB Product ID: 894
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '059DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '894';
-- 
-- DBC Item Code: DOM.895.WORS
-- HB Product ID: 895
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '079DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '895';
-- 
-- DBC Item Code: DVPS.1282.DVPS
-- HB Product ID: 1282
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'D39BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1282';
-- 
-- DBC Item Code: DYNA.1125.DYN3
-- HB Product ID: 1125
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'F59DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1125';
-- 
-- DBC Item Code: DYNA.1132.D365
-- HB Product ID: 1132
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '8D9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1132';
-- 
-- DBC Item Code: EM.1116.MCP3
-- HB Product ID: 1116
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C79DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1116';
-- 
-- DBC Item Code: EM.1123.MCP4
-- HB Product ID: 1123
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C99DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1123';
-- 
-- DBC Item Code: EM.875.CEM
-- HB Product ID: 875
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C19DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '875';
-- 
-- DBC Item Code: EM.998.MCP2
-- HB Product ID: 998
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C39DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '998';
-- 
-- DBC Item Code: EM.999.MCP1
-- HB Product ID: 999
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C59DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '999';
-- 
-- DBC Item Code: FLH.1153.FS01
-- HB Product ID: 1153
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '7B9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1153';
-- 
-- DBC Item Code: FLH.1154.FS02
-- HB Product ID: 1154
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '7D9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1154';
-- 
-- DBC Item Code: FLH.1155.FS03
-- HB Product ID: 1155
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '7F9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1155';
-- 
-- DBC Item Code: FLH.1157.FS04
-- HB Product ID: 1157
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '819BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1157';
-- 
-- DBC Item Code: FLH.1158.FS05
-- HB Product ID: 1158
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '839BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1158';
-- 
-- DBC Item Code: GSU.1195.GSU2
-- HB Product ID: 1195
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '3D9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1195';
-- 
-- DBC Item Code: GSU.1223.GSU7
-- HB Product ID: 1223
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '3F9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1223';
-- 
-- DBC Item Code: GSU.1249.GSW1
-- HB Product ID: 1249
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C85E9D6F-EC4F-EB11-AF23-000D3AC907E2' WHERE `id` = '1249';
-- 
-- DBC Item Code: GSU.1250.GSW2
-- HB Product ID: 1250
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C85E9D6F-EC4F-EB11-AF23-000D3AC907E2' WHERE `id` = '1250';
-- 
-- DBC Item Code: GSU.1251.GSW3
-- HB Product ID: 1251
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C85E9D6F-EC4F-EB11-AF23-000D3AC907E2' WHERE `id` = '1251';
-- 
-- DBC Item Code: GSU.1252.GSW4
-- HB Product ID: 1252
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C85E9D6F-EC4F-EB11-AF23-000D3AC907E2' WHERE `id` = '1252';
-- 
-- DBC Item Code: GSU.1253.GSW5
-- HB Product ID: 1253
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C85E9D6F-EC4F-EB11-AF23-000D3AC907E2' WHERE `id` = '1253';
-- 
-- DBC Item Code: GSU.1254.GSW6
-- HB Product ID: 1254
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C85E9D6F-EC4F-EB11-AF23-000D3AC907E2' WHERE `id` = '1254';
-- 
-- DBC Item Code: GSU.152.GSU1
-- HB Product ID: 152
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '2D9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '152';
-- 
-- DBC Item Code: GSU.624.GSA2
-- HB Product ID: 624
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '2F9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '624';
-- 
-- DBC Item Code: GSU.688.GSU4
-- HB Product ID: 688
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '319CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '688';
-- 
-- DBC Item Code: GSU.730.GSA1
-- HB Product ID: 730
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '339CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '730';
-- 
-- DBC Item Code: GSU.748.GOOV
-- HB Product ID: 748
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '359CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '748';
-- 
-- DBC Item Code: GSU.754.GSU3
-- HB Product ID: 754
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '379CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '754';
-- 
-- DBC Item Code: GSU.755.GSU6
-- HB Product ID: 755
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '399CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '755';
-- 
-- DBC Item Code: GSU.869.GSA
-- HB Product ID: 869
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '3B9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '869';
-- 
-- DBC Item Code: IDN.1189.IDN1
-- HB Product ID: 1189
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '139DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1189';
-- 
-- DBC Item Code: IDN.1192.IDN2
-- HB Product ID: 1192
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '159DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1192';
-- 
-- DBC Item Code: LD.1217.DED6
-- HB Product ID: 1217
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'B59BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1217';
-- 
-- DBC Item Code: LD.149.DED2
-- HB Product ID: 149
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'AD9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '149';
-- 
-- DBC Item Code: LD.369.DED4
-- HB Product ID: 369
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'AF9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '369';
-- 
-- DBC Item Code: LD.674.DED1
-- HB Product ID: 674
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'B19BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '674';
-- 
-- DBC Item Code: LD.676.DED5
-- HB Product ID: 676
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'B39BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '676';
-- 
-- DBC Item Code: LH.1034.EECO
-- HB Product ID: 1034
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '5F9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1034';
-- 
-- DBC Item Code: LH.22.ECO
-- HB Product ID: 22
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '3B9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '22';
-- 
-- DBC Item Code: LH.23.STAD
-- HB Product ID: 23
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '3D9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '23';
-- 
-- DBC Item Code: LH.24.PREM
-- HB Product ID: 24
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '3F9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '24';
-- 
-- DBC Item Code: LH.25.ECOM
-- HB Product ID: 25
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '419BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '25';
-- 
-- DBC Item Code: LH.283.IP
-- HB Product ID: 283
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '499BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '283';
-- 
-- DBC Item Code: LH.295.EXT1
-- HB Product ID: 295
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '4B9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '295';
-- 
-- DBC Item Code: LH.296.EXT2
-- HB Product ID: 296
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '4D9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '296';
-- 
-- DBC Item Code: LH.297.CPWN
-- HB Product ID: 297
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '4F9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '297';
-- 
-- DBC Item Code: LH.298.STWN
-- HB Product ID: 298
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '519BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '298';
-- 
-- DBC Item Code: LH.299.EXWN
-- HB Product ID: 299
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '539BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '299';
-- 
-- DBC Item Code: LH.302.EMIN
-- HB Product ID: 302
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '559BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '302';
-- 
-- DBC Item Code: LH.304.EEWN
-- HB Product ID: 304
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '579BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '304';
-- 
-- DBC Item Code: LH.313.COWN
-- HB Product ID: 313
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '599BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '313';
-- 
-- DBC Item Code: LH.316.RS15
-- HB Product ID: 316
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '5B9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '316';
-- 
-- DBC Item Code: LH.59.CORP
-- HB Product ID: 59
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '439BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '59';
-- 
-- DBC Item Code: LH.60.ULTI
-- HB Product ID: 60
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '459BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '60';
-- 
-- DBC Item Code: LH.61.ENTP
-- HB Product ID: 61
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '479BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '61';
-- 
-- DBC Item Code: LH.751.HNC1
-- HB Product ID: 751
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '5D9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '751';
-- 
-- DBC Item Code: LOBA.1086.LBB1
-- HB Product ID: 1086
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'FB9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1086';
-- 
-- DBC Item Code: LOBA.1087.LBB2
-- HB Product ID: 1087
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'FD9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1087';
-- 
-- DBC Item Code: LOBA.1088.LBB3
-- HB Product ID: 1088
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'FF9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1088';
-- 
-- DBC Item Code: LOVM.1089.LBV1
-- HB Product ID: 1089
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '059EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1089';
-- 
-- DBC Item Code: LOVM.1090.LBV2
-- HB Product ID: 1090
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '079EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1090';
-- 
-- DBC Item Code: LOVM.1091.LBV3
-- HB Product ID: 1091
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '099EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1091';
-- 
-- DBC Item Code: LVM.883.24753
-- HB Product ID: 883
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'DF9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '883';
-- 
-- DBC Item Code: LVM.883.LVMW
-- HB Product ID: 883
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'DF9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '883';
-- 
-- DBC Item Code: LVPS.882.LVPS
-- HB Product ID: 882
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'D39BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '882';
-- 
-- DBC Item Code: M365.1051.M3E2
-- HB Product ID: 1051
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '7B9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1051';
-- 
-- DBC Item Code: M365.1085.M3ET
-- HB Product ID: 1085
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '7D9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1085';
-- 
-- DBC Item Code: M365.1093.PWB2
-- HB Product ID: 1093
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '7F9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1093';
-- 
-- DBC Item Code: M365.1124.PWB3
-- HB Product ID: 1124
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '819CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1124';
-- 
-- DBC Item Code: M365.1194.ODP2
-- HB Product ID: 1194
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '859CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1194';
-- 
-- DBC Item Code: M365.1213.M3BV
-- HB Product ID: 1213
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '879CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1213';
-- 
-- DBC Item Code: M365.1482.M3P6
-- HB Product ID: 1482
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '4D9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1482';
-- 
-- DBC Item Code: M365.677.M3E3
-- HB Product ID: 677
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '479CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '677';
-- 
-- DBC Item Code: M365.682.M3C1
-- HB Product ID: 682
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '499CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '682';
-- 
-- DBC Item Code: M365.684.M3EK
-- HB Product ID: 684
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '4B9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '684';
-- 
-- DBC Item Code: M365.696.M3P1
-- HB Product ID: 696
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '4D9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '696';
-- 
-- DBC Item Code: M365.707.M3AB
-- HB Product ID: 707
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '4F9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '707';
-- 
-- DBC Item Code: M365.708.M3B1
-- HB Product ID: 708
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '519CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '708';
-- 
-- DBC Item Code: M365.709.M3B2
-- HB Product ID: 709
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '539CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '709';
-- 
-- DBC Item Code: M365.710.M3E1
-- HB Product ID: 710
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '559CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '710';
-- 
-- DBC Item Code: M365.714.M3AE
-- HB Product ID: 714
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '579CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '714';
-- 
-- DBC Item Code: M365.724.M3VS
-- HB Product ID: 724
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '599CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '724';
-- 
-- DBC Item Code: M365.752.M3EM
-- HB Product ID: 752
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '5D9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '752';
-- 
-- DBC Item Code: M365.758.M3BM
-- HB Product ID: 758
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '5F9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '758';
-- 
-- DBC Item Code: M365.759.M3AM
-- HB Product ID: 759
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '619CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '759';
-- 
-- DBC Item Code: M365.760.M3SM
-- HB Product ID: 760
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '639CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '760';
-- 
-- DBC Item Code: M365.769.M3P2
-- HB Product ID: 769
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '659CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '769';
-- 
-- DBC Item Code: M365.871.M3P3
-- HB Product ID: 871
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '679CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '871';
-- 
-- DBC Item Code: M365.872.M3P4
-- HB Product ID: 872
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '699CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '872';
-- 
-- DBC Item Code: M365.873.M3P5
-- HB Product ID: 873
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '6B9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '873';
-- 
-- DBC Item Code: M365.901.M3EA
-- HB Product ID: 901
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '6D9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '901';
-- 
-- DBC Item Code: M365.924.PWB1
-- HB Product ID: 924
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '6F9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '924';
-- 
-- DBC Item Code: M365.955.ODP1
-- HB Product ID: 955
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '719CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '955';
-- 
-- DBC Item Code: M365.975.O3A1
-- HB Product ID: 975
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '739CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '975';
-- 
-- DBC Item Code: M365.984.VIS2
-- HB Product ID: 984
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '779CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '984';
-- 
-- DBC Item Code: M365.985.VIS1
-- HB Product ID: 985
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '799CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '985';
-- 
-- DBC Item Code: MA.1183.MAN1
-- HB Product ID: 1183
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '339BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1183';
-- 
-- DBC Item Code: MA.398.MAN3
-- HB Product ID: 398
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '2D9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '398';
-- 
-- DBC Item Code: MA.82.MAN2
-- HB Product ID: 82
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '2B9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '82';
-- 
-- DBC Item Code: MA.898.MAN4
-- HB Product ID: 898
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '2F9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '898';
-- 
-- DBC Item Code: MA.918.MAN5
-- HB Product ID: 918
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '319BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '918';
-- 
-- DBC Item Code: MON.394.MONT
-- HB Product ID: 394
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'B99DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '394';
-- 
-- DBC Item Code: MON.395.SMS
-- HB Product ID: 395
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'BB9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '395';
-- 
-- DBC Item Code: NES.1023.NWS1
-- HB Product ID: 1023
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '9B9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1023';
-- 
-- DBC Item Code: O365.1151.A3F
-- HB Product ID: 1151
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '6F4ED87E-0550-EB11-AF23-000D3AC907E2' WHERE `id` = '1151';
-- 
-- DBC Item Code: O365.979.O3A3
-- HB Product ID: 979
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'C7BCED4E-0550-EB11-AF23-000D3AC907E2' WHERE `id` = '979';
-- 
-- DBC Item Code: PJ.526.REGO
-- HB Product ID: 526
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '919EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '526';
-- 
-- DBC Item Code: RES.582.RSD1
-- HB Product ID: 582
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '0F9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '582';
-- 
-- DBC Item Code: RSTD.128.REDE
-- HB Product ID: 128
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '119DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '128';
-- 
-- DBC Item Code: RVPS.1268.RVPS
-- HB Product ID: 1268
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'D39BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1268';
-- 
-- DBC Item Code: SERV.103.BACU
-- HB Product ID: 103
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '959EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '103';
-- 
-- DBC Item Code: SERV.1110.CFG2
-- HB Product ID: 1110
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A79EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1110';
-- 
-- DBC Item Code: SERV.1127.ETNB
-- HB Product ID: 1127
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A99EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1127';
-- 
-- DBC Item Code: SERV.119.IPAD
-- HB Product ID: 119
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '979EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '119';
-- 
-- DBC Item Code: SERV.125.MIGI
-- HB Product ID: 125
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '999EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '125';
-- 
-- DBC Item Code: SERV.1259.HWD2
-- HB Product ID: 1259
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'BF71169D-9E5B-EB11-AF25-000D3AC907E2' WHERE `id` = '1259';
-- 
-- DBC Item Code: SERV.1260.HWD3
-- HB Product ID: 1260
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A09EEDA3-9E5B-EB11-AF25-000D3AC907E2' WHERE `id` = '1260';
-- 
-- DBC Item Code: SERV.1261.HWD4
-- HB Product ID: 1261
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '51EB68AA-9E5B-EB11-AF25-000D3AC907E2' WHERE `id` = '1261';
-- 
-- DBC Item Code: SERV.284.INST
-- HB Product ID: 284
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '9B9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '284';
-- 
-- DBC Item Code: SERV.454.ONSI
-- HB Product ID: 454
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A19EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '454';
-- 
-- DBC Item Code: SERV.477.CFG1
-- HB Product ID: 477
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '9D9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '477';
-- 
-- DBC Item Code: SERV.743.EMGS
-- HB Product ID: 743
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '9F9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '743';
-- 
-- DBC Item Code: SERV.745.ONSI
-- HB Product ID: 745
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A19EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '745';
-- 
-- DBC Item Code: SERV.890.MSFE
-- HB Product ID: 890
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A39EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '890';
-- 
-- DBC Item Code: SERV.930.DMBN
-- HB Product ID: 930
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A59EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '930';
-- 
-- DBC Item Code: SERV.95.FIRW
-- HB Product ID: 95
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '939EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '95';
-- 
-- DBC Item Code: SSL.1000.SE09
-- HB Product ID: 1000
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '959DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1000';
-- 
-- DBC Item Code: SSL.1044.SE07
-- HB Product ID: 1044
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '979DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1044';
-- 
-- DBC Item Code: SSL.1047.SE08
-- HB Product ID: 1047
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '999DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1047';
-- 
-- DBC Item Code: SSL.1117.SD08
-- HB Product ID: 1117
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '9B9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1117';
-- 
-- DBC Item Code: SSL.1118.SD09
-- HB Product ID: 1118
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '9D9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1118';
-- 
-- DBC Item Code: SSL.1186.SD10
-- HB Product ID: 1186
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '9F9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1186';
-- 
-- DBC Item Code: SSL.1187.SD11
-- HB Product ID: 1187
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A19DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1187';
-- 
-- DBC Item Code: SSL.1199.SO07
-- HB Product ID: 1199
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A39DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1199';
-- 
-- DBC Item Code: SSL.1203.SG02
-- HB Product ID: 1203
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A59DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1203';
-- 
-- DBC Item Code: SSL.1204.SG09
-- HB Product ID: 1204
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A79DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1204';
-- 
-- DBC Item Code: SSL.1205.SG06
-- HB Product ID: 1205
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'A99DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1205';
-- 
-- DBC Item Code: SSL.1206.SD13
-- HB Product ID: 1206
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '999DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1206';
-- 
-- DBC Item Code: SSL.1207.SD12
-- HB Product ID: 1207
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'AB9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1207';
-- 
-- DBC Item Code: SSL.1218.ST02
-- HB Product ID: 1218
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'AD9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1218';
-- 
-- DBC Item Code: SSL.1228.SD02
-- HB Product ID: 1228
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'AF9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1228';
-- 
-- DBC Item Code: SSL.1230.SD05
-- HB Product ID: 1230
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'B19DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1230';
-- 
-- DBC Item Code: SSL.153.SG01
-- HB Product ID: 153
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '1B9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '153';
-- 
-- DBC Item Code: SSL.154.SR01
-- HB Product ID: 154
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '1D9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '154';
-- 
-- DBC Item Code: SSL.165.ST01
-- HB Product ID: 165
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '1F9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '165';
-- 
-- DBC Item Code: SSL.166.SD01
-- HB Product ID: 166
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '219DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '166';
-- 
-- DBC Item Code: SSL.167.SO01
-- HB Product ID: 167
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '239DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '167';
-- 
-- DBC Item Code: SSL.168.SG07
-- HB Product ID: 168
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '259DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '168';
-- 
-- DBC Item Code: SSL.169.ST07
-- HB Product ID: 169
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '279DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '169';
-- 
-- DBC Item Code: SSL.170.SS01
-- HB Product ID: 170
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '299DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '170';
-- 
-- DBC Item Code: SSL.171.SS04
-- HB Product ID: 171
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '2B9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '171';
-- 
-- DBC Item Code: SSL.172.SC01
-- HB Product ID: 172
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '2D9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '172';
-- 
-- DBC Item Code: SSL.173.SC02
-- HB Product ID: 173
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '2F9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '173';
-- 
-- DBC Item Code: SSL.174.SC03
-- HB Product ID: 174
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '319DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '174';
-- 
-- DBC Item Code: SSL.175.SS08
-- HB Product ID: 175
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '339DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '175';
-- 
-- DBC Item Code: SSL.176.SS06
-- HB Product ID: 176
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '359DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '176';
-- 
-- DBC Item Code: SSL.177.ST05
-- HB Product ID: 177
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '379DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '177';
-- 
-- DBC Item Code: SSL.179.SC13
-- HB Product ID: 179
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '399DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '179';
-- 
-- DBC Item Code: SSL.180.SD04
-- HB Product ID: 180
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '3B9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '180';
-- 
-- DBC Item Code: SSL.181.SG05
-- HB Product ID: 181
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '3D9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '181';
-- 
-- DBC Item Code: SSL.182.ST04
-- HB Product ID: 182
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '3F9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '182';
-- 
-- DBC Item Code: SSL.184.SC06
-- HB Product ID: 184
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '419DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '184';
-- 
-- DBC Item Code: SSL.185.SD03
-- HB Product ID: 185
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '439DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '185';
-- 
-- DBC Item Code: SSL.186.SG08
-- HB Product ID: 186
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '459DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '186';
-- 
-- DBC Item Code: SSL.187.SO02
-- HB Product ID: 187
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '479DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '187';
-- 
-- DBC Item Code: SSL.188.SR02
-- HB Product ID: 188
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '499DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '188';
-- 
-- DBC Item Code: SSL.227.SS10
-- HB Product ID: 227
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '4B9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '227';
-- 
-- DBC Item Code: SSL.228.SS12
-- HB Product ID: 228
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '4D9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '228';
-- 
-- DBC Item Code: SSL.233.SS13
-- HB Product ID: 233
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '4F9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '233';
-- 
-- DBC Item Code: SSL.234.SD07
-- HB Product ID: 234
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '519DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '234';
-- 
-- DBC Item Code: SSL.235.SD06
-- HB Product ID: 235
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '539DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '235';
-- 
-- DBC Item Code: SSL.240.ST09
-- HB Product ID: 240
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '559DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '240';
-- 
-- DBC Item Code: SSL.317.SS03
-- HB Product ID: 317
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '579DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '317';
-- 
-- DBC Item Code: SSL.372.SO03
-- HB Product ID: 372
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '599DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '372';
-- 
-- DBC Item Code: SSL.373.SO04
-- HB Product ID: 373
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '5B9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '373';
-- 
-- DBC Item Code: SSL.374.SO05
-- HB Product ID: 374
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '5D9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '374';
-- 
-- DBC Item Code: SSL.536.SG03
-- HB Product ID: 536
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '5F9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '536';
-- 
-- DBC Item Code: SSL.540.SS02
-- HB Product ID: 540
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '619DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '540';
-- 
-- DBC Item Code: SSL.541.SS05
-- HB Product ID: 541
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '639DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '541';
-- 
-- DBC Item Code: SSL.542.SS09
-- HB Product ID: 542
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '659DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '542';
-- 
-- DBC Item Code: SSL.543.SS07
-- HB Product ID: 543
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '679DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '543';
-- 
-- DBC Item Code: SSL.546.SC04
-- HB Product ID: 546
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '699DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '546';
-- 
-- DBC Item Code: SSL.547.SC05
-- HB Product ID: 547
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '6B9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '547';
-- 
-- DBC Item Code: SSL.548.SC07
-- HB Product ID: 548
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '6D9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '548';
-- 
-- DBC Item Code: SSL.549.SC08
-- HB Product ID: 549
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '6F9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '549';
-- 
-- DBC Item Code: SSL.550.SC11
-- HB Product ID: 550
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '719DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '550';
-- 
-- DBC Item Code: SSL.551.SC12
-- HB Product ID: 551
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '739DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '551';
-- 
-- DBC Item Code: SSL.552.SC14
-- HB Product ID: 552
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '759DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '552';
-- 
-- DBC Item Code: SSL.553.SC15
-- HB Product ID: 553
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '779DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '553';
-- 
-- DBC Item Code: SSL.554.SS11
-- HB Product ID: 554
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '799DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '554';
-- 
-- DBC Item Code: SSL.618.ST08
-- HB Product ID: 618
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '7B9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '618';
-- 
-- DBC Item Code: SSL.620.ST06
-- HB Product ID: 620
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '7D9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '620';
-- 
-- DBC Item Code: SSL.634.SE01
-- HB Product ID: 634
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '7F9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '634';
-- 
-- DBC Item Code: SSL.635.SE06
-- HB Product ID: 635
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '819DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '635';
-- 
-- DBC Item Code: SSL.637.SE05
-- HB Product ID: 637
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '839DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '637';
-- 
-- DBC Item Code: SSL.638.SE03
-- HB Product ID: 638
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '859DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '638';
-- 
-- DBC Item Code: SSL.639.SE04
-- HB Product ID: 639
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '879DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '639';
-- 
-- DBC Item Code: SSL.640.SE02
-- HB Product ID: 640
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '899DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '640';
-- 
-- DBC Item Code: SSL.864.SC09
-- HB Product ID: 864
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '8B9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '864';
-- 
-- DBC Item Code: SSL.885.SG04
-- HB Product ID: 885
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '8D9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '885';
-- 
-- DBC Item Code: SSL.886.ST03
-- HB Product ID: 886
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '8F9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '886';
-- 
-- DBC Item Code: SSL.953.SO06
-- HB Product ID: 953
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '919DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '953';
-- 
-- DBC Item Code: SSL.954.SC10
-- HB Product ID: 954
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '939DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '954';
-- 
-- DBC Item Code: SWL.1039.SFP5
-- HB Product ID: 1039
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '699EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1039';
-- 
-- DBC Item Code: SWL.1092.SFV4
-- HB Product ID: 1092
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '6B9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1092';
-- 
-- DBC Item Code: SWL.1112.SPJ3
-- HB Product ID: 1112
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '6D9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1112';
-- 
-- DBC Item Code: SWL.1113.SFW9
-- HB Product ID: 1113
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '6F9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1113';
-- 
-- DBC Item Code: SWL.1114.SFW7
-- HB Product ID: 1114
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '719EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1114';
-- 
-- DBC Item Code: SWL.1115.SFWU
-- HB Product ID: 1115
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '739EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1115';
-- 
-- DBC Item Code: SWL.1122.SPJ4
-- HB Product ID: 1122
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '759EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1122';
-- 
-- DBC Item Code: SWL.1128.SFP3
-- HB Product ID: 1128
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '779EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1128';
-- 
-- DBC Item Code: SWL.1135.SFC4
-- HB Product ID: 1135
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '799EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1135';
-- 
-- DBC Item Code: SWL.1136.SFC1
-- HB Product ID: 1136
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '7B9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1136';
-- 
-- DBC Item Code: SWL.1137.SFC2
-- HB Product ID: 1137
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '7D9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1137';
-- 
-- DBC Item Code: SWL.1141.SCI6
-- HB Product ID: 1141
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '7F9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1141';
-- 
-- DBC Item Code: SWL.1142.SCI4
-- HB Product ID: 1142
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '819EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1142';
-- 
-- DBC Item Code: SWL.1147.SCI3
-- HB Product ID: 1147
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '839EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1147';
-- 
-- DBC Item Code: SWL.1152.SFKN
-- HB Product ID: 1152
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '859EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1152';
-- 
-- DBC Item Code: SWL.1200.SFP1
-- HB Product ID: 1200
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '879EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1200';
-- 
-- DBC Item Code: SWL.1201.SFP4
-- HB Product ID: 1201
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '899EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1201';
-- 
-- DBC Item Code: SWL.1219.SFMQ
-- HB Product ID: 1219
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '8B9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1219';
-- 
-- DBC Item Code: SWL.1255.SFSC
-- HB Product ID: 1255
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'BE7114EB-B254-EB11-AF23-000D3AC907E2' WHERE `id` = '1255';
-- 
-- DBC Item Code: SWL.1257.HWD1
-- HB Product ID: 1257
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'E6BA4569-9E5B-EB11-AF25-000D3AC907E2' WHERE `id` = '1257';
-- 
-- DBC Item Code: SWL.1278.SFC4
-- HB Product ID: 1278
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '7D9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1278';
-- 
-- DBC Item Code: SWL.1472.SFIM
-- HB Product ID: 1472
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '859EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1472';
-- 
-- DBC Item Code: SWL.389.SFC3
-- HB Product ID: 389
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '0F9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '389';
-- 
-- DBC Item Code: SWL.390.SFC5
-- HB Product ID: 390
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '119EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '390';
-- 
-- DBC Item Code: SWL.462.SDAI
-- HB Product ID: 462
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '139EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '462';
-- 
-- DBC Item Code: SWL.470.SCI2
-- HB Product ID: 470
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '159EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '470';
-- 
-- DBC Item Code: SWL.472.SCI5
-- HB Product ID: 472
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '179EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '472';
-- 
-- DBC Item Code: SWL.529.SFDA
-- HB Product ID: 529
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '199EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '529';
-- 
-- DBC Item Code: SWL.664.SFF
-- HB Product ID: 664
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '1C32C196-0650-EB11-AF23-000D3AC907E2' WHERE `id` = '664';
-- 
-- DBC Item Code: SWL.746.SFW4
-- HB Product ID: 746
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '1B9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '746';
-- 
-- DBC Item Code: SWL.749.SFP
-- HB Product ID: 749
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '6F0F070A-0650-EB11-AF23-000D3AC907E2' WHERE `id` = '749';
-- 
-- DBC Item Code: SWL.770.SFW2
-- HB Product ID: 770
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '1D9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '770';
-- 
-- DBC Item Code: SWL.772.SFW5
-- HB Product ID: 772
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '1F9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '772';
-- 
-- DBC Item Code: SWL.774.SFW1
-- HB Product ID: 774
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '219EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '774';
-- 
-- DBC Item Code: SWL.775.SFW3
-- HB Product ID: 775
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '239EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '775';
-- 
-- DBC Item Code: SWL.776.SFHS
-- HB Product ID: 776
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '259EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '776';
-- 
-- DBC Item Code: SWL.777.SFHB
-- HB Product ID: 777
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '279EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '777';
-- 
-- DBC Item Code: SWL.778.SFMS
-- HB Product ID: 778
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '299EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '778';
-- 
-- DBC Item Code: SWL.780.SFSD
-- HB Product ID: 780
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '2B9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '780';
-- 
-- DBC Item Code: SWL.781.SFPP
-- HB Product ID: 781
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '2D9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '781';
-- 
-- DBC Item Code: SWL.784.SPJ2
-- HB Product ID: 784
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '2F9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '784';
-- 
-- DBC Item Code: SWL.785.SFV5
-- HB Product ID: 785
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '319EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '785';
-- 
-- DBC Item Code: SWL.786.SFV3
-- HB Product ID: 786
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '339EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '786';
-- 
-- DBC Item Code: SWL.792.SFW8
-- HB Product ID: 792
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '359EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '792';
-- 
-- DBC Item Code: SWL.800.SFU2
-- HB Product ID: 800
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '379EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '800';
-- 
-- DBC Item Code: SWL.806.SFD3
-- HB Product ID: 806
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '399EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '806';
-- 
-- DBC Item Code: SWL.809.SFD2
-- HB Product ID: 809
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '3B9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '809';
-- 
-- DBC Item Code: SWL.812.SFD1
-- HB Product ID: 812
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '3D9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '812';
-- 
-- DBC Item Code: SWL.826.SFSL
-- HB Product ID: 826
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '3F9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '826';
-- 
-- DBC Item Code: SWL.827.SFC6
-- HB Product ID: 827
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '419EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '827';
-- 
-- DBC Item Code: SWL.835.SFK1
-- HB Product ID: 835
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '439EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '835';
-- 
-- DBC Item Code: SWL.836.SFK2
-- HB Product ID: 836
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '459EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '836';
-- 
-- DBC Item Code: SWL.839.SFK4
-- HB Product ID: 839
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '479EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '839';
-- 
-- DBC Item Code: SWL.840.SFK5
-- HB Product ID: 840
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '499EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '840';
-- 
-- DBC Item Code: SWL.842.SFK6
-- HB Product ID: 842
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '4B9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '842';
-- 
-- DBC Item Code: SWL.862.SFVS
-- HB Product ID: 862
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '4D9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '862';
-- 
-- DBC Item Code: SWL.866.SFP2
-- HB Product ID: 866
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '4F9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '866';
-- 
-- DBC Item Code: SWL.867.SFK3
-- HB Product ID: 867
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '519EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '867';
-- 
-- DBC Item Code: SWL.868.SFU1
-- HB Product ID: 868
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '539EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '868';
-- 
-- DBC Item Code: SWL.911.SFQ5
-- HB Product ID: 911
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '559EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '911';
-- 
-- DBC Item Code: SWL.921.SFVM
-- HB Product ID: 921
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '579EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '921';
-- 
-- DBC Item Code: SWL.937.SFQ6
-- HB Product ID: 937
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '599EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '937';
-- 
-- DBC Item Code: SWL.956.SFQ4
-- HB Product ID: 956
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '5B9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '956';
-- 
-- DBC Item Code: SWL.968.SFQ1
-- HB Product ID: 968
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '5D9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '968';
-- 
-- DBC Item Code: SWL.969.SFA2
-- HB Product ID: 969
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '5F9EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '969';
-- 
-- DBC Item Code: SWL.970.SFA3
-- HB Product ID: 970
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '619EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '970';
-- 
-- DBC Item Code: SWL.971.SFA5
-- HB Product ID: 971
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '639EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '971';
-- 
-- DBC Item Code: SWL.972.SFA1
-- HB Product ID: 972
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '659EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '972';
-- 
-- DBC Item Code: SWL.974.SFA4
-- HB Product ID: 974
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '679EB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '974';
-- 
-- DBC Item Code: SWL.976.VSSS
-- HB Product ID: 976
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '939CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '976';
-- 
-- DBC Item Code: VP.1214.VPC1
-- HB Product ID: 1214
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '1F9CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1214';
-- 
-- DBC Item Code: VP.1215.VPC2
-- HB Product ID: 1215
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '219CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1215';
-- 
-- DBC Item Code: VP.1216.VPC3
-- HB Product ID: 1216
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '239CB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1216';
-- 
-- DBC Item Code: WD.1054.WDED
-- HB Product ID: 1054
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'BB9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1054';
-- 
-- DBC Item Code: WH.301.WCWN
-- HB Product ID: 301
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '6D9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '301';
-- 
-- DBC Item Code: WH.305.WSWN
-- HB Product ID: 305
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '6F9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '305';
-- 
-- DBC Item Code: WH.309.WRWI
-- HB Product ID: 309
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '719BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '309';
-- 
-- DBC Item Code: WH.310.WTIN
-- HB Product ID: 310
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '739BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '310';
-- 
-- DBC Item Code: WH.312.WCOB
-- HB Product ID: 312
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '759BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '312';
-- 
-- DBC Item Code: WH.62.WADV
-- HB Product ID: 62
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '659BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '62';
-- 
-- DBC Item Code: WH.63.WSM
-- HB Product ID: 63
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '679BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '63';
-- 
-- DBC Item Code: WH.68.WMXM
-- HB Product ID: 68
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '699BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '68';
-- 
-- DBC Item Code: WH.69.WBSI
-- HB Product ID: 69
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = '6B9BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '69';
-- 
-- DBC Item Code: WVM.993.WVMW
-- HB Product ID: 993
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'E59BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '993';
-- 
-- DBC Item Code: WVPS.988.WVPS
-- HB Product ID: 988
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'D99BB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '988';
-- 
-- DBC Item Code: ZEN.1120.ZE01
-- HB Product ID: 1120
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'E19DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1120';
-- 
-- DBC Item Code: ZEN.1121.ZCB2
-- HB Product ID: 1121
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'E39DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1121';
-- 
-- DBC Item Code: ZEN.1130.ZAAP
-- HB Product ID: 1130
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'E59DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1130';
-- 
-- DBC Item Code: ZEN.1131.ZLVP
-- HB Product ID: 1131
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'E79DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '1131';
-- 
-- DBC Item Code: ZEN.925.ZSYS
-- HB Product ID: 925
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'CF9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '925';
-- 
-- DBC Item Code: ZEN.928.ZPMS
-- HB Product ID: 928
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'D19DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '928';
-- 
-- DBC Item Code: ZEN.940.ZS03
-- HB Product ID: 940
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'D39DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '940';
-- 
-- DBC Item Code: ZEN.941.ZS04
-- HB Product ID: 941
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'D59DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '941';
-- 
-- DBC Item Code: ZEN.943.ZG01
-- HB Product ID: 943
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'D79DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '943';
-- 
-- DBC Item Code: ZEN.944.ZG02
-- HB Product ID: 944
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'D99DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '944';
-- 
-- DBC Item Code: ZEN.945.ZC01
-- HB Product ID: 945
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'DB9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '945';
-- 
-- DBC Item Code: ZEN.947.ZC03
-- HB Product ID: 947
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'DD9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '947';
-- 
-- DBC Item Code: ZEN.948.ZC04
-- HB Product ID: 948
-- 
UPDATE `hb_products` SET `dimensionCodeBUId` = 'DF9DB845-6447-EB11-BF6C-000D3AC8F2C9' WHERE `id` = '948';