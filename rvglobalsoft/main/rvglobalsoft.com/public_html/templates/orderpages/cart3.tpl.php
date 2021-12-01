<?php

$db = hbm_db();
$client = hbm_logged_client();
$usr_id = $client['id'];

$item = $this->get_template_vars('item');
if($item['id'] == 59){
        $chk = $db->query("
                SELECT
                      	id
                FROM
                    	hb_accounts
                WHERE
                     	client_id = :usr_id
                        AND product_id = 59
                ", array(
                        ':usr_id' => $usr_id
                )
        )->fetch();
        if(isset($chk['id']) && $chk['id'] != ''){
                $this->assign('have2Fa', '1');
        }
}

?>
