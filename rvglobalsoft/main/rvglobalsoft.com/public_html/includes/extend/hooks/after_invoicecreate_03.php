<?php

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

$invoiceId          = $details;

/*
 * แก้ปัญหาการคิดราคา prorate จาก "รายนาที" เป็นวัน "รายวัน" แทน เราราคาไม่ตรงกันเลย
 */

require_once(APPDIR . 'modules/Site/invoicehandle/admin/class.invoicehandle_controller.php');
invoicehandle_controller::singleton()->updateInvoiceItemPriceProrate($invoiceId);
