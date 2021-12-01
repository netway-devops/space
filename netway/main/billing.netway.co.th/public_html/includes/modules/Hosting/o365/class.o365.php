<?php
include_once(APPDIR . "libs/azureapi/AzureApi.php");
include_once(APPDIR . "libs/hbapiwrapper/hbApiWrapper.php");
class o365 extends HostingModule 
{
    private $azure_resource_url = 'https://api.partnercenter.microsoft.com';
    private $azure_tenant_id;
    private $azure_app_id;
    private $azure_app_secret;
    /// @TODO: ไม่รู้ทำไม ตอน suspend ค่า password ถึงกลายเป็นค่าว่างไปได้
    private $netway_partnet_app_secret = 'W_QoZSkv-1fs8uU6Yo3xmF43JH_RP_7.8n';
    
    private $server_hostname;
    private $server_username;
    private $server_password;
    
    // Extras >> Plugins >> Hosting Modules
    // Module name
    protected $modname = "o365";
    
    // Extras >> Search results
    // Description module
    protected $description = "สั่งซื้อ o365";
   
    //protected $aLicenseOfferMatrix = array();
    // Settings >> Products && Services
    // Connect with App
    
    protected $options = array(
        'ms_offer_id' => array(
            'name' => 'Durable Offer ID',
            'value' => false,
            'description' => 'คุณสามารถค้นหา `Durable Offer ID` ด้วย `Offer Display Name` โดยการกดปุ่ม `Get values from server` จากนั้นเลือก `Offer Display Name` ที่ต้องการ.',
            'type' => 'loadable',
            'default' => 'getMSOffers'
        )
    );
    
    /**
     * You can choose which fields to display in Settings->Apps section
     * by defining this variable
     * @var array
     */
    protected $serverFields = array(
        "hostname" => true,
        "username" => false,
        "ip" => true,
        "password" => true,
        "maxaccounts" => false,
        "status_url" => false,
        "hash" => false,
        "ssl" => false,
        "nameservers" => false,
    );
    
    /**
     * HostBill will replace default labels for server fields
     * with this variable configured
     * @var array
     */
    protected $serverFieldsDescription = array(
        "hostname" => 'Tenant ID',
        "ip" => "Application ID",
        "password" => "Application secret keys",
    );

    public function getMSOffers()
    {
        try {
            if (empty($_SESSION['o365_license_offermatrix'])) {
                include_once(APPDIR_MODULES . "Hosting/o365/include/class.o365_license_offermatrix.php");
                $oLicenseOfferMatrix = new o365LicenseOffermatrix();
                $aLicenseOfferMatrix = $oLicenseOfferMatrix->getByAllowedCountries(array('Thailand'));
                $aLists = array();
                foreach ($aLicenseOfferMatrix as $item) {
                    $aLists[trim($item['Durable Offer ID'])] = trim($item['Offer Display Name']);
                }
                asort($aLists);
                $aResult = array();
                foreach ($aLists as $key => $value) {
                    $aResult[] = array(
                        $key, $value
                    );
                }
                $_SESSION['o365_license_offermatrix'] = $aResult;
            }

            return $_SESSION['o365_license_offermatrix'];
        } catch (Exception $ex) {
            $this->addError( $ex->getMessage());
            return array();
        }
    }

    /**
     * HostBill will call this method before calling any other function from your module
     * It will pass remote  app details that module should connect with
     *
     * @param array $connect Server details configured in Settings->Apps
     */
    public function connect($connect) 
    {
        $this->azure_tenant_id = (isset($connect["host"])) ? $connect["host"] : "";
        $this->azure_app_id = (isset($connect["ip"])) ? $connect["ip"] : "";
        
        $this->azure_app_secret = (isset($connect["password"]) && $connect["password"] !== '') ? $connect["password"] : $this->netway_partnet_app_secret;
    }
    

