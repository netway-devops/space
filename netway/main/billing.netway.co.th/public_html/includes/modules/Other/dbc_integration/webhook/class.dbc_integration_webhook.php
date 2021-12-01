<?php
require_once(APPDIR . 'libs/hbapiwrapper/hbApiWrapper.php');
require_once(APPDIR_MODULES . 'Other/dbc_integration/model/class.dbc_integration_model.php');


class dbc_integration_webhook {
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
        $this->api = new hbApiWrapper();
    }

    private function sendToUrl($method, $url, $data=array())
    {
        try {
            $oCURL = curl_init();
            curl_setopt_array($oCURL, array(
                CURLOPT_PORT => "443",
                CURLOPT_URL => $url,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_ENCODING => "",
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => strtoupper($method),
                CURLOPT_POSTFIELDS => json_encode($data),
                CURLOPT_HTTPHEADER => array(
                    "content-type: application/json",
                    "cache-control: no-cache"
                ),
            ));
            $response = curl_exec($oCURL);
            $err = curl_error($oCURL);
            curl_close($oCURL);
            if (empty($response)) {
                $response = '{"status": "ok"}';
            }
            $this->db->query("
                INSERT INTO 
                    `dbc_webhook_logs` (`method`, `url`, `data`, `response`)
                VALUES
                (:method, :url, :data, :response)
            ", array(
                'method' => strtoupper($method),
                'url' => $url,
                'data' => json_encode($data),
                'response' => $response
            ));

            if ($err) {
                return array(
                    'isError' => true,
                    'message' => $err
                );
            } else {
                return array(
                    'isError' => false
                );
            }
        } catch (Exception $ex) {
            return array(
                'isError' => true,
                'message' => $ex->getMessage()
            );
        }
    }

    public function postCategoryToDBC($hbCategoryId)
    {
        if (!is_null($hbCategoryId)) {
            $aWebhookResult = dbc_integration_model::singleton()->getWebhooks(1)->fetchAll();
            if (count($aWebhookResult) > 0 && trim($aWebhookResult[0]['url']) != '') {
                $aResponse = $this->sendToUrl($aWebhookResult[0]['method'], $aWebhookResult[0]['url'], array('id' => $hbCategoryId));
                if ($aResponse['isError'] == false) {
                    return array(
                        'status'   => 'ok',
                        'message' => 'Call request modified item category on DBC has been successfully.'
                    );
                } else {
                    return array(
                        'status'   => 'error',
                        'message' => $aResponse['message']
                    );
                }
            } else {
                return array(
                    'status'   => 'error',
                    'message' => 'Not config webhook URL to update Product Category.'
                );
            }
        } else {
            return array(
                'status'   => 'error',
                'message' => 'Category ID is empty.'
            );
        }
    }

    public function postProductToDBC($hbProductID)
    {
        if (!is_null($hbProductID)) {
            $aWebhookResult = dbc_integration_model::singleton()->getWebhooks(2)->fetchAll();
            if (count($aWebhookResult) > 0 && trim($aWebhookResult[0]['url']) != '') {
                $aResponse = $this->sendToUrl($aWebhookResult[0]['method'], $aWebhookResult[0]['url'], array('id' => $hbProductID));
                if ($aResponse['isError'] == false) {
                    return array(
                        'status'   => 'ok',
                        'message' => 'Call request modified item on DBC has been successfully.'
                    );
                } else {
                    return array(
                        'status'   => 'error',
                        'message' => $aResponse['message']
                    );
                }
            } else {
                return array(
                    'status'   => 'error',
                    'message' => 'Not config webhook URL to update Product.'
                );
            }
        } else {
            return array(
                'status'   => 'error',
                'message' => 'Product ID is empty.'
            );
        }
    }

    public function postCreateSalesOrderOnDBC($hbInvoiceID)
    {
        try {
            if (empty($hbInvoiceID)) {
                throw new Exception("Hostbill invoice ID is empty.");
            } else {
                $aWebhookResult = dbc_integration_model::singleton()->getWebhooks(3)->fetchAll();
                $hbInvoiceID = intval($hbInvoiceID);
                if (count($aWebhookResult) > 0 && trim($aWebhookResult[0]['url']) != '') {
                    //dbc_integration_model::singleton()->updateSalesOrderLogs('create', $hbInvoiceID);
                    $aResponse = $this->sendToUrl($aWebhookResult[0]['method'], $aWebhookResult[0]['url'], array('hb_invoice_id' => intval($hbInvoiceID)));
                    if ($aResponse['isError'] == false) {
                        return array(
                            'status'   => 'ok',
                            'message' => 'Call request created/modified seals order on DBC has been successfully.'
                        );
                    } else {
                        return array(
                            'status'   => 'error',
                            'message' => $aResponse['message']
                        );
                    }
                } else {
                    return array(
                        'status'   => 'error',
                        'message' => 'Not config webhook URL create sales order on DBC.'
                    );
                }
            }
        } catch (Exception $ex) {
            return array(
                'isError' => true,
                'message' => $ex->getMessage()
            );
        }
    }
}