<?php
#@LICENSE@#

class RVLibs_oAuth_RSA_SHA1
{
    public function randomKeyPhrase($bit=8)
    {
        $keyPhrase = '';
        for ($i = 1; $i <= $bit; $i++) {
            /// สุ่มว่าจะเป็น ตัวเล็ก หรือ ตัวใหญ่
            $lower = (rand(1,200) > 100) ? true : false;
            if ($lower === true) {
                /// สุ่มอักษร a-z
                $keyPhrase .= chr(rand(97, 122));
            } else {
                /// สุ่มอักษร A-Z
                $keyPhrase .= chr(rand(65, 90));
            }
        }
        return $keyPhrase;
    }
    
    public function newPrivatekey($keyPhrase='')
    {
        $oKey = openssl_pkey_new();
        openssl_pkey_export($oKey, $privatekey, $keyPhrase);
        return trim($privatekey);
    }
    
    public function fecthPublickey($privatekey, $keyPhrase='')
    {
        $res = openssl_get_privatekey($privatekey, $keyPhrase);
        $pubkey = openssl_pkey_get_details($res);
        return trim($pubkey["key"]);
    }

}
