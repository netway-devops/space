ALTER TABLE `hb_invoices` ADD `sortid` BIGINT(11)  UNSIGNED  NULL  DEFAULT '0'  AFTER `flags`;
##########
ALTER TABLE `hb_invoices` ADD INDEX (`sortid`);
##########
UPDATE hb_invoices SET sortid=id;
