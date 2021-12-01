ALTER TABLE `hb_notes` CHANGE `type` `type` ENUM('client','account','domain','order','draft','admin','invoice','estimate','rackitem')   NOT NULL  DEFAULT 'client';
