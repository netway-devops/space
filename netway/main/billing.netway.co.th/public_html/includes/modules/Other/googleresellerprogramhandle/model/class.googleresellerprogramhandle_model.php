<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class googleresellerprogramhandle_model {

    private static  $instance;
    private $db;
     
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
    
    private function __construct () 
    {
        $this->db       = hbm_db();
        
    }

    public function listSubscription ()
    {
        $result     = $this->db->query("
            SELECT skuId
            FROM hb_google_reseller_subscription
            GROUP BY skuId
            ")->fetchAll();
        $result     = count($result) ? $result : array();

        $aSku       = array();
        foreach ($result as $arr) {            
            $aSku[] = $arr['skuId'];
        }

        $sql        = "
            SELECT product_id, options
            FROM `hb_products_modules`
            WHERE `options` = '---nodata---'
            ";
        foreach ($aSku as $v) {
            $sql    .= "
                OR `options` LIKE '%{$v}%'
                ";
        }
        $result     = $this->db->query($sql)->fetchAll();
        $result     = count($result) ? $result : array();
        
        $aProduct   = array();
        foreach ($result as $arr) {
            foreach ($aSku as $skuId) {
                if (preg_match('/'. $skuId .'/i', $arr['options'])) {
                    break;
                }
            }
            $aProduct[$arr['product_id']]   = $skuId;
        }

        $data   = array();
        foreach ($aProduct as $k => $v){
            $data[]     = " SELECT '{$k}' as productId, '{$v}' as skuId ";
        }
        
        $sql    = implode(' UNION ', $data);

        $sql    = "
            SELECT a.id, a.status, 
                grs.customerDomain, grs.numberOfSeats, grs.skuId, grs.skuName, grs.planName,
                grs.endTime, grs.customerId, grs.subscriptionId
            FROM hb_google_reseller_subscription grs
                LEFT JOIN ({$sql}) p ON p.skuId = grs.skuId
                LEFT JOIN hb_accounts a ON a.domain = grs.customerDomain
                    AND a.status IN ('Active', 'Suspended')
                LEFT JOIN ({$sql}) p2 ON p2.productId = a.product_id
            WHERE grs.status IN ('ACTIVE', 'SUSPENDED')
                AND a.id IS NULL
            GROUP BY grs.subscriptionId
            ORDER BY grs.customerDomain ASC
            LIMIT 100
            ";

        $result     = $this->db->query($sql)->fetchAll();
        $result     = count($result) ? $result : array();
        return $result;
    }

    public function getAccountById ($id)
    {
        $result     = $this->db->query("
            SELECT *
            FROM hb_accounts
            WHERE id = '{$id}'
            ")->fetch();
        $result     = isset($result['id']) ? $result : array();
        return $result;
    }

    public function getSubscriptionByDomain ($domain)
    {
        $result     = $this->db->query("
            SELECT *
            FROM hb_google_reseller_subscription
            WHERE customerDomain = '{$domain}'
            ")->fetchAll();
        $result     = count($result) ? $result : array();
        return $result;
    }
    
    public function update ($data)
    {
        $subscriptionId = isset($data['subscriptionId']) ? $data['subscriptionId'] : '';
        if (! $subscriptionId) {
            return false;
        }

        $customerId     = isset($data['customerId']) ? $data['customerId'] : '';

        $result     = $this->db->query("
            SELECT *
            FROM hb_google_reseller_subscription
            WHERE subscriptionId = :subscriptionId
                AND customerId = :customerId
            ", array(
                ':subscriptionId'   => $subscriptionId,
                ':customerId'       => $customerId,
            ))->fetch();
        
        $id         = isset($result['id']) ? $result['id'] : 0;

        $aData      = array(
            ':customerDomain'       => $data['customerDomain'],
            ':endTime'              => $data['endTime'],
            ':isCommitmentPlan'     => $data['isCommitmentPlan'],
            ':billingMethod'        => $data['billingMethod'],
            ':renewalSettings'      => $data['renewalSettings'],
            ':status'               => $data['status'],
            ':resourceUiUrl'        => $data['resourceUiUrl'],
            ':numberOfSeats'        => $data['numberOfSeats'] + 0,
            ':planName'             => $data['planName'],
            ':skuName'              => $data['skuName'],
            ':skuId'                => $data['skuId'],
            ':subscriptionId'       => $data['subscriptionId'],
            ':customerId'           => $data['customerId'],
            ':creationTime'         => $data['creationTime'],
        );
        
        $md5Data    = md5(serialize($aData));
        $aData['md5_data']      = $md5Data;
        $aData['sync_date']     = date('Y-m-d H:i:s');

        if ($id) {
            if ($result['md5_data'] == $md5Data) {
                $aData['sync_date']     = $result['sync_date'];
            }

            $this->db->query("
                UPDATE hb_google_reseller_subscription
                SET sync_date = :sync_date,
                    md5_data = :md5_data,
                    customerDomain = :customerDomain,
                    endTime = :endTime,
                    isCommitmentPlan = :isCommitmentPlan,
                    billingMethod = :billingMethod,
                    renewalSettings = :renewalSettings,
                    status = :status,
                    resourceUiUrl = :resourceUiUrl,
                    numberOfSeats = :numberOfSeats,
                    planName = :planName,
                    skuName = :skuName,
                    skuId = :skuId,
                    subscriptionId = :subscriptionId,
                    customerId = :customerId,
                    creationTime = :creationTime
                WHERE id = '{$id}'
                ", $aData);

        } else {
            $this->db->query("
                INSERT INTO hb_google_reseller_subscription (
                    id, creationTime, customerId, subscriptionId, skuId, skuName, planName,
                    numberOfSeats, resourceUiUrl, status, renewalSettings, billingMethod,
                    isCommitmentPlan, endTime, customerDomain, sync_date, md5_data
                ) VALUES (
                    '', :creationTime, :customerId, :subscriptionId, :skuId, :skuName, :planName,
                    :numberOfSeats, :resourceUiUrl, :status, :renewalSettings, :billingMethod,
                    :isCommitmentPlan, :endTime, :customerDomain, :sync_date, :md5_data
                )
                ", $aData);
            
        }
        
        return true;
    }

    public function pendingSync ($accountId = 0)
    {
        if ($accountId) {
            $result     = $this->getAccountById($accountId);
            $domain     = isset($result['domain']) ? $result['domain'] : '';
            $sql    = "
                SELECT *
                FROM hb_google_reseller_subscription
                WHERE customerDomain = '{$domain}'
                ORDER BY sync_date ASC
                LIMIT 100
                ";
        } else {
            $sql    = "
                SELECT *
                FROM hb_google_reseller_subscription
                WHERE sync_date != sync_account_date
                ORDER BY sync_date ASC
                LIMIT 100
                ";
        }
        $result     = $this->db->query($sql)->fetchAll();
        
        $result     = count($result) ? $result : array();
        
        return $result;
    }

    public function getAccount ($data)
    {
        $customerDomain     = $data['customerDomain'];
        $skuId              = $data['skuId'];

        $aProductId = array();

        $result     = $this->db->query("
            SELECT *
            FROM `hb_products_modules`
            WHERE `options` LIKE '%". $skuId ."%'
            ")->fetchAll();
        
        if (! count($result)) {
            return false;
        }

        foreach ($result as $arr) {
            array_push($aProductId, $arr['product_id']);
        }

        $result     = $this->db->query("
            SELECT *
            FROM hb_accounts
            WHERE domain = '". $customerDomain ."'
                AND status IN ('Pending','Active','Suspended')
                AND product_id IN (". implode(',', $aProductId) .")
            ")->fetchAll();

        if (count($result) != 1) {
            return false;
        }
        
        $result     = $result[0];
        return $result;
    }

    public function updateSync ($id)
    {
        $this->db->query("
            UPDATE hb_google_reseller_subscription
            SET sync_account_date = sync_date
            WHERE id = '{$id}'
            ");
    }

    public function recalculate ()
    {
        $this->db->query("
            UPDATE hb_gsuite_price_adjustment
            SET is_calculate = 0
            WHERE 1
            ");
    }
    
    public function listPendingCalculate ()
    {
        $result     = $this->db->query("
            SELECT a.*
            FROM hb_accounts a
                LEFT JOIN hb_gsuite_price_adjustment g
                    ON g.account_id = a.id,
                hb_products p
            WHERE a.product_id = p.id
                AND a.status IN ('Pending', 'Active', 'Suspended')
                AND p.category_id = 8
                AND ( g.account_id IS NULL OR g.is_calculate = 0)
            LIMIT 10
            ")->fetchAll();
        
        $result     = count($result) ? $result : array();

        return $result;
    }
    
    public function getSeatByAccountId ($accountId)
    {
        $result     = $this->db->query("
            SELECT c2a.*
            FROM hb_config2accounts c2a,
                hb_config_items_cat cic
            WHERE c2a.rel_type = 'Hosting'
                AND c2a.account_id = '{$accountId}'
                AND c2a.config_cat = cic.id
                AND cic.variable = 'quantity'
            ")->fetch();
        
        $result     = isset($result['qty']) ? $result['qty'] : 0;

        return $result;
    }

    public function updatePriceAdjustment ($accountId, $data)
    {
        $seat           = $data['seat'];

        $this->db->query("
            REPLACE INTO hb_gsuite_price_adjustment (
                sync_date, account_id, seat, is_calculate
            ) VALUES (
                NOW(), :account_id, :seat, 1
            )
            ", array(
                ':account_id'   => $accountId,
                ':seat'         => $seat,
            ));
    }

    public function listLatestSync ()
    {
        $result     = $this->db->query("
            SELECT 
                a.id, a.domain, a.next_due, a.expiry_date, a.billingcycle, a.total, a.status, a.product_id
                , p.name
                , g.seat, g.sync_date
            FROM hb_gsuite_price_adjustment g,
                hb_accounts a,
                hb_products p
            WHERE g.account_id = a.id
                AND a.product_id = p.id
                AND a.billingcycle LIKE '%ly'
            ORDER BY a.next_due ASC
            ")->fetchAll();
        
        $result     = count($result) ? $result : array();

        return $result;
    }

    public function updateRecuring ($accountId, $total)
    {
        $this->db->query("
            UPDATE hb_accounts
            SET total = :total
            WHERE id = :id
            ", array(
                ':id'       => $accountId,
                ':total'    => $total,
            ));
    }

    

}
