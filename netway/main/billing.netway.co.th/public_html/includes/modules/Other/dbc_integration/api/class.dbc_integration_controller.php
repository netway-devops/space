<?php

require_once(APPDIR_MODULES . 'Other/dbc_integration/model/class.dbc_integration_model.php');
require_once(APPDIR_MODULES . 'Other/dbc_integration/webhook/class.dbc_integration_webhook.php');

class dbc_integration_controller extends HBController {

    public function apiCheckDBCIntegrationModule($request)
    {
        return array(true, array(
            'status'   => 'ok'
        ));
    }

    public function getConfiguration($request)
    {
        return array(true, array(
            'success'   => true,
            'configuration' => $this->module->configuration
        ));
    }

     /**
     * API For Get category detail
     * @params <array> $request;
     *                 $request = array(
     *                       'call'      => 'module',
     *                       'module'    => 'dbc_integration',
     *                       'fn'        => 'getProductDetail',
     *                       'id' => <string>, // Hostbill Product ID.
     *                 );
     * 
     */


    public function getProductDetail($request)
    {
        $productId  = isset($request['id']) ? $request['id'] : null;
        if (is_null( $productId )) {
            return array(false, array(
                'status'   => 'error',
                'message' => 'Product ID is empty.'
            ));
        } else {
            $action = '';
            $aProductDetail = dbc_integration_model::singleton()->getProducts($productId)->fetchAll();
            $aProduct = count($aProductDetail) > 0 ? $aProductDetail[0] : array();
            if (isset($aProduct['id'])) {
                if (isset($aProduct['revenue_group']) && isset($aProduct['line_group_id'])) {
                    $aProduct['dimensionCodeBU'] = dbc_integration_model::singleton()->genDimensionCodeBU($aProduct['id'], $aProduct['revenue_group'], $aProduct['line_group_id']);
                }
                if (isset($aProduct['stock']) && $aProduct['stock'] == 1) {
                    $aProduct['inventory'] = isset($aProduct['qty'])? $aProduct['qty'] : 0;
                } else {
                    $aProduct['inventory'] = 0;
                }

                $aProduct['realCodeName'] = dbc_integration_model::singleton()->genFullProductCode($aProduct['id']);

                $aDimensionQuery = dbc_integration_model::singleton()->getDimensionByName('Business Unit')->fetchAll();
                if (count($aDimensionQuery) > 0) {
                    $aProduct['dimensionBUId'] = $aDimensionQuery[0]['id'] ? $aDimensionQuery[0]['id'] : '';
                }

                if (empty(trim($aProduct['realCodeName']))) {
                    $action = 'skip';
                } else {
                    if (empty(trim($aProduct['dbcCategoryId']))) {
                        $action = 'create';
                    } else if ($aProduct['visible'] == -1) {
                        $action = 'block';
                    } else {
                        $action = 'edit';
                    }
                }
            }
            return array(true, array(
                'status'   => 'ok',
                'product' => $aProduct,
                'action' => $action
            ));
        }
    }

    /**
     * API For Get category detail
     * @params <array> $request;
     *                 $request = array(
     *                       'call'      => 'module',
     *                       'module'    => 'dbc_integration',
     *                       'fn'        => 'getProductCategoryDetail',
     *                       'id' => <string>, // Category ID.
     *                 );
     * 
     */
    
    public function getProductCategoryDetail($request)
    {
        $categoryId  = isset($request['id']) ? $request['id'] : null;
        if (is_null($categoryId)) {
            return array(true, array(
                'status' => 'error',
                'detail' => array(
                    'message' => 'Category ID is empty.'
                )
            ));
        } else {
            $aCategoryQueryResult = dbc_integration_model::singleton()->getCategoryDetail($categoryId)->fetchAll(); 
            
            $aResult = array();
            if (count($aCategoryQueryResult) > 0) {
                $aCategoryQueryResult = $aCategoryQueryResult[0];
                $aResult['id'] = $categoryId;
                $aResult['name'] = $aCategoryQueryResult['name'];
                $aResult['codeName'] = $aCategoryQueryResult['codeName'];
                $aResult['dbcCategoryId'] = $aCategoryQueryResult['dbcCategoryId'];
                if ( $aCategoryQueryResult['visible'] == -1) {
                    $aResult['action'] = 'delete';
                } else if (empty(trim($aResult['dbcCategoryId']))) {
                    $aResult['action'] = 'create';
                } else {
                    $aResult['action'] = 'update';
                }
                return array(true, array(
                    'status' => 'ok',
                    'detail' => $aResult
                ));
            } else {
                return array(true, array(
                    'status' => 'error',
                    'detail' => array(
                        'message' => 'Category ID ' . $categoryId . ' not found.'
                    )
                ));
            }
        }
    }
    
