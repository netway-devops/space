<?php
#@LICENSE@#
$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
$item_id = isset($this->_tpl_vars['REQUEST']['id']) ? $this->_tpl_vars['REQUEST']['id'] : '1';
$aSSLList = $oAuth->request('get', 'sslallitems', array('showby' => 'validation'));
$aAuthority = array();
$aInstallChk = array();
$aoSSLAuthority = (array) $aSSLList->authority;

foreach ($aoSSLAuthority as $k => $v) {
	$aAuthority[$k] = $v->authority_name;
	$aInstallChk[$k] = $v->install_check_url;
}
$aGroup = (array) $aSSLList->validation;
$aSiteseal = (array) $aSSLList->siteseal;

$this->assign('aGroup', $aGroup);
$this->assign('aSSLAuthority', $aAuthority);
$this->assign('aMultidomain', $aSSLList->multidomain);
$this->assign('aSSLItemList', $aSSLList->items);
$this->assign('activeItem', $item_id);
$this->assign('aSiteseal', $aSiteseal);
$this->assign('aInstallChk', $aInstallChk);
