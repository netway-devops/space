<?php

require_once(APPDIR .'class.cache.extend.php');

class matrixslahandle_controller extends HBController {
    
    
    public function beforeCall ($request)
    {
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $db             = hbm_db();
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function getPerformance ()
    {
        $db             = hbm_db();
        
        $aAdmin         = hbm_logged_admin();
        $staffId        = $aAdmin['id'];
        
        $result         = $db->query("
                SELECT tm.*
                FROM sc_team_member tm
                WHERE tm.staff_id = :staffId
                ", array(
                    ':staffId'     => $staffId
                ))->fetch();
        
        $teamId         = isset($result['team_id']) ? $result['team_id'] : 0;
        
        $dateRange      = ' \''. date('Y-m-01') .' 00:00:00\' AND \''. date('Y-m-d') .' 23:59:59\' '; // this month
        $lastMonth      = mktime(0, 0, 0, date('n')-1, 1, date('Y')); // last month
        $lastMonthEnd   = mktime(0, 0, 0, date('n'), 1, date('Y'))-1;
        $dateRangePass  = ' \''. date('Y-m-01', $lastMonth) .' 00:00:00\' AND \''. date('Y-m-d', $lastMonthEnd) .' 23:59:59\' ';
        $lastMonth2     = mktime(0, 0, 0, date('n')-2, 1, date('Y')); // last month
        $lastMonthEnd2  = mktime(0, 0, 0, date('n'), 1, date('Y'))-1;
        $dateRangePass2 = ' \''. date('Y-m-01', $lastMonth2) .' 00:00:00\' AND \''. date('Y-m-d', $lastMonthEnd2) .' 23:59:59\' ';
        
        $aData          = array();
        
        $result         = self::_myResponseTime(1, $staffId, $teamId, $dateRange); // my
        $now            = $result['average'];
        $record         = $result['record'];
        $result         = self::_myResponseTime(1, $staffId, $teamId, $dateRangePass); // my
        $pass           = $result['average'];
        $result         = self::_myResponseTime(1, $staffId, $teamId, $dateRangePass2); // my
        $pass2          = $result['average'];
        $aData[1][1]    = self::_matrixSLAText ($now, $record, $pass, $pass2);
        $result         = self::_myResponseTime(1, 0, $teamId, $dateRange); // team
        $now            = $result['average'];
        $result         = self::_myResponseTime(1, 0, $teamId, $dateRangePass); // team
        $pass           = $result['average'];
        $result         = self::_myResponseTime(1, 0, $teamId, $dateRangePass2); // team
        $pass2          = $result['average'];
        $aData[1][2]    = self::_matrixSLAText ($now, '', $pass, $pass2);
        $result         = self::_myResponseTime(1, 0, 0, $dateRange); // org
        $now            = $result['average'];
        $result         = self::_myResponseTime(1, 0, 0, $dateRangePass); // org
        $pass           = $result['average'];
        $result         = self::_myResponseTime(1, 0, 0, $dateRangePass2); // org
        $pass2          = $result['average'];
        $aData[1][3]    = self::_matrixSLAText ($now, '', $pass, $pass2);
        
        $result         = self::_myResolveTime(1, $staffId, $teamId, $dateRange); // my
        $now            = $result['average'];
        $record         = $result['record'];
        $result         = self::_myResolveTime(1, $staffId, $teamId, $dateRangePass); // my
        $pass           = $result['average'];
        $result         = self::_myResolveTime(1, $staffId, $teamId, $dateRangePass2); // my
        $pass2          = $result['average'];
        $aData[2][1]    = self::_matrixSLAText ($now, $record, $pass, $pass2);
        $result         = self::_myResolveTime(1, 0, $teamId, $dateRange); // team
        $now            = $result['average'];
        $result         = self::_myResolveTime(1, 0, $teamId, $dateRangePass); // team
        $pass           = $result['average'];
        $result         = self::_myResolveTime(1, 0, $teamId, $dateRangePass2); // team
        $pass2          = $result['average'];
        $aData[2][2]    = self::_matrixSLAText ($now, '', $pass, $pass2);
        $result         = self::_myResolveTime(1, 0, 0, $dateRange); // org
        $now            = $result['average'];
        $result         = self::_myResolveTime(1, 0, 0, $dateRangePass); // org
        $pass           = $result['average'];
        $result         = self::_myResolveTime(1, 0, 0, $dateRangePass2); // org
        $pass2          = $result['average'];
        $aData[2][3]    = self::_matrixSLAText ($now, '', $pass, $pass2);
        
        $result         = self::_myResponseTime(2, $staffId, $teamId, $dateRange); // my
        $now            = $result['average'];
        $record         = $result['record'];
        $result         = self::_myResponseTime(2, $staffId, $teamId, $dateRangePass); // my
        $pass           = $result['average'];
        $result         = self::_myResponseTime(2, $staffId, $teamId, $dateRangePass2); // my
        $pass2          = $result['average'];
        $aData[3][1]    = self::_matrixSLAText ($now, $record, $pass, $pass2);
        $result         = self::_myResponseTime(2, 0, $teamId, $dateRange); // team
        $now            = $result['average'];
        $result         = self::_myResponseTime(2, 0, $teamId, $dateRangePass); // team
        $pass           = $result['average'];
        $result         = self::_myResponseTime(2, 0, $teamId, $dateRangePass2); // team
        $pass2          = $result['average'];
        $aData[3][2]    = self::_matrixSLAText ($now, '', $pass, $pass2);
        $result         = self::_myResponseTime(2, 0, 0, $dateRange); // org
        $now            = $result['average'];
        $result         = self::_myResponseTime(2, 0, 0, $dateRangePass); // org
        $pass           = $result['average'];
        $result         = self::_myResponseTime(2, 0, 0, $dateRangePass2); // org
        $pass2          = $result['average'];
        $aData[3][3]    = self::_matrixSLAText ($now, '', $pass, $pass2);
        
        $result         = self::_myResolveTime(2, $staffId, $teamId, $dateRange); // my
        $now            = $result['average'];
        $record         = $result['record'];
        $result         = self::_myResolveTime(2, $staffId, $teamId, $dateRangePass); // my
        $pass           = $result['average'];
        $result         = self::_myResolveTime(2, $staffId, $teamId, $dateRangePass2); // my
        $pass2          = $result['average'];
        $aData[4][1]    = self::_matrixSLAText ($now, $record, $pass, $pass2);
        $result         = self::_myResolveTime(2, 0, $teamId, $dateRange); // team
        $now            = $result['average'];
        $result         = self::_myResolveTime(2, 0, $teamId, $dateRangePass); // team
        $pass           = $result['average'];
        $result         = self::_myResolveTime(2, 0, $teamId, $dateRangePass2); // team
        $pass2          = $result['average'];
        $aData[4][2]    = self::_matrixSLAText ($now, '', $pass, $pass2);
        $result         = self::_myResolveTime(2, 0, 0, $dateRange); // org
        $now            = $result['average'];
        $result         = self::_myResolveTime(2, 0, 0, $dateRangePass); // org
        $pass           = $result['average'];
        $result         = self::_myResolveTime(2, 0, 0, $dateRangePass2); // org
        $pass2          = $result['average'];
        $aData[4][3]    = self::_matrixSLAText ($now, '', $pass, $pass2);
        
        echo '<!-- {"ERROR":[],"INFO":[]'
            . ',"DATA":['. json_encode($aData).']'
            . ',"STACK":0} -->';
        exit;
    }