    /**
     * API For update UnitsOfMeasure
     * @params <array> $request;
     *                 $request = array(
     *                       'call'      => 'module',
     *                       'module'    => 'dbc_integration',
     *                       'fn'        => 'updateUnitsOfMeasure',
     *                       'id' => <string>, // unitsOfMeasure Row ID.
     *                       'code' => <string>, // unitsOfMeasure Code.
     *                       'displayName' => <string>, // unitsOfMeasure displayName.
     *                 );
     * 
     */
    public function getUnitsOfMeasure()
    {
        $aUnitsOfMeasure = dbc_integration_model::singleton()->getUnitsOfMeasure()->fetchAll();
        return array(true, array(
            'success'   => true,
            'unitsOfMeasure' => $aUnitsOfMeasure
        ));
    }
    
    public function updateUnitsOfMeasureID($request)
    {
        $oDB = hbm_db();
        $isSuccess = true;
        $message = '';
        $unitsOfMeasureId  = isset($request['id']) ? $request['id'] : '';
        $unitsOfMeasureCode  = isset($request['code']) ? $request['code'] : '';
        $unitsOfMeasuredisplayName  = isset($request['displayName']) ? $request['displayName'] : '';


        if ($unitsOfMeasureId == '') {
            $isSuccess = false;
            $message = 'Units of measure row ID is empty.';
        } else {
            $result = dbc_integration_model::singleton()->replaceUnitsOfMeasureByID($unitsOfMeasureId, array(
                'code' => $unitsOfMeasureCode,
                'displayName' => $unitsOfMeasuredisplayName
            ));

            if ($result == true) {
                $message = 'Units of measure row ID: ' . $unitsOfMeasureId . ' has updated.';
            } else {
                $isSuccess = false;
                $message = 'Updated Units of measure row ID: ' . $unitsOfMeasureId . ' has problem.';
            }
        }

        return array(true, array(
            'success'   => $isSuccess,
            'message' => $message
        ));
    }

    public function deleteUnitsOfMeasureID($request)
    {
        $oDB = hbm_db();
        $isSuccess = true;
        $message = '';
        $unitsOfMeasureId  = isset($request['id']) ? $request['id'] : '';

        if ($unitsOfMeasureId == '') {
            $isSuccess = false;
            $message = 'Units of measure row ID is empty.';
        } else {
            dbc_integration_model::singleton()->deleteUnitsOfMeasureByID($unitsOfMeasureId);
            $message = 'Units of measure row ID ' . $unitsOfMeasureId . ' has deleted.';
        }

        return array(true, array(
            'success'   => $isSuccess,
            'message' => $message
        ));
    }


    /**
     * updateDBCCategoryIdWithHBProductCategoryID
     * @params <array> $request;
     *                 $request = array(
     *                       'call'      => 'module',
     *                       'module'    => 'dbc_integration',
     *                       'fn'        => 'updateDBCCategoryIdWithHBProductCategoryID',
     *                       'id' => <string>, // Hostbill Category ID
     *                       'dbcCategoryId' => <string>, // DBC Category ID
     *                 );
     * 
     */
    public function updateDBCCategoryIdWithHBProductCategoryID($request)
    {
        $catId  = isset($request['id']) ? $request['id'] : '';
        $dbcCategoryId  = isset($request['dbcCategoryId']) ? $request['dbcCategoryId'] : '';
        if (!dbc_integration_model::singleton()->updateDBCCategoryIdWithProductCategoryID($catId, $dbcCategoryId)) {
            $status = false;
            $message = 'Have problem to update dbcCategoryId:' . $dbcCategoryId . ' in Hostbill product category record ID: ' . $catId . '!';
        } else {
            $status = true;
            $message = 'Updated dbcCategoryId:' . $dbcCategoryId . ' in Hostbill product category record ID: ' . $catId . ' has been successfuly.'; 
        }

        return array(true, array(
            'success'   => $status,
            'message' => $message
        ));
    }

