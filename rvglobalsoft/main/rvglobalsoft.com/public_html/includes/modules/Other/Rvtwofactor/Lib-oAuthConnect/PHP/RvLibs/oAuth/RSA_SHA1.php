<?php
# WebSite:  https://rvglobalsoft.com/rv2factor
# Unauthorized copying is strictly forbidden and may result in severe legal action.
# Copyright (c) 2013 RV Global Soft Co.,Ltd. All rights reserved.
#
# =====YOU MUST KEEP THIS COPYRIGHTS NOTICE INTACT AND CAN NOT BE REMOVE =======
# Copyright (c) 2013 RV Global Soft Co.,Ltd. All rights reserved.
# This Agreement is a legal contract, which specifies the terms of the license
# and warranty limitation between you and RV Global Soft Co.,Ltd. and RV2Factor for Apps Product for RV Global Soft.
# You should carefully read the following terms and conditions before
# installing or using this software.  Unless you have a different license
# agreement obtained from RV Global Soft Co.,Ltd., installation or use of this software
# indicates your acceptance of the license and warranty limitation terms
# contained in this Agreement. If you do not agree to the terms of this
# Agreement, promptly delete and destroy all copies of the Software.
#
# =====  Grant of License =======
# The Software may only be installed and used on a single host machine.
#
# =====  Disclaimer of Warranty =======
# THIS SOFTWARE AND ACCOMPANYING DOCUMENTATION ARE PROVIDED "AS IS" AND
# WITHOUT WARRANTIES AS TO PERFORMANCE OF MERCHANTABILITY OR ANY OTHER
# WARRANTIES WHETHER EXPRESSED OR IMPLIED.   BECAUSE OF THE VARIOUS HARDWARE
# AND SOFTWARE ENVIRONMENTS INTO WHICH RV SITE BUILDER MAY BE USED, NO WARRANTY OF
# FITNESS FOR A PARTICULAR PURPOSE IS OFFERED.  THE USER MUST ASSUME THE
# ENTIRE RISK OF USING THIS PROGRAM.  ANY LIABILITY OF RV GLOBAL SOFT CO.,LTD. WILL BE
# LIMITED EXCLUSIVELY TO PRODUCT REPLACEMENT OR REFUND OF PURCHASE PRICE.
# IN NO CASE SHALL RV GLOBAL SOFT CO.,LTD. BE LIABLE FOR ANY INCIDENTAL, SPECIAL OR
# CONSEQUENTIAL DAMAGES OR LOSS, INCLUDING, WITHOUT LIMITATION, LOST PROFITS
# OR THE INABILITY TO USE EQUIPMENT OR ACCESS DATA, WHETHER SUCH DAMAGES ARE
# BASED UPON A BREACH OF EXPRESS OR IMPLIED WARRANTIES, BREACH OF CONTRACT,
# NEGLIGENCE, STRICT TORT, OR ANY OTHER LEGAL THEORY. THIS IS TRUE EVEN IF
# RV GLOBAL SOFT CO.,LTD. IS ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. IN NO CASE WILL
# RV GLOBAL SOFT CO.,LTD.'S LIABILITY EXCEED THE AMOUNT OF THE LICENSE FEE ACTUALLY PAID
# BY LICENSEE TO RV GLOBAL SOFT CO.,LTD.
# ===============================


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
