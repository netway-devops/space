# Netway ถ้ามี desal ไม่ต้องไปสร้างใหม่ที่ Clickup
ALTER TABLE `hb_order_drafts` ADD `clickup_task_id` VARCHAR(32) NOT NULL COMMENT 'Netway ถ้ามี desal ไม่ต้องไปสร้างใหม่ที่ Clickup'  ;