    public function updateDBCItemIdWithProductId($request)
    {
        $hbProductId  = isset($request['id']) ? $request['id'] : '';
        $dbcItemId  = isset($request['dbcItemId']) ? $request['dbcItemId'] : '';
        $dbcUnitOfMeasureId  = isset($request['unitOfMeasureId']) ? $request['unitOfMeasureId'] : '';
        $dbcUnitOfMeasureCode  = isset($request['unitOfMeasureCode']) ? $request['unitOfMeasureCode'] : '';

        if (!dbc_integration_model::singleton()->updateDBCItemIdWithProductId($hbProductId, $dbcItemId, $dbcUnitOfMeasureId, $dbcUnitOfMeasureCode)) {
            $status = false;
            $message = 'Have problem to update dbcItemId:' . $dbcItemId . ' in Hostbill product record ID: ' . $hbProductId . '!';
        } else {
            $status = true;
            $message = 'Updated dbcItemId:' . $dbcItemId . ' in Hostbill product record ID: ' . $hbProductId . ' has been successfuly.'; 
        }

        return array(true, array(
            'success'   => $status,
            'message' => $message
        ));
    }

    /**
     * apiUpdateDBCItemIDByhbProductID
     * @params <array> $request;
     *                 $request = array(
     *                       'call'      => 'module',
     *                       'module'    => 'dbc_integration',
     *                       'fn'        => 'apiUpdateDBCItemIDByhbProductID',
     *                       'id' => <string>, // Hostbill Category ID
     *                       'dbcItemId' => <string>, // DBC Item Row ID
     *                 );
     * 
     */    
    public function apiUpdateDBCItemIDByhbProductID($request)
    {
        $hbProductId  = isset($request['id']) ? $request['id'] : '';
        $dbcItemId  = isset($request['dbcItemId']) ? $request['dbcItemId'] : '';
        $status = '';
        if (dbc_integration_model::singleton()->updateDBCItemIdByProductId($hbProductId, $dbcItemId)) {
            $status = 'ok';
            $message = 'Updated dbcItemId:' . $dbcItemId . ' to Hostbill product record ID: ' . $hbProductId . ' has been successfuly.'; 
        } else {
            $status = 'failed';
            $message = 'Have problem to update dbcItemId:' . $dbcItemId . ' to Hostbill product ID: ' . $hbProductId . '!';

        }
        return array(true, array(
            'status'   => $status,
            'message' => $message
        ));
    }

    public function apiUpdateDBCDimensionCodeBUIDByhbProductID($request)
    {
        $hbProductId  = isset($request['id']) ? $request['id'] : '';
        $dimensionCodeBUId  = isset($request['dimensionCodeBUId']) ? $request['dimensionCodeBUId'] : '';
        $status = '';
        if (!dbc_integration_model::singleton()->updateDBCDimensionCodeBUIDByhbProductID($hbProductId, $dimensionCodeBUId)) {
            $status = 'ok';
            $message = 'Updated dimensionCodeBUId:' . $dimensionCodeBUId . ' to Hostbill product ID: ' . $hbProductId . ' has been successfuly.'; 
        } else {
            $status = 'failed';
            $message = 'Have problem to update dimensionCodeBUId:' . $dimensionCodeBUId . ' to Hostbill product ID: ' . $hbProductId . '!';

        }
        return array(true, array(
            'status'   => $status,
            'message' => $message
        ));
    }


