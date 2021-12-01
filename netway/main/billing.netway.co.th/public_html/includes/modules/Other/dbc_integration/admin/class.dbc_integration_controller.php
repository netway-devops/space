<?php
require_once(APPDIR_MODULES . 'Other/dbc_integration/model/class.dbc_integration_model.php');
require_once(APPDIR_MODULES . 'Other/dbc_integration/webhook/class.dbc_integration_webhook.php');

class dbc_integration_controller extends HBController {
    private static  $instance;
    private $isProduction = 1;
    private $leftMenus = array(
        array('id' => 'productcategories', 'name' => 'Product Categories'),
        array('id' => 'product', 'name' => 'Products'),
        array('id' => 'unitofmeasure', 'name' => 'Unit of Measure'),
        //array('id' => 'salesorder', 'name' => 'Sales Order'),*/
    );

    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }

    public function getModuleConfiguration()
    {
        return $this->module->configuration;
    }
    
    public function beforeCall ($request)
    {
        try {
            $api = new ApiWrapper();
            $this->template->assign('aLeftMenus', $this->leftMenus);
            $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
            $this->template->assign('tplClientPath', MAINDIR . 'templates/');    
        } catch (Exception $error) {
            //$this->addError($error->getMessage());
            return false;
        }
    }
    
    public function _default($request)
    {
        try {
            if (isset($request['urlconfigs']) && count($request['urlconfigs']) > 0) {
                foreach ($request['urlconfigs'] as $id => $url) {
                    if (preg_match('/^$/i', trim($url)) == false) {
                        dbc_integration_model::singleton()->updateWebhooks($id, trim($url));
                    }
                }
            }
            $this->template->assign('aWebhooksList', dbc_integration_model::singleton()->getWebhooks()->fetchAll());
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
        } catch (Exception $error) {
            $this->addError($error->getMessage());
            return false;
        }
    }

    public function productcategories($request)
    {
        try {
            $this->template->assign('aProductCategoriesList', dbc_integration_model::singleton()->getProductCategories()->fetchAll());
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/productcategories.tpl',array(), true);
        } catch (Exception $error) {
            $this->addError($error->getMessage());
            return false;
        }
    }

    public function product($request)
    {
        try {
            $this->template->assign('aProductList', dbc_integration_model::singleton()->getProducts()->fetchAll());
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/products.tpl',array(), true);
        } catch (Exception $error) {
            $this->addError($error->getMessage());
            return false;
        }
    }

    public function salesorder($request)
    {
        try {
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/salesorder.tpl',array(), true);
        } catch (Exception $error) {
            $this->addError($error->getMessage());
            return false;
        }
    }

    public function getUnitsOfMeasure()
    {
        return dbc_integration_model::singleton()->getUnitsOfMeasure()->fetchAll();
    }

    public function unitofmeasure($request)
    {
        try {
            $this->template->assign('aUnitsOfMeasureList', $this->getUnitsOfMeasure());
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/unitofmeasure.tpl',array(), true);
        } catch (Exception $error) {
            $this->addError($error->getMessage());
            return false;
        }
    }

    public function update_cateroty_to_DBC($request)
    {
        try {
            $catid = isset($request['catid']) ? $request['catid'] : null;
            
            
            if (is_null($catid)) {
                throw new Exception("Category ID is empty.");
            } else {
                $aResult = dbc_integration_webhook::singleton()->postCategoryToDBC($catid);
                $this->loader->component('template/apiresponse', 'json');
                $this->json->assign('data', $aResult);
                $this->json->show();
            }
        } catch (Exception $ex) {
            $this->addError($ex->getMessage(), true);
            return false;
        }
    }

    public function update_product_to_DBC($request)
    {
        try {
            $productId = isset($request['pid']) ? $request['pid'] : null;
            if (is_null($productId)) {
                throw new Exception("Product ID is empty.");
            } else {
                $aResult = dbc_integration_webhook::singleton()->postProductToDBC($productId);
                $this->loader->component('template/apiresponse', 'json');
                $this->json->assign('data', $aResult);
                $this->json->show();
            }
        } catch (Exception $ex) {
            $this->addError($ex->getMessage(), true);
            return false;
        }
    }

    public function ajaxValidateCategoryCodename($request) 
    {
        $codeName  = (isset($request['codename']) && trim($request['codename']) != '') ? $request['codename'] : null;
        if (is_null($codeName)) {
            $this->addError('Category code name is empty!', true);
        } else {
            try {
                $aCatCode = dbc_integration_model::singleton()->getCategoryCodeByName($codeName)->fetchAll();
                $aResult = array();
                if (count($aCatCode) > 0) {
                    $aResult =  array(
                        'isError' => false,
                        'available' => false
                    );
                } else {
                    $aResult=  array(
                        'isError' => false,
                        'available' => true
                    );
                }
                $this->loader->component('template/apiresponse', 'json');
                $this->json->assign('data', $aResult);
                $this->json->show();
            } catch (Exception $error) {
                $this->addError($error->getMessage(), true);
            }
        }
    }

    public function ajaxUpdateCodenameToCategoryID($request) 
    {
        $catID  = isset($request['cat_id']) ? $request['cat_id'] : null;
        $codeName  = (isset($request['codename']) && trim($request['codename']) != '') ? $request['codename'] : null;
        if (is_null($catID)) {
            $this->addError('Category ID is empty!', true);
        } else if (is_null($codeName)) {
            $this->addError('Category code name is empty!', true);
        } else {
            try {
                dbc_integration_model::singleton()->updateCategoryCodename($catID, $codeName);
                $aData = array(
                    'isError' => false,
                    'message' => 'Update codename for category ID: ' . $catID . ' has been successfully.'
                );
                $this->loader->component('template/apiresponse', 'json');
                $this->json->assign('data', $aData);
                $this->json->show();
            } catch (Exception $error) {
                $this->addError($error->getMessage(), true);
            }
        }
    }

    public function genDimensionCodeBUByProdictID($request)
    {
        $productID  = isset($request['p_id']) ? $request['p_id'] : null;
        if (is_null($productID)) {
            $this->addError('Product ID is empty!', true);
        } else {
            $revenueGroup  = isset($request['revenue_group']) && trim($request['revenue_group']) != '' 
                                ? $request['revenue_group'] 
                                : null;
            $lineGroup  = isset($request['line_group']) && trim($request['line_group']) != '' 
                                ? $request['line_group'] 
                                : null;
            try {
                $dimensionCodeBU = dbc_integration_model::singleton()->genDimensionCodeBU($productID, $revenueGroup, $lineGroup);
                $this->loader->component('template/apiresponse', 'json');
                $this->json->assign('dimensionCodeBU', $dimensionCodeBU);
                $this->json->show();
            } catch (Exception $error) {
                $this->addError($error->getMessage(), true);
            }
        }
    }

    public function updateDBCInfo2Product($request)
    {
        $productID  = isset($request['pid']) ? $request['pid'] : null;
        $productCodename  = isset($request['codename']) ? $request['codename'] : null;
        $uom  = isset($request['uom']) ? $request['uom'] : null;
        $itemType  = isset($request['item_type']) ? $request['item_type'] : null;
        $revenueGroup  = isset($request['revenue_group']) ? $request['revenue_group'] : null;
        $lineGroupId  = isset($request['line_group_id']) ? $request['line_group_id'] : null;
        try {
            if (is_null($productID) || empty($productID)) {
                throw new Exception('Prodoct ID is empty.');
            }

            if (!is_null($productCodename) && !empty($productCodename)) {
                dbc_integration_model::singleton()->updateProductCodename($productID, $productCodename);
            }

            if (!is_null($revenueGroup) && !empty($revenueGroup)) {
                dbc_integration_model::singleton()->updateRevenueGroup($productID, $revenueGroup);
            }

            if (!is_null($lineGroupId) && !empty($lineGroupId)) {
                dbc_integration_model::singleton()->updateLineGroupId($productID, $lineGroupId);
            }

            if (!is_null($itemType) && !empty($itemType)) {
                dbc_integration_model::singleton()->updateItemType($productID, $itemType);
            }

            if (!is_null($uom) && !empty($uom)) {
                $aUOMResult = dbc_integration_model::singleton()->getUnitsOfMeasure($uom)->fetchAll();
                $aProductResult = dbc_integration_model::singleton()->getProducts($productID)->fetchAll();

                if (count($aUOMResult) > 0 && count($aProductResult) > 0) {
                    $uomCode = $aUOMResult[0]['code'];
                    $dbcItemId = $aProductResult[0]['dbcItemId'];
                    dbc_integration_model::singleton()->updateDBCItemIdWithProductId($productID, $dbcItemId, $uom, $uomCode);
                }
                $aProductResult = $aProductResult[0];
            }

            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('success', true);
            $this->json->assign('message', 'Updated DBC infomation to product has been successfully.');
            $this->json->show();

        } catch (Exception $error) {
            $this->addError($error->getMessage(), true);
        }
    }


    public function addError($message, $json = false) 
    {
        if (!$json) {
            $this->template->assign('message', $message);
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/error.tpl',array(), true);
        } else {
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', array('isError' => true, 'message' => $message));
            $this->json->show();
        }
    }

}
