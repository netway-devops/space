<?php
include_once(APPDIR . "libs/hbapiwrapper/hbApiWrapper.php");
include_once(APPDIR_MODULES . "Other/o365_management/include/class.common_hb_controller.php");
class o365_management_controller extends AzurePartnerCenterManagementCommonHBController {

    var $module = 'o365_management';
    function call_EveryRun()
    {
        $db  = hbm_db();
        $aResult = $db->query('
            SELECT 
                ms_order_id, ms_customer_id, hb_account_id
            FROM 
                ms_order_queue
            WHERE
                next_check <=  NOW()
                AND status = 0
            ', array(
                ':thisTime' => time()
            )
        )->fetchAll();
        
        foreach ($aResult as $item) {
            try {
                $aGetAccountDetails =  $this->hbApi()->getAccountDetails(array('id' => $item['hb_account_id']));
                if (isset($aGetAccountDetails['details'])) {
                    $aAccountDetails = $aGetAccountDetails['details'];
                    $oMSPartnerConn = $this->connectMicrosoftPartnerCenterWithHBServerID($aAccountDetails['server_id']);
                    $aMsOrder = $oMSPartnerConn->partnerApiGetAnOrder($item['ms_customer_id'], $item['ms_order_id']);
                    if (isset($aMsOrder['status'])) {
                        switch (strtolower($aMsOrder['status'])) {
                            case 'completed':
                                $db->query('
                                    UPDATE
                                        ms_order_queue 
                                    SET
                                        status = :status
                                        last_check =  NOW(),
                                        message = :message
                                    WHERE 
                                        ms_order_id = :ms_order_id',
                                    array(
                                        ':ms_order_id' => $item['ms_order_id'],
                                        ':status' => true,
                                        ':last_check' => time(),
                                        ':message' => 'completed',
                                    )
                                );
                                $this->hbApi()->accountCreate(array('id' => $item['hb_account_id']));
                                break;
                            case 'pending':
                                $db->query('
                                    UPDATE
                                        ms_order_queue 
                                    SET
                                        status = :status
                                        last_check =  NOW(),
                                        message = :message
                                    WHERE 
                                        ms_order_id = :ms_order_id',
                                    array(
                                        ':ms_order_id' => $item['ms_order_id'],
                                        ':last_check' => time(),
                                        ':next_check' => $nextCheck,
                                        ':message' => 'pending',
                                    )
                                );
                                break;
                            case 'unknown':
                                throw new Exception('Create order on microsoft partner center response status unknown!!');
                                break;
                            case 'cancelled':
                                $return = $this->hbApi()->editAccountDetails(array(
                                    'id' => $item['hb_account_id'],
                                    'status' => 'Cancelled',
                                    'notes' => 'Create order on microsoft partner center response status cancelled. (microsoft cuatomer ID: '. $item['ms_customer_id']. ' microsoft order ID: ' . $item['ms_order_id'] . ')'
                                ));
                                break;
                        }
                    }
                } else {
                    throw new Exception('Cannot get details hostbill account ID: ' . $item['hb_account_id'] . '!!');
                }
            } catch (Exception $error) { 
                $nextCheck = time() + 60000;
                $db->query('
                    UPDATE
                        ms_order_queue 
                    SET
                        next_check = :next_check, 
                        last_check =  NOW(),
                        message = :message
                    WHERE 
                        ms_order_id = :ms_order_id',
                    array(
                        ':ms_order_id' => $item['ms_order_id'],
                        ':last_check' => time(),
                        ':next_check' => $nextCheck,
                        ':message' => $error->getMessage()
                    )
                );
            }
        }
        return "OK";
    }

    // will be executed by HostBill every hour
    function call_Hourly()
    {
        return 'OK';
    }

    // will be executed by HostBill once a day
    function call_Daily()
    {
        return 'OK';
    }

    // will be executed by HostBill once a week
    function call_Weekly()
    {
        return 'OK';
    }

    // will be executed by HostBill once a month
    function call_Monthly()
    {
        return 'OK';
    }
}
