<?php
require('includes/hostbill.php');

// --- hostbill helper ---
$client     = hbm_logged_client();
$db         = hbm_db();
$api        = new ApiWrapper();
// --- hostbill helper ---

$page       = substr($_SERVER['REQUEST_URI'],1);

if (preg_match('/\?/', $page)) {
    $page   = explode('?', $page);
    $page   = $page[0];
}


hbm_render_page($page .'.tpl', array(), ucwords($page));
