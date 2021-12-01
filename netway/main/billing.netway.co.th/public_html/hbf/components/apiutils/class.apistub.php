<?php



/**



 * License check, check for branding and other options.



 * Bit dirty, but noone should look here



 * @author Kris Pajak <kris.p@hostbillapp.com>



 */

class APIStub extends HBModel {



	/**



     * Return license activation code



     */

	public function activation() {

		$stamp = HBConfig::getConfig("LActivation");

		if (!$stamp) {

			$license = HBConfig::getConfig("License");

			$d = HBLoader::LoadComponent("ApiUtils", array("nocache" => true));

			$license = $d->base64d($license);

			$license = explode("\$|\$", $d->d(substr($license, 0, 10), substr($license, 10, -1)));

			if (isset($license[1]) && $license[1] != "") {

				list(, $stamp) = $license;

			}

			HBConfig::setConfig("LActivation", $stamp);

		}

		return $stamp;

	}





	/**



     * Check if we need to show branding.



     * For performance, check HBConfig::getConfig('CSRF_Stamp') first, if  not avilable  use ApiUtils



     */

	public function branding() {

		$stamp = HBConfig::getConfig("CSRF_Stamp");

		if (!$stamp) {

			$license = HBConfig::getConfig("License");

			$d = HBLoader::LoadComponent("ApiUtils", array("nocache" => true));

			$license = $d->base64d($license);

			$license = explode("\$|\$", $d->d(substr($license, 0, 10), substr($license, 10, -1)));

			if (isset($license[10]) && $license[10] == "0") {

				$stamp = md5("0");

			}

			else {

				$stamp = md5("1");

			}

			HBConfig::setConfig("CSRF_Stamp", $stamp, true);

		}

		if ($stamp == md5("1")) {

			return false;

		}

		return false;

	}





	/**



     * Check if product id is set to trial



     * For performance, check HBConfig::getConfig('CSRF_Hash') first, if not available use ApiUtils



     */

	public function trial() {

		$stamp = HBConfig::getConfig("CSRF_Hash");

		if (!$stamp) {

			$license = HBConfig::getConfig("License");

			$d = HBLoader::LoadComponent("ApiUtils", array("nocache" => true));

			$license = $d->base64d($license);

			$license = explode("\$|\$", $d->d(substr($license, 0, 10), substr($license, 10, -1)));

			if (isset($license[11]) && $license[11] == "3") {

				$stamp = md5("1");

			}

			else {

				$stamp = md5("0");

			}

			HBConfig::setConfig("CSRF_Hash", $stamp, true);

		}

		if ($stamp == md5("1")) {

			return true;

		}

		return false;

	}





	/**



     * Check for product ID



     * For performance, check HBConfig::getConfig('CSRF_Enable') first, if not available use ApiUtils



     */

	public function pid() {

		$stamp = HBConfig::getConfig("CSRF_Enable");

		if (!$stamp) {

			$license = HBConfig::getConfig("License");

			$d = HBLoader::LoadComponent("ApiUtils", array("nocache" => true));

			$license = $d->base64d($license);

			$license = explode("\$|\$", $d->d(substr($license, 0, 10), substr($license, 10, -1)));

			if (isset($license[11])) {

				list(, , , , , , , , , , , $stamp) = $license;

			}

			else {

				$stamp = "3";

			}

			HBConfig::setConfig("CSRF_Enable", $stamp, true);

		}

		return $stamp;

	}





	static private function paraseDomain($d) {

		$d = trim(strtolower($d));

		if (strpos($d, "www.") === 0) {

			return substr($d, 4);

		}

		return $d;

	}





	/**



     * Adminarea license check



     */

	public function lc($params) {

		if (Controller::isAjax()) {

			return true;

		}

		$license = HBConfig::getConfig("License");

		$licensing_server = "";

		if (isset($params["licenseerror"])) {

			$params["licenseerror"] = substr($params["licenseerror"], 0, 1);

		}

		if (isset($params["licenseerror"]) && $params["licenseerror"] == "") {

			// (Remove AutoLogout) HBLoader::LoadComponent("Authorization/AdminAuthorization")->logout();

			$d = HBLoader::LoadComponent("ApiUtils", array("nocache" => true));

			$licarr = array();

			$numtries = 0;

			if ($license !== false && $license != "") {

				$l = $d->base64d($license);

				$numtries = (int)substr($l, -1);

				$licarr = explode("\$|\$", $d->d(substr($l, 0, 10), substr($l, 10, -1)));

				$d->clean();

				if (is_array($licarr) && 3 < count($licarr)) {

					list(, , , $licstat) = $licarr;

				}

				else {

					$licstat = "pending";

					$licarr = array();

					$numtries = 0;

				}

			}

			$numaccounts = 0;

			if (empty($licarr)) {

				$licarr = implode("\$|\$", array("", "", "pending", self::paraseDomain($_SERVER["HTTP_HOST"]), $_SERVER["SERVER_ADDR"] ? $_SERVER["SERVER_ADDR"] : $_SERVER["LOCAL_ADDR"], date("Y-m-d"), date("Y-m-d"), date("Y-m-d"), MAINDIR, $numaccounts));

			}

			else {

				$licarr2 = $licarr;

				$licarr = implode("\$|\$", array("", "", "pending", self::paraseDomain($_SERVER["HTTP_HOST"]), $_SERVER["SERVER_ADDR"] ? $_SERVER["SERVER_ADDR"] : $_SERVER["LOCAL_ADDR"], date("Y-m-d"), date("Y-m-d"), date("Y-m-d"), MAINDIR, $numaccounts));

				$licarr2 = implode("\$|\$", $licarr2);

			}

			$k = $d->generateKey();

			$lic2 = $d->base64e($k . $d->e($k, $licarr));

			$query_string = "checkl=" . $lic2;

			$ch = curl_init();

			curl_setopt($ch, CURLOPT_URL, $licensing_server);

			curl_setopt($ch, CURLOPT_POST, 1);

			curl_setopt($ch, CURLOPT_TIMEOUT, 10);

			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

			curl_setopt($ch, CURLOPT_POSTFIELDS, $query_string);

			$data = curl_exec($ch);

			curl_close($ch);

			$success = false;

			if ($data !== false) {

				$d->clean();

				$data = $d->base64d($data);

				$k = explode("\$|\$", $d->d(substr($data, 0, 10), substr($data, 10)));

				$d->clean();

				if (is_array($k) && 3 < count($k)) {

					$success = true;

				}

			}

			if (!$success) {

				if (2 < $numtries && strtolower($licstat) != "active") {

					$q = $this->db->prepare("UPDATE hb_configuration SET value='' WHERE setting='License'");

					$q->execute();

					$success = true;

				}

				else {

					if ($numtries < 9) {

						++$numtries;

					}

					$d->clean();

					$k = $d->generateKey();

					if ($licarr2) {

						$lic = $d->base64e($k . $d->e($k, $licarr2) . $numtries);

					}

					else {

						$lic = $d->base64e($k . $d->e($k, $licarr) . $numtries);

					}

					$q = $this->db->prepare("UPDATE hb_configuration SET value=? WHERE setting='License'");

					$q->execute(array($lic));

					$success = true;

				}

			}

			else {

				$numtries = 0;

				$key = $d->generateKey();

				$license = $d->e($key, implode("\$|\$", $k));

				$d->clean();

				$license = $d->base64e($key . $license . $numtries);

				$q = $this->db->prepare("UPDATE hb_configuration SET value=? WHERE setting='License'");

				$q->execute(array($license));

				HBConfig::setConfig("CSRF_Stamp", "", true);

				HBConfig::setConfig("CSRF_Hash", "", true);

				if ($k[2] == "active") {

					Utilities::redirect("index.php");

				}

				else {

					if ($k[2] == "pending") {

						//Utilities::redirect("index.php?licenseerror=89");

					}

					else {

						if ($k[2] == "expired") {

							//Utilities::redirect("index.php?licenseerror=90");

						}

						else {

							if ($k[2] == "suspended") {

								//Utilities::redirect("index.php?licenseerror=91");

							}

							else {

								if (stripos($k[2], "|") !== false) {

									$dx = explode("|", $k[2]);

									Utilities::redirect("index.php?licenseerror=1&d=" . $dx[1]);

								}

								//Utilities::redirect("index.php?licenseerror=92");

							}

						}

					}

				}

			}

		}

		else {HBConfig::setConfig("LicenseDetails", array("to" => "Owned-770e3e7a2936733", "expires" => "Asla"));}

		return true;

	}





	

}
