<?php
    if ( ! defined('HBF_APPNAME')) {
    exit;
    }
    

    // --- hostbill helper ---
    $db         = hbm_db();
    // --- hostbill helper ---
    
    $orderNum   = $this->get_template_vars('order_num');
    $catName     = $db->query("SELECT c.name
                              FROM   hb_orders o 
                                     INNER JOIN hb_accounts a 
                                     ON (o.id = a.order_id)
                                     INNER JOIN hb_products p
                                     ON (a.product_id = p.id)
                                     INNER JOIN hb_categories c
                                     ON (p.category_id = c.id)   
                              WHERE
                                   o.number = :order_num
                             ",array(':order_num' => $orderNum))->fetch(); 
    if(isset($catName['name']))                         
        $this->assign('category_name',$catName['name']);
    if(isset($_SESSION['2FactorRenew']) && $_SESSION['2FactorRenew'] == 1){
    	$client     = hbm_logged_client();
		$lastAccountInfo = $db->query("
                                        SELECT
                                                id
                                        FROM
                                                hb_invoices
                                        WHERE
                                                client_id = :client_id
					ORDER BY id DESC
					LIMIT 0,1

                                        ", array(
                                                ':client_id' => $client['id']
        ))->fetchAll();


        $lastAccountInfo = (array) $lastAccountInfo;

		if(sizeof($lastAccountInfo) == 1){
			$lastAccountInfo2 = $db->query("
				SELECT
					description
				FROM
					hb_invoice_items
				WHERE
					invoice_id = :invId
				ORDER BY id ASC
				LIMIT 0,1
					", array(
					':invId' => $lastAccountInfo[0]['id']
				)
			)->fetchAll();
			$lastAccountInfo2 = (array) $lastAccountInfo2;
				if(sizeof($lastAccountInfo2) == 1 && isset($lastAccountInfo2[0]['description']) && substr($lastAccountInfo2[0]['description'],0,38) == '2-factor Authentication for WHM (Renew'){
//				$this->assign('2faRenewInv', $lastAccountInfo[0]['id']);
				$system_url = $this->get_template_vars('system_url');
				unset($_SESSION['2FactorRenew']);
				?>
				<script type='text/javascript'>
				 	window.location.assign('<?php echo $system_url;?>' + 'clientarea/invoice/' + '<?php echo $lastAccountInfo[0]['id'];?>');
				</script>
				<?php 
			}
		}
		unset($_SESSION['2FactorRenew']);
		
    }
?>
    