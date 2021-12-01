<?php

/*************************************************************
 *
 * Hosting Module Class - RvGlobalsoft Common
 * 
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/admin-area/
 * http://dev.hostbillapp.com/dev-kit/advanced-topics/hostbill-controllers/
 * 
 * 
 ************************************************************/

class rvglobalsoft_common_controller extends HBController {
    
    
    /**
     * 
     * Enter description here ...
     * @param $request
     */
    public function view($request) {
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $request
     */
    public function coupon($request) {
        
        $this->loader->component('template/apiresponse', 'json');
        
        if ($request['subaction'] == 'add') {
            $this->json->assign("aResponse", $this->couponAdd($request));
        } else if ($request['subaction'] == 'update') {
            $this->json->assign("aResponse", $this->couponUpdate($request));
        }
        
        $this->json->show();
   }
   
   
   /**
    * 
    * Enter description here ...
    * @param $request
    */
   public function couponView($request) {
   	    return true;
   }
   
   /**
    * 
    * Enter description here ...
    * @param $request
    */
   public function couponAdd($request) {
   	
   	    if (isset($request['couponCode']) && $request['couponCode']) {
   	    	
   	    	$db = hbm_db();
   	    	
   	    	
   	    	$query = sprintf("   
                                SELECT
                                    c.id
                                FROM 
                                    %s c
                                WHERE
                                    c.code='%s'                
                                "
                                , "hb_coupons"
                                , $request['couponCode']
                            );
                            
            $aRes = $db->query($query)->fetchAll();
            $request['couponId'] = (isset($aRes[0]['id'])) ? $aRes[0]['id'] : '';
   	    	$this->couponUpdate($request);
   	    	
   	    }
   	
        return true;
   }
   
   /**
    * 
    * Enter description here ...
    * @param $request
    */
   public function couponUpdate($request) {

        if (isset($request['couponId']) && $request['couponId'] != '') {
            $db = hbm_db();
            
            // Update hb_coupons
            $query = sprintf("
                                    UPDATE 
                                        %s
                                    SET
                                        view_order_cart0='%s',
                                        view_order_cart3='%s',
                                        view_coupon_details='%s'
                                    WHERE
                                        id='%s'
                                    "
                                    , "hb_coupons"
                                    , $request['viewOrderCart0']
                                    , $request['viewOrderCart3']
                                    , $request['viewCouponDetails']
                                    , $request['couponId']
                     );
            $db->query($query);
        }
        
        return true;
   }

	/*********************************************
 	* ใช้สำหรับ ลบ email เพราะว่าบางที่เราทำ manage แล้วมี mail เกิดขึ้น เราไม่อยากให้ลูกค้าเห็น
 	********************************************/
     public function email_delete($request) {
     	//$request['selected'] = array(13375,13374,13373,13372,13371);
     	if (isset($request['selected'])) {
     		$email_list = is_array($request['selected']) ? join(',',$request['selected']) : $request['selected'];
     		$db = hbm_db();
            $query = sprintf("
            	DELETE FROM
            		%s
            	WHERE
            		id in (%s)
				"
				, "hb_email_log"
				, $email_list
				);
            $res = $db->query($query);
            if ($res) {
				echo '<!-- {"ERROR":[],"INFO":["Delete ' . count($request['selected']) . ' item success"],"STACK":0} -->';
            } else {
            	echo '<!-- {"ERROR":["Delete mail error"],"INFO":[],"STACK":0} -->';
            }
     	} else {
     		echo '<!-- {"ERROR":[],"INFO":["ไม่มีการเลือกข้อมูลที่ต้องการจะลบ"],"STACK":0} -->';
     	}
   }

}