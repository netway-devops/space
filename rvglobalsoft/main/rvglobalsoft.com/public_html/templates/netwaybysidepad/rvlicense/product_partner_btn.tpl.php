<?php 
$clientid = $_SESSION['AppSettings']['login']['id'];
$db = hbm_db();
$aData = $db->query("
        SELECT
            acc.id, acc.product_id, acc.status
        FROM
            hb_accounts acc
            
        WHERE
            acc.client_id = :client_id 
        ",
        array(
            ':client_id' => $clientid
        )
    )->fetchAll();
 
$aServername = array();
$aBtn = array();
$aProductSB7_noc = array(159);

$aProductSB_in = array(77,78);
$aProductSB_ex = array(79,80);
$aProductSK_in = array(73,74);
$aProductSK_ex = array(75,76);
foreach($aData as $foo=>$service) { 
	if (in_array($service['product_id'],$aProductSB7_noc)){
		$aBtn['sb7_noc'] = $service['product_id'];
	}
    if (in_array($service['product_id'],$aProductSB_in)){
        $aBtn['sb_in'] = $service['product_id'];
    }
    if (in_array($service['product_id'],$aProductSB_ex)){
        $aBtn['sb_ex'] = $service['product_id'];
    }
    if (in_array($service['product_id'],$aProductSK_in)){
        $aBtn['sk_in'] = $service['product_id'];
    }
    if (in_array($service['product_id'],$aProductSK_ex)){
        $aBtn['sk_ex'] = $service['product_id'];
    }
}  

$this->assign('aBtn',$aBtn);

if(isset($aBtn)){
       $noc =   $db->query("
                   SELECT DISTINCT(a.client_id),c.firstname,c.lastname 
                   FROM hb_accounts a LEFT 
                   JOIN hb_client_details c 
                   ON a.client_id = c.id 
                   WHERE a.client_id = $clientid 
                   AND a.product_id IN (77,78) 
                   AND a.status = 'Active' 
                   AND a.client_id != 4609 
                  
                ")->fetch();  
      }
  $this->assign('noc',$noc); 