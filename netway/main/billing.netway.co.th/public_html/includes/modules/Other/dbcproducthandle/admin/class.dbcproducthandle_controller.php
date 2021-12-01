<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Other/dbcproducthandle/model/class.dbcproducthandle_model.php');
require_once(APPDIR . 'modules/Other/dbcproducthandle/library/class.dbcproducthandle_library.php');

class dbcproducthandle_controller extends HBController {
    
    private static  $instance;
    private $aPage  = array(
        'customer'  => 21,
        'item'      => 30,
    );
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }
        
        return self::$instance;
    }
    
    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }
    
    public function beforeCall ($request)
    {
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $oInfo      = (object) array(
            'title' => 'Products',
            'desc'  => '',
            );
        $this->template->assign('oInfo', $oInfo);
        
        $aConfig    = $this->module->configuration;
        
        $result     = dbcproducthandle_model::singleton()->getAllCategory();
        $aCategory  = array();
        foreach ($result as $arr) {
            $catId  = $arr['id'];
            $arr['aProducts']    = array();
            $aCategory[$catId]  = $arr;
        }
        
        $result     = dbcproducthandle_model::singleton()->getAllProduct();
        $aProduct   = array();
        foreach ($result as $arr) {
            $productId  = $arr['id'];
            $catId      = $arr['category_id'];
            $aProduct[$productId]  = $arr;
            
            if (! isset($aCategory[$catId]['aProduct'])) {
                $aCategory[$catId]['aProduct']  = array();
            }
            $aCategory[$catId]['aProducts'][$productId]  = $arr;
        }
        
        $result     = dbcproducthandle_model::singleton()->getAllDBCProduct();
        foreach ($result as $arr) {
            $productId  = $arr['product_id'];
            if (! isset($aProduct[$productId])) {
                continue;
            }
            $aProduct[$productId]['aDbcProduct']   = $arr;
        }
        
        $result     = dbcproducthandle_model::singleton()->getAllProductPrice();
        foreach ($result as $arr) {
            $id     = $arr['id'];
            $rel    = $arr['rel'];
            
            if ($rel == 'Product') {
                $productId  = $id;
                
                if (! isset($aProduct[$productId])) {
                    continue;
                }
                
                $aProduct[$productId]['aPrice'][$rel]   = array();
                
                unset($arr['id']);
                
                $aDbcProduct    = isset($aProduct[$productId]['aDbcProduct']) ? $aProduct[$productId]['aDbcProduct'] : array();
                $code           = isset($aDbcProduct['code']) ? $aDbcProduct['code'] : '';
                $unitPrice      = isset($aDbcProduct['dbc_unit_price']) ? $aDbcProduct['dbc_unit_price'] + 0 : 0;
                
                foreach ($arr as $k => $price) {
                    $price      = $price + 0;
                    $priceDbc   = 0;
                    $error      = 0;
                    
                    if ($k == 'm' && $code == 'MONTH') {
                        $priceDbc   = $unitPrice;
                        if ($price != $priceDbc) {
                            $error  = 1;
                        }
                    }
                    if ($k == 'a' && $code == 'YEAR') {
                        $priceDbc   = $unitPrice;
                        if ($price != $priceDbc) {
                            $error  = 1;
                        }
                    }
                    
                    $aProduct[$productId]['aPrice'][$rel][$k]   = array(
                        'error'     => $error,
                        'price'     => $price,
                        'price_dbc' => $priceDbc,
                        'unit_code' => $code,
                    );
                }
                
            }
        }
        
        $proceDbc   = 0;
        $error      = 0;
        $result     = dbcproducthandle_model::singleton()->getAllDomainPrice();
        foreach ($result as $arr) {
            $productId      = $arr['product_id'];
            $period         = $arr['period'];
            $price          = $arr['register'] + 0;
            
            if (! isset($aProduct[$productId])) {
                continue;
            }
            
            $rel        = 'Product';
            if (! isset($aProduct[$productId]['aPrice'][$rel])) {
                $aProduct[$productId]['aPrice'][$rel]  = array();
            }
            
            $aDbcProduct    = isset($aProduct[$productId]['aDbcProduct']) ? $aProduct[$productId]['aDbcProduct'] : array();
            $code           = isset($aDbcProduct['code']) ? $aDbcProduct['code'] : '';
            $unitPrice      = isset($aDbcProduct['dbc_unit_price']) ? $aDbcProduct['dbc_unit_price'] + 0 : 0;
            
            
            if ($period == 1) {
                $error      = ($unitPrice != $price) ? 1 : 0;
                $proceDbc   = $unitPrice;
            } else {
                $error      = 0;
                $proceDbc   = $unitPrice * $period;
            }
            
            $aProduct[$productId]['aPrice'][$rel][$period]   = array(
                'error'     => $error,
                'price'     => $price,
                'price_dbc' => $proceDbc,
                'unit_code' => $code,
            );
            
        }
        
        $dbcProductUrl  = $aConfig['DBC_WEB_URL']['value'] .'&page='. $this->aPage['item'];
        
        $this->template->assign('aCategory', $aCategory);
        $this->template->assign('aProducts', $aProduct);
        $this->template->assign('dbcProductUrl', $dbcProductUrl);
        
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function listCompany ($request)
    {
        $oInfo          = (object) array(
            'title'     => 'List company',
            'desc'      => '',
            );
        $this->template->assign('oInfo', $oInfo);
        
        $aConfig        = $this->module->configuration;
        
        $aCompany       = dbcproducthandle_library::singleton($aConfig)->getCompany();
        $this->template->assign('aCompany', $aCompany);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/list_company.tpl',array(), true);
    }
    
    public function sync ($request)
    {
        $oInfo          = (object) array(
            'title'     => 'Sync Products',
            'desc'      => '',
            );
        $this->template->assign('oInfo', $oInfo);
        
        $step       = isset($request['step']) ? $request['step'] : '';
        $aConfig    = $this->module->configuration;
        
        if ($step == 'sync') {
            
            $aItem      = dbcproducthandle_library::singleton($aConfig)->getAllItem();
            //echo '<pre>'.print_r($aItem,true).'</pre>'; 
            $result     = dbcproducthandle_model::singleton()->updateItem($aItem);
            
        } else {
            
            $result     = array_map('str_getcsv', file(APPDIR . 'modules/Other/dbcproducthandle/data/DBC_Product.csv'));
            $aProduct   = array();
            $aField     = array();
            foreach ($result as $i => $arr) {
                if ($arr[0] == 'dbc_no' && ! count($aField)) {
                    $aField     = array_flip($arr);
                }
                if (! count($aField)) {
                    continue;
                }
                $productKey         = $aField['product_id'];
                $itemKey            = $aField['dbc_no'];
                $itemNameKey        = $aField['dbc_description'];
                $hbNameKey          = $aField['product_name'];
                
                $productId      = $arr[$productKey] ? (int) $arr[$productKey] : $productId;
                if (! $productId) {
                    continue;
                }
                
                $dbcNo          = $arr[$itemKey] ? trim($arr[$itemKey]) : '';
                $dbcName        = $arr[$itemNameKey] ? $arr[$itemNameKey] : '';
                $hbName         = $arr[$hbNameKey] ? $arr[$hbNameKey] : '';
                
                if (! isset($aProduct[$productId])) {
                    $aProduct[$productId]   = array(
                        'productId'     => $productId,
                        'dbcNo'         => $dbcNo,
                        'dbcName'       => $dbcName,
                        'hbName'        => $hbName
                    );
                }
                
            }
            
            if (count($aProduct)) {
                dbcproducthandle_model::singleton()->setDbcProductActiveAll(0);
                foreach ($aProduct as $productId => $arr) {
                    $result     = dbcproducthandle_model::singleton()->addUpdate($arr);
                }
            }
        
        }
        
        $this->template->assign('step', $step);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/sync.tpl',array(), true);
    }
	
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
}