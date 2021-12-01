<?php



class Ubi_wrapper {

    private $user;
    private $password;
    private $temp_cookie=false;
    private $cookiename;

	public function __construct($url,$username,$password) {
		$this->url = "https://".$url.":6443/";
		$this->user = $username;
        $this->password = $password;
        $this->cookiename = 'ubiqiti_'.md5($this->url.$this->user.$this->password);
        $this->temp_cookie =  \HBCache::get($this->cookiename);
	}


    /**
     * Authenticate with observium
     * @return bool
     * @throws Exception
     */
	private function authentication() {

		$temp_cookie =  \HBCache::get($this->cookiename);
		if (!$temp_cookie) {
			$temp_cookie = tempnam("/tmp",$this->cookiename);
            \HBCache::set($this->cookiename,$temp_cookie,1440);
		}
		$this->temp_cookie =$temp_cookie;


		$url = $this->url."login";
		$ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_POST, TRUE);
		curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query (array(
				'username' => $this->user,
				'password' => $this->password,
                'login' => 'Login',
			))
		);

		curl_setopt($ch, CURLOPT_COOKIEJAR, $this->temp_cookie);
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
		if (preg_match('`^https://`i', $this->url)) {
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
			curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
		}
		$ret = curl_exec($ch);
		$information = curl_getinfo($ch);
		$error = curl_error($ch);
        curl_close($ch);
		if ($ret === FALSE ) {
            $this->temp_cookie =false;

			throw new \Exception(curl_error($ch));
			return false;
		} elseif($information['http_code']!=302) {

            throw new \Exception("Expected status code 302 upon login, got: ".$information['http_code']);
		    return false;
        }


		return true;
	}



	public function get($url) {
       if(!$this->temp_cookie && !$this->authentication()) {
           \HBCache::delete($this->cookiename);
       }


        $url = $this->url . ltrim($url,'/');

		$ch = curl_init($url);
		curl_setopt($ch, CURLOPT_POST, FALSE);
		if (preg_match('`^https://`i', $url)) {
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
			curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
		}
		curl_setopt($ch, CURLOPT_FRESH_CONNECT, TRUE);
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
		curl_setopt($ch, CURLOPT_COOKIEFILE, $this->temp_cookie);
		$ret = curl_exec($ch);
		$resultStatus = curl_getinfo($ch);
        $error = curl_error($ch);
		curl_close($ch);

        if(!$ret && $error) {
            throw new Exception($error,$url);
        }

        return $ret;
	}


}