    public function validateMicrosoftParnetCenterConfigs() 
    {
        try {
            if (empty($this->azure_tenant_id)) {
                throw new Exception('Azure tenant ID is empty!!');
            } else if (empty($this->azure_app_id)) {
                throw new Exception('Azure app ID is empty!!');
            } else if (empty($this->azure_app_secret)) {
                throw new Exception('Azure app secret is empty!!');
            }
            return true;
        } catch (Exception $ex) {
            echo $ex->getMessage(); exit;
            throw new Exception($ex->getMessage());
        }
    }
        
    /**
     * HostBill will call this method when admin clicks on "test Connection" in settings->apps
     * It should test connection to remote app using details provided in connect method
     *
     * Use $this->addError('message'); to provide errors details (if any)
     *
     * http://xxx.xxx.xxx.xxx/public_html/admin/index.php?cmd=servers&action=test_connection
     *
     * @see connect
     * @return boolean true if connection suceeds
     */
    public function testConnection() 
    {
        try {
            if ($this->validateMicrosoftParnetCenterConfigs()) {
                $oAzureApi = new AzureApi($this->azure_resource_url, $this->azure_tenant_id, $this->azure_app_id, $this->azure_app_secret, 60);
                if ($oAzureApi->access_token_is_active() == false) {
                    throw new Exception('After authentication to microsoftonline access token is not active!!');
                } else {
                    $aUsagesummary = $oAzureApi->getPartnerUsagesummary();
                    if (isset($aUsagesummary['resourceId']) && $aUsagesummary['resourceId'] == $this->azure_tenant_id) {
                        return true;
                    } else {
                        throw new Exception('Not response "resourceId" after try get usagesummary with partner API!!');    
                    }
                }
            }
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
            return false;
        }
    }


    function connectMsPartnerCenter()
    {
        try {
            if ($this->validateMicrosoftParnetCenterConfigs()) {
                $oAzureApi = new AzureApi($this->azure_resource_url, $this->azure_tenant_id, $this->azure_app_id, $this->azure_app_secret, 60);
                if ($oAzureApi->access_token_is_active() == false) {
                    throw new Exception('After authentication to microsoftonline access token is not active!!');
                } else {
                    return $oAzureApi;
                }
            }
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
            return false;
        }
    }


    /**
     * This method is invoked automatically when creating an account.
     * @return boolean true if creation succeeds
     */

