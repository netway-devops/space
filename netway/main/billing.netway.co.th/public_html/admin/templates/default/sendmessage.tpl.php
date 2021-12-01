<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$type       = $this->get_template_vars('type');
$selected   = $this->get_template_vars('selected');
// --- Get template variable ---

$clientId   = 0;

switch ($type) {
    case 'clients' : {
        $clientId   = $selected;
        break;
    }
    case 'invoices' : {
        $result     = $db->query("
            SELECT i.client_id
            FROM hb_invoices i
            WHERE i.id = :invoiceId
            ", array(
                ':invoiceId'    => $selected
            ))->fetch();
        $clientId   = isset($result['client_id']) ? $result['client_id'] : 0;
        break;
    }
}

if ($clientId) {
    echo '
        <script type="text/javascript">
        window.location="?cmd=sendmessage&type=clients&selected='. $clientId .'";
        </script>
        ';
    
} else {
    echo '
        <p align="center">Client id not found</p>
        ';
}
exit;
