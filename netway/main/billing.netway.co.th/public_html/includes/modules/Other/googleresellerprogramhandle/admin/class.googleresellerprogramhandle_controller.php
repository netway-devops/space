<?php

require_once dirname(__DIR__) . '/class.googleresellerprogramhandle.php';
require_once dirname(__DIR__) . '/model/class.googleresellerprogramhandle_model.php';

class googleresellerprogramhandle_controller extends HBController {
    
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

    public function beforeCall ($request)
    {
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(__DIR__) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $db         = hbm_db();

        $result     = googleresellerprogramhandle_model::singleton()->listSubscription();
        $this->template->assign('aDatas', $result);

        $this->template->render(dirname(__DIR__) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function changeRecurringPrice ($request)
    {
        echo 'Function นี้ถูกปิดการใช้งานแล้ว';
        exit;

        $db         = hbm_db();

        $recalculate    = isset($request['recalculate']) ? $request['recalculate'] : 0;
        $calculate      = isset($request['calculate']) ? $request['calculate'] : 0;
        $updatePrice    = isset($request['update_price']) ? $request['update_price'] : 0;

        if ($recalculate) {
            googleresellerprogramhandle_model::singleton()->recalculate();
            $calculate  = 1;
        }

        if ($calculate) {
            $aAccounts  = googleresellerprogramhandle_model::singleton()->listPendingCalculate();
            $calculate  = count($aAccounts) ? 1 : 0;
            foreach ($aAccounts as $aAccount) {
                $accountId  = $aAccount['id'];
                $seat       = googleresellerprogramhandle_model::singleton()->getSeatByAccountId($accountId);
                $aData      = array(
                    'account_id'    => $accountId,
                    'seat'          => $seat,
                );
                googleresellerprogramhandle_model::singleton()->updatePriceAdjustment($accountId, $aData);

            }
        }

        $result         = googleresellerprogramhandle_model::singleton()->listLatestSync();
        $aDatas         = array();
        if (count($result)) {

            $aPrice     = array(
                '152'       => array('Annually' => '2150'),
                '624'       => array('Annually' => '7350'),
                '688'       => array('Annually' => '4500'),
                '730'       => array('Annually' => '1680'),
                '748'       => array('Annually' => '1700'),
                '754'       => array('Monthly' => '190', 'Quarterly' => '570', 'Semi-Annually' => '1140', 'Annually' => '2280'),
                '755'       => array('Monthly' => '395', 'Quarterly' => '1185', 'Semi-Annually' => '2370', 'Annually' => '4740'),
                '869'       => array('Annually' => '3150'),
            );

            foreach ($result as $arr) {
                $accountId  = $arr['id'];
                $productId  = $arr['product_id'];
                $cycle      = $arr['billingcycle'];
                $seat       = $arr['seat'];
                $price      = isset($aPrice[$productId][$cycle]) ? $aPrice[$productId][$cycle] : 0;
                $arr['price']   = $price;

                $newPrice   = $price * $seat;
                if (strtotime($arr['next_due']) < strtotime('2020-04-02')) {
                    //$newPrice   = '';
                }
                if ($newPrice && $updatePrice) {
                    # งานจบแล้ว googleresellerprogramhandle_model::singleton()->updateRecuring($accountId, $newPrice);
                }

                $arr['recurring_new']   = $newPrice;
                
                $aDatas[]   = $arr;
            }
        }

        $this->template->assign('calculate', $calculate);
        $this->template->assign('aDatas', $aDatas);

        $this->template->render(dirname(__DIR__) .'/templates/admin/change_recurring_price.tpl',array(), true);
    }
    
    public function relatedInfo ($request)
    {
        $db         = hbm_db();

        $accountId  = isset($request['accountId']) ? $request['accountId'] : 0;
        $result     = googleresellerprogramhandle_model::singleton()->getAccountById($accountId);
        $domain     = isset($result['domain']) ? $result['domain'] : '';

        $result     = googleresellerprogramhandle_model::singleton()->getSubscriptionByDomain($domain);

        $this->template->assign('aSubscriptions', $result);
        $this->template->assign('accountId', $accountId);

        $this->template->render(dirname(__DIR__) .'/templates/admin/ajax.related_info.tpl', array(), false);
    }
    
    public function syncAccount ($request)
    {
        $db         = hbm_db();

        $accountId  = isset($request['accountId']) ? $request['accountId'] : 0;

        $result    = googleresellerprogramhandle::singleton()->syncAccount($accountId);

        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($result));
        $this->json->show();
    }
    
    
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
}


