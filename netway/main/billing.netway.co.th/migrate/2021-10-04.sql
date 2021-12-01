--
-- Table structure for table `dbc_salesorder`
--

CREATE TABLE `dbc_salesorder` (
  `invoice_id` int NOT NULL,
  `dbc_salesorder_id` varchar(36) DEFAULT NULL,
  `status` varchar(10) DEFAULT 'pending',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for table `dbc_salesorder`
--
ALTER TABLE `dbc_salesorder`
  ADD PRIMARY KEY (`invoice_id`);


INSERT INTO `dbc_webhooks` (`id`, `name`, `method`, `url`) VALUES ('3', 'Create/Update Sales Order', 'POST', '');

ALTER TABLE `hb_invoices` ADD `create_sod_status` INT(1) NOT NULL DEFAULT '0' COMMENT 'Netway ' AFTER `deal_id`;