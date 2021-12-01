# vendor มีการ insert ข้อมูลแล้วไม่มี product_id ต้องเปลี่ยนค่า default ให้เพื่อป้องกัน error
ALTER TABLE `hb_product_log_diff` CHANGE `product_id` `product_id` INT NULL DEFAULT NULL;