    private function _matrixSLAText ($now, $record, $pass, $pass2 = 0)
    {
        $val        = $now - $pass;
        $now        = $now ? $now : '- ';
        if ($val) {
            $val    = ($val > 0) ? '<span style="color:red">+'. $val .'</span>' : '<span style="color:green">'. $val .'</span>';
        } else {
            $val    = ' - ';
        }
        $val2       = $now - $pass2;
        if ($val2) {
            $val2   = ($val2 > 0) ? '<span style="color:red">+'. $val2 .'</span>' : '<span style="color:green">'. $val2 .'</span>';
        } else {
            $val2   = ' - ';
        }
        $str        = $now .' ('. $val .', '. $val2 .') '. ($record ? ' / '. $record : '');
        return $str;
    }
    
    /**
     * $requestType 1 = service request , 2 = incident
     */
    private function _myResponseTime ($requestType, $staffId = 0, $teamId = 0, $dateRange = '')
    {
        $db         = hbm_db();
        
        $sql        = "
                SELECT %s
                FROM mtx_ticket_response_time trt
                WHERE request_type = {$requestType}
                    ". ($staffId ? " AND trt.staff_id = {$staffId} " : "") ."
                    ". ($teamId ? " AND trt.team_id = {$teamId} " : "") ."
                    ". ($dateRange ? " AND (trt.ticket_date BETWEEN {$dateRange}) " : "") ."
                ";
        
        $total      = " COUNT(*) AS total ";
        $cacheKey   = md5(serialize($total.$sql));
        $result     = CacheExtend::singleton()->get($cacheKey);
        if ($result == null) {
            $result     = $db->query(sprintf($sql, $total))->fetch();
            CacheExtend::singleton()->set($cacheKey, $result, 3600*3);
        }
        $totalRecord    = isset($result['total']) ? $result['total'] : 0;
        
        $total      = " SUM(time_in_second) AS total ";
        $cacheKey   = md5(serialize($total.$sql));
        $result     = CacheExtend::singleton()->get($cacheKey);
        if ($result == null) {
            $result     = $db->query(sprintf($sql, $total))->fetch();
            CacheExtend::singleton()->set($cacheKey, $result, 3600*3);
        }
        $totalTime      = isset($result['total']) ? ceil($result['total'] / 60) : 0;
        
        $average    = ($totalTime && $totalRecord) ? ceil($totalTime/$totalRecord) : 0;
        
        $aData      = array(
            'average'   => $average,
            'record'    => $totalRecord
            );
        
        return $aData;
    }

