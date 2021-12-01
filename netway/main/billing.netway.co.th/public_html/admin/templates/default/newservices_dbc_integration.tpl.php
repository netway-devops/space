<?php
require_once(APPDIR . 'libs/hbapiwrapper/hbApiWrapper.php');
$oHBApiWrapper = new hbApiWrapper();

$isActiveModuleDBCIntegration = $oHBApiWrapper->moduleIsActive('dbc_integration');
$this->assign('isActiveModuleDBCIntegration', $isActiveModuleDBCIntegration);


if ($isActiveModuleDBCIntegration) {
    $aUnitsOfMeasure = $oHBApiWrapper->module(
        array(
            'call' => 'module', 
            'module' => 'dbc_integration', 
            'fn' => 'getUnitsOfMeasure'
        )
    );
    $this->assign('aUnitsOfMeasureList', isset($aUnitsOfMeasure['unitsOfMeasure']) ? $aUnitsOfMeasure['unitsOfMeasure'] : array());

    $aProduct   = $this->get_template_vars('product');
    //$oHBApiWrapper->getCategory('category_id');
    $aCategostDetail = $oHBApiWrapper->getCategory($aProduct['category_id']);
    $aProduct['category_detail'] = $aCategostDetail['category'];
    
    $aDBCProductDetail = $oHBApiWrapper->module(
        array(
            'call' => 'module', 
            'module' => 'dbc_integration', 
            'fn' => 'getProductDetail',
            'id' => $aProduct['id']
        )
    );
    if (isset($aDBCProductDetail['success']) && isset($aDBCProductDetail['product'])) {
        $aProduct['baseUnitOfMeasureId'] = $aDBCProductDetail['product']['baseUnitOfMeasureId'];
    }

    $this->assign('product', $aProduct);
}



