--
-- Table structure for table `ms_order_queue`
--

CREATE TABLE IF NOT EXISTS `ms_order_queue` (
  `hb_account_id` int NOT NULL,
  `ms_order_id` varchar(32) COLLATE utf8_general_ci NOT NULL,
  `ms_customer_id` varchar(32) COLLATE utf8_general_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  `last_check` timestamp NOT NULL,
  `next_check` timestamp NOT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `ms_order_queue`
  ADD PRIMARY KEY (`hb_account_id`);
