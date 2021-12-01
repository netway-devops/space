<?php

/**
 *
 * Widget SSL Details
 *
 * http://schlitt.info/opensource/blog/0581_reflecting_private_properties.html
 *
 */

// include_once(APPDIR_MODULES . "Hosting/symantecvip/include/api/class.symantecvip.dao.php");

class widget_ssl_details extends HostingWidget {

    protected $description = 'This is description of widget that will be displayed in clientarea';
    protected $widgetfullname = "SSL detail";

    /**
     * HostBill will call this function when widget is visited from clientarea
     * @param HostingModule $module Your provisioning module object
     * @return array
     */
    public function clientFunction(&$module) {

        $reflectionObject = new ReflectionObject($module);
        $property = $reflectionObject->getProperty('account_details');
        $property->setAccessible(true);
        $aAccountDetails = $property->getValue($module);

        $accountId = (isset($aAccountDetails["id"])) ? $aAccountDetails["id"] : null;
        $serverId = (isset($aAccountDetails["server_id"])) ? $aAccountDetails["server_id"] : null;
        $clientId = (isset($aAccountDetails["client_id"])) ? $aAccountDetails["client_id"] : null;
        $orderId = (isset($aAccountDetails["order_id"])) ? $aAccountDetails["order_id"] : null;

        // TODO ต้องย้าย query ไว้ใน DAO ตอนนี้ query นี้มีอยู่ที่ class.ssl.controller ใน admin function accountdetails
        $db = hbm_db();
        $orderItrmInfo = $db->query("
                SELECT
                    *
                FROM
                    hb_ssl_order
                WHERE
                    order_id = :order_id
        ", array(
            ':order_id' => $orderId
        ))->fetch();

        $params = array(
            "account" => array()
        );
        $aList = array('csr', 'email_approval', 'server_type', 'commonname', 'authority_orderid', 'code_ca', 'code_certificate', 'date_expire');
        foreach ($aList as $v) {
            $params['account'][$v] = $orderItrmInfo[$v];
        }

        return array(
                               "ssl_details.tpl",
                               array(
                                    'accountId' => $accountId,
                                    'serverId' => $serverId,
                                    'clientId' => $clientId,
                                    'accounts' => $params['account']
                               )
                      );
    }


}