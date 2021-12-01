ALTER TABLE `hb_mettered_values`
CHANGE COLUMN `qty` `qty` DECIMAL(25,5) NOT NULL,
CHANGE COLUMN `charge` `charge` DECIMAL(25,5) NOT NULL;
##########
ALTER TABLE `hb_mettered_reports`
CHANGE COLUMN `charge` `charge` DECIMAL(25,5) NOT NULL;
##########
ALTER TABLE `hb_mettered_prices`
CHANGE COLUMN `price` `price` DECIMAL(25,5) NOT NULL;
