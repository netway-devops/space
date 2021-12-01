<?php
$aContents = $this->get_template_vars('contents');
$db = hbm_db();
$client     = hbm_logged_client();
$usr_id = $client['id'];
$result = $db->query("
                      SELECT
                        id
                      FROM
                        hb_accounts
                      WHERE
                        client_id = :usr_id
						AND product_id = 59
                      ORDER BY id DESC
                      LIMIT 0,1
                ", array(
                        ':usr_id' => $usr_id
                )
        )->fetch();
if(isset($result['id'])){
$result2 = $db->query("
                      SELECT
                        quantity_at_symantec
                      FROM
                        hb_vip_info
                      WHERE
                        usr_id = :usr_id
                      ORDER BY vip_info_id DESC
                      LIMIT 0,1
                ", array(
                        ':usr_id' => $usr_id
                )
        )->fetch();

$aContents[1][13][13]['qty'] = $result2['quantity_at_symantec'];

$this->assign('contents', $aContents);
$this->assign('2faLockQty', 1);
}
?>