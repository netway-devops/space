<?php

class addresshandle_controller extends HBController {

    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }

    public function beforeCall ($request)
    {
        $this->_beforeRender();
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
    }
    
    // https://hostbill.billing.netway.co.th/7944web/index.php?cmd=addresshandle&action=migratedefaultmainbranch

    public function migratedefaultmainbranch ($request)
    {exit;
        $db     = hbm_db();
        $api        = new ApiWrapper();

        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;

        $aResult    = $db->query("
            SELECT ca.*
            FROM hb_client_access ca
            WHERE ca.id > :id
            ORDER BY ca.id ASC
            LIMIT 50
            ", array(
                ":id"   => $clientId
            ))->fetchAll();
        
        if (! count($aResult)) {
            echo 'DONE';exit;
        }

        foreach ($aResult as $arr) {
            $clientId   = $arr['id'];
            $email      = $arr['email'];

            echo '<br />'. $clientId;
            
            $params = array(
                'id'    => $clientId
            );
            $result     = $api->getClientDetails($params);
            $aClient    = isset($result['client']) ? $result['client'] : array();

            if (! count($aClient)) {
                continue;
            }

            $taxId      = isset($aClient['taxid']) ? $aClient['taxid'] : '';
            $branch     = isset($aClient['branch']) ? $aClient['branch'] : '';

            if ($taxId == '') {
                continue;
            }
            if ($branch != '') {
                continue;
            }

            $branch     = 'สำนักงานใหญ่';

            $params     = array(
                'id'        => $clientId,
                'branch'    => $branch,
            );
            $result     = $api->setClientDetails($params);
            echo '<pre>'. print_r($result, true) .'</pre>';
        }

        echo '<script>
        setTimeout( function () {
            document.location="?cmd=addresshandle&action=migratedefaultmainbranch&clientId='. $clientId .'";
        }, 2500);
        </script>';
        exit;


    }
    
    // https://hostbill.billing.netway.co.th/7944web/index.php?cmd=addresshandle&action=migratecustomerid

    public function migratecustomerid ($request)
    {exit;
        $db         = hbm_db();
        $api        = new ApiWrapper();

        $cfTaxId        = 30;
        $cfCompanyId    = 57;

        // UPDATE `client_export_form_dbc` SET `client_id` = 0, `rel_type` = '',  `is_sync` = 0 WHERE 1

/*

SELECT  
    '#HOSTBILL#'
    , cfv.value AS Hostbill_CF_TaxID, cfv2.value AS Hostbill_CF_CompanyName
    , cd.firstname AS Hostbill_firstname, cd.lastname AS Hostbill_lastname
    , '#DBC###'
    , ce.22 AS DBC_TaxID
    , ce.*
    , '#HOSTBILL#'
    , cd.address1, cd.city, cd.state, cd.postcode, cd.companyname
FROM
    client_export_form_dbc ce
    LEFT JOIN hb_client_details cd
        ON cd.id = ce.client_id
    LEFT JOIN hb_client_fields_values cfv
        ON cfv.client_id = cd.id
        AND cfv.field_id = 30
    LEFT JOIN hb_client_fields_values cfv2
        ON cfv2.client_id = cd.id
        AND cfv2.field_id = 57
WHERE
    # ce.client_id = 0

*/

        $customerId = isset($request['customerId']) ? $request['customerId'] : '';

        $aResult    = $db->query("
            SELECT *
            FROM client_export_form_dbc
            WHERE 
                # id = '81'
                ( is_sync = 0 AND client_id = 0 ) 
            LIMIT 10
            ")->fetchAll();
        
        if (! count($aResult)) {
            echo 'DONE';exit;
        }
        
        $aCustomerSync  = array();

        foreach ($aResult as $aCustomer) {
            $index      = $aCustomer['id'];
            $customerId = trim($aCustomer['1']);
            $clientId   = 0;
            $clientArea = '';
            $dbcCustomerGUID    = $aCustomer['85'];
            $dbcCustomerGUID    = preg_replace('/\{/','', $dbcCustomerGUID);
            $dbcCustomerGUID    = preg_replace('/\}/','', $dbcCustomerGUID);

            array_push($aCustomerSync, $index);

            echo '<br /><b>'. $index .' '. $customerId .' '. $dbcCustomerGUID .'</b>';

            if (! preg_match('/^CD/', $customerId)) {
                continue;
            }
            
            $companyName    = trim($aCustomer['2']);
            $taxId          = trim($aCustomer['50']);

            if ($taxId) {
                $sql        = "
                    SELECT cfv.*
                    FROM hb_client_fields_values cfv,
                        hb_client_details cd
                    WHERE cfv.field_id = '{$cfTaxId}'
                        AND cfv.value LIKE '%{$taxId}%'
                        AND cfv.client_id = cd.id
                    ORDER BY cd.parent_id ASC
                    ";
                //echo '<br />TAXID <pre>'.print_r($sql, true).'</pre>';
                $result     = $db->query($sql)->fetch();

                $clientId   = isset($result['client_id']) ? $result['client_id'] : 0;
                if ($clientId) {
                    $clientArea = 'TAXID';
                }
            }

            if (! $clientId && $taxId) {
                $companyName2   = preg_replace('/\s+/', '', $companyName);
                $companyName2   = preg_replace('/จำกัด/u', '', $companyName2);
                $companyName2   = preg_replace('/บริษัท/u', '', $companyName2);

                $sql        = "
                    SELECT cfv.*
                    FROM hb_client_fields_values cfv,
                        hb_client_details cd
                    WHERE cfv.field_id = '{$cfCompanyId}'
                        AND REPLACE(cfv.value, ' ', '') LIKE '%{$companyName2}%'
                        AND cfv.client_id = cd.id
                    ORDER BY cd.parent_id ASC
                    ";
                //echo '<br />COMPANY <pre>'.print_r($sql, true).'</pre>';
                $result     = $db->query($sql)->fetch();

                $clientId   = isset($result['client_id']) ? $result['client_id'] : 0;
                if ($clientId) {
                    $clientArea = 'COMPANY';
                }
            }

            if (! $clientId) {
                $companyName2   = preg_replace('/คุณ/u', '', $companyName);
                preg_match_all('/([^\s]+)/u', $companyName2, $match);

                $firstname      = isset($match[1][0]) ? $match[1][0] : '';
                $lastname       = isset($match[1][1]) ? $match[1][1] : '';

                //echo '<pre>'. print_r($match, true) .'</pre>';
                $firstname  = preg_replace('/\'s/', '', $firstname);
                $lastname   = preg_replace('/\'s/', '', $lastname);

                $sql        = "
                    SELECT *
                    FROM hb_client_details
                    WHERE ( firstname LIKE '%{$firstname}%' AND lastname LIKE '%{$lastname}%' )
                        OR  firstname LIKE '%{$firstname} {$lastname}%'
                    ORDER BY parent_id ASC
                    ";
                //echo '<br />PROFILE <pre>'.print_r($sql, true).'</pre>';
                $result     = $db->query($sql)->fetch();

                $clientId   = isset($result['id']) ? $result['id'] : 0;
                if ($clientId) {
                    $clientArea = 'PROFILE';
                }

                if (! $clientId) {
                    $sql        = "
                        SELECT *
                        FROM hb_client_details
                        WHERE firstname LIKE '%{$companyName2}%'
                        ORDER BY parent_id ASC
                        ";
                    //echo '<br />PROFILE_2 <pre>'.print_r($sql, true).'</pre>';
                    $result     = $db->query($sql)->fetch();

                    $clientId   = isset($result['id']) ? $result['id'] : 0;
                    if ($clientId) {
                        $clientArea = 'PROFILE_2';
                    }
                }

            }

            if (! $clientId) {
                $aParam     = array(
                    'query' => $companyName
                );
                $result     = $api->search($aParam);
                // echo '<pre>'. print_r($result, true) .'</pre>';
                $clientId   = isset($result['results']['Clients'][0]['id']) ? $result['results']['Clients'][0]['id'] : 0;
                if ($clientId) {
                    $clientArea = 'SEARCH';
                }

            }

            echo '<br />Type : '. $clientArea .' $clientId : '. $clientId;

            if ($clientId) {
                
                $db->query("
                    UPDATE client_export_form_dbc
                    SET client_id = '{$clientId}',
                        rel_type = '{$clientArea}',
                        is_sync = 1
                    WHERE id = '{$index}'
                    ");
                
                $params     = array(
                    'id'    => $clientId,
                    'dbccustomerguid'   => $dbcCustomerGUID
                );
                $result     = $api->setClientDetails($params);
                echo '<pre>'. print_r($result, true) .'</pre>';

            }

        }

        $db->query("
            UPDATE client_export_form_dbc
            SET is_sync = 1
            WHERE id IN (". implode(',', $aCustomerSync) .")
            ");


        echo '<script>
        setTimeout( function () {
            document.location="?cmd=addresshandle&action=migratecustomerid&customerId='. $customerId .'";
        }, 5000);
        </script>';
        exit;


    }
    
    // https://hostbill.billing.netway.co.th/7944web/index.php?cmd=addresshandle&action=migratetaxidbranch

    public function migratetaxidbranch ($request)
    {exit;
        $db     = hbm_db();
        $api        = new ApiWrapper();

        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;

        $aResult    = $db->query("
            SELECT ca.*
            FROM hb_client_access ca
            WHERE ca.id > :id
            ORDER BY ca.id ASC
            LIMIT 50
            ", array(
                ":id"   => $clientId
            ))->fetchAll();
        
        if (! count($aResult)) {
            echo 'DONE';exit;
        }

        foreach ($aResult as $arr) {
            $clientId   = $arr['id'];
            $email      = $arr['email'];

            echo '<br />'. $clientId;
            
            $params = array(
                'id'    => $clientId
            );
            $result     = $api->getClientDetails($params);
            $aClient    = isset($result['client']) ? $result['client'] : array();

            if (! count($aClient)) {
                continue;
            }

            $taxId      = isset($aClient['taxid']) ? $aClient['taxid'] : '';
            $branch     = isset($aClient['branch']) ? $aClient['branch'] : '';

            if ($taxId == '') {
                continue;
            }
            if ($branch != '') {
                continue;
            }

            preg_match('/^((\d|\s)+)(.*)/', $taxId, $match);

            echo '<pre>'. print_r($match, true) .'</pre>';

            if (! isset($match[1]) || $match[1] == '') {
                continue;
            }

            $taxId      = isset($match[1]) ? trim($match[1]) : '';
            $branch     = isset($match[3]) ? trim($match[3]) : '';

            $params     = array(
                'id'        => $clientId,
                'taxid'     => $taxId,
                'branch'    => $branch,
            );
            $result     = $api->setClientDetails($params);
            echo '<pre>'. print_r($result, true) .'</pre>';
        }

        echo '<script>
        setTimeout( function () {
            document.location="?cmd=addresshandle&action=migratetaxidbranch&clientId='. $clientId .'";
        }, 2500);
        </script>';
        exit;


    }
    
    // https://hostbill.billing.netway.co.th/7944web/index.php?cmd=addresshandle&action=migrateemailcontact

    public function migrateemailcontact ($request)
    {exit;
        $db     = hbm_db();
        $api        = new ApiWrapper();

        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;

        $aResult    = $db->query("
            SELECT ca.*
            FROM hb_client_access ca,
                hb_client_details cd
            WHERE ca.id = cd.id
                AND cd.parent_id  = '0'
                AND ca.id > :id
            ORDER BY ca.id ASC
            LIMIT 50
            ", array(
                ":id"   => $clientId
            ))->fetchAll();
        
        if (! count($aResult)) {
            echo 'DONE';exit;
        }

        foreach ($aResult as $arr) {
            $clientId   = $arr['id'];
            $email      = $arr['email'];

            echo '<br />'. $clientId .' '. $email;
            
            $params = array(
                'id'    => $clientId
            );
            $result     = $api->getClientContacts($params);
            $aContacts  = isset($result['contacts']) ? $result['contacts'] : array();

            if (! count($aContacts)) {
                continue;
            }

            $aEmail     = array();
            array_push($aEmail, $email);

            //echo '<pre>'. print_r($aClient, true) .'</pre>';
            foreach ($aContacts as $aContact) {
                
                $contactId      = $aContact['id'];
                $contactEmail   = $aContact['email'];
                if (! in_array($contactEmail, $aEmail)) {
                    array_push($aEmail, $contactEmail);
                    continue;
                }
                
                $contactEmail   = preg_replace('/\@/', '+'. $contactId .'@', $contactEmail);

                $params     = array(
                    'id'    => $contactId,
                    'email'   => $contactEmail,
                );
                $result     = $api->setClientDetails($params);


                echo '<br /> : '. $contactEmail .' <pre> '. print_r($result, true) .' </pre>';

            }

        }

        echo '<script>
        setTimeout( function () {
            document.location="?cmd=addresshandle&action=migrateemailcontact&clientId='. $clientId .'";
        }, 2500);
        </script>';
        exit;


    }
    
    // https://hostbill.billing.netway.co.th/7944web/index.php?cmd=addresshandle&action=migratephone

    public function migratephone ($request)
    {exit;
        $db     = hbm_db();
        $api        = new ApiWrapper();

        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;

        // https://github.com/giggsey/libphonenumber-for-php
        require_once( dirname(APPDIR) . '/vendor/libphonenumber/vendor/autoload.php' );
        $phoneNumberUtil = \libphonenumber\PhoneNumberUtil::getInstance();

        $aResult    = $db->query("
            SELECT *
            FROM hb_client_access
            WHERE id > :id
            ORDER BY id ASC
            LIMIT 50
            ", array(
                ":id"   => $clientId
            ))->fetchAll();
        
        if (! count($aResult)) {
            echo 'DONE';exit;
        }

        foreach ($aResult as $arr) {
            $clientId   = $arr['id'];

            echo $clientId .' ';
            
            $params = array(
                'id'    => $clientId
            );
            $result     = $api->getClientDetails($params);
            $aClient    = isset($result['client']) ? $result['client'] : array();

            if (! $aClient['id']) {
                continue;
            }

            //echo '<pre>'. print_r($aClient, true) .'</pre>';

            $country    = $aClient['country'];
            $phone      = $aClient['phonenumber'];
            $mobile     = $aClient['mobile'];
            $fax        = $aClient['fax'];
            
            if ($phone && $phoneNumberUtil->isPossibleNumber($phone, $country)) {
                $phoneNumberObject  = $phoneNumberUtil->parse($phone, $country);
                $phone  = $phoneNumberUtil->format($phoneNumberObject, \libphonenumber\PhoneNumberFormat::INTERNATIONAL);
            }
            
            if ($mobile && $phoneNumberUtil->isPossibleNumber($mobile, $country)) {
                $phoneNumberObject  = $phoneNumberUtil->parse($mobile, $country);
                $mobile = $phoneNumberUtil->format($phoneNumberObject, \libphonenumber\PhoneNumberFormat::INTERNATIONAL);
            }
            
            if ($fax && $phoneNumberUtil->isPossibleNumber($fax, $country)) {
                $phoneNumberObject  = $phoneNumberUtil->parse($fax, $country);
                $fax    = $phoneNumberUtil->format($phoneNumberObject, \libphonenumber\PhoneNumberFormat::INTERNATIONAL);
            }

            $params     = array(
                'id'    => $clientId,
                'phonenumber'   => $phone,
                'mobile'        => $mobile,
                'fax'           => $fax
            );
            $api->setClientDetails($params);

            echo '<pre> phonenumber '. print_r($phone, true) .' mobile '. print_r($mobile, true) .' fax '. print_r($fax, true) .' </pre>';


        }

        echo '<script>
        setTimeout( function () {
            document.location="?cmd=addresshandle&action=migratephone&clientId='. $clientId .'";
        }, 1000);
        </script>';
        exit;


    }
    
    // https://hostbill.billing.netway.co.th/7944web/index.php?cmd=addresshandle&action=migratedata

    public function migrateaddress ($request)
    {exit;
        $db         = hbm_db();
        $api        = new ApiWrapper();

        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;

        $aField     = array(
            '57'    => 'thaicompanyname',
            '47'    => 'thaiaddress1',
            '48'    => 'thaiaddress2',
            '49'    => 'thaicity',
            '50'    => 'thaistate',
            '51'    => 'thaipostcode',
        );
        
        $aResult    = $db->query("
            SELECT *
            FROM hb_client_access
            WHERE id > :id
            ORDER BY id ASC
            LIMIT 50
            ", array(
                ":id"   => $clientId
            ))->fetchAll();
        
        if (! count($aResult)) {
            echo 'DONE';exit;
        }

        foreach ($aResult as $arr) {
            $clientId   = $arr['id'];

            echo $clientId .' ';
            
            $params = array(
                'id'    => $clientId
            );
            $result     = $api->getClientDetails($params);
            $aClient    = isset($result['client']) ? $result['client'] : array();

            if (! $aClient['id']) {
                continue;
            }

            //echo '<pre>'. print_r($aClient, true) .'</pre>';

            foreach ($aField as $fieldId => $fieldName) {

                echo '<br />';

                $result     = $db->query("
                    SELECT *
                    FROM hb_client_fields_values
                    WHERE client_id = :client_id
                        AND field_id = :field_id
                    ", array(
                        ":client_id"    => $clientId,
                        ":field_id"     => $fieldId,
                    ))->fetch();

                if (! isset($result['client_id'])) {
                    $db->query("
                        INSERT INTO hb_client_fields_values (
                            client_id, field_id
                        ) VALUES (
                            :client_id, :field_id
                        )
                        ", array(
                            ":client_id"    => $clientId,
                            ":field_id"     => $fieldId,
                        ));
                        echo ' INSERT '. $fieldName . ' ';
                }

                $value  = '';

                if ($fieldName == 'thaicompanyname') {
                    if ($aClient['company'] && $aClient['companyname'] && $aClient['thaicompanyname'] == '') {
                        $value    = $aClient['companyname'];
                    }

                }

                if ($fieldName == 'thaiaddress1') {
                    if ($aClient['address1'] &&  $aClient['thaiaddress1'] == '') {
                        $value    = $aClient['address1'];
                    }
                    
                }

                if ($fieldName == 'thaiaddress2') {
                    if ($aClient['address2'] &&  $aClient['thaiaddress2'] == '') {
                        $value    = $aClient['address2'];
                    }
                    
                }

                if ($fieldName == 'thaicity') {
                    if ($aClient['city'] &&  $aClient['thaicity'] == '') {
                        $value    = $aClient['city'];
                    }
                    
                }

                if ($fieldName == 'thaistate') {
                    if ($aClient['state'] &&  $aClient['thaistate'] == '') {
                        $value    = $aClient['state'];
                    }
                    
                }

                if ($fieldName == 'thaipostcode') {
                    if ($aClient['postcode'] &&  $aClient['thaipostcode'] == '') {
                        $value    = $aClient['postcode'];
                    }
                    
                }

                if ($value != '') {
                    $db->query("
                        UPDATE hb_client_fields_values
                        SET value = :value
                        WHERE client_id = :client_id
                            AND field_id = :field_id
                        ", array(
                            ":client_id"    => $clientId,
                            ":field_id"     => $fieldId,
                            ":value"        => $value,
                        ));
                    
                    echo ' UPDATE '. $fieldName . ' : ' . $value .' ';
                }

            }

            echo '<br /><br />';

        }

        echo '<script>
        setTimeout( function () {
            document.location="?cmd=addresshandle&action=migrateaddress&clientId='. $clientId .'";
        }, 1000);
        </script>';
        exit;

    }



    public function getContactAddressFronContactId ($contactId)
    {
        $api    = new ApiWrapper();

        $aClient        = array();
        if ($contactId) {
            $params = array(
                'id'    => $contactId
            );
            $result     = $api->getClientDetails($params);
            $aClient    = isset($result['client']) ? $result['client'] : array();
            //echo '<pre>'.print_r($aClient,true).'</pre>';
        }
        
        // หา billing address และ mailing address จาก จาก client detail
        $billingContactId   = $contactId;
        $billingAddress     = '';
        $billingTaxId       = '';
        $mailingContactId   = $billingContactId;
        $mailingAddress     = '';
        $isReceiveTaxInvoice    = 0;
        $isChangeMailto     = 0;
        $mailtoPerson       = '';
        $companyName        = '';

        // ดึง default billing address จาก English address
        if (isset($aClient['id'])) {

            $mailtoPerson   = $aClient['firstname'] . ' ' . $aClient['lastname'];
            $companyName    = $aClient['company'] ? $aClient['companyname'] : '';
            if ($aClient['company'] && $aClient['thaicompanyname']) {
                $companyName    = $aClient['thaicompanyname'];
            }

            $billingAddress = $aClient['address1'] . ' ' . $aClient['address2'] . "\n"
                . $aClient['city'] . ' ' . $aClient['state'] . "\n"
                . $aClient['postcode'];

            // ถ้าเป็น Private ต้องเลือก รับใยกำกับภาษีเต็มรูปแบบ ส่งไปที่ English address
            // ถ้าเป็น Org ต้องระบุ Thai Address
            if ($aClient['company']) {
                $isReceiveTaxInvoice    = 1;
                $billingTaxId   = $aClient['taxid'] .' '. $aClient['branch'];
            } else if (isset($aClient['invoicedeliverymethod'][0]) && $aClient['invoicedeliverymethod'][0]) {
                $isReceiveTaxInvoice    = 1;
            }

            // ถ้ามี thaiaddress1 แสดงว่าเป็น format ใหม่
            if ($aClient['company']) {
                if ($aClient['thaiaddress1']) {
                    $billingAddress = $aClient['thaiaddress1'] . ' ' . $aClient['thaiaddress2'] . "\n"
                        . $aClient['thaicity'] . ' ' . $aClient['thaistate'] . "\n"
                        . $aClient['thaipostcode'];
                }
            }

            $mailingAddress = $billingAddress;

            // ที่อยู่จัดส่งเอกสารถ้ามีการเปล่ี่ยนแปลง
            if ( (isset($aClient['changemailto'][0]) && $aClient['changemailto'][0]) && $aClient['mailtoperson']) {
                $mailtoPerson   = $aClient['mailtoperson'];
            }
            if ( (isset($aClient['changemailtoaddress'][0]) && $aClient['changemailtoaddress'][0]) && $aClient['mailingaddress1']) {
                $isChangeMailto = 1;
                $mailingAddress = $aClient['mailingaddress1'] . "\n"
                    . $aClient['mailingaddress2'] .' '.  $aClient['mailingcity'] . "\n"
                    . $aClient['mailingstate']  .' '.  $aClient['mailingpostcode'];
                $mailingAddress .= ($aClient['mailingphonenumber']) ? "\n โทร: ". $aClient['mailingphonenumber'] : '';
                $mailingAddress .= ($aClient['mailingnote']) ? "\n หมายเหตุ: ". $aClient['mailingnote'] : '';
            }

        }

        $billingAddress     = ($companyName ? $companyName ."\n": '') . $billingAddress . ($billingTaxId ? "\n<b>เลขประจำตัวผู้เสียภาษี:</b> ". $billingTaxId : '');

        $aClient['billingContactId']    = $billingContactId;
        $aClient['billingAddress']      = $billingAddress;
        $aClient['billingTaxId']        = $billingTaxId;
        $aClient['mailingContactId']    = $mailingContactId;
        $aClient['mailingAddress']      = $mailingAddress;
        $aClient['isReceiveTaxInvoice'] = $isReceiveTaxInvoice;
        $aClient['mailtoPerson']        = $mailtoPerson;
        $aClient['companyName']         = $companyName;
        $aClient['isChangeMailto']      = $isChangeMailto;
        
        return $aClient;
    }
    
    /**
     * แสดง address ให้เลือก
     * @param unknown_type $request
     * @return unknown_type
     */
    public function listInvoice ($request)
    {
        $db     = hbm_db();
        $api    = new ApiWrapper();

        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $accountId      = isset($request['accountId']) ? $request['accountId'] : 0;
        $domainId       = isset($request['domainId']) ? $request['domainId'] : 0;
        $orderDraftId   = isset($request['orderDraftId']) ? $request['orderDraftId'] : 0;
        $estimateId     = isset($request['estimateId']) ? $request['estimateId'] : 0;
        
        $type           = isset($request['type']) ? $request['type'] : '';
        
        /* --- ดึงข้อมูลลูกค้า --- */
        if ($invoiceId) {
            $result         = $db->query("
                        SELECT
                            i.*
                        FROM
                            hb_invoices i
                        WHERE
                            i.id = :invoiceId
                        ", array(
                            ':invoiceId'      => $invoiceId
                        ))->fetch();
                        
        } else if ($accountId) {
            $result         = $db->query("
                        SELECT
                            a.*
                        FROM
                            hb_accounts a
                        WHERE
                            a.id = :accountId
                        ", array(
                            ':accountId'      => $accountId
                        ))->fetch();
                        
        } else if ($domainId) {
            $result         = $db->query("
                        SELECT
                            d.*
                        FROM
                            hb_domains d
                        WHERE
                            d.id = :domainId
                        ", array(
                            ':domainId'      => $domainId
                        ))->fetch();
                        
        } else if ($orderDraftId) {
            $result         = $db->query("
                        SELECT
                            od.*
                        FROM
                            hb_order_drafts od
                        WHERE
                            od.id = :id
                        ", array(
                            ':id'   => $orderDraftId
                        ))->fetch();
                        
        } else if ($estimateId) {
            $result         = $db->query("
                        SELECT
                            e.*
                        FROM
                            hb_estimates e
                        WHERE
                            e.id = :id
                        ", array(
                            ':id'   => $estimateId
                        ))->fetch();
                        
        }
        
        $clientId           = isset($result['client_id']) ? $result['client_id'] : 0;
        $currentContactId   = 0;
        if ($type == 'billing') {
            $currentContactId   = isset($result['billing_contact_id']) ? $result['billing_contact_id'] : 0;
        } else if ($type == 'mailing') {
            $currentContactId   = isset($result['mailing_contact_id']) ? $result['mailing_contact_id'] : 0;
        }
        
        $this->template->assign('invoiceId', $invoiceId);
        $this->template->assign('accountId', $accountId);
        $this->template->assign('domainId', $domainId);
        $this->template->assign('orderDraftId', $orderDraftId);
        $this->template->assign('estimateId', $estimateId);
        $this->template->assign('type', $type);
        $this->template->assign('clientId', $clientId);
        $this->template->assign('currentContactId', $currentContactId);
        
        $aAddress   = array();

        $result     = $this->getContactAddressFronContactId($clientId);
        array_push($aAddress, $result);

        $params     = array(
            'id'    => $clientId
        );
        $result     = $api->getClientContacts($params);
        
        if (count($result['contacts'])) {
            foreach ($result['contacts'] as $arr) {
                $result2    = $this->getContactAddressFronContactId($arr['id']);
                array_push($aAddress, $result2);
            }
        }
        //echo '<pre>'.print_r($aAddress, true).'</pre>';
        $this->template->assign('aAddress', $aAddress);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.lists.tpl', array(), false);
    }
    
    /**
     * เลือก invoice address
     * @param unknown_type $request
     * @return unknown_type
     */
    public function updateToInvoice ($request)
    {
        $db     = hbm_db();
        
        $isReturn       = isset($request['isReturn']) ? $request['isReturn'] : 0;
        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $accountId      = isset($request['accountId']) ? $request['accountId'] : 0;
        $domainId       = isset($request['domainId']) ? $request['domainId'] : 0;
        $orderDraftId   = isset($request['orderDraftId']) ? $request['orderDraftId'] : 0;
        $estimateId     = isset($request['estimateId']) ? $request['estimateId'] : 0;
        $type           = isset($request['type']) ? $request['type'] : '';
        $clientId       = isset($request['client_id']) ? $request['client_id'] : 0;
        $skipContactName    = isset($request['skip_contactname']) ? $request['skip_contactname'] : 0;
        
        $aContact       = $this->getContactAddressFronContactId($clientId);

        $billingAddress     = isset($aContact['billingAddress']) ? $aContact['billingAddress'] : '';
        $billingTaxId       = isset($aContact['billingTaxId']) ? $aContact['billingTaxId'] : '';
        $isReceiveTaxInvoice    = isset($aContact['isReceiveTaxInvoice']) ? $aContact['isReceiveTaxInvoice'] : '';
        $companyName        = isset($aContact['companyName']) ? $aContact['companyName'] : '';

        $mailingAddress     = isset($aContact['mailingAddress']) ? $aContact['mailingAddress'] : '';
        $mailtoPerson       = isset($aContact['mailtoPerson']) ? $aContact['mailtoPerson'] : '';

        $billingAddressNew  = '';
        if (! $skipContactName) {
            $billingAddressNew .=  ($mailtoPerson ? $mailtoPerson ."\n" : '');
        }
        $billingAddressNew  .= $billingAddress;

        $mailingAddress     = ($mailtoPerson ? $mailtoPerson ."\n" : '') . $mailingAddress;

        // รอดูก่อนว่าต้องเอาออกใหม
        /*
        if (! $isReceiveTaxInvoice) {
            $billingAddress = '';
            $mailingAddress = '';
        }
        */

        // ระบบใหม่ให้ใช้ mailling_contact_id เกียวกับ billing_contact_id

        if ($invoiceId) {
            $db->query("
                UPDATE
                    hb_invoices
                SET 
                    billing_contact_id  = :clientId,
                    mailing_contact_id  = :clientId,
                    billing_address     = :billingAddress,
                    mailing_address     = :mailingAddress,
                    billing_taxid       = :billingTaxid
                WHERE
                    id = :invoiceId
                ", array(
                    ':clientId'         => $clientId,
                    ':billingAddress'   => $billingAddressNew,
                    ':mailingAddress'   => $mailingAddress,
                    ':billingTaxid'     => $billingTaxId,
                    ':invoiceId'    => $invoiceId
                ));
            echo '<!-- {"ERROR":[],"INFO":["Update '. $type .' address to invoice:'. $invoiceId .'"]'
                . ',"STACK":0} -->';
                
        } else if ($accountId) {
            echo '<!-- {"ERROR":["Function นี้ถูกปิดแล้ว ให้ใช้ Billing Contact แทน"],"INFO":[]'
                . ',"STACK":0} -->';
                
        } else if ($domainId) {
            $db->query("
                UPDATE
                    hb_domains
                SET 
                    billing_contact_id = :clientId,
                    mailing_contact_id = :clientId
                WHERE
                    id = :domainId
                ", array(
                    ':clientId'     => $clientId,
                    ':domainId'     => $domainId
                ));
            echo '<!-- {"ERROR":[],"INFO":["Update '. $type .' address to domain:'. $domainId .'"]'
                . ',"STACK":0} -->';
            
        } else if ($orderDraftId) {
            $db->query("
                UPDATE
                    hb_order_drafts
                SET 
                    billing_contact_id = :billing_contact_id,
                    billing_address = :billing_address
                WHERE
                    id = :id
                ", array(
                    ':billing_contact_id'   => $clientId,
                    ':billing_address'      => $billingAddressNew,
                    ':id'                   => $orderDraftId
                ));
            
            if ($isReturn) {
                return array('billingAddress' => $billingAddressNew);
            }

            echo '<!-- {"ERROR":[],"INFO":["Update '. $type .' address to order draft:'. $orderDraftId .'"]'
                . ',"STACK":0} -->';
            
        } else if ($estimateId) {
            $db->query("
                UPDATE
                    hb_estimates
                SET 
                    billing_contact_id = :billing_contact_id,
                    billing_address = :billing_address
                WHERE
                    id = :id
                ", array(
                    ':billing_contact_id'   => $clientId,
                    ':billing_address'      => $billingAddressNew,
                    ':id'                   => $estimateId
                ));
            echo '<!-- {"ERROR":[],"INFO":["Update '. $type .' address to estimate :'. $estimateId .'"]'
                . ',"STACK":0} -->';
            
        }
        
        exit;
    }
    
    /**
     * เพิ่ม contact address เพื่อใช้กับ invoice 
     * @param unknown_type $request
     * @return unknown_type
     */
    public function addToInvoice ($request)
    {
        $db         = hbm_db();
        // $api     = new ApiWrapper(); ใช้แล้วไม่มี return อะไร เลยจะใช้ curl แทน
        
        require_once(APPDIR . 'class.general.custom.php');
        require_once(APPDIR . 'class.api.custom.php');
        
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
        
        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $accountId      = isset($request['accountId']) ? $request['accountId'] : 0;
        $domainId       = isset($request['domainId']) ? $request['domainId'] : 0;
        $type           = isset($request['type']) ? $request['type'] : '';
        
        $firstname      = isset($request['firstname']) ? $request['firstname'] : '';
        $lastname       = isset($request['lastname']) ? $request['lastname'] : '';
        $companyname    = isset($request['companyname']) ? trim($request['companyname']) : '';
        $address1       = isset($request['address1']) ? $request['address1'] : '';
        $address2       = isset($request['address2']) ? $request['address2'] : '';
        $city           = isset($request['city']) ? $request['city'] : '';
        $state          = isset($request['state']) ? $request['state'] : '';
        $postcode       = isset($request['postcode']) ? $request['postcode'] : '';
        $phonenumber    = isset($request['phonenumber']) ? $request['phonenumber'] : '';
        
        $taxid          = isset($request['taxid']) ? $request['taxid'] : '';
        
        /* --- ดึงข้อมูลลูกค้า --- */
        if ($invoiceId) {
            $result         = $db->query("
                        SELECT
                            i.*
                        FROM
                            hb_invoices i
                        WHERE
                            i.id = :invoiceId
                        ", array(
                            ':invoiceId'      => $invoiceId
                        ))->fetch();
                        
        } else if ($accountId) {
            $result         = $db->query("
                        SELECT
                            a.*
                        FROM
                            hb_accounts a
                        WHERE
                            a.id = :accountId
                        ", array(
                            ':accountId'      => $accountId
                        ))->fetch();
                        
        } else if ($domainId) {
            $result         = $db->query("
                        SELECT
                            d.*
                        FROM
                            hb_domains d
                        WHERE
                            d.id = :domainId
                        ", array(
                            ':domainId'      => $domainId
                        ))->fetch();
                        
        }
        
        $clientId       = isset($result['client_id']) ? $result['client_id'] : 0;
        
        $result         = $db->query("
                    SELECT
                        ca.*
                    FROM
                        hb_client_access ca
                    WHERE
                        ca.id = :clientId
                    ", array(
                        ':clientId'     => $clientId
                    ))->fetch();
        $email          = isset($result['email']) ? $result['email'] : '';
        
        $password       = GeneralCustom::singleton()->randomPassword();
        
        $aParam         = array(
                    'call'              => 'addClientContact',
                    // http://api.hostbillapp.com/clients/addClientContact/
                    'id'                => $clientId,
                    'firstname'         => $firstname,
                    'lastname'          => $lastname,
                    'email'             => 'noreply_'. time() .'@netway.co.th', // กัน email ซ้ำ
                    'password'          => $password,
                    'password2'         => $password,
                    'phonenumber'       => $phonenumber,
                    'address1'          => $address1,
                    'address2'          => $address2,
                    'city'              => $city,
                    'state'             => $state,
                    'postcode'          => $postcode,
                    'country'           => 'TH',
                    'company'           => ($companyname ? 1 : 0),
                    'companyname'       => $companyname
                    );

        $result         = $apiCustom->request($aParam);
        
        if (isset($result['contact_id']) && $result['contact_id']) {
            
            $contactId      = $result['contact_id'];
            
            /* --- เอา email จริงมา update --- */
            $db->query("
                UPDATE
                    hb_client_access
                SET 
                    email = :email
                WHERE
                    id = :contactId
                ", array(
                    ':email'        => $email,
                    ':contactId'    => $contactId
                ));
            
            $db->query("
                UPDATE
                    hb_client_details
                SET 
                    companyname = :companyname,
                    company = :company
                WHERE
                    id = :contactId
                ", array(
                    ':companyname'  => $companyname,
                    ':company'      => ($companyname ? 1 : 0),
                    ':contactId'    => $contactId
                ));
            
            
            /* --- ตั้ง taxid ให้ contact address --- */
            $result         = $db->query("
                        SELECT
                            cf.id, cf.default_value
                        FROM
                            hb_client_fields cf
                        WHERE
                            cf.code = 'taxid'
                        ")->fetch();
            $cfTaxId        = isset($result['id']) ? $result['id'] : 0;
            
            $db->query("
                REPLACE INTO hb_client_fields_values (
                    client_id, field_id, value
                ) VALUES (
                    :clientId, :cfTaxId, :taxId
                )
                ", array(
                    ':clientId'     => $contactId,
                    ':cfTaxId'      => $cfTaxId,
                    ':taxId'        => $taxid
                ));
            
            /* --- ตั้ง address_type ให้ contact address --- */
            $result         = $db->query("
                        SELECT
                            cf.id, cf.default_value
                        FROM
                            hb_client_fields cf
                        WHERE
                            cf.code = 'addresstype'
                        ")->fetch();
            $cfId           = isset($result['id']) ? $result['id'] : 0;
            
            if ($cfId) {
                
                $db->query("
                    REPLACE INTO hb_client_fields_values (
                        client_id, field_id, value
                    ) VALUES (
                        :clientId, :cfId, 'Invoice'
                    )
                    ", array(
                        ':clientId'     => $contactId,
                        ':cfId'         => $cfId
                    ));
                    
                echo '<!-- {"ERROR":[]'
                    . ',"INFO":["New contact address#'. $contactId .' is added"]'
                    . ',"DATA":[\''. json_encode(array(
                            'contactId'     => $contactId, 
                            'invoiceId'     => $invoiceId,
                            'addressType'   => $type
                            )) .'\']'
                    . ',"STACK":0} -->';
                    
            } else {
                echo '<!-- {"ERROR":["ไม่สามารถระบุ address type ให้กับ contact '. $contactId .'"],"INFO":[]' 
                    . ',"STACK":0} -->';
            }
            
        } else {
            $resultInfo         = base64_encode(serialize($aParam));
            echo '<!-- {"ERROR":["ไม่สามารถเพิ่มข้อมูลได้ -'. $resultInfo .'- "],"INFO":[]' . ',"STACK":0} -->';
            
        }
        exit;
    }
    
    /**
     * รายการ address สำหรับส่ง notification
     */
    public function listNotify ($request)
    {
        $db         = hbm_db();
        
        $type           = isset($request['type']) ? $request['type'] : '';
        $serviceId      = isset($request['serviceId']) ? $request['serviceId'] : 0;
        
        $this->template->assign('serviceId', $serviceId);
        $this->template->assign('type', $type);
        
        if ($type == 'account' && $serviceId) {
            $result         = $db->query("
                        SELECT
                            a.*
                        FROM
                            hb_accounts a
                        WHERE
                            a.id = :serviceId
                        ", array(
                            ':serviceId'    => $serviceId
                        ))->fetch();
            $clientId       = isset($result['client_id']) ? $result['client_id'] : 0;
            
        } else if ($type == 'domain' && $serviceId) {
            $result         = $db->query("
                        SELECT
                            d.*
                        FROM
                            hb_domains d
                        WHERE
                            d.id = :serviceId
                        ", array(
                            ':serviceId'    => $serviceId
                        ))->fetch();
            $clientId       = isset($result['client_id']) ? $result['client_id'] : 0;
            
        }
        
        /* --- ดึงข้อมูล customfield addresstype  --- */
        $result         = $db->query("
                    SELECT
                        cf.id, cf.default_value
                    FROM
                        hb_client_fields cf
                    WHERE
                        cf.code = 'addresstype'
                    ")->fetch();
        $cfId           = isset($result['id']) ? $result['id'] : 0;
        
        /* --- ดึงข้อมูล Invoice address --- */
        $result         = $db->query("
                    SELECT
                        cd.*, ca.*
                    FROM
                        hb_client_details cd,
                        hb_client_access ca,
                        hb_client_fields_values cfv
                    WHERE
                        cd.parent_id = :clientId
                        AND cd.id = ca.id
                        AND ca.status = 'Active'
                        AND cd.id = cfv.client_id
                        AND cfv.field_id = :fieldId
                        AND cfv.value = 'Notify'
                    ", array(
                        ':clientId'     => $clientId,
                        ':fieldId'      => $cfId
                    ))->fetchAll();
        $aAddress       = $result;
        $this->template->assign('aAddress', $aAddress);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.list_notify.tpl', array(), false);
    }
    
    public function updateToNotify ($request)
    {
        $db     = hbm_db();
        
        $serviceId      = isset($request['serviceId']) ? $request['serviceId'] : 0;
        $type           = isset($request['type']) ? $request['type'] : '';
        $clientId       = isset($request['client_id']) ? $request['client_id'] : 0;
        
        $aPrivileges    = array();
        
        /* --- ดึงข้อมูลลูกค้า --- */
        $result         = $db->query("
                    SELECT
                        cp.*
                    FROM
                        hb_client_privileges cp
                    WHERE
                        cp.client_id = :clientId
                    ", array(
                        ':clientId'     => $clientId
                    ))->fetch();
        
        if (isset($result['client_id'])) {
            $aPrivileges    = unserialize($result['privileges']);
        }
        
        if ($type == 'account') {
            if (! is_array($aPrivileges['services'])) {
                $aPrivileges['services']                = array();
            }
            if (! is_array($aPrivileges['services'][$serviceId])) {
                $aPrivileges['services'][$serviceId]    = array();
            }
            
            if (! isset($aPrivileges['services'][$serviceId]['notify'])) {
                $aPrivileges['services'][$serviceId]['notify']  = 1;
            }
            
        } else if ($type == 'domain') {
            if (! is_array($aPrivileges['domains'])) {
                $aPrivileges['domains']                = array();
            }
            if (! is_array($aPrivileges['domains'][$serviceId])) {
                $aPrivileges['domains'][$serviceId]    = array();
            }
            
            if (! isset($aPrivileges['domains'][$serviceId]['notify'])) {
                $aPrivileges['domains'][$serviceId]['notify']  = 1;
            }
            
        }
        
        $privilege          = '';
        if (count($aPrivileges)) {
            $privilege      = serialize($aPrivileges);
        } else {
            $privilege      = 'N;';
        }
        
        $db->query("
            REPLACE INTO hb_client_privileges (
                client_id, privileges
            ) VALUES (
                :clientId, :privilege
            )
            ", array(
                ':clientId'     => $clientId,
                ':privilege'    => $privilege
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Update '. $type .' contact to service:'. $serviceId .'"]'
            . ',"STACK":0} -->';
        
        exit;
    }

    public function addToNotify ($request)
    {
        $db         = hbm_db();
        // $api     = new ApiWrapper(); ใช้แล้วไม่มี return อะไร เลยจะใช้ curl แทน
        
        require_once(APPDIR . 'class.general.custom.php');
        require_once(APPDIR . 'class.api.custom.php');
        
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
        
        $serviceId      = isset($request['serviceId']) ? $request['serviceId'] : 0;
        $type           = isset($request['type']) ? $request['type'] : '';
        
        $email          = isset($request['email']) ? trim($request['email']) : '';
        
        if (! $email) {
            echo '<!-- {"ERROR":["กรุณาระบุอีเมล์"],"INFO":[]' . ',"STACK":0} -->';
            exit;
        }
        
        $firstname      = isset($request['firstname']) ? $request['firstname'] : '';
        $lastname       = isset($request['lastname']) ? $request['lastname'] : '';
        $phonenumber    = isset($request['phonenumber']) ? $request['phonenumber'] : '';
        $notes          = isset($request['notes']) ? $request['notes'] : '';
        
        if ($type == 'account' && $serviceId) {
            $result         = $db->query("
                        SELECT
                            a.*
                        FROM
                            hb_accounts a
                        WHERE
                            a.id = :serviceId
                        ", array(
                            ':serviceId'    => $serviceId
                        ))->fetch();
            $clientId       = isset($result['client_id']) ? $result['client_id'] : 0;
            
        } else if ($type == 'domain' && $serviceId) {
            $result         = $db->query("
                        SELECT
                            d.*
                        FROM
                            hb_domains d
                        WHERE
                            d.id = :serviceId
                        ", array(
                            ':serviceId'    => $serviceId
                        ))->fetch();
            $clientId       = isset($result['client_id']) ? $result['client_id'] : 0;
            
        }
        
        if (! $clientId) {
            echo '<!-- {"ERROR":["ไม่สามารถหาข้อมูลลูกค้าได้"],"INFO":[]' . ',"STACK":0} -->';
            exit;
        }
        
        $password       = GeneralCustom::singleton()->randomPassword();
        $emailTemp      = 'clientcontact'. time() .'@netway.co.th'; 
        $aParam         = array(
                    'call'              => 'addClientContact',
                    
                    'id'                => $clientId,
                    'firstname'         => $firstname,
                    'lastname'          => $lastname,
                    'email'             => $emailTemp,
                    'password'          => $password,
                    'password2'         => $password,
                    'phonenumber'       => $phonenumber,
                    'country'           => 'TH'
                    );

        $result         = $apiCustom->request($aParam);
        
        if (isset($result['contact_id']) && $result['contact_id']) {
            
            $contactId      = $result['contact_id'];
            
            $db->query("
                UPDATE hb_client_access
                SET email = :email
                WHERE id = :id
                ", array(
                    ':email'    => $email,
                    ':id'       => $contactId,
                ));
            
            $db->query("
                UPDATE
                    hb_client_details
                SET
                    notes = :notes
                WHERE
                    id = :contactId
                ", array(
                    ':notes'        => htmlspecialchars($notes),
                    ':contactId'    => $contactId
                ));
            
            
            /* --- ตั้ง address_type ให้ contact address --- */
            $result         = $db->query("
                        SELECT
                            cf.id, cf.default_value
                        FROM
                            hb_client_fields cf
                        WHERE
                            cf.code = 'addresstype'
                        ")->fetch();
            $cfId           = isset($result['id']) ? $result['id'] : 0;
            
            if ($cfId) {
                
                /* --- ตั้ง address type = Notify --- */
                $db->query("
                    REPLACE INTO hb_client_fields_values (
                        client_id, field_id, value
                    ) VALUES (
                        :clientId, :cfId, 'Notify'
                    )
                    ", array(
                        ':clientId'     => $contactId,
                        ':cfId'         => $cfId
                    ));
                
                echo '<!-- {"ERROR":[]'
                    . ',"INFO":["New contact address#'. $contactId .' is added"]'
                    . ',"DATA":[\''. json_encode(array(
                            'contactId'     => $contactId, 
                            'serviceId'     => $serviceId,
                            'addressType'   => $type
                            )) .'\']'
                    . ',"STACK":0} -->';
                    
            } else {
                echo '<!-- {"ERROR":["ไม่สามารถระบุ address type ให้กับ contact '. $contactId .'"],"INFO":[]' 
                    . ',"STACK":0} -->';
            }
            
        } else {
            
            echo '<!-- {"ERROR":["ไม่สามารถเพิ่มข้อมูลได้: '. @implode(', ', $result['error'])
                . '"],"INFO":[]' . ',"STACK":0} -->';
            
        }
        exit;
    }
    
    /**
     * เอาการแจ้งเตื่อนออก แต่ไม่ได้ลบ contact address
     */
    public function removeNotify ($request)
    {
        $db         = hbm_db();
        
        $type           = isset($request['type']) ? $request['type'] : '';
        $serviceId      = isset($request['serviceId']) ? $request['serviceId'] : 0;
        $clientId       = isset($request['clientId']) ? $request['clientId'] : 0;
        
        $aPrivileges    = array();
        
        $result         = $db->query("
                    SELECT
                        cp.*
                    FROM
                        hb_client_privileges cp
                    WHERE
                        cp.client_id = :clientId
                    ", array(
                        ':clientId'     => $clientId
                    ))->fetch();
        if (isset($result['client_id'])) {
            $aPrivileges    = unserialize($result['privileges']);
        }
        
        if ($type == 'account' && isset($aPrivileges['services'][$serviceId])) {
            if (isset($aPrivileges['services'][$serviceId]['notify'])) {
                unset($aPrivileges['services'][$serviceId]['notify']);
            }
            
        } else if ($type == 'domain' && isset($aPrivileges['domains'][$serviceId])) {
            if (isset($aPrivileges['domains'][$serviceId]['notify'])) {
                unset($aPrivileges['domains'][$serviceId]['notify']);
            }
            
        }
        
        $privilege          = '';
        if (count($aPrivileges)) {
            $privilege      = serialize($aPrivileges);
        } else {
            $privilege      = 'N;';
        }
        
        $db->query("
            REPLACE INTO hb_client_privileges (
                client_id, privileges
            ) VALUES (
                :clientId, :privilege
            )
            ", array(
                ':clientId'     => $clientId,
                ':privilege'    => $privilege
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Removed '. $type .' contact from service:'. $serviceId .'"]'
            . ',"STACK":0} -->';
        
        exit;
    }

    public function updateNotes ($request)
    {
        $db         = hbm_db();
        
        $contactId      = isset($request['contactId']) ? $request['contactId'] : 0;
        $notes          = isset($request['notes']) ? $request['notes'] : '';
        
        $db->query("
            UPDATE
                hb_client_details
            SET
                notes = :notes
            WHERE
                id = :contactId
            ", array(
                ':notes'        => htmlspecialchars($notes),
                ':contactId'    => $contactId
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Update '. $type .' contact from contact# '. $contactId .'"]'
            . ',"STACK":0} -->';
        
        exit;
    }

    public function updateMailDelivery ($request)
    {
        $db         = hbm_db();
        
        require_once(APPDIR . 'class.general.custom.php');
        
        $invoiceId          = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        
        $result     = $db->query("
                SELECT 
                    im.*
                FROM
                    hb_invoice_mails im
                WHERE
                    im.invoice_id = :invoiceId
                ", array(
                    ':invoiceId'    => $invoiceId
                ))->fetch();
        if (! isset($result['id'])) {
            $db->query("
                INSERT INTO hb_invoice_mails (
                    id, invoice_id
                ) VALUES (
                    '', :invoiceId
                )
                ", array(
                    ':invoiceId'    => $invoiceId
                ));
            $result     = $db->query("
                    SELECT 
                        im.*
                    FROM
                        hb_invoice_mails im
                    WHERE
                        im.invoice_id = :invoiceId
                    ", array(
                        ':invoiceId'    => $invoiceId
                    ))->fetch();
        }
        $invoiceMailId      = $result['id'];
        
        if (isset($request['invoiceSendDate'])) {
            $invoiceSendDate    = GeneralCustom::singleton()->convertStrtotime($request['invoiceSendDate']);
            $db->query("
                UPDATE 
                    hb_invoice_mails
                SET 
                    delivery = :mailDelivery
                WHERE
                    id = :invoiceMailId
                ", array(
                    ':mailDelivery'     => date('Y-m-d', $invoiceSendDate),
                    ':invoiceMailId'    => $invoiceMailId
                ));
        }
        
        if ($request['invoiceSendBy']) {
            $db->query("
                UPDATE 
                    hb_invoice_mails
                SET 
                    sendby = :invoiceSendBy
                WHERE
                    id = :invoiceMailId
                ", array(
                    ':invoiceSendBy'    => $request['invoiceSendBy'],
                    ':invoiceMailId'    => $invoiceMailId
                ));
        }
        
        if (isset($request['invoiceSendNotes'])) {
            $db->query("
                UPDATE 
                    hb_invoice_mails
                SET 
                    notes = :invoiceNotes
                WHERE
                    id = :invoiceMailId
                ", array(
                    ':invoiceNotes'     => $request['invoiceSendNotes'],
                    ':invoiceMailId'    => $invoiceMailId
                ));
        }

        echo '<!-- {"ERROR":[],"INFO":["Updated mail devilery to invoice# '. $invoiceId .'"]'
            . ',"STACK":0} -->';
        
        exit;
    }

    public function updateWithholdingTax ($request)
    {
        $db         = hbm_db();
        
        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $value          = isset($request['value']) ? $request['value'] : 0;
        
        $db->query("
            UPDATE
                hb_invoices
            SET
                is_wh_tax_receipt    = :status
            WHERE
                id = :invoiceId
            ", array(
                ':status'       => $value,
                ':invoiceId'    => $invoiceId
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Update withholding tax status for invoiceId# '. $invoiceId .'"]'
            . ',"STACK":0} -->';
        
        exit;
    }
    
    public function updateOrgname ($request)
    {
        $db         = hbm_db();
        
        $contactId      = isset($request['contactId']) ? $request['contactId'] : 0;
        $orgname        = isset($request['orgname']) ? $request['orgname'] : '';
        $isOrg          = $orgname ? 1 : 0;
        
        $db->query("
            UPDATE
                hb_client_details
            SET
                companyname = :orgName,
                company = :isOrg
            WHERE
                id = :contactId
            ", array(
                ':orgName'      => $orgname,
                ':isOrg'        => $isOrg,
                ':contactId'    => $contactId
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Update organization for contactId# '. $contactId .'"]'
            . ',"STACK":0} -->';
        
        exit;
    }
    
    public function updateEmailaddress ($request)
    {
        $db             = hbm_db();
        
        $contactId      = isset($request['contactId']) ? $request['contactId'] : 0;
        $emailaddress   = isset($request['emailaddress']) ? $request['emailaddress'] : '';
        
        $db->query("
            UPDATE
                hb_client_access
            SET
                email = :emailaddress
            WHERE
                id = :contactId
            ", array(
                ':emailaddress' => $emailaddress,
                ':contactId'    => $contactId
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Updated email contact for contactId# '. $contactId .'"]'
            . ',"STACK":0} -->';
        
        exit;
    }
    
    /* --- update main client email address --- */
    public function updateClientEmailaddress ($request)
    {
        $db             = hbm_db();
        
        $clientId       = isset($request['clientId']) ? $request['clientId'] : 0;
        $emailaddress   = isset($request['emailaddress']) ? $request['emailaddress'] : '';
        
        $result         = $db->query("
                SELECT
                    ca.id
                FROM
                    hb_client_access ca,
                    hb_client_details cd
                WHERE
                    ca.email = :emailaddress
                    AND ca.id = cd.id
                    AND cd.parent_id = 0
                ", array(
                    ':emailaddress' => $emailaddress,
                ))->fetch();
        
        if (isset($result['id']) && $result['id']) {
            echo '<!-- {"ERROR":["Email is already existed by clientId# '. $result['id'] .'"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $db->query("
            UPDATE
                hb_client_access
            SET
                email = :emailaddress
            WHERE
                id = :clientId
            ", array(
                ':emailaddress' => $emailaddress,
                ':clientId'     => $clientId
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Updated email contact for clientId# '. $clientId .'"]'
            . ',"STACK":0} -->';
        
        exit;
    }

    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function afterCall ($request)
    {
        
    }
}