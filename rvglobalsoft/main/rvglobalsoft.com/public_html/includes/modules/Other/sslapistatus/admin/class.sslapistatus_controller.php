<?php

class sslapistatus_controller extends HBController {

    public function _default($request) {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$db = hbm_db();
        $oAuth =& RvLibs_SSL_PHPLibs::singleton();

        $active = '<font color="green">Active</font>';
        $inactive = '<font color="red">Inactive</font>';

        $info = $oAuth->apiConnectionInfo();
        if($info['mode'] == 'test'){
        	$info['mode'] = '<font color="green">Enable</font>';
        } else {
        	$info['mode'] = '<font color="red">Disable</font>';
        }
        $this->template->assign('symantecApiInfo', $info);

        // HELLO
        $hello = $oAuth->Hello('Active');

        if($hello['helloResult'] == 'Active'){
        	$this->template->assign('hello', $active);
        } else {
        	$this->template->assign('hello', $inactive);
        }



        // GET USER AGREEMENT
        $userAgreement = $oAuth->GetUserAgreement('SSL123', 'ORDERING');

        if(!$userAgreement['GetUserAgreementResult']['QueryResponseHeader']['SuccessCode'] && empty($userAgreement['GetUserAgreementResult']['QueryResponseHeader']['Errors'])){
        	$this->template->assign('userAgreement', $active);
        } else {
        	$this->template->assign('userAgreement', $inactive);
        }

        $cronQuery = $db->query("
        SELECT
        	id
        FROM
        	hb_modules_configuration
        WHERE
        	module LIKE '%ssl%'
        	AND type = 'Other'
        ")->fetchAll();
        $cronTask = array();
        foreach($cronQuery as $v){
        	$query = false;
        	$query = $db->query("SELECT name, lastrun FROM hb_cron_tasks WHERE task LIKE '%{$v['id']}%'")->fetch();
        	if($query){
        		$cronTask[] = array('name' => $query['name'], 'lastrun' => $query['lastrun']);
        	}
        }
        $this->template->assign('cronTask', $cronTask);

        $this->template->render(APPDIR_MODULES . 'Other' . '/sslapistatus/templates/admin/default.tpl', $request, true);

    }

}
?>
