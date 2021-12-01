<?php

require_once __DIR__ . '/model/class.googleresellerprogramhandle_model.php';

class googleresellerprogramhandle extends OtherModule {
    
    protected $modname      = 'GSuite Account List (googleresellerprogramhandle)';
    protected $description  = '***NETWAY*** ตัวจัดการเสริม reseller program google
    <br />
    - ดูรายการ account ที่ยังมีการใช้งานอยู่บน GSuite แต่ไม่มีการเรียกเก็บบน billing <a target="_blank" href="https://billing.netway.co.th/7944web/index.php?cmd=googleresellerprogramhandle">https://billing.netway.co.th/7944web/index.php?cmd=googleresellerprogramhandle</a>
    ';

    protected $info         = array(
        'orders_menu'       => true,
    );

    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }
        
        return self::$instance;
    }
    
    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }


    /**
     * Returns an authorized API client.
     * @return Google_Client the authorized client object
     */
    public function getClient ()
    {
        $credentialPath     = dirname(MAINDIR) .'/google-cli/';
        $client = new Google_Client();
        $client->setApplicationName('G Suite Reseller API PHP Quickstart');
        $client->setScopes(Google_Service_Reseller::APPS_ORDER);
        $client->setAuthConfig($credentialPath .'credentials.json');
        $client->setAccessType('offline');
        $client->setPrompt('select_account consent');

        // Load previously authorized token from a file, if it exists.
        // The file token.json stores the user's access and refresh tokens, and is
        // created automatically when the authorization flow completes for the first
        // time.
        $tokenPath = $credentialPath .'token.json';
        if (file_exists($tokenPath)) {
            $accessToken = json_decode(file_get_contents($tokenPath), true);
            $client->setAccessToken($accessToken);
        }

        // If there is no previous token or it's expired.
        if ($client->isAccessTokenExpired()) {
            return false;
        }
        return $client;
    }
    
    public function sync ()
    {
        require_once __DIR__ . '/libs/vendor/autoload.php';

        $db         = hbm_db();
        
        require_once(APPDIR . 'class.config.custom.php');

        $nwGoogleResellerSubscriptionList   = ConfigCustom::singleton()->getValue('nwGoogleResellerSubscriptionList');
        $nwGoogleResellerSubscriptionList   = $nwGoogleResellerSubscriptionList ? unserialize($nwGoogleResellerSubscriptionList) : array();
        $nextPageToken  = isset($nwGoogleResellerSubscriptionList['nextPageToken']) ? $nwGoogleResellerSubscriptionList['nextPageToken'] : '';

        // Get the API client and construct the service object.
        $client     = $this->getClient();
        if (! $client) {
            return array('error' => 'Token expired.');
        }
        $service    = new Google_Service_Reseller($client);
        // Print the first 10 subscriptions you manage.
        $optParams  = array(
          'maxResults'  => 100,
        );
        if ($nextPageToken) {
            $optParams['pageToken'] = $nextPageToken;
        }
        $results    = $service->subscriptions->listSubscriptions($optParams);
        
        $kind       = $results->getKind();
        $totalSubscription  = count($results->getSubscriptions());
        $nextPageToken      = $totalSubscription ? $results->getNextPageToken() : '';
        $nwGoogleResellerSubscriptionList   = array(
            'kind'  => $kind,
            'subscriptions'  => $totalSubscription,
            'nextPageToken'  => $nextPageToken,
        );
        $nwGoogleResellerSubscriptionList   = serialize($nwGoogleResellerSubscriptionList);
        ConfigCustom::singleton()->setValue('nwGoogleResellerSubscriptionList', $nwGoogleResellerSubscriptionList);

        if (! $totalSubscription) {
            return array();
        }

        foreach ($results->getSubscriptions() as $subscription) {

            $creationTime   = $subscription->getCreationTime();
            $customerId     = $subscription->getCustomerId();
            $subscriptionId = $subscription->getSubscriptionId();
            $skuId          = $subscription->getSkuId();
            $skuName        = $subscription->getSkuName();
            $planName       = $subscription->getPlan()->getPlanName();
            $numberOfSeats  = $subscription->getSeats()->getNumberOfSeats();
            $customerDomain = $subscription->getCustomerDomain();
            $resourceUiUrl  = $subscription->getResourceUiUrl();
            $status         = $subscription->getStatus();
            $renewalSettings    = '';//$subscription->getRenewalSettings()->getRenewalType();
            $billingMethod  = $subscription->getBillingMethod();
            $isCommitmentPlan   = $subscription->getPlan()->getIsCommitmentPlan();
            $endTime        = $isCommitmentPlan ? $subscription->getPlan()->getCommitmentInterval()->getEndTime() : 0;
            
            $aData      = array(
                'creationTime'      => $creationTime,
                'customerId'        => $customerId,
                'subscriptionId'    => $subscriptionId,
                'skuId'             => $skuId,
                'skuName'           => $skuName,
                'planName'          => $planName,
                'numberOfSeats'     => $numberOfSeats,
                'customerDomain'    => $customerDomain,
                'resourceUiUrl'     => $resourceUiUrl,
                'status'            => $status,
                'renewalSettings'   => $renewalSettings,
                'billingMethod'     => $billingMethod,
                'isCommitmentPlan'  => $isCommitmentPlan,
                'endTime'           => $endTime,
            );

            googleresellerprogramhandle_model::singleton()->update($aData);
            
        }

        return $nwGoogleResellerSubscriptionList;
    }

    public function syncAccount ($accountId = 0)
    {
        $db         = hbm_db();
        $api        = new ApiWrapper();
        
        return true; # ใช้ไม่ได้

        $result     = googleresellerprogramhandle_model::singleton()->pendingSync($accountId);
        
        if (! count($result)) {
            return false;
        }

        $result_    = $result;
        foreach ($result_ as $arr) {
            $customerDomain     = $arr['customerDomain'];
            $skuId              = $arr['skuId'];
            $status             = $arr['status'];
            $endTime            = $arr['endTime'] ? date("Y-m-d", substr($arr['endTime'], 0, 10)) : '';
            
            $aParam     = array(
                'customerDomain'    => $customerDomain,
                'skuId'             => $skuId,
            );
            $result     = googleresellerprogramhandle_model::singleton()->getAccount($aParam);
            
            if (isset($result['id']) && $endTime) {
                
                $nextDue    = $endTime;
                $status_    = '';

                switch ($status) {
                    case 'ACTIVE': {
                        $status_    = 'Active';
                        break;
                    }
                    case 'SUSPENDED': {
                        $status_    = 'Suspended';
                        break;
                    }
                    default : {
                        $nextDue    = $result['next_due'];
                    }
                }

                $aParam     = array(
                    'id'    => $result['id'],
                    'next_due'      => $nextDue,
                );
                if ($status_) {
                    $aParam['status']   = $status_;
                }
                // ใช้ไม่ได้ $return = $api->editAccountDetails($aParam);

            }

            googleresellerprogramhandle_model::singleton()->updateSync($arr['id']);

        }

        return true;
    }

}