    /**
     * $requestType 1 = service request , 2 = incident
     */
    private function _myResolveTime ($requestType, $staffId = 0, $teamId = 0, $dateRange = '')
    {
        $db         = hbm_db();
        
        $sql        = "
                SELECT %s
                FROM mtx_ticket_resolve_time trt
                WHERE request_type = {$requestType}
                    ". ($staffId ? " AND trt.staff_id = {$staffId} " : "") ."
                    ". ($teamId ? " AND trt.team_id = {$teamId} " : "") ."
                    ". ($dateRange ? " AND (trt.ticket_date BETWEEN {$dateRange}) " : "") ."
                ";
        
        $total      = " COUNT(*) AS total ";
        $cacheKey   = md5(serialize($total.$sql));
        $result     = CacheExtend::singleton()->get($cacheKey);
        if ($result == null) {
            $result     = $db->query(sprintf($sql, $total))->fetch();
            CacheExtend::singleton()->set($cacheKey, $result, 3600*3);
        }
        $totalRecord    = isset($result['total']) ? $result['total'] : 0;
        
        $total      = " SUM(time_in_second) AS total ";
        $cacheKey   = md5(serialize($total.$sql));
        $result     = CacheExtend::singleton()->get($cacheKey);
        if ($result == null) {
            $result     = $db->query(sprintf($sql, $total))->fetch();
            CacheExtend::singleton()->set($cacheKey, $result, 3600*3);
        }
        $totalTime      = isset($result['total']) ? ceil($result['total'] / 60) : 0;
        
        $average    = ($totalTime && $totalRecord) ? ceil($totalTime/$totalRecord) : 0;
        
        $aData      = array(
            'average'   => $average,
            'record'    => $totalRecord
            );
        
        return $aData;
    }
    
    public function afterCall ($request)
    {
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('oAdmin', (object)$aAdmin);
        
        $_SESSION['notification']   = array();
    }
}