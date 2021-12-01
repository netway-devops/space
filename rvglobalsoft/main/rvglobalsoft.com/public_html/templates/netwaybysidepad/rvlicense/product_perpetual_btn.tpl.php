<?php 
$clientid = $_SESSION['AppSettings']['login']['id'];
$db = hbm_db();
$aData = $db->query("
        SELECT
            q.quota_ded_max,q.quota_vps_max
        FROM
            hb_rv_license_quota q
        WHERE
            q.client_id = :client_id 
        ",
        array(
            ':client_id' => $clientid
        )
    )->fetch();
if ($aData && !($aData['quota_ded_max'] == 0 && $aData['quota_vps_max'] == 0)) {
	$aBtn['ded'] = $aData['quota_ded_max'];
	$aBtn['vps'] = $aData['quota_vps_max'];
	$aBtn['res'] = true;
} else {
	$aBtn['res'] = false;
}
$this->assign('aBtn',$aBtn);
