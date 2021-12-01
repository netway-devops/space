<?php

$aTemplatelProducts = $this->get_template_vars('product');
$aTemplateSSL = $this->get_template_vars('aSSL');

order_coupon::singleton()->setVar($aTemplatelProducts, 'product');
order_coupon::singleton()->setVar($aTemplateSSL, 'ssl');

$cartItems      = isset($_SESSION['AppSettings']['Cart']) ? count($_SESSION['AppSettings']['Cart']) : 0;
$this->assign('cartItems', $cartItems);
$catid;
$recurr;
$haveLicence=FALSE;
foreach ($_SESSION['AppSettings']['Cart'] as $key) {
    $catid = $key['product']['category_id'];
    if($catid == 6){
        $haveLicence = TRUE;
        $recurr = $key['product']['recurring'];
        break;
    }
}
$this->assign('havelicence', $haveLicence);
$this->assign('catid', $catid);
$this->assign('recurr', $recurr);
//secho '<pre>'.print_r($_SESSION['AppSettings'], true).'</pre>';
class order_coupon {
	
	/*
	 
	 
{php}
    $templatePath   = $this->get_template_vars('template_path');
    include(dirname($templatePath) . '/orderpages/order_coupon.tpl.php');
    
    $aTemplateCart = $this->get_template_vars('cart_contents');
    $aRes = order_coupon::singleton()->displayCoupon($aTemplateCart[0]['id']);
    $this->assign('aDataRvCustomCoupon', $aRes);
{/php}

	Array
	(
		[id] => 3
		[code] => I1FEPE49785
		[type] => percent
		[cycle] => recurring
		[value] => 50.00
		[cycles] => all
		[products] => 52|53|54|55|56
		[upgrades] => all
		[addons] => 1
		[domains] => all
		[expires] => 2013-06-30
		[max_usage] => 100
		[num_usage] => 0
		[clients] => new
		[client_id] => 0
		[notes] => 
	)
	*/
	
	
	// --- hostbill helper ---
	// $db = hbm_db();
	// --- hostbill helper ---
	
	
    protected $db;
    
    protected $aGlobalProducts;
    
    protected $aGlobalSSL;
    
    /**
     * 
     * Enter description here ...
     */
    public function __construct() {
        $this->db = hbm_db();
    }
    
    /**
     * Returns a singleton HostbillApi instance.
     *
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param bool $autoload
     * @return obj
     * 
     */
     public function &singleton($autoload=false) {
        static $instance;
        // If the instance is not there, create one
        if (!isset($instance) || $autoload) {
            $class = __CLASS__;
            $instance = new $class();
        }
        return $instance;
    }
	
    
    public function setVar($aVar=array(), $type="") {
    	if ($type == 'product') {
    		$this->aGlobalProducts = $aVar;
    	} else if ($type == 'ssl') {
    		$this->aGlobalSSL = $aVar;
    	}
    }
	
	/**
	 * 
	 * Enter description here ...
	 * @param $couponId
	 */
	function getCountAllClientUseCouponByCouponId($couponId="'") {
		
		   $query = sprintf("   
	                            SELECT
	                                count(*) AS count
	                            FROM 
	                                %s i
	                            WHERE
	                                i.coupon_id='%s'                 
	                            "
	                            , "hb_coupons_log"
	                            , $couponId
	                        );
	                        
	         $aRes = $this->db->query($query)->fetchAll();
	         
	         return (isset($aRes[0]['count'])) ? $aRes[0]['count'] : 0;
	}
	
	/**
	 * 
	 * Enter description here ...
	 * @param $productId
	 */
	function getCouponByProductId($productId="") {
				
		$query = sprintf("   
	                            SELECT
	                                *
	                            FROM 
	                                %s i
	                            WHERE
	                                i.products='%s'
	                            OR
	                                i.products LIKE '%s|%%'
	                            OR
	                                i.products LIKE '%%|%s|%%'
	                            OR
	                                i.products LIKE '%%|%s'
	                            OR
	                                i.products='all'
	                            ORDER BY
	                                i.products ASC 
	                            "
	                            , "hb_coupons"
	                            , $productId
	                            , $productId
	                            , $productId
	                            , $productId
	                        );
		
	    $aRes = $this->db->query($query)->fetchAll();
	                        
	    return (isset($aRes["0"])) ? $aRes["0"] : array();	
	}
	
	
	function getProductByProductId($productId="") {
		
		$aProduct = array(
		   'hb_common' => array(),
		   'hb_products' => array()
		);
		
		// Find Hostbill Products
		$query = sprintf("   
	                            SELECT
	                                *
	                            FROM 
	                                %s i
	                            WHERE
	                                i.id='%s'
	                            "
	                            , "hb_products"
	                            , $productId
	                        );
		
	    $aRes = $this->db->query($query)->fetchAll();
	    $aProduct['hb_products'] = (isset($aRes[0])) ? $aRes[0] : array();
	    
	    
	    // Find Hostbill Common
	    $query = sprintf("   
	                            SELECT
	                                *
	                            FROM 
	                                %s i
	                            WHERE
	                                i.id='%s'
	                            "
	                            , "hb_common"
	                            , $productId
	                        );
	    
	    $aRes = array();
	    $aRes = $this->db->query($query)->fetchAll();
	    $aProduct['hb_common'] = (isset($aRes[0])) ? $aRes[0] : array();
		
		return $aProduct;
	}
	
