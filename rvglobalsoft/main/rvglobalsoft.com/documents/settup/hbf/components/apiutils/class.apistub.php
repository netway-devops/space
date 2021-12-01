<?php
	/* #####################################
		HOSTBILL v4.0.4 NULLED BY FLIPMODE!
		 RELEASE DATE: 2012.11.02
		 NULLED! DATE: 2012.11.05
		
		CONTRIBUTORS:
			'Mr Z...' & 'Trawis'
		
		FIND GENUINE RELEASES @
		 > WWW.YAGBU.NET
		 > WWW.PORTALIZ.COM
		 > WWW.FORUMSCRIPTZ.ORG
	##################################### */

class APIStub{ /* #### extends HBModel{ #### */
/* ####
	public function activation(){
		$stamp = ("LActivation");
		if (!$stamp){
			$license = ("License");
			$d = ("ApiUtils", array("nocache" => true));
			$license = $d->base64d($license);
			$license = explode("$|\$", $d->d(substr($license, 0, 10), substr($license, 10, 0 - 1)));
			if (isset($license[1]) && $license[1] != ""){
				$stamp = $license[1];
			}
			("LActivation", $stamp);
		}
		return $stamp;
	}
#### */

	public function branding(){
	/* ####
		$stamp = ("CSRF_Stamp");
		if (!$stamp){
			$license = ("License");
			$d = ("ApiUtils", array("nocache" => true));
			$license = $d->base64d($license);
			$license = explode("$|\$", $d->d(substr($license, 0, 10), substr($license, 10, 0 - 1)));
			if (isset($license[10]) && $license[10] == "0"){
				$stamp = md5("0");
			}
			else{
				$stamp = md5("1");
			}
			("CSRF_Stamp", $stamp, true);
		}
		if ($stamp == md5("1")){
			return true;
		}
		return false;
	#### */
	}
	public function trial(){
	/* ####
		$stamp = ("CSRF_Hash");
		if (!$stamp){
			$license = ("License");
			$d = ("ApiUtils", array("nocache" => true));
			$license = $d->base64d($license);
			$license = explode("$|\$", $d->d(substr($license, 0, 10), substr($license, 10, 0 - 1)));
			if (isset($license[11]) && $license[11] == "3"){
				$stamp = md5("1");
			}
			else{
				$stamp = md5("0");
			}
			("CSRF_Hash", $stamp, true);
		}
		if ($stamp == md5("1")){
			return true;
		}
		return false;
	#### */
	}
	public function pid(){
	/* ####
		$stamp = ("CSRF_Enable");
		if (!$stamp){
			$license = ("License");
			$d = ("ApiUtils", array("nocache" => true));
			$license = $d->base64d($license);
			$license = explode("$|\$", $d->d(substr($license, 0, 10), substr($license, 10, 0 - 1)));
			if (isset($license[11])){
				$stamp = $license[11];
			}
			else{
				$stamp = "3";
			}
			("CSRF_Enable", $stamp, true);
		}
		return $stamp;
	#### */
	}
	private static function paraseDomain($d){
		$d = trim(strtolower($d));
		if (strpos($d, "www.") === 0){
			return substr($d, 4);
		}
		return $d;
	}
	public function lc($params){
	/* ####
		$license = ("License");
		$licensing_server = "http://hostbillapp.com/clientarea/license.php";
	#### */
	
	/* #### TRIMMED CODE.... #### */
	
	/* ####
		$x = $license[7];
		if (strpos($x, "2030") !== false){
			$license[7] = "Never";
		}
	#### */
		
		/* #### ADDED LICENCE LINK #### */
		require_once (MAINDIR . "includes/My_Flipping_HostBill_Licence.php"); /* #### MAINDIR = RELATIVE PATH: ../../../../includes/ #### */
		
	/* #### TRIMMED CODE.... #### */
				
		HBConfig::setconfig("LicenseDetails", array("to" => $license[0], "expires" => $license[7])); 
		return true;
	}
}
?>