<?php

/**
 * 
 * Hostbill Dao
 * 
 * @auther Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
 */

class ManageServiceDao {
    
    protected $db;
    
    /**
     * 
     * Enter description here ...
     */
    public function __construct() {
        $this->db = hbm_db();
    }
    
    /**
     * Returns a singleton HostbillApi instance.
     *
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
     * @param bool $autoload
     * @return obj
     * 
     */
     public function &singleton($autoload=false) {
        static $instance;
        // If the instance is not there, create one
        if (!isset($instance) || $autoload) {
            $class = __CLASS__;
            $instance = new $class();
        }
        return $instance;
    }
   
   
    /**
     * Is check box managed by account
     * 
     * @param $accountID
     * @return BOOLEAN
     * 
     * @example ManageServiceDao::singleton()->isCheckBoxManagedByAccountId("3528")
     */
    public function isCheckBoxManagedByAccountId($accountID="") {
 
        $query = sprintf("   
                            SELECT
                                c2a.account_id
                            FROM 
                                %s c2a
                                , %s cic
                                , %s ci
                            WHERE
                                c2a.account_id='%s'
                            AND
                                c2a.rel_type='Hosting'
                            AND 
                                c2a.qty='1'
                            AND
                                c2a.data='1'
                            AND
                                c2a.config_cat=cic.id
                            AND
                                cic.variable='managed'
                            AND
                                c2a.config_id=ci.id
                            AND
                                ci.variable_id='managed_paid'                                                                 
                            "
                            , "hb_config2accounts"
                            , "hb_config_items_cat"
                            , "hb_config_items"
                            , $accountID
        );

        $aRes = $this->db->query($query)->fetchAll();
        
        return (count($aRes)>0 && isset($aRes[0]["account_id"]) && $aRes[0]["account_id"] != '') ? true : false;
        
    }

    /**
     * 
     * Is Check Addons
     * Fix: ID:
     * OR
     * Addons Name: 'Premium Managed Server Services'
     * AND
     * Status: Active
     * 
     */
    public function isCheckAddonsPremium($accountID='') {
            $query = sprintf("   
                            SELECT
                                acad.account_id
                            FROM 
                                %s acad
                            WHERE
                                acad.account_id='%s'
                            AND
                                (
                                        acad.addon_id='49'
                                    OR 
                                        acad.name='Premium Managed Server Services'
                                )
                            AND
                                acad.status='Active'                                                                 
                            "
                            , "hb_accounts_addons"
                            , $accountID
        );

        $aRes = $this->db->query($query)->fetchAll();
        
        return (count($aRes)>0 && isset($aRes[0]["account_id"]) && $aRes[0]["account_id"] != '') ? true : false;
    }
    
}