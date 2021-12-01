<?php

require_once(APPDIR . 'modules/Site/invoicehandle/admin/class.invoicehandle_controller.php');

 // --- hostbill helper ---
 $db         = hbm_db();
 // --- hostbill helper ---

$invoiceId      = $details;

invoicehandle_controller::singleton()->addFreeTrial(array('invoiceId'=>$invoiceId));

