<?php
class SSLApiMgr
{
	public function __construct()
	{

	}

	public function &singleton($autoload=false)
	{
		static $instance;
		// If the instance is not there, create one
		if (!isset($instance) || $autoload) {
			$class = __CLASS__;
			$instance = new $class();
		}
		return $instance;
	}

	public function decodecsr($request)
	{
		/*include_once(APPDIR_MODULES . "Hosting/ssl/include/common/SSLCommon.php");
		$csrData = $request['csrData'];
		$ssl_id = $request['ssl_id'];
		$oSSLCommon = &new SSLCommon;
		$aCSRInfo = $oSSLCommon->csrDecoder($csrData);

		if (isset($aCSRInfo['status']) && $aCSRInfo['status'] == 'ERROR') {
			return $aCSRInfo;
		} else {
			$aCsrValidation = $oSSLCommon->csrValidation($aCSRInfo, $ssl_id);
			if (isset($aCsrValidation['status']) && $aCsrValidation['status'] == 'ERROR') {
				return $aCsrValidation;
			}
			file_put_contents('/home/panya/public_html/manage.netway.co.th/public_html/a.txt', print_r($aCSRInfo, true));
            file_put_contents('/home/panya/public_html/manage.netway.co.th/public_html/b.txt', print_r($aCsrValidation, true));
			return array(
				'status' => 'success',
				'csrData' => $aCSRInfo,
				'validateData' => $aCsrValidation
			);
		}*/
		require_once(HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php');
        $oAuth =& RvLibs_SSL_PHPLibs::singleton();

        $csrDecodeData = $oAuth->ParseCSR($request['csrData']);

        return array(
                'status' => 'success',
                'csrData' => $csrDecodeData,
                'validateData' => array()
            );
	}

	public function getwhoisdomain($request)
	{
		$domain = $request['domain'];
		require_once(HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php');
		$oAuth =& RvLibs_SSL_PHPLibs::singleton();
		$aSSLList = $oAuth->GetWhoisByDomain($domain);
		return $aSSLList;
	}
}

