<?php
/**
 * Root Commission for SSL
 */

/// ไม่สามารถบันทึก commission ขณะนี้ได้ เนื่องจาก ขณะที่ run hook ข้อมูลที่ส่งมาจาก billing ของ reseller ยังไม่ครบ
/// จะไปบันทึก commission ในตอน invocefullpaid แทน

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

$invoiceId          = $details;
