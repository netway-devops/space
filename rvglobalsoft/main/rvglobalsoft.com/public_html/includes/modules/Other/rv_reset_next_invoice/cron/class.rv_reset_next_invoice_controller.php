<?php
/****************************************************************
 * _mergeUser : เอาไว้ merge client id จาก hostbilll เข้า database ของ rvsitebuilder
 * 
 * 
 ***************************************************************/
class rv_reset_next_invoice_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    public function call_daily()
    {
        $message = "-ไม่มีการอัพเดท-";
        $db         = hbm_db();
        
    	$aUpdate= $db->query("
            UPDATE
				hb_accounts acc,hb_automation_settings s
			SET 
				acc.next_invoice = acc.next_due
			WHERE
				acc.product_id = s.item_id
				AND s.setting = 'InvoiceGeneration'
				AND (s.value =  '' OR s.value =  '0')
            ", array());
		$message = 'UPDATE NEXT INVOICE OK' . "\n";
         
        $aDeletelog = $db->query("
            DELETE FROM
				hb_error_log
			WHERE
				entry LIKE '%IN hbf/core/class.hbeventmanager.php(115) : runtime-created function(277)%'
				OR entry LIKE '%\'4349\' for key \'invoice_id\' IN /home/rvglobal/public_html/includes/modules/Payment/class.manualcc.php%'
				OR entry LIKE '%function showAjax() on a non-object IN hbf/components/utilities/class.utilities.php(700)%'
				OR entry LIKE '%1062 Duplicate entry \'4349\' for key \'invoice_id\' IN /home/rvglobal/public_html/includes/modules/Payment/class.manualcc.php%'
            ", array());
		$message .= 'DELETE ERROR LOG (runtime-created function(277)) OK';
		
		
        echo $message;
        return $message;
    }
    
   

    
}
