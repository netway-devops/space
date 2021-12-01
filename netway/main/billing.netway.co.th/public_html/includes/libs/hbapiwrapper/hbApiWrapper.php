<?php
class hbApiWrapper extends ApiWrapper
{
    function __construct()
    {
        parent::__construct();
        $this->db = hbm_db();
    }

    /**
     * Get config items cat by product ID
     * 
     * @access public
     * @param string $productID; // Product ID
     * 
     * @return array = [
     *      'success'           => (bool), // Status
     *      'product_id'        => (string),  Product ID
     *      'config_items_cat'  => (mixed), 
     *      'call'              => (string), // Method name
     *      'server_time'       => (timestamp)
     * ]
     */
    public function getConfigItemsCatByProductID($productID)
    {
        try {
            $aQuery = $this->db->query("
                SELECT * 
                FROM 
                    hb_config_items_cat
                WHERE
                    product_id = :product_id
            ", array(
                ':product_id'        => $productID
            ))->fetchAll();
            
            return array(
                'success' => true,
                'product_id' => $productID,
                'config_items_cat' => $aQuery,
                'call' => 'getConfigItemsCatByProductID',
                'server_time' => time()
            );

        } catch (Exception $error) {
            return array(
                'success' => false,
                'message' => $error->getMessage()
            );
        }
    }

    public function getAccountDetails($aParam) 
    {
        return parent::getAccountDetails($aParam);
    }

    public function getConfigItemsCatByAccountID($accountID) 
    {
        try {
            $result    =    $this->db->query("
                SELECT
                    f.name, f.variable, ac.config_cat, ac.config_id, ac.data, ac.qty
                FROM 
                    hb_accounts acc
                    INNER JOIN hb_config2accounts ac ON ( acc.id = ac.account_id )
                    INNER JOIN hb_config_items_cat f ON ( ac.config_cat = f.id )
                    INNER JOIN hb_products p ON (acc.product_id = p.id)
                WHERE 
                    acc.id = :account_id
                ",array(
                    ':account_id'    =>    $accountID
                ))->fetchAll();
            
            return array(
                'success' => true,
                'account_id' => $accountID,
                'config_items_cat' => $result,
                'call' => 'getAccountConfigItemsCat',
                'server_time' => time()
            );

        } catch (Exception $error) {
            return array(
                'success' => false,
                'message' => $error->getMessage()
            );
        }
    }

    private function makeStringQuery($old, $query, $option)
    {
        if (trim($old) == '') {
            return $query;
        } else {
            return $old . ' ' . $option . ' '.$query;
        }
    }

    /**
     * Get config to accounts
     * 
     * @access public
     * @param array $aParams; 
     *      $aParams = [
     *          'account_id'    => (string), // Account ID
     *          'config_cat'    => (string), // Config Category ID
     *          'config_id'     => (string), // Config ID
     *      ]
     * @return array [
     *      'success'           => (bool), // Status
     *      'config2account'    => (mixed), 
     *      'call'              => (string), // Method name
     *      'server_time'       => (timestamp)
     *  ]
     */
    public function getConfig2Accounts($aParams=array())
    {
        try {
            $whereQuery = '';
            $aValue2Query = array();

            if (isset($aParams['account_id'])) {
                $whereQuery = $this->makeStringQuery($whereQuery, 'account_id = :accountId', 'AND'); 
                $aValue2Query['accountId'] = $aParams['account_id'];
            }
            if (isset($aParams['config_cat'])) {
                $whereQuery = $this->makeStringQuery($whereQuery, 'config_cat = :configCat', 'AND'); 
                $aValue2Query['configCat'] = $aParams['config_cat'];
            }
            if (isset($aParams['config_id'])) {
                $whereQuery = $this->makeStringQuery($whereQuery, 'config_id = :configId', 'AND'); 
                $aValue2Query['configId'] = $aParams['config_id'];
            }
            
            $strQuery = "
                SELECT
                    rel_type, account_id, config_cat, config_id, qty, data
                FROM
                    hb_config2accounts
            ";
            if (trim($whereQuery) != '') {
                $strQuery .= ' WHERE ' . $whereQuery;
            }
            
            $result    =    $this->db->query($strQuery, $aValue2Query)->fetchAll();
            return array(
                'success' => true,
                'config2account' => $result,
                "call" => "getConfig2Accounts",
                "server_time" => time()
            );
        } catch (Exception $error) {
            return array(
                'success' => false,
                'message' => $error->getMessage()
            );
        }
    }

    public function updateQuantityConfigItemsCatByAccountID($accountID, $configCatID, $configID, $quantity)
    {
        try {
            $result    =    $this->db->query("
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
                ':quantity'        => $quantity,
                ':accountId'        => $accountID,
                ':configCat'        => $configCatID,
                ':configId'         => $configID
            ));
            return array(
                'success' => true,
                "call" => "updateQuantityConfigItemsCatByAccountID",
                "server_time" => time()
            );
            
        } catch (Exception $error) {
            return array(
                'success' => false,
                'message' => $error->getMessage()
            );
        }

    }

    public function updateDataConfigItemsCatByAccountID($accountID, $configCatID, $configID, $data)
    {
        try {
            $result    =    $this->db->query("
                UPDATE
                    hb_config2accounts
                SET 
                    data = :data
                WHERE 
                    account_id = :accountId
                    AND config_cat = :configCat
                    AND config_id = :configId
            ", array(
                ':data'        => $data,
                ':accountId'        => $accountID,
                ':configCat'        => $configCatID,
                ':configId'         => $configID
            ));
            return array(
                'success' => true,
                "call" => "updateQuantityConfigItemsCatByAccountID",
                "server_time" => time()
            );
        } catch (Exception $error) {
            return array(
                'success' => false,
                'message' => $error->getMessage()
            );
        }
    }

    public function moduleIsActive($name)
    {
        $aQueryModules = $this->db->query("
            SELECT 
                *
            FROM
                hb_modules_configuration
            WHERE
                module = :name
                AND active = 1
            ;
        ", array(
            ':name' => $name
        ))->fetchAll();
        
        if (count($aQueryModules) > 0) {
            return true;
        } else {
            return false;
        }
    }

    public function getCategory($id)
    {
        $aQuery = $this->db->query("
            SELECT 
                *
            FROM
                hb_categories
            WHERE
                id = :id
            ;
        ", array(
            ':id' => $id
        ))->fetchAll();
        
        return array(
            'success' => false,
            'category' => (count($aQuery) > 0) ? $aQuery[0] : array()
        );
    }
}