    /// ใช้ test https://billing.netway.co.th.develop/7944web/?cmd=accounts&action=edit&id=32821
    public function Create() 
    {
        try {
            $db  = hbm_db();
            $api = new hbApiWrapper();
            
            $aQueueMsOrder = $db->query('
            SELECT 
            ms_order_id, ms_customer_id, hb_account_id
            FROM 
            ms_order_queue
            WHERE
            hb_account_id = :hb_account_id
            AND status = 1
            ', array(
                ':hb_account_id' => $this->account_details['id'],
                )
                )->fetchAll();
                

            if (count($aQueueMsOrder) <=0) {
                ///////////////////////////////////////////////////
                // Find invoice id 
                ///////////////////////////////////////////////////
                $aGetOrderDetail = $api->getOrderDetails(array(
                    'id' => $this->account_details['order_id']
                ));

                if (empty($aGetOrderDetail['success']) || !$aGetOrderDetail['success']) {
                    $errorMessage = isset($aGetOrderDetail['message']) 
                    ? $aGetOrderDetail['message'] 
                    : 'Cannot get detail order ID: ' . $this->account_details['order_id'];
                    throw new Exception($errorMessage);
                }

                $aOrderDetail = $aGetOrderDetail['details'];
                $this->account_details['invoice_id'] = $aOrderDetail['invoice_id'];

                $aGetConfig2Accounts = $api->getConfig2Accounts(array(
                    'account_id' => $this->account_details['id'],
                ));

                $hbFormQuantity = intval($this->account_details['forms']['quantity']['qty']);
                $hbFormMicrosoftID = trim($this->account_details['forms']['microsoft_id']['value']);
                $hbBillingcycle = trim($this->account_details['billingcycle']);
            
                ///////////////////////////////////////////////////
                // 1. Get hostbill client details for this account.
                ///////////////////////////////////////////////////
                $aClientDetails = $api->getClientDetails(array(
                    'id' => $this->account_details["client_id"]
                ));

                if (empty($aClientDetails['success']) || empty($aClientDetails['client'])) {
                    throw new Exception('Have problem to get hostbill client details!!');
                } else {
                    $aClientDetails = $aClientDetails['client'];
                }
                
                ///////////////////////////////////////////////////
                // 2. Validate hostbill product for this account have setup ms offer id.
                ///////////////////////////////////////////////////
                $msOfferID = null;
                if (empty($this->account_details['options']['ms_offer_id']) || trim($this->account_details['options']['ms_offer_id']) == '') {
                    throw new Exception('ยังไม่ได้ทำการกำหนด "Microsoft offer", โปรดไปหน้า  product detail แท็บ "Connect with App" จากนั้นกดปุ่ม "Get values from server" และทำการเลือก "Microsoft Offer" ให้ถูกต้อง.');   
                } else {
                    $msOfferID = $this->account_details['options']['ms_offer_id'];
                }


                ///////////////////////////////////////////////////
                // 3. Validate variable "domain" in hostbill account.
                ///////////////////////////////////////////////////
                $domain = null;
                if (!empty($this->account_details['domain'])) {
                    $domain = $this->account_details['domain'];
                } else if (!empty($this->account_config['domain_name']['value'])) {
                    $domain = $this->account_config['domain_name']['value'];
                } else if (!empty($this->account_details['forms']['domain_name']['value'])) {
                    $domain = $this->account_details['forms']['domain_name']['value'];
                }


                if (is_null($domain) && $hbFormMicrosoftID == '') {
                    throw new Exception('Domain is empty!!');   
                }

                ///////////////////////////////////////////////////
                // 4. Format domain name เพื่อจะนำไปใช้บน ms partner center ขอเรียกว่า ms domain
                // รูปแบบคือ ตัดอักขระพิเศษใน domain ออกทั้งหมด แล้วต่อด้วย ".onmicrosoft.com"
                ///////////////////////////////////////////////////
                $msPrimaryDomain = (preg_match('/\.onmicrosoft\.com/', trim($domain), $aMatch)) ? strtolower(trim($domain)) : preg_replace("/[^A-Za-z0-9]/","", strtolower(trim($domain))) . '.onmicrosoft.com';
                
                /**
                 * @TODO: กำลัง test เลย lock ชื่อเอาไว้ 
                */
                //$msPrimaryDomain = 'actechthailand.onmicrosoft.com';
                
                $oMsPartnerCenter = $this->connectMsPartnerCenter();

                $aMsCustomerInfo = array(
                    'tenantId' => null
                );
                
                ///////////////////////////////////////////////////
                // 5. ตรวจสอบว่าจะต้องทำการ create microsoft customer หรือไม่
                ///////////////////////////////////////////////////
                if ($hbFormMicrosoftID != '') {
                    ///////////////////////////////////////////////////
                    // 5.1 กำหนด Microsoft ID ไว้ใน hostbill
                    ///////////////////////////////////////////////////
                    $aResMsCustomerInfo = $oMsPartnerCenter->partnerApiGetCustomerInfoID(strtolower(trim($hbFormMicrosoftID)));
                    if (count($aResMsCustomerInfo) > 0) {
                        $aMsCustomerInfo['tenantId'] = strtolower(trim($hbFormMicrosoftID));
                        $aMsCustomerInfo['domain'] = trim($aResMsCustomerInfo['companyProfile']['domain']);
                        $aMsCustomerInfo['billingProfile'] = array(
                            'companyName' => $aResMsCustomerInfo['companyProfile']['companyName']
                        );
                        $aMsCustomerInfo['__createNew'] = false;
                        $msPrimaryDomain = trim($aResMsCustomerInfo['companyProfile']['domain']);
                    } else {
                        ///////////////////////////////////////////////////
                        // 5.1.2  ไม่พบ Microsoft ID อยู่ภายใต้การดูแลของเรา จบการทำงาน
                        // Response ข้อความ error แจ้งเตือนออกไป 
                        ///////////////////////////////////////////////////
                        throw new Exception('ไม่พบ Microsoft ID: "' . $hbFormMicrosoftID . '" ที่ Microsoft Partner Center.');
                    }
                } else {
                    ///////////////////////////////////////////////////
                    // 5.2 ไม่ได้กำหนด Microsoft ID ไว้ใน hostbill ให้ตรวจสอบ $msPrimaryDomain
                    ///////////////////////////////////////////////////
                    $aVerify = $oMsPartnerCenter->partnerApiVerifyDomainAvailability($msPrimaryDomain);

                    if ($aVerify['http_code'] == '200') {
                        ///////////////////////////////////////////////////
                        // 5.2.1 ชื่อ ms domain มีการใช้งานอยู่แล้ว
                        // ตรวจสอบต่อไปว่า customer เจ้าของ ms domain นี้ อยู่ภายใต้การดูแลของเราหรือไม่ 
                        ///////////////////////////////////////////////////
                        $aFillter = array("Field" => "domain", "Value" => $msPrimaryDomain, "Operator" => "starts_with");
                        $aMsCustomerList = $oMsPartnerCenter->partnerApiGetCustomers($aFillter);
                        if (isset($aMsCustomerList['items'])) {
                            foreach($aMsCustomerList['items'] as $aItem) {
                                if (strtolower(trim($aItem['companyProfile']['domain'])) == strtolower(trim($msPrimaryDomain))) {
                            ///////////////////////////////////////////////////
                            // 5.2.1.1  customer เจ้าของ ms domain นี้ อยู่ภายใต้การดูแลของเรา สามารถทำขั้นตอนต่อไปได้
                            // Flag: ไม่ต้องสร้าง Microsoft Customer
                            ///////////////////////////////////////////////////
                                    $aMsCustomerInfo['tenantId'] = strtoupper(trim($aItem['id']));
                                    $aMsCustomerInfo['domain'] = trim($aItem['companyProfile']['domain']);
                                    $aMsCustomerInfo['billingProfile'] = array(
                                        'companyName' => $aItem['companyProfile']['companyName']
                                    );
                                    $aMsCustomerInfo['__createNew'] = false;
                                    break;
                                }
                            }
                        }
                        if ($aMsCustomerInfo['tenantId'] == null) {
                            ///////////////////////////////////////////////////
                            // 5.2.1.2  customer เจ้าของ ms domain นี้ ไม่ได้อยู่ภายใต้การดูแลของเรา จบการทำงาน
                            // Response ข้อความ error แจ้งเตือนออกไป 
                            ///////////////////////////////////////////////////
                            throw new Exception('Verify domain availability on microsoft.<br />Domain "' . $msPrimaryDomain . '" is already in use.');
                        }
                    } else {
                        ///////////////////////////////////////////////////
                        // 5.2.2 ms domain ยังไม่มีการใช้งาน สามารถถสร้างได้
                        ///////////////////////////////////////////////////
                        $this->addInfo('Domain "' . $msPrimaryDomain . '" is available.');
                    }
                }
                
                ///////////////////////////////////////////////////
                // 6. ตรวจสอบว่าจะต้อง create ms customer หรือไม่
                ///////////////////////////////////////////////////
                if ($aMsCustomerInfo['tenantId']  != null) {
                    ///////////////////////////////////////////////////
                    // 6.1 ไม่ต้อง create ms customer
                    ///////////////////////////////////////////////////
                    $this->addInfo('Domain "' . $msPrimaryDomain . '" มีการใช้งานอยู่ภายใต้ relationship ของเรา. (Microsoft Customer ID: "' . $aMsCustomerInfo['tenantId'] . '")');
                } else {
                    ///////////////////////////////////////////////////
                    // 6.2 create ms customer
                    ///////////////////////////////////////////////////
                    $aBillingProfile = array(
                        'Culture' => 'en-US', 
                        'Email' => $aClientDetails['email'], 
                        'Language' => 'en', 
                        'CompanyName' => $aClientDetails['companyname']
                    );
                    $addressLine = $aClientDetails['address1'];
                    if (trim($aClientDetails['address2']) != '') {
                        $addressLine .= ' ' . trim($aClientDetails['address2']);
                    }
                    $aDefaultAddress = array(
                        'FirstName' => $aClientDetails['firstname'],
                        'LastName' => $aClientDetails['lastname'],
                        'AddressLine1' => $addressLine,
                        'City' => $aClientDetails['city'],
                        'State' => $aClientDetails['state'],
                        'PostalCode' => $aClientDetails['postcode'],
                        'Country' => $aClientDetails['country'],
                        'PhoneNumber' => isset($aClientDetails['phonenumber']) ? $aClientDetails['phonenumber'] : ''
                    );
                    
                    $aResCreateCustomer = $oMsPartnerCenter->partnerApiCreateCustomer($msPrimaryDomain, $aBillingProfile, $aDefaultAddress);
                    if (isset($aResCreateCustomer['code']) && isset($aResCreateCustomer['description'])) {
                        throw new Exception('Call create customer with microsoft partner center API has problem. ' . $aResCreateCustomer['description']);
                    } elseif (empty($aResCreateCustomer['commerceId'])) {
                        throw new Exception('Find not found "commerceId" after call create customer with microsoft partner center API.');
                    } else {
                        $aMsCustomerInfo['tenantId'] = strtoupper(trim($aResCreateCustomer['id']));
                        $aMsCustomerInfo['domain'] = trim($aResCreateCustomer['companyProfile']['domain']);
                        $aMsCustomerInfo['billingProfile'] = $aResCreateCustomer['billingProfile'];
                        $aMsCustomerInfo['__createNew'] = true;
                        $api->updateDataConfigItemsCatByAccountID(
                            $this->account_details["id"], 
                            $this->account_details['forms']['microsoft_id']['config_cat'], 
                            $this->account_details['forms']['microsoft_id']['config_id'], 
                            $aMsCustomerInfo['tenantId']
                        );
                    }
                }

                ///////////////////////////////////////////////////
                // 7. ดึงข้อมูล subscription ทั้งหมดของ ms customer
                ///////////////////////////////////////////////////
                $aMsSubscriptionList = array();
                if ($aMsCustomerInfo['__createNew'] != true) {
                    $aMsSubscriptionList = $oMsPartnerCenter->partnerApiGetSubscriptionsByCustomerID($aMsCustomerInfo['tenantId']);
                }

                ///////////////////////////////////////////////////
                // 8. Validate ว่ามีการ subscription ที่เป็น ms offer id เดียวกันหรือไม่
                ///////////////////////////////////////////////////
                $canOrderThisOfferID = true; 
                $usageInSubscriptionID = null;
                if (isset($aMsSubscriptionList['items'])) {
                    foreach ($aMsSubscriptionList['items'] as $aItem) {
                        if (strtoupper(trim($aItem['offerId'])) == strtoupper(trim($msOfferID))) {
                            $canOrderThisOfferID = false;
                            $usageInSubscriptionID = strtoupper(trim($aItem['id']));
                            break;
                        }
                    }
                }

                
                if ($canOrderThisOfferID == false) {
                    // 8.1 พบ subscription ที่เป็น ms offer id เดียวกัน
                    // Response ข้อความ error แจ้งเตือนออกไป 
                    ///////////////////////////////////////////////////
                    throw new Exception('ไม่สามารถทำการ create account ได้ เนื่องจาก พบว่า Microsoft Customer ID: ' . $aMsCustomerInfo['tenantId'] . ' ได้มีการใช้งาน Offer ID: ' . $msOfferID . ' อยู่ที่ Subscription ID: ' . $usageInSubscriptionID . '.');
                }

                echo '<pre>'; print_r($canOrderThisOfferID); print_r($usageInSubscriptionID); exit;
                
                ///////////////////////////////////////////////////
                // 9. Create an order
                ///////////////////////////////////////////////////
                $hbFormQuantity = 1;
                $msOrderBillingcycle = $this->formatHb2MsBillingCycleType($hbBillingcycle);
                $aMsOrder = $oMsPartnerCenter->partnerApiCreateAnOrder($aMsCustomerInfo['tenantId'],  $msOfferID, $hbFormQuantity, $msOrderBillingcycle);
                
                ///////////////////////////////////////////////////
                // 10. Check status after create an order on Microsoft partner center
                ///////////////////////////////////////////////////
                $_createNewMSOrder = true;
            } else {
                $_createNewMSOrder = false;
                $aMsOrder = $oMsPartnerCenter->partnerApiGetAnOrder($aQueueMsOrder['ms_customer_id'], $aQueueMsOrder['ms_order_id']);
            }
            $_createAccountStatus = false;
            if (isset($aMsOrder['status'])) {
                switch (strtolower($aMsOrder['status'])) {
                    case 'completed':
                        if (isset($aMsOrder['lineItems'][0]) && isset($aMsOrder['lineItems']['subscriptionId'])) {
                            $_msOrderSubscriptionId = trim(strtolower($aMsOrder['lineItems']['subscriptionId']));
                            /// @TODO: MS Order ID เตรียมเอาไปบันทึก OrderID กับ invoice_item (https://app.clickup.com/t/8a0v6n)
                            $_msOrderId = trim(strtolower($aMsOrder['id']));


                            $api->updateDataConfigItemsCatByAccountID(
                                $this->account_details["id"], 
                                $this->account_details['forms']['subscription_id']['config_cat'], 
                                $this->account_details['forms']['subscription_id']['config_id'], 
                                $_msOrderSubscriptionId
                            );
                            $aAccountSynch = $api->accountSynch(array('id'=>$this->account_details["id"]));
                            $db->query('
                            DELETE FROM
                                ms_order_queue
                            WHERE
                                hb_account_id = :hb_account_id
                            ', array(
                                ':hb_account_id' => $this->account_details["id"]
                            ));
                            $_createAccountStatus = true;
                        } else {
                            throw new Exception('Cannot find subscription id after created order on microsoft partner center!!');
                        }
                        break;
                    case 'pending':
                        if ($_createNewMSOrder) {
                            $_msOrderId = trim(strtolower($aMsOrder['id']));
                            $nextCheck = time() + 60000;
                            $db->query('
                                INSERT INTO 
                                    ms_order_queue (ms_order_id, ms_customer_id, hb_account_id, status, last_check, next_check, message) 
                                VALUES 
                                    (:ms_order_id, :ms_customer_id, :hb_account_id, :status, :next_check, :message)',
                                array(
                                    ':ms_order_id' => $_msOrderId,
                                    ':ms_customer_id' => $aMsCustomerInfo['tenantId'],
                                    ':hb_account_id' => $this->account_details["id"],
                                    ':status' => false,
                                    ':last_check' => time(),
                                    ':next_check' => $nextCheck,
                                    ':message' => 'Pending create order on microsoft partner center.'
                                )
                            );
                        }
                        throw new Exception('Pending create order on microsoft partner center.');
                        break;
                    case 'unknown':
                        throw new Exception('Create order on microsoft partner center response status unknown!!');
                        break;
                    case 'cancelled':
                        throw new Exception('Create order on microsoft partner center response status cancelled!!');
                        break;
                }
            }
            return $_createAccountStatus;
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
            return false;
        }
    }

    private function formatHb2MsBillingCycleType($hbBillingcycle) 
    {
        if (strtolower($hbBillingcycle) == 'annually') {
            return 'Annual';
        } else {
            return $hbBillingcycle;
        }
    }

    /**
     * This method is invoked automatically when suspending an account.
     * @return boolean true if suspend succeeds
     */
    public function Suspend() 
    {
        try {
            $api = new ApiWrapper();
            $hbFormMicrosoftID = trim($this->account_config['microsoft_id']['value']);
            if (empty($hbFormMicrosoftID) || $hbFormMicrosoftID == '') {
                throw new Exception('ยังไม่ได้ทำการกำหนด "Microsoft ID"!!');
            }
            $msOfferID = null;
            if (empty($this->account_details['options']['ms_offer_id']) || trim($this->account_details['options']['ms_offer_id']) == '') {
                throw new Exception('ยังไม่ได้ทำการกำหนด "Microsoft offer", โปรดไปหน้า  product detail แท็บ "Connect with App" จากนั้นกดปุ่ม "Get values from server" และทำการเลือก "Microsoft Offer" ให้ถูกต้อง.');   
            } else {
                $msOfferID = $this->account_details['options']['ms_offer_id'];
            }
            
            $oMsPartnerCenter = $this->connectMsPartnerCenter();
            $aMsSubscriptionList = array();
            $aMsSubscriptionList = $oMsPartnerCenter->partnerApiGetSubscriptionsByCustomerID($hbFormMicrosoftID);

            $usageInSubscriptionID = null;
            if (isset($aMsSubscriptionList['items'])) {
                foreach ($aMsSubscriptionList['items'] as $aItem) {
                    if (strtoupper(trim($aItem['offerId'])) == strtoupper(trim($msOfferID))) {
                        $canOrderThisOfferID = false;
                        $usageInSubscriptionID = strtoupper(trim($aItem['id']));
                        break;
                    }
                }
            }
            if (empty($usageInSubscriptionID) || $usageInSubscriptionID == '') {
                throw new Exception('Find not found subscription ID on Microsoft partner center!!');
            }

            $aSuspendDetail = $oMsPartnerCenter->partnerApiSuspendSubscription($hbFormMicrosoftID, $usageInSubscriptionID);
            if (isset($aSuspendDetail['Status']) && $aSuspendDetail['Status'] == 'suspended') {
                return true;
            } else {
                throw new Exception('After call API to suspend subscription microsoft partner center, it response status ' . $aSuspendDetail['Status']);
            }
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
            return false;
        }
    }

    private function _debug($message) 
    {
        if (is_string($message) == false) {
            echo '<pre>'; print_r($message); echo '</pre>';
            $message = json_encode($message);
        }
        $this->addInfo($message);
    }

    /**
     * This method is invoked automatically when unsuspending an account.
     * @return boolean true if unsuspend succeeds
     */
    public function Unsuspend() 
    {
        try {
            $api = new ApiWrapper();
            $hbFormMicrosoftID = trim($this->account_details['forms']['microsoft_id']['value']);
            $msOfferID = null;
            if (empty($this->account_details['options']['ms_offer_id']) || trim($this->account_details['options']['ms_offer_id']) == '') {
                throw new Exception('ยังไม่ได้ทำการกำหนด "Microsoft offer", โปรดไปหน้า  product detail แท็บ "Connect with App" จากนั้นกดปุ่ม "Get values from server" และทำการเลือก "Microsoft Offer" ให้ถูกต้อง.');   
            } else {
                $msOfferID = $this->account_details['options']['ms_offer_id'];
            }

            return true;
        } catch (Exception $ex) {
            return false;
        }
    }

    /**
     * This method is invoked automatically when terminating an account.
     * @return boolean true if termination succeeds
     */
    public function Terminate() 
    {
        return true;
    }

    /**
     *
     * Enter description here ...
     */
    public function Renewal() {
        // TODO Renewal.
        return true;
    }


    /**
     * This method is invoked when account should have password changed
     * @param string $newpassword New password to set account with
     * @return boolean true if action succeeded
     */
    public function ChangePassword($newpassword) {
        return true;
    }


    /**
     * This method is invoked when account should be upgraded/downgraded
     * $options variable is loaded with new package configuration
     * @return boolean true if action succeeded
     */
    public function ChangePackage() {
        return true;
    }


    /**
     * Auxilary method that HostBill will load to get plans from server:
     * @see $options variable above
     * @return array - list of plans to display in product configuration
     */
    public function getPlans() {
        return false;
    }


    /**
     * This method is OPTIONAL. in this example it is used to connect to the server and manage all the modules action with the API.
     *  @ignore
     */
    private function Send($action, $post) {
        return true;
    }

    /**
     * Synchronize remote account.
     * This method should use $this->details $this->options, etc arrays to return
     * basic info about user
     * @link: https://dev.hostbillapp.com/dev-kit/provisioning-modules/account-synchronization/
     * @return array|false
     */

    public function getSynchInfo() {
        try {
            include_once(__DIR__ . '/admin/class.o365_controller.php');
            $oO365Controller = new o365_controller();
            $aResult = $oO365Controller->getAzureSubscriptionByHBAccountID($this->account_details["id"]);

            $hasDataMicrosoftIdInHB = isset($aResult['hasDataMicrosoftIdInHB']) ? $aResult['hasDataMicrosoftIdInHB'] : false;
            if (!$hasDataMicrosoftIdInHB) {
                throw new Exception('ยังไม่ได้ทำการผูก Microsoft ID เข้ากับ Hostbill account! กรุณาผูก Microsoft ID เข้ากับ Hostbill account ก่อน');
            }

            $hasDataSubscriptIdInHB = isset($aResult['hasDataSubscriptIdInHB']) ? $aResult['hasDataSubscriptIdInHB'] : false;
            if (!$hasDataSubscriptIdInHB) {
                throw new Exception('ยังไม่ได้ทำการผูก Subscript ID เข้ากับ Hostbill account! กรุณาผูก Subscript ID เข้ากับ Hostbill account ก่อน');
            }

            $_aCheckItems = array();
            foreach ($aResult['aAzSubscription'] as $item) {
                if ($item['status'] =='active') {
                    array_push($_aCheckItems, array('quantity' => (int) $item['quantity'], 'next_due' =>  $item['commitmentEndDate']));
                }
            }

            if (count($_aCheckItems) <= 0) {
                throw new Exception('ไม่มีข้อมูล Subscription ที่ active บน Azure Partner Center.');
            } else if (count($_aCheckItems) > 1) {
                throw new Exception('ข้อมูล Subscription ที่ active บน Azure Partner Center มีมากกว่า 1 record.');
            }

            $aHBFieldconfigs = array();
            foreach ($aResult['aHbAccountInfo']['account_configs'] as $item) {
                if ($item['variable'] == 'quantity') {
                    $aHBFieldconfigs = $item;
                    break;
                }
            }

            if (count($aHBFieldconfigs) <= 0 || !isset($aHBFieldconfigs['config_cat']) || !isset($aHBFieldconfigs['config_id'])) {
                throw new Exception('Find not found field Seat Quantity in Hostbill account!!');
            }

            $pricePreUnit = 0;
            foreach ($aResult['aHbAccountInfo']['product_prices'] as $item) {
                $pricePreUnit = (float) $item['price'];
                break;
            }

            if (is_null($pricePreUnit)) {
                throw new Exception('Find not found product price in Hostbill account!!');
            }
            
            $aForUpdate = $_aCheckItems[0];
            $updateTotalPrice = (int) $aForUpdate['quantity'] * $pricePreUnit;
            
            $upNextDue = date("Y-m-d H:i:s", strtotime($aForUpdate['next_due']));
            $db        =    hbm_db();
            $db->query("
                UPDATE
                    hb_config2accounts
                SET 
                    qty = :quantity,
                    data = :quantity
                WHERE 
                    account_id = :accountId
                    AND config_cat = :configCat
                    AND config_id = :configId
            ", array(
                ':quantity'        => $aForUpdate['quantity'],
                ':accountId'        => $this->account_details["id"],
                ':configCat'        => $aHBFieldconfigs['config_cat'],
                ':configId'         => $aHBFieldconfigs['config_id']
            ));

            $db->query("
                UPDATE
                    hb_accounts
                SET 
                    total = :total,
                    next_due = :nextDue
                WHERE 
                    id = :accountId
            ", array(
                ':accountId' => $this->account_details["id"],
                ':total'     => $updateTotalPrice,
                ':nextDue' => $upNextDue
            ));

            $return=array(
                'next_due' => $upNextDue,
                'domain'=> $aResult['aHbAccountInfo']['account_detail']['domain'],
                'total' => $updateTotalPrice,
            );

            $message = 'Updated quantity to ' . $updateQuantity . ' seat(s) and updated recurring amount to '. money_format('%.2n', $updateTotalPrice) . ' has been successfully.';
            $this->addInfo($message);
            return $return;
        } catch (Exception $error) {
            $this->addError($error->getMessage());
            return false;
        }
    }
}
