<?php

define('DEFAULT_CLIENT_ID', 1);

class bankstatement_controller extends HBController {

    public function beforeCall ($request)
    {
        
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
        $api    = new ApiWrapper();
        
        if (isset($request['filter'])) {
            $request['page']    = 0;
        }
        
        $currentfilter      = $this->_filter($request);
        $aBankTransfer      = $this->_listBankTransfer();
        
        $aParam     = array();
        $condition  = ' t.invoice_id != 0 ';
        if ($currentfilter && count($aBankTransfer) > 0 ) {
            $condition              .= ' AND t.module IN ('. implode(',', array_keys($aBankTransfer)).') ';
        }
        if ($currentfilter && isset($currentfilter['payment']) && $currentfilter['payment'] ) {
            $condition              .= 'AND t.module = :tModule ';
            $aParam[':tModule']     = $currentfilter['payment'];
        }
        if ($currentfilter && isset($currentfilter['date_from']) && $currentfilter['date_from'] ) {
            $condition              .= 'AND t.date >= :tDateFrom ';
            $aParam[':tDateFrom']   = date('Y-m-d', $this->_convertStrtotime($currentfilter['date_from']));
        }
        if ($currentfilter && isset($currentfilter['date_to']) && $currentfilter['date_to'] ) {
            $condition              .= 'AND t.date <= :tDateTo ';
            $aParam[':tDateTo']     = date('Y-m-d', $this->_convertStrtotime($currentfilter['date_to']));
        }
        
        $totalAmount    = 0;
        $total          = 0;
        
        $aAmount    = $db->query("
                    SELECT 
                        SUM(t.in - t.out - t.fee) AS total
                    FROM
                        hb_transactions t
                    WHERE 
                        {$condition}
                    ", $aParam)->fetch();
        if (count($aAmount)) {
            $totalAmount    = $aAmount['total'];
        }
        
        $aTotal    = $db->query("
                    SELECT 
                        COUNT(t.id) AS total
                    FROM
                        hb_transactions t
                    WHERE 
                        {$condition}
                    ", $aParam)->fetch();
        if (count($aTotal)) {
            $total  = $aTotal['total'];
        }
        
        $limit              = 25;
        $offset             = (isset($request['page']) && $request['page'] ) ? ($request['page'] * $limit) : 0;
        $aTransactions  = $db->query("
                    SELECT 
                        t.*, i.paid_id
                    FROM
                        hb_transactions t
                        LEFT JOIN hb_invoices i ON i.id = t.invoice_id
                    WHERE 
                        {$condition}
                    ORDER BY t.date DESC LIMIT {$offset}, {$limit} 
                    ", $aParam)->fetchAll();
        if (count($aTransactions)) {
            foreach ($aTransactions as $k => $aData) {
                $aTransactions[$k]['dateFormated']  = date('Y-m-d', strtotime($aData['date']));
                $aTransactions[$k]['amount']        = $aData['in'] - $aData['out'] - $aData['fee'];
            }
        }
        
        $aBankName  = array(
            'ธนาคาร กรุงเทพ', 'ธนาคาร ไทยพาณิชย์', 'ธนาคาร กสิกรไทย'
            , 'ธนาคาร ทหารไทย', 'ธนาคาร กรุงไทย', 'ธนาคาร กรุงศรีอยุธยา');
        
        $this->template->assign('aBankName', $aBankName);
        
        /*--- Pagination ---*/
        $sorterpage     = (isset($request['page']) && $request['page'] ) ? $request['page']+1 : 1;
        $totalpages     = ceil($total / $limit);
        $this->template->assign('perpage', $limit);
        $this->template->assign('totalpages', $totalpages);
        $this->template->assign('sorterrecords', $total);
        $this->template->assign('sorterpage', $sorterpage);
        $this->template->assign('sorterlow', ($offset+1));
        $this->template->assign('sorterhigh', (($offset+$limit) > $total) ? $total : ($offset+$limit));
        /*--- Pagination ---*/
        
        $this->template->assign('totalAmount', $totalAmount);
        $this->template->assign('aTransactions', $aTransactions);
        $this->template->assign('currentfilter', $currentfilter);
        $this->template->assign('aBankTransfer', $aBankTransfer);
        $this->_beforeRender();

        if (isset($request['page'])) {
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.lists.tpl',array(), true);
        } else {
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
        }
    }
    
    public function getadvanced ($request)
    {
        $aBankTransfer      = $this->_listBankTransfer();
        $currentfilter      = $this->_filter($request);
        
        $this->template->assign('currentfilter', $currentfilter);
        $this->template->assign('aBankTransfer', $aBankTransfer);
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.filter.tpl',array(), true);
    }
    
    public function bankinfo ($request)
    {
        $db     = hbm_db();
        
        $aBankTransfer      = $this->_listBankTransfer();
        
        $id         = (isset($request['id']) && $request['id']) ? $request['id'] : 0 ;
        
        $aModule    = $db->query("
                    SELECT 
                        *
                    FROM
                        hb_modules_configuration mc
                    WHERE 
                        mc.id = :mcId
                    ", array(':mcId' => $id))->fetch();
        $aConfig    = array();
        if (count($aModule)) {
            $aConfig    = unserialize($aModule['config']);
        }
        //echo '<pre>'.print_r($aConfig, true).'</pre>';
        $this->template->assign('id', $id);
        $this->template->assign('aConfig', $aConfig);
        $this->template->assign('aBankTransfer', $aBankTransfer);
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/bankinfo.tpl',array(), true);
    }
    
    public function bankinfoupdate ($request)
    {
        global  $hb_admin_folder;
        
        $db     = hbm_db();
        
        $id         = (isset($request['id']) && $request['id']) ? $request['id'] : 0 ;
        $aData      = isset($request['data']) ? $request['data'] : array() ;

        $url        = $hb_admin_folder . '?cmd=bankstatement&action=bankinfo&id=' . $id;
        
        if ( ! $id ) {
            $_SESSION['notification']   = array('type' => 'error', 'message' => 'เกิดข้อผิดพลาดระหว่างบันทึกข้อมูล');
            header('Location: ' . $uri);exit;
        }
        
        $aModule    = $db->query("
                    SELECT 
                        *
                    FROM
                        hb_modules_configuration mc
                    WHERE 
                        mc.id = :mcId
                    ", array(':mcId' => $id))->fetch();
        
        $aConfig    = array();
        if (count($aModule)) {
            $aConfig    = unserialize($aModule['config']);
        }
        
        foreach ($aConfig as $k => $v) {
            $aConfig[$k]['value']    = $aData[$k];
        }
        
        $config     = serialize($aConfig);
        
        $db->query("
            UPDATE hb_modules_configuration
            SET config = :config
            WHERE 
                id = :id
        ", array(':config' => $config, ':id' => $id));
        
        $_SESSION['notification']   = array('type' => 'success', 'message' => 'บันทึกข้อมูลเรียบร้อย');
        
        header('Location: ' . $uri);exit;
    }
    
    public function addwithdraw($request)
    {
        
        global  $hb_admin_folder;
        
        $db     = hbm_db();
        
        $aBankTransfer      = $this->_listBankTransfer();
        
        $url    = $hb_admin_folder . '?cmd=bankstatement';
        
        $in     = 0;
        $out    = 0;
        
        if ($request['type'] == 'ฝาก') {
            $in     = $request['amount'];
        } else if ($request['type'] == 'ถอน') {
            $out    = $request['amount'];
        }
        
        $description    = 'บันทึก: ' . $request['type'] . '     จากธนาคาร: ' . $aBankTransfer[$request['payment']]
            . "\n" . 'เป็น: ' . $request['format'] . ' '
            . (($request['format'] == 'เช็คธนาคาร') ? 
                'หมายเลข: ' . $request['formatExt']['number'] . '     ธนาคาร: ' . $request['formatExt']['bank'] . ' '
                : '')
            . "\n" . 'หมายเหตุ: ' . ($request['log'] ? $request['log'] :' - ') . ' '
            ;
        
        $db->query("
            INSERT INTO `hb_transactions` (
            `id`, `client_id`, `invoice_id`, `module`, `date`, `description`, `in`, `fee`, `out`, 
            `trans_id`, `currency_id`, `rate`, `refund_of`
            ) VALUES (
            NULL, :client_id, -1, :module, :date, :description, :in, 0.00, :out, :trans_id, 0, 1.0000, 0
            )
        ", array(
            ':client_id'    => DEFAULT_CLIENT_ID,
            ':module'       => $request['payment'],
            ':date'         => date('Y-m-d', $this->_convertStrtotime($request['date'])),
            ':description'  => $description,
            ':in'           => $in,
            ':out'          => $out,
            ':trans_id'     => date('Y-m-d H:i')
        ));
        
        $_SESSION['notification']   = array('type' => 'success', 'message' => 'บันทึกข้อมูลเรียบร้อย');

        header('Location: ' . $uri);exit;
    }
    
    private function _listBankTransfer ()
    {
        
        $api        = new ApiWrapper();
        $return     = $api->getPaymentModules();
        
        $aLists     = array();
        if (isset($return['success']) && $return['success']) {
            
            foreach ($return['modules'] as $id => $name) {
                if ($name == 'BankTransfer') {
                    continue;
                }
                if (preg_match('/^BankTransfer/i', $name)) {
                    $aLists[$id]   = $name;
                }
            }
            
        }
        
        return $aLists;
    }
    
    private function _convertStrtotime ($str = '00/00/0000')
    {
        $d  = substr($str,0,2);
        $m  = substr($str,3,2);
        $y  = substr($str,6);
        return strtotime($y .'-'. $m .'-'. $d);
    }
    
    private function _filter ($request)
    {
        if (isset($request['resetfilter']) && $request['resetfilter']) {
            $_SESSION['Sorterbankstatement'] = array();
        }
        
        if (isset($request['filterName']) && $request['filterName']) {
            $currentfilter      = array();
            if ( isset($_SESSION['Sorterbankstatement']['filter']) && $_SESSION['Sorterbankstatement']['filter']) {
                $currentfilter  = $_SESSION['Sorterbankstatement']['filterInput'];
            }
            $request['filter']  = $currentfilter;
            
            switch ($request['filterName']) {
                case 'now' : {
                        $request['filter']['date_from'] = '';
                        $request['filter']['date_to']   = '';
                    } break;
                case 'thismonth' : {
                        $request['filter']['date_from'] = date('01/m/Y');
                        $request['filter']['date_to']   = date('t/m/Y');
                    } break;
                case 'lastmonth' : {
                        $request['filter']['date_from'] = date('01/m/Y', mktime(0,0,0,(date('n')-1),1,date('Y')));
                        $request['filter']['date_to']   = date('t/m/Y', mktime(0,0,0,(date('n')-1),1,date('Y')));
                    } break;
                default:
            }
            
        }
        
        if (isset($request['filter'])) {
            
            $aSorter    = array(
                'filter'        => true,
                'filterFields'  => array_keys($request['filter']),
                'filterInput'   => $request['filter'],
                'smart'         => ''
            );
            $_SESSION['Sorterbankstatement'] = $aSorter;
        
        }
        
        if ( ! isset($_SESSION['Sorterbankstatement']['filter']) || ! $_SESSION['Sorterbankstatement']['filter']) {
            return false;
        }
        
        return $_SESSION['Sorterbankstatement']['filterInput'];
        
/*

    [Sorterbankstatement] => Array
        (
            [orderby] => tr.date
            [page] => 0
            [perpage] => 25
            [pagination] => 1
            [type] => DESC
            [filter] => Array
                (
                    [0] => tr.trans_id LIKE '%qknz1dg12wivmq%'
                )

            [filterFields] => Array
                (
                    [0] => trans_id
                )

            [filterInput] => Array
                (
                    [trans_id] => QKNZ1DG12WIVMQ
                    [description] => 
                    [module] => 
                    [lastname] => 
                    [date] => 
                )

            [smart] => 
        )
 */

    }
    
    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) 
            . '/templates/');
    }

    public function afterCall ($request)
    {
        
    }
}