    /**
     * syncCategoryToDBC
     * @params <array> $request;
     *                 $request = array(
     *                       'call'      => 'module',
     *                       'module'    => 'dbc_integration',
     *                       'fn'        => 'syncCategoryToDBC',
     *                       'id' => <string>, // Category ID.
     *                 );
     * 
     */

    public function syncCategoryToDBC($request)
    {
        $hbCategoryId  = isset($request['id']) ? $request['id'] : null;
        $aResult = dbc_integration_webhook::singleton()->postCategoryToDBC($hbCategoryId);
        return array(true, $aResult);
    }

    public function syncProductToDBC($request)
    {
        $hbProductId  = isset($request['id']) ? $request['id'] : null;
        $aResult = dbc_integration_webhook::singleton()->postProductToDBC($hbProductId);
        return array(true, $aResult);
    }
    
    /**
     * Get SalesOrder Details by Invoice ID
     * @params <array> $request;
     *                  $request = array(
     *                       'call'      => 'module',
     *                       'module'    => 'dbc_integration',
     *                       'fn'        => 'apiGetSalesOrderDetailByInvoiceId',
     *                       'hb_invoice_id' => <integer>, // Hostbill invoice ID.
     *                 );
     * 
     * @return <array>; array(
     *      'SalesOrder' => array(
     *          'number' => 'SOD202100001'// <string> DBC SalesOrder Number
     *          'orderDate' => '2021-12-31', // <string> Order Date (format yyyy-mm-dd)
     *          'customerId' => '2A595410-5467-EA11-A813-000D3AA19217', //<string> DBC Customer Row ID
     *          'items' => array(
     *              // item 1
     *              array(
     *                 // item line;
     *                  array(
     *                     'lineType' => 'Item', // <string> DBC SalesOrder Line; The type of the sales order line. It can be "Comment", "Account", "Item", "Resource" Value", "Fixed Asset" or "Charge".
     *                      'description' => 'Linux VPS - Flexible', // <string> Specifies the description of the sales order line.
     *                      'itemId' => '3DC5C59A-4B47-EB11-BF6C-000D3AC8F2C9', // <string> The ID of the item in the sales order line.
     *                      'quantity' => 1, // <decimal> The quantity of the item in the sales order line.
     *                      'unitPrice' => '1799.00', // <decimal> Specifies the price for one unit of the item in the specified sales order line.
     *                      'discountAmount' => '0.00', // <decimal> The sales order line discount amount.
     *                      'type' => 'RENEW', // <string> NEW or RENEW เอาไปใช้ผูก dimensionSetLine
     *                  ) 
     *              )
     *          )
     *      )
     * )
     */
    public function apiGetSalesOrderDetailByInvoiceId($request)
    {

        $hbInvoiceId  = isset($request['hb_invoice_id']) ? $request['hb_invoice_id'] : null;
        $aResult = dbc_integration_model::singleton()->getSalesOrderDetailByInvoiceId($hbInvoiceId);

        if (isset($aResult['isError']) && $aResult['isError']) {
            return array(true, array(
                'status' => 'error',
                'detail' => array(
                    'message' => $aResult['message']
                )
            ));
        } else {
            return array(true, array(
                'status' => 'ok',
                'SalesOrderDatails' => isset($aResult['SalesOrder']) ? $aResult['SalesOrder'] : array()));
        }
    }

    public function hookCreateSalesOrder($request)
    {
        $hbInvoiceId  = isset($request['hb_invoice_id']) ? $request['hb_invoice_id'] : null;
        if (empty($hbInvoiceId)) {
            $status = 'failed';
            $message = 'Hostbill invoice ID is empty.';
        } else {
            $aResult = dbc_integration_webhook::singleton()->postCreateSalesOrderOnDBC('create', $hbInvoiceId);
            if ($aResult['isError']) {
                $status = 'failed';
                $message = $aResult['message'];
            } else {
                $status = 'ok';
                $message = 'Hostbill invoice ID is empty.';
            }
        }
        return array(true, array(
            'status'   => $status,
            'message' => $message
        ));
    }
}