	function _validate_coupon($productId=null, $aCoupon=array()) {
		
		// Validate Here..
		$aValidate = array(
	       'raiseError' => 0,
	       'messageError' => ""
	    );
		
	    // Max Usage
	    if ($aCoupon['num_usage'] >= $aCoupon['max_usage']) {
	    	if ($aCoupon['max_usage'] == 0) {
	    		// Usage unlimited
	    	} else {
	    		$aValidate['raiseError'] = 1;
                $aValidate['messageError'] = "Coupon Usage Maximum " . $aCoupon['max_usage'];
	    	}
	    }
	    
	    
	    // Expire Date
	    if ($aValidate['raiseError'] == 0) {
	    	if ($aCoupon['expires'] == "0000-00-00") {
	    		// Usage unlimited
	    	} else {
		    	$expires = strtotime($aCoupon['expires']);
	            if ($expires == "") {
	            } else {
	                $now = time();
	                if ($now > $expires) {
	                    $aValidate['raiseError'] = 1;
	                    $aValidate['messageError'] = "Expire Date " . $aCoupon['expires'];
	                }
	            }
	    	}
	    }
	    
	    return $aValidate;
	}
	
	
	/**
	 * 
	 * Enter description here ...
	 * @param $aProduct
	 * @param $aCoupon
	 */
	function getCalculateCoupon($aProduct=array(), $aCoupon=array()) {
		
		$aCalculate = array();
		
		foreach($aProduct['hb_common'] as $key => $value) {
			if (preg_match("/\_setup/i", $key)) {
			} else {
				
				$assingKey = $key . "_coupon";
				
				if ($value == 0 || $value == '0.00') {
					$aProduct['hb_common'][$assingKey] = 0;
				} else {
					
				   if ($aCoupon['type'] == "fixed") {
				   	   $res = $value - $aCoupon['value'];
		           } else if ($aCoupon['type'] == "percent") {
		               $res  = (($value * $aCoupon['value']) / 100);
		           }
		           
		           $aProduct['hb_common'][$assingKey] = ($res>0) ? round($res, 2) : 0;
		           
				}
				
				
			}
		}
		
		
		$aCalculate = $aProduct;
		$aCalculate['hb_coupons'] = $aCoupon;
		
		return $aCalculate;
	}
	
	
	function getProductIdByProductName($productName="") {
		
		$query = sprintf("   
	                            SELECT
	                                p.id
	                            FROM 
	                                %s p,
	                                %s s
	                            WHERE
	                                p.name=s.ssl_name                
	                            "
	                            , "hb_products"
	                            , 'hb_ssl'
	                        );
	                        
	    $aRes = $this->db->query($query)->fetchAll();
	    return (isset($aRes[0]['id'])) ? $aRes[0]['id'] : null;
	    
	}
	
	
	/**
	 * 
	 * Enter description here ...
	 * @param $viewCart
	 * @param $productId
	 */
	function displayCoupon($viewCart=null, $productId=null) {
		
		// Set Datat Structer
		$aDataRvCustomCoupon = array(
		   'data' => array(),
		   'raiseError' => 0,
		   'messageError' => ""
		);
		
		
		if (isset($productId)) {
		} else {
			
			if (isset($this->aGlobalProducts['id']) && $this->aGlobalProducts['id'] != "") {
				$productId = $this->aGlobalProducts['id'];
			} else {
				$productName = (isset($this->aGlobalSSL['ssl_name'])) ? : null;
				
				if (isset($productName)) {
					$productId = $this->getProductIdByProductName($productName);
				} else {
					$aDataRvCustomCoupon['raiseError'] = 1;
					$aDataRvCustomCoupon['messageError'] = "Cannot find product id.";
				}
				
			}
			
		}
		
		if (isset($productId)) {
			$aCoupon = $this->getCouponByProductId($productId);
			if (is_array($aCoupon) && count($aCoupon)>0) {
				
				$aRes = $this->_validate_coupon($productId, $aCoupon);
				if ($aRes['raiseError'] == 1) {
					$aDataRvCustomCoupon['raiseError'] = 1;
	                $aDataRvCustomCoupon['messageError'] = $aRes['messageError'];
				} else {
					$aProduct = $this->getProductByProductId($productId);
					$aDataRvCustomCoupon['data'] = $this->getCalculateCoupon($aProduct, $aCoupon);
				}
				
			}
			
		} else {
			$aDataRvCustomCoupon['raiseError'] = 1;
	        $aDataRvCustomCoupon['messageError'] = "Cannot find product id.";
		}
		
		// $this->assign('aDataRvCustomCoupon', $aDataRvCustomCoupon);
		//return $aDataRvCustomCoupon;
		
		if (isset($viewCart)) {
			if (isset($aDataRvCustomCoupon['data']['hb_coupons']['code'])
			     && $aDataRvCustomCoupon['data']['hb_coupons']['code'] != ''
			     && $aDataRvCustomCoupon.raiseError == 0
			   ) {
				
			   if ($viewCart == 0 && $aDataRvCustomCoupon['data']['hb_coupons']['view_order_cart0'] == 1) {
	               echo $aDataRvCustomCoupon['data']['hb_coupons']['view_coupon_details'];
	           } else if ($viewCart == 3 && $aDataRvCustomCoupon['data']['hb_coupons']['view_order_cart3'] == 1) {
	               echo $aDataRvCustomCoupon['data']['hb_coupons']['view_coupon_details'];
	           }
			   	
			}
		}
		
		
		return true;
	}
	
	

}