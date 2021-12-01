<?php 
class SSLCommon
{
	public function csrDecoder($csrData=null)
	{
		if (!is_writable(MAINDIR . 'templates_c')) {
			return array(
					'status' => 'ERROR',
					'message' => 'Cannot writable tmp dir.'
			);
		} elseif (!file_exists(MAINDIR . 'templates_c/csr_tmp') && !mkdir(MAINDIR . 'templates_c/csr_tmp')) {
			return array(
					'status' => 'ERROR',
					'message' => 'Cannot make tmp dir.'
			);
		} elseif (!is_writable(MAINDIR . 'templates_c/csr_tmp')) {
			return array(
					'status' => 'ERROR',
					'message' => 'Cannot writable tmp dir.'
			);
		} elseif (is_null($csrData) || $csrData == '') {
			return array(
					'status' => 'ERROR',
					'message' => 'Required CSR.'
			);
		} elseif (!preg_match('/^-----BEGIN ([a-z0-9]+ )?CERTIFICATE REQUEST-----.*?-----END ([a-z0-9]+ )?CERTIFICATE REQUEST-----$/si', trim($csrData))) {
			return array(
					'status' => 'ERROR',
					'message' => 'Wrong current CSR.'
			);
		} else {
			$filename = "csr_" . md5(time() . rand(10,100)) . '.crt';
			$saveTo = MAINDIR . 'templates_c/csr_tmp/' . "{$filename}";
			$handle = fopen($saveTo, "w");

			if (!$handle) {
				return array(
						'status' => 'ERROR',
						'message' => 'Cannot write to ' . $saveTo
				);
			}

			fwrite($handle, trim($csrData));
			fclose($handle);
			$outTo = preg_replace('/\.crt$/si', '.out', $saveTo);
			system("openssl req -text -in {$saveTo} -out {$outTo} ", $retval);
			unlink($saveTo);
			$aLine = file($outTo);
			//unlink($outTo);

			$aCSRData = self::csrOutToArray($aLine);

			if (count($aCSRData) <= 0) {
				return array(
						'status' => 'ERROR',
						'message' => 'Cannot decode CSR data'
				);
			}
			return $aCSRData;
		}
	}

	private	function csrOutToArray($aLine)
	{
		$aData = array();
		foreach ($aLine as $k => $v) {
			$line = trim($v);
			if (preg_match('/^Subject:(.*?)$/', $line, $aMatch)) {
				$subject = $aMatch[1] . ',';
				preg_match_all('/.*?=.*?[^,],/si', $subject, $aSubject);
				foreach ($aSubject[0] as $k=>$v) {
					$v = preg_replace('/,$/','',$v);
					if (!preg_match('/,/si', $v, $amatchinline)) {
						$aValue = preg_split('/=/', $v);
						$aData[trim($aValue[0])] = trim($aValue[1]);
					} else {
						preg_match('/(.*),(.*?)$/si', $v, $amatchinline);
						$aValue = preg_split('/=/', $amatchinline[1]);
						$aData[trim($aValue[0])] = trim($aValue[1]);
						if (isset($amatchinline[2])) {
							$aValue = preg_split('/=/', $amatchinline[2]);
							$aData[trim($aValue[0])] = trim($aValue[1]);
						}

					}
					
					$aValue = preg_split('/=/', $v);
					$aData[trim($aValue[0])] = trim($aValue[1]);
					if (trim($aValue[0]) == 'CN') {
						$commonName = $aData[trim($aValue[0])];
						$commonName = preg_replace('/^http:\/\/|https:\/\//si', '', $commonName);
						$aURL = parse_url('http://' . $commonName);
						$aData[trim($aValue[0])] = $aURL['host'];
					}
				}
			} else if (preg_match('/^Public Key Algorithm:(.*?)$/', $line, $aMatch)) {
				$aData["KeyAlgorithm"] = $aMatch[1];
			} else if (preg_match('/Public Key: \((.*?)\)$/', $line, $aMatch) || preg_match('/Public-Key: \((.*?)\)$/', $line, $aMatch)) {
				$aData["KeyLength"] = $aMatch[1];
			} else if (preg_match('/^Signature Algorithm:(.*?)$/', $line, $aMatch)) {
				$aData["SignatureAlgorithm"] = $aMatch[1];
				$aData["Signature"] = 'Verified';
			}
		}
		return $aData;
	}

	public function csrValidation($aCsrData=array(), $sslId=null)
	{
		include_once(APPDIR_MODULES . "Hosting/ssl/include/common/SSLDao.php");
		$oSSLDao =& SSLDao::singleton();

		$aError = array();

		if (count($aCsrData) <= 0 ) {
			return array(
					'status' => 'ERROR',
					'message' => 'Cannot decode CSR data'
			);
		}

		if (is_null($sslId) || $sslId == '') {
			return array(
					'status' => 'ERROR',
					'message' => 'Not founf SSL ID'
			);
		}

		$oSSLInfo = $oSSLDao->getSSL(array('ssl_id' => $sslId));
		$aSSLValidation = $oSSLDao->getSSLValidation();
		$aCSRReqKey = array('CN', 'O', 'OU', 'L', 'ST', 'C', 'KeyAlgorithm', 'KeyLength', 'Signature');
		$aSSLInfo = $oSSLInfo;
		foreach ($aCSRReqKey as $v) {
			if (array_key_exists($v, $aCsrData) === false) {
				if ($v == 'OU') continue;
				$aError[$v] = array(
						'status' => 'ERROR',
						'message' => "{$v} fill in required data",
				);
			} else {
				switch ($v)
				{
					case 'CN':
						if (preg_match('/^\*/si', $aCsrData[$v])) {
							switch ($aSSLInfo[0]['ssl_multidomain_id'])
							{
								case 1: case 2:
									$aError[$v] = array(
										'error' => true,
										'message' => "Cannot usage \"*.domain\" in \"{$aSSLInfo[0]['ssl_name']}\"",
									);
									break;
							}
						}
						break;
					case 'O':
						break;
					case 'OU':
						break;
					case 'L':
						break;
					case 'ST':
						break;
					case 'C':
						if ($aCsrData[$v] != strtoupper($aCsrData[$v])) {
							$aError[$v] = array(
									'error' => true,
									'message' => "Cannot usage lowercase in country code.",
							);
						}
						break;
					case 'KeyAlgorithm':
						break;
					case 'KeyLength':
						$csrLength = (int) $aCsrData[$v];
						$reqLength = (int) $oSSL->key_length;
						if ($csrLength < $reqLength) {
							$aError[$v] = array(
									'error' => true,
									'message' => "Your Key Size is too small.
									SSL certificates will be required to have a key length of {$oSSL->key_length} or greater.",
							);
						}
						break;
					case 'Signature':
						break;
				}
			}
		}
		return $aError;
	}
}