<?php
require_once APPDIR . "class.general.custom.php";
require_once APPDIR . "class.api.custom.php";
class rvsitebuilder_developer_license_controller extends HBController
{
    protected $modname = 'Cron Update Status RVsitebuilder Developer License';
    protected $description = '';

    public function call_EveryRun()
    {
        //$this->findHbLicenseStatusAndUpdate();
        
        return "Success";
    }

    private function findHbLicenseStatusAndUpdate()
    {
        // $db = hbm_db();
        // $result = $db->query("SELECT * FROM hb_accounts WHERE product_id = 161 OR product_id = 162 OR product_id = 170 ORDER BY date_changed DESC LIMIT 5")->fetchAll();
        // foreach ($result as $account) {
        //     $statusflag = ($account['status'] == 'Active' || $account['status'] == 'Renewing') ? 1 : 0;
        //     $query = $db->query("
        //         UPDATE
        //             rvsitebuilder_developer_license
        //         SET
        //             active = :statusflag,
        //             status = :status
        //         WHERE
        //             client_id = :client_id
        //         AND
        //             hb_acc = :id
        //         ", array(
        //             ':statusflag'   => $statusflag,
        //             ':status' => $account['status'],
        //             ':client_id'	=> $account['client_id'],
        //             ':id'	    => $account['id'],
        //     ));
        // }

        return true;
    }
}
