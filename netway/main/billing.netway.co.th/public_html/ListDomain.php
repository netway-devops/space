<?php
    header("Content-Type: application/json");
    include('includes/extend/whois/whois.php');
    
    
    function cmp($a, $b){
        return strcmp(substr($a, 1,2),substr($b,1,2));
    }
    foreach ($servers as $key => $value) {
        $listDomain['TLD'][] = $key;
    }
    usort($listDomain['TLD'],'cmp');
    if(isset($_GET['callback']))
        echo $_GET['callback']."(".json_encode($listDomain).")";
    else
        echo json_encode($listDomain);
    
    
?>

