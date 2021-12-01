<?php
#@LICENSE@#
$item_id = isset($this->_tpl_vars['REQUEST']['id']) ? $this->_tpl_vars['REQUEST']['id'] : '5';
$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
$aSSLList = $oAuth->request('get', 'sslallitems', array('showby' => 'authority'));
$aAuthority = array();
$aInstallChk = array();
$aoSSLAuthority = (array) $aSSLList->authority;

foreach ($aoSSLAuthority as $k => $v) {
	$aAuthority[$k] = $v->authority_name;
	$aInstallChk[$k] = $v->install_check_url;
}

$aSSLValidation = (array) $aSSLList->validation;
$aSiteseal = (array) $aSSLList->siteseal;

/// Assign Values to Template
$this->assign('aGroup', $aAuthority);
$this->assign('aSSLValidation', $aSSLValidation);
$this->assign('aMultidomain', $aSSLList->multidomain);
$this->assign('aSSLItemList', $aSSLList->items);
$this->assign('activeItem', $item_id);
$this->assign('aSiteseal', $aSiteseal);
$this->assign('aInstallChk', $aInstallChk);

