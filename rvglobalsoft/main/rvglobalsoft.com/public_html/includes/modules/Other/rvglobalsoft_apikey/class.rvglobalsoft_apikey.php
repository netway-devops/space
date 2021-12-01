<?php 
require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';
require_once HBFDIR_LIBS . 'RvLibs/oAuth/RSA_SHA1.php';

class rvglobalsoft_apikey extends OtherModule
{
	protected $info = array(
			'haveadmin' => true,    //is module accessible from adminarea
			'haveuser' => true,     //is module accessible from client area
			'havelang' => false,     //does module support multilanguage
			'havetpl' => true,      //does module have template
			'havecron' => false,     //does module support cron calls
			'haveapi' => false,      //does module have functions accessible via api
			'needauth' => false,     //does module needs authorisation by clients to use it
			'isobserver' => false,   //is module an observer - must implement Observer interface!
			'clients_menu' => false, //should module be listed in adminarea->clients menu
			'support_menu' => true,  //should module be listed in adminarea->support menu
			'payment_menu' => false,  // should module be listed in adminarea->payments menu
			'orders_menu' => false,   //should module be listed in adminarea->orders menu
			'extras_menu' => false,    //should module be listed in extras menu
			'mainpage' => false,       //should module be listed in admin home screen and/or clientarea root screen
			'header_js' => false,     //does module have getHeaderJS function - add header javascript code to admin/clientarea
	);

	const NAME = 'rvglobalsoft_apikey';

	protected $filename='class.rvglobalsoft_apikey.php';
	protected $description='RV Global Soft API Key';
	protected $modname = 'RV Global Soft API Key';
	
	public function showapikey()
	{
		$apikey = '';
		$query = $this->db->prepare("
				SELECT 
					oc.usr_id AS usr_id
					, oc.key_phrase AS key_phrase
					, oc.billing_privatekey AS billing_privatekey
				FROM 
					hb_oauth_consumer AS oc,
					hb_client_access AS ca
				WHERE
					ca.id = oc.usr_id
					AND ca.email = 'reseller'
				 ");
		$query->execute();
		$aResKeyInfo = $query->fetchAll(PDO::FETCH_ASSOC); //fetching returned data
		$query->closeCursor(); //closing data cursor
		
		if (count($aResKeyInfo) < 1) {
			 $aAPIKeyInfo = $this->genNewKey();
		} else {
			$aAPIKeyInfo = $aResKeyInfo[0];
		}

		$aResData = array();
		
		$aResData['publickey'] = RVLibs_oAuth_RSA_SHA1::fecthPublickey($aAPIKeyInfo['billing_privatekey'], $aAPIKeyInfo['key_phrase']);
		
		if (is_writable(HBFDIR_LIBS . 'RvLibs/key.pem') && isset($output->shopapikey)) {
			$handle =fopen(HBFDIR_LIBS . 'RvLibs/key.pem', 'w+');
			fwrite($handle, $output->shopapikey);
			fclose($handle);
		} else {
			$aResData['warning'] = 'ไม่สามารถเขียนไฟล์ ' . HBFDIR_LIBS . 'RvLibs/key.pem ได้';
		}

		$aResData['apiconnection'] = $this->testAPIConnection();
		
		return $aResData;
	}
	
	private function genNewKey()
	{
		$keyPhrase = RVLibs_oAuth_RSA_SHA1::randomKeyPhrase(8);
		$bullingPrivatekey = RVLibs_oAuth_RSA_SHA1::newPrivatekey($keyPhrase);
		
		$query = $this->db->prepare("
			SELECT
				ca.id AS id
			FROM
				hb_client_access AS ca
			WHERE
				ca.email = 'reseller'
		");
		
		$query->execute();
		$aAcctInfo = $query->fetchAll(PDO::FETCH_ASSOC);
		$query->closeCursor(); //closing data cursor
		$resId = '1';
		
		if (isset($aAcctInfo[0]['id'])) {
			$resId = $aAcctInfo[0]['id'];
		}
		
		return array(
			'billing_privatekey' => $bullingPrivatekey,
			'key_phrase' => $keyPhrase,
		);
	}
	
	private function testAPIConnection()
	{
		$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
		$oRes = $oAuth->request('get', 'SessionTest');
		if (isset($oRes->AppSettings->admin_login->username) 
				&& $oRes->AppSettings->admin_login->username == $_SESSION['AppSettings']['admin_login']['username']) {
			return 'OK';
		} else {
			return 'Error!!';
		}
	}
	
	public function user_showapikey()
	{
		$sql = "
			SELECT
				oc.usr_id AS usr_id
				, oc.key_phrase AS key_phrase
				, oc.billing_privatekey AS billing_privatekey
				, oc.controlpanel_privatekey AS controlpanel_privatekey
			FROM
				hb_oauth_consumer AS oc,
				hb_client_access AS ca
			WHERE
				ca.id = oc.usr_id
				AND ca.id = '{$_SESSION['AppSettings']['login']['id']}'
		";
		
		$query = $this->db->prepare($sql);
		
		$query->execute();
		$aResKeyInfo = $query->fetchAll(PDO::FETCH_ASSOC);
		$query->closeCursor(); //closing data cursor

		if (count($aResKeyInfo) < 1) {
			$aAPIKeyInfo = $this->user_genNewKey();
		} else {
			$aAPIKeyInfo = $aResKeyInfo[0];
		}
		$aResData = array();
		
		$aResData['billing_accesskey'] = RVLibs_oAuth_RSA_SHA1::fecthPublickey($aAPIKeyInfo['billing_privatekey'], $aAPIKeyInfo['key_phrase']);
		$aResData['cp_accesskey'] = RVLibs_oAuth_RSA_SHA1::fecthPublickey($aAPIKeyInfo['controlpanel_privatekey'], $aAPIKeyInfo['key_phrase']);
		return $aResData;
	}
	
	public function user_genNewKey()
	{
		$keyPhrase = RVLibs_oAuth_RSA_SHA1::randomKeyPhrase(8);
		$bullingPrivatekey = RVLibs_oAuth_RSA_SHA1::newPrivatekey($keyPhrase);
		$cpPrivatekey = RVLibs_oAuth_RSA_SHA1::newPrivatekey($keyPhrase);
		
		$sql = "
				REPLACE INTO
					hb_oauth_consumer
					(usr_id, billing_privatekey, controlpanel_privatekey, key_phrase)
				VALUES
					(\"{$_SESSION['AppSettings']['login']['id']}\", \"{$bullingPrivatekey}\", \"{$cpPrivatekey}\", \"{$keyPhrase}\")
		";
	
		$query = $this->db->prepare($sql);
		$query->execute();
		$query->closeCursor();
		return array(
			'billing_privatekey' => $bullingPrivatekey,
			'controlpanel_privatekey' => $cpPrivatekey,
			'key_phrase' => $keyPhrase
		);
	}
	
	public function show_info($message='')
	{
		$this->addInfo($message);	
	}
	
}