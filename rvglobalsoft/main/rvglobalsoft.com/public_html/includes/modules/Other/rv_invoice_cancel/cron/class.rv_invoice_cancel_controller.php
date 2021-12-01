<?php
/****************************************************************
 * _mergeUser : เอาไว้ merge client id จาก hostbilll เข้า database ของ rvsitebuilder
 * 
 * 
 ***************************************************************/
class rv_invoice_cancel_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
	
	/**
	 * 
	 */
    public function call_daily()
    {
        $message = "-ไม่มีการอัพเดท-";
		require_once(APPDIR . 'class.general.custom.php');
        $db         = hbm_db();
		
		//1. หา inv ที่มี account ที่ terminate ล่าสุด
		$aInv = $db->query("
			SELECT
				i.id
			FROM
				hb_accounts a,hb_invoices i,hb_invoice_items ii ,hb_account_logs al 
			WHERE 
				ii.item_id = a.id and 
				ii.invoice_id = i.id and 
				a.id = al.account_id and
				a.status = 'Terminated' and
				i.status = 'Unpaid' and 
				al.event = 'AccountTerminate'
				
			GROUP BY
				ii.invoice_id
			ORDER BY 
				al.date DESC
		
		",array())->fetchall();
		$list1 = '';
		$list2 = '';
		foreach ($aInv as $key => $adtl) {
			$res = true;
			//2. เอา inv แต่ละตัวไปตรวจดูว่า ทุก item เป็น teminate รึไม่ ถ้าเป็นก็ cancel inv ไปเลย
			$aListAccinv = $db->query("
			SELECT
				ii.invoice_id,ii.description
			FROM
				hb_accounts a,hb_invoice_items ii
			WHERE 
				ii.item_id = a.id and
				ii.type != 'Invoice' and
				a.status != 'Terminated' and
				ii.invoice_id = :inv_id
		
			",array(
			':inv_id' => $adtl['id']
			))->fetch();
			
			//2.1 มีบาง item ที่ยังไม่ terminate
			if ($aListAccinv) {
				$res = false;
				$aListAccinvTerminate = $db->query("
				SELECT
					ii.invoice_id,ii.description
				FROM
					hb_accounts a,hb_invoice_items ii
				WHERE 
					ii.item_id = a.id and
					ii.type != 'Invoice' and
					a.status = 'Terminated' and
					ii.invoice_id = :inv_id
			
				",array(
				':inv_id' => $adtl['id']
				))->fetchall();
				//echo '<pre>';print_r($aListAccinvTerminate);exit;
				$list1 .=','.$adtl['id'];
			} else {
				//2.2 ทุก item terminate หมดแล้ว
				//3. ทำการ set invoice เป็น cancel
				$return       = GeneralCustom::singleton()->apiSetInvoiceStatus($adtl['id'], 'Cancelled');
				if (isset($return['success']) && $return['success'] == false ){
					//3.1 api set status invoice error 
					$res = false;
				} else {
					//3.2 api set status invoice success 
					$message .= 'cancel inv ['.$adtl['id'].'] ok' . "\n";
				}
				$list2 .=','.$adtl['id'];
			}
			if ($res == false) {
        		//$resApi       = GeneralCustom::singleton()->apiSendTicketManualCancelInvForAccTerminateCron($aListAccinvTerminate);
			}
		}
		$message = 'invoice cancel ไม่ได้ ส่ง ticket ['.$list1.']' . "\n";
		$message .= 'invoice cancel ได้ ['.$list2.']' . "\n";
        echo $message;
        return $message;
    }
    
   

    
}
