<?php

require_once(APPDIR .'class.cache.extend.php');

class servicecataloghandle_controller extends HBController {
    
    public $aPipedrive      = array(
        '21'    => array(
            'name'      => 'Renew Service',
            'staff'     => array(
                'nutchapabha@netway.co.th'      => 'Nutchapabha Khanapitikawee',
                ),
            ),
        '4'     => array(
            'name'      => 'SALES-SSL',
            'staff'     => array(
                'vanvipa@netway.co.th'          => 'Vanvipa Piriyothinkul',
                ),
            ),
        '12'    => array(
            'name'      => 'SALES-NW',
            'staff'     => array(
                'jutiphorn@netway.co.th'      => 'Jutiphorn Damsong',
                ),
            ),
        '11'    => array(
            'name'      => 'SALES-EM',
            'staff'     => array(
                'prapatsorn@netway.co.th'      => 'Prapatsorn Tamthura',
                ),
            ),
        '14'    => array(
            'name'      => 'SALES-SYSNOC',
            'staff'     => array(
                'monthira@netway.co.th'      => 'Monthira Prasawang',
                ),
            ),
        '17'    => array(
            'name'      => 'Apps',
            'staff'     => array(
                'jatturaput@netway.co.th'       => 'Jatturaput Nilumprachart',
                ),
            ),
        '8'     => array(
            'name'      => 'RV',
            'staff'     => array(
                'sirishom@rvglobalsoft.com'       => 'Sirishom Potchong',
                ),
            ),
        '18'    => array(
            'name'      => 'Netway Business Solution',
            'staff'     => array(
                'jatturaput@netway.co.th'       => 'Jatturaput Nilumprachart',
                ),
            ),
        );
    
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
        
        $this->browse($request);
        
        //$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function search ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $aLists         = array('total' => 0, 'list' => array());
        
        $searchKeyword  = isset($request['searchKeyword']) ? $request['searchKeyword'] : '';
        $this->template->assign('searchKeyword', $searchKeyword);
        $type           = isset($request['type']) ? $request['type'] : '';
        $this->template->assign('type', $type);
        
        $page           = isset($request['p']) ? $request['p'] : 1;
        $this->template->assign('p', $page);
        $limit          = 10;
        $offset         = ($page - 1) * $limit;
        
        $table          = ($type == 'incidentKB') ? 'in_incident_kb': 'sc_service_catalog';
        
        $sqlSearch      = "";
        if ($searchKeyword) {
            $sqlSearch  .= "
                AND ( sc.title LIKE '%{$searchKeyword}%'
                    OR sc.description LIKE '%{$searchKeyword}%')
                ";
        }
        
        $result         = $db->query("
                SELECT COUNT(sc.id) AS total
                FROM {$table} sc
                WHERE sc.is_delete = 0
                ". $sqlSearch )->fetch();
        
        $aLists['total']= isset($result['total']) ? $result['total'] : 0;
        
        $aCategory      = self::_getCategory($type);
        $aCategories    = array();
        $aCategories    = self::_listCategory($aCategories, $aCategory);
        
        $cacheKey   = md5(serialize($request));
        $result     = null;//CacheExtend::singleton()->get($cacheKey);
        if ($result == null) {
            $result         = $db->query("
                    SELECT 
                        sc.*,
                        ad.firstname
                    FROM
                        {$table} sc
                        LEFT JOIN hb_admin_details ad
                            ON ad.id = sc.staff_id
                    WHERE sc.is_delete = 0
                    ". $sqlSearch ."
                    ORDER BY sc.staff_id = :staffId, sc.modified DESC
                    LIMIT {$offset}, {$limit}
                    ", array(
                        ':staffId'      => $aAdmin['id'],
                    ))->fetchAll();
            CacheExtend::singleton()->set($cacheKey, $result, 3600*3);
        }
        
        if (count($result)) {
            foreach ($result as $arr) {
                $aPath                  = self::_pathWay($aCategories, $arr['category_id']);
                krsort($aPath);
                $cat                    = '';
                foreach ($aPath as $arr2) {
                    $cat    .= ' &gt; ' . $arr2['name'];
                }
                
                $arr['category']        = $cat;
                $arr['desc']            = substr($arr['description'], 0, 250);
                $arr['date']            = date('F j, y H:i', strtotime($arr['modified']));
                $aLists['list'][$arr['id']]     = $arr;
            }
        }
        
        $this->template->assign('total', $aLists['total']);
        $this->template->assign('aLists', $aLists['list']);
        
        $next           = (($offset+$limit) < $result['total']) ? $page+1 : 0;
        $prev           = ($page > 1) ? $page-1 : 0;
        
        $this->template->assign('next', $next);
        $this->template->assign('prev', $prev);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/search_result.tpl',array(), true);
    }
    
    public function serviceCatalog ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $this->browse();
        
        /*
        $oInfo          = (object) array(
            'title'     => 'Service Catalog',
            'desc'      => 'จัดการ Service Catalog (Service Request) ที่คุณรับผิดชอบ'
            );
        
        $this->template->assign('oInfo', $oInfo);
        
        $page           = isset($request['p']) ? $request['p'] : 1;
        $this->template->assign('p', $page);
        $limit          = 10;
        $offset         = ($page - 1) * $limit;
        
        $aCategory      = self::_getCategory();
        $aCategories    = array();
        $aCategories    = self::_listCategory($aCategories, $aCategory);
        
        if (! $offset) {
            $result     = self::_listDraft ($aCategories);
            $this->template->assign('aDrafts', $result);
        }
        
        $result         = self::_listMyServiceCatalog ($aCategories, $offset, $limit);
        $this->template->assign('total', $result['total']);
        $this->template->assign('aLists', $result['list']);
        
        $next           = (($offset+$limit) < $result['total']) ? $page+1 : 0;
        $prev           = ($page > 1) ? $page-1 : 0;
        
        $this->template->assign('next', $next);
        $this->template->assign('prev', $prev);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/service_catalog.tpl',array(), true);
        */
    }
    
    public function incidentKB ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $oInfo          = (object) array(
            'title'     => 'Incident KB',
            'desc'      => 'จัดการ Incident KB ที่คุณรับผิดชอบ',
            'type'      => 'incidentKB',
            );
        
        $this->template->assign('oInfo', $oInfo);
        
        $page           = isset($request['p']) ? $request['p'] : 1;
        $this->template->assign('p', $page);
        $limit          = 10;
        $offset         = ($page - 1) * $limit;
        
        $aCategory      = self::_getCategory('incidentKB');
        $aCategories    = array();
        $aCategories    = self::_listCategory($aCategories, $aCategory);
        
        if (! $offset) {
            $result     = self::_listDraft ($aCategories, 'incidentKB');
            $this->template->assign('aDrafts', $result);
        }
        
        $result         = self::_listMyServiceCatalog ($aCategories, $offset, $limit, 'incidentKB');
        $this->template->assign('total', $result['total']);
        $this->template->assign('aLists', $result['list']);
        
        $next           = (($offset+$limit) < $result['total']) ? $page+1 : 0;
        $prev           = ($page > 1) ? $page-1 : 0;
        
        $this->template->assign('next', $next);
        $this->template->assign('prev', $prev);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/incident_kb.tpl',array(), true);
    }
    
    private function _listMyServiceCatalog ($aCategories, $offset = 0, $limit = 10, $type = '')
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $aLists         = array('total' => 0, 'list' => array());
        $table          = ($type == 'incidentKB') ? 'in_incident_kb' : 'sc_service_catalog';
        
        $result         = $db->query("
                SELECT 
                    COUNT(sc.id) AS total
                FROM
                    {$table} sc
                WHERE
                    sc.staff_id = :staffId
                    AND sc.is_publish = 1
                    AND sc.is_delete = 0
                ", array(
                    ':staffId'      => $aAdmin['id'],
                ))->fetch();
        
        $aLists['total']    = isset($result['total']) ? $result['total'] : 0;
        
        $result         = $db->query("
                SELECT 
                    sc.id, sc.title, sc.description, sc.modified, sc.category_id
                FROM
                    {$table} sc
                WHERE
                    sc.staff_id = :staffId
                    AND sc.is_publish = 1
                    AND sc.is_delete = 0
                ORDER BY sc.modified DESC
                LIMIT {$offset}, {$limit}
                ", array(
                    ':staffId'      => $aAdmin['id'],
                ))->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $aPath                  = self::_pathWay($aCategories, $arr['category_id']);
                krsort($aPath);
                $cat                    = '';
                foreach ($aPath as $arr2) {
                    $cat    .= ' &gt; ' . $arr2['name'];
                }
                
                $arr['category']        = $cat;
                $arr['desc']            = substr($arr['description'], 0, 250);
                $arr['date']            = date('F j, y H:i', strtotime($arr['modified']));
                $aLists['list'][$arr['id']]     = $arr;
            }
        }
        
        return $aLists;
    }

    private function _listDraft ($aCategories, $type = '')
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $aDrafts        = array();
        $table          = ($type == 'incidentKB') ? 'in_incident_kb' : 'sc_service_catalog';
        
        $result         = $db->query("
                SELECT 
                    sc.id, sc.title, sc.description, sc.modified, sc.category_id
                FROM
                    {$table} sc
                WHERE
                    sc.staff_id = :staffId
                    AND sc.is_publish = 0
                    AND sc.is_delete = 0
                ORDER BY sc.orders ASC
                ", array(
                    ':staffId'      => $aAdmin['id']
                ))->fetchAll();
        
        
        if (count($result)) {
            foreach ($result as $arr) {
                $aPath                  = self::_pathWay($aCategories, $arr['category_id']);
                krsort($aPath);
                $cat                    = '';
                foreach ($aPath as $arr2) {
                    $cat    .= ' &gt; ' . $arr2['name'];
                }
                
                $arr['category']        = $cat;
                $arr['desc']            = substr($arr['description'], 0, 250);
                $arr['date']            = date('F j, y H:i', strtotime($arr['modified']));
                $aDrafts[$arr['id']]    = $arr;
            }
        }
        
        return $aDrafts;
    }
    
    private function _pathWay ($aCategories, $catId, $aPath = array())
    {
        if (! count($aCategories)) {
            return $aPath;
        }
        
        $aCategories_       = $aCategories;
        foreach ($aCategories_ as $arr) {
            if ($arr['id'] == $catId) {
                array_push($aPath, $arr);
                $aPath  = self::_pathWay($aCategories, $arr['parent_id'], $aPath);
                break;
            }
        }
        
        return $aPath;
    }
    
    public function browse ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $type           = isset($request['type']) ? $request['type'] : '';
        $typeName       = ($type == 'incidentKB') ? 'Incident KB' : 'Service Catalog';
        
        $oInfo          = (object) array(
            'title'     => 'Browse '. $typeName,
            'desc'      => 'แสดงรายการ '. $typeName .' ทั้งหมด',
            'type'      => $type,
            'typeName'  => $typeName,
            );
        
        $this->template->assign('oInfo', $oInfo);
        $this->template->assign('aAdmin', $aAdmin);
        
        $aCategory      = self::_getCategory($type);
        $this->template->assign('aCategory', $aCategory);
        $aCategories    = array();
        $aCategories    = self::_listCategory($aCategories, $aCategory);
        $this->template->assign('aCategories', $aCategories);
        
        $table          = ($type == 'incidentKB') ? 'in_incident_kb' : 'sc_service_catalog';
        
        $aTotal         = array();
        $result         = $db->query("
                SELECT COUNT(sc.id) AS total, sc.category_id
                FROM {$table} sc
                WHERE sc.is_delete = 0
                GROUP BY sc.category_id
                ")->fetchAll();
        if (count($result)) {
            foreach ($result as $arr) {
                $aTotal[$arr['category_id']]    = $arr['total'];
            }
        }
        $this->template->assign('aTotal', $aTotal);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/browse.tpl',array(), true);
    }
    
    public function listServiceCatalog ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $catId          = isset($request['catId']) ? $request['catId'] : 0;
        $type           = isset($request['type']) ? $request['type'] : '';
        
        $result         = $db->query("
                SELECT tm.level
                FROM sc_team_member tm
                WHERE tm.staff_id = :staffId
                ", array(
                    ':staffId'  => $aAdmin['id']
                ))->fetch();
                
        $level          = isset($result['level']) ? $result['level'] : 1;
        
        $table          = ($type == 'incidentKB') ? 'in_incident_kb' : 'sc_service_catalog';
        
        if ($table == 'sc_service_catalog') {
            $aProcess   = array();
            $result     = $db->query("
                SELECT COUNT(*) AS total, pg.sc_id
                FROM sc_process_group pg,
                    sc_service_catalog sc
                WHERE pg.sc_id = sc.id
                    AND sc.category_id = :catId
                GROUp BY pg.sc_id
                ", array(
                    ':catId'        => $catId
                ))->fetchAll();
            foreach ($result as $arr) {
                $aProcess[$arr['sc_id']]    = $arr['total'];
            }
            $aProcessList       = array();
            $result     = $db->query("
                SELECT pg.*
                FROM sc_process_group pg,
                    sc_service_catalog sc
                WHERE pg.sc_id = sc.id
                    AND sc.category_id = :catId
                ORDER BY pg.orders ASC
                ", array(
                    ':catId'        => $catId
                ))->fetchAll();
            foreach ($result as $arr) {
                $aProcessList[$arr['sc_id']]    .= $arr['sla_tag'] .'| '. $arr['name'] .'<br />';
            }
        }
        
        $result         = $db->query("
                SELECT
                    sc.id, sc.title, sc.is_publish, sc.staff_id, sc.zendesk_guide_id, tm.level, ad.firstname
                FROM
                    {$table} sc
                    LEFT JOIN sc_team_member tm
                        ON tm.staff_id = sc.staff_id
                    LEFT JOIN hb_admin_details ad
                        ON ad.id = sc.staff_id
                WHERE
                    sc.category_id = :catId
                    AND sc.is_delete = 0
                ORDER BY sc.orders ASC, sc.modified DESC
                ", array(
                    ':catId'        => $catId
                ))->fetchAll();
        
        for ($i = 0; $i < count($result); $i++) {
            $result[$i]['level']    = $level;
            $scId   = $result[$i]['id'];
            $result[$i]['process']  = isset($aProcess[$scId]) ? $aProcess[$scId] : 0;
            $result[$i]['processList']  = isset($aProcessList[$scId]) ? $aProcessList[$scId] : '';
        }
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($result));
        $this->json->show();
    }

    public function deleteServiceCatalog ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $id             = isset($request['id']) ? $request['id'] : 0;
        

        $oTeam          = self::_myTeam();
        
        $result         = $db->query("
                SELECT sc.*
                FROM sc_service_catalog sc
                WHERE sc.id = :id
                ", array(
                    ':id'       => $id
                ))->fetch();
        
        if ($result['staff_id'] != $aAdmin['id'] && $oTeam->level < 2) {
            $_SESSION['notification']   = array('type' => 'error', 'message' => 'คุณไม่มีสิทธิ์ลบข้อมูลนี้');
            header('location:?cmd=servicecataloghandle&action=browse');
            exit;
        }
        
        $result         = $db->query("
                SELECT *
                FROM hb_products_config
                WHERE fulfillment_create_id = :id
                    OR fulfillment_upgrade_id = :id
                    OR fulfillment_renew_id = :id
                    OR fulfillment_suspend_id = :id
                    OR fulfillment_unsuspend_id = :id
                    OR fulfillment_terminate_id = :id
                    OR fulfillment_transfer_id = :id
                    OR fulfillment_fraud_id = :id
                ", array(
                    ':id'       => $id
                ))->fetch();
        
        if (isset($result['id']) && $result['id']) {
            $_SESSION['notification']   = array(
                'type' => 'error', 
                'message' => 'มีการใช้งานอยู่ที่ <a href="?cmd=services&action=product&id='
                    . $result['id'] .'" target="_blank">'. $result['id'] .'</a>'
                );
            header('location:?cmd=servicecataloghandle&action=browse');
            exit;
        }
        
        $db->query("
                UPDATE sc_service_catalog
                SET is_delete = 1,
                    is_publish = 0
                WHERE id = :id
                ", array(
                    ':id'       => $id
                ));
        
        $log            = '#'. $aAdmin['firstname'] .' delete service catalog #'. $id .' '. $result['title'];
        self::_addLogs($log);
        
        $_SESSION['notification']   = array('type' => 'success', 'message' => 'ลบข้อมูลเรียบร้อยแล้ว');
        header('location:?cmd=servicecataloghandle&action=browse');
        exit;
    }

    public function deleteIncidentKB ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $id             = isset($request['id']) ? $request['id'] : 0;
        
        $oTeam          = self::_myTeam();
        
        $result         = $db->query("
                SELECT kb.*
                FROM in_incident_kb kb
                WHERE kb.id = :id
                ", array(
                    ':id'       => $id
                ))->fetch();
        
        if ($result['staff_id'] != $aAdmin['id'] && $oTeam->level < 2) {
            $_SESSION['notification']   = array('type' => 'error', 'message' => 'คุณไม่มีสิทธิ์ลบข้อมูลนี้');
            header('location:?cmd=servicecataloghandle&action=browse&type=incidentKB');
            exit;
        }
        
        $db->query("
                UPDATE in_incident_kb
                SET is_delete = 1,
                    is_publish = 0
                WHERE id = :id
                ", array(
                    ':id'       => $id
                ));
        
        $log            = '#'. $aAdmin['firstname'] .' delete Incident KB #'. $id .' '. $result['title'];
        self::_addLogs($log);
        
        $_SESSION['notification']   = array('type' => 'success', 'message' => 'ลบข้อมูลเรียบร้อยแล้ว');
        header('location:?cmd=servicecataloghandle&action=browse&type=incidentKB');
        exit;
    }
    
    public function sortCategory ($request)
    {
        $db             = hbm_db();
        
        $type           = isset($request['type']) ? $request['type'] : '';
        $this->template->assign('type', $type);
        
        $parentId       = isset($request['parentId']) ? $request['parentId'] : 0;
        $this->template->assign('parentId', $parentId);
        
        $aCategory      = self::_getCategory($type);
        $aCats          = $aCategory[$parentId];
        $this->template->assign('aCats', $aCats);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.sort_category.tpl',array(), false);
    }
    
    public function sortServiceCatalog ($request)
    {
        $db             = hbm_db();
        
        $type           = isset($request['type']) ? $request['type'] : '';
        $this->template->assign('type', $type);
        
        $catId          = isset($request['catId']) ? $request['catId'] : 0;
        $this->template->assign('catId', $catId);
        
        $table          = ($type == 'incidentKB') ? 'in_incident_kb' : 'sc_service_catalog';
        
        $result         = $db->query("
                SELECT sc.id, sc.title
                FROM {$table} sc
                WHERE sc.category_id = :catId
                    AND sc.is_delete = 0
                ORDER BY sc.orders ASC, sc.modified DESC
                ", array(
                    ':catId'        => $catId
                ))->fetchAll();
        $this->template->assign('aLists', $result);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.sort_service_catalog.tpl',array(), false);
    }
    
    public function orderCategory ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $type           = isset($request['type']) ? $request['type'] : '';
        $aLists         = isset($request['lists']) ? explode(',', $request['lists']) : array();
        
        if (! count($aLists)) {
            echo '<!-- {"ERROR":["ไม่พบ category ที่ต้องการให้จัดการ"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $table          = ($type == 'incidentKB') ? 'in_category' : 'sc_category';
        
        foreach ($aLists as $k => $id) {
            $db->query("
                    UPDATE 
                        {$table}
                    SET 
                        orders = :orders
                    WHERE
                        id = :id
                    ", array(
                        ':orders'       => $k,
                        ':id'           => $id
                    ));
            
        }
        
        $log            = '#'. $aAdmin['firstname'] .' sort category 
            <a href="index.php?cmd=servicecataloghandle&action=browse&type='. $type .'">#'. implode(', ', $aLists) .'</a>
            ';
        // self::_addLogs($log);
        
        echo '<!-- {"ERROR":[],"INFO":["เรียงลำดับ Category เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function orderServiceCatalog ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $aLists         = isset($request['lists']) ? explode(',', $request['lists']) : array();
        $type           = isset($request['type']) ? $request['type'] : '';
        $typeName       = ($type == 'incidentKB') ? 'Incident KB' : 'Service Catalog';
        
        if (! count($aLists)) {
            echo '<!-- {"ERROR":["ไม่พบข้อมูลที่ต้องการให้จัดการ"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $table          = ($type == 'incidentKB') ? 'in_incident_kb' : 'sc_service_catalog';
        
        foreach ($aLists as $k => $id) {
            $db->query("
                    UPDATE 
                        {$table}
                    SET 
                        orders = :orders
                    WHERE
                        id = :id
                    ", array(
                        ':orders'       => $k,
                        ':id'           => $id
                    ));
            
        }
        
        $log            = '#'. $aAdmin['firstname'] .' sort '. $typeName .' 
            <a href="index.php?cmd=servicecataloghandle&action=browse&type='. $type .'">#'. implode(', ', $aLists) .'</a>
            ';
        // self::_addLogs($log);
        
        echo '<!-- {"ERROR":[],"INFO":["เรียงลำดับเรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }

    public function editCategory ($request)
    {
        $db             = hbm_db();
        
        $id             = isset($request['id']) ? $request['id'] : 0;
        $type           = isset($request['type']) ? $request['type'] : '';
        $this->template->assign('type', $type);
        
        $table          = ($type == 'incidentKB') ? 'in_category': 'sc_category';
        
        $result         = $db->query("
                SELECT c.*
                FROM {$table} c
                WHERE c.id = :id
                ", array(
                    ':id'       => $id
                ))->fetch();
        
        if (! isset($result['id'])) {
            echo '<!-- {"ERROR":["ไม่พบ category ที่ต้องการให้จัดการ"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $this->template->assign('aData', $result);
        
        $aCategory      = self::_getCategory($type);
        $aLists         = array();
        $aLists         = self::_listCategory($aLists, $aCategory);
        $aLists         = self::_disableChild($aLists, $id);
        $this->template->assign('aLists', $aLists);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.edit_category.tpl',array(), false);
    }
    
    private function _disableChild ($aLists, $parentId = 0)
    {
        $aIndex         = array();
        array_push($aIndex, $parentId);
        
        for ($i = 0; $i < count($aLists); $i++) {
            $arr        = $aLists[$i];
            if ($arr['id'] == $parentId || in_array($arr['parent_id'], $aIndex)) {
                $aLists[$i]['isDisable']    = 1;
                array_push($aIndex, $arr['id']);
            }
        }
        
        return $aLists;
    }
    
    public function updateCategory ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $id             = isset($request['id']) ? $request['id'] : 0;
        $name           = isset($request['name']) ? $request['name'] : '';
        $parentId       = isset($request['parentId']) ? $request['parentId'] : 0;
        $type           = isset($request['type']) ? $request['type'] : '';
        
        if (! $name ) {
            echo '<!-- {"ERROR":[],"INFO":["ชื่อ Category เกิดข้อผิดพลาด"]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $table          = ($type == 'incidentKB') ? 'in_category': 'sc_category';
        
        $db->query("
                UPDATE {$table}
                SET 
                    parent_id = :parentId,
                    name = :name
                WHERE
                    id = :id
                ", array(
                    ':parentId'     => $parentId,
                    ':name'         => $name,
                    ':id'           => $id
                ));
        
        
        $log            = '#'. $aAdmin['firstname'] .' update category #'. $id .' to 
            <a href="index.php?cmd=servicecataloghandle&action=browse&type='. $type .'">'. $name .'</a>
            ';
        // self::_addLogs($log);
        
        echo '<!-- {"ERROR":[],"INFO":["แก้ไข Category เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }

    public function deleteCategory ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $id             = isset($request['id']) ? $request['id'] : 0;
        $type           = isset($request['type']) ? $request['type'] : '';
        $typeName       = ($type == 'incidentKB') ? 'Incident KB': 'Service Catalog';
        $table          = ($type == 'incidentKB') ? 'in_category': 'sc_category';
        
        $result         = $db->query("
                SELECT c.id
                FROM {$table} c
                WHERE c.parent_id = :parentId
                ", array(
                    ':parentId'     => $id
                ))->fetch();
        
        if (isset($result['id'])) {
            $_SESSION['notification']   = array('type' => 'error', 'message' => 'ต้องลบหทวดย่อยก่อน ถึงจะลบหมวดนี้ได้');
            header('location:?cmd=servicecataloghandle&action=browse&type='. $type);
            exit;
        }
        
        $table2         = ($type == 'incidentKB') ? 'in_incident_kb': 'sc_service_catalog';
        
        $result         = $db->query("
                SELECT sc.id
                FROM {$table2} sc
                WHERE sc.category_id = :categoryId
                    AND sc.is_delete = 0
                ", array(
                    ':categoryId'     => $id
                ))->fetch();
        
        if (isset($result['id'])) {
            $_SESSION['notification']   = array('type' => 'error', 'message' => 'มี '. $typeName .' อยู่ในหมวด ต้องย้ายออกไปก่อน');
            header('location:?cmd=servicecataloghandle&action=browse&type='. $type);
            exit;
        }
        
        $db->query("DELETE FROM {$table} WHERE id = :id ", array(':id' => $id));
        
        $log            = '#'. $aAdmin['firstname'] .' delete category #'. $id .'';
        self::_addLogs($log);
        
        $_SESSION['notification']   = array('type' => 'success', 'message' => 'ลบข้อมูลเรียบร้อยแล้ว');
        header('location:?cmd=servicecataloghandle&action=browse&type='. $type);
        exit;
    }
    
    public function requestForServiceCatalog ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $result         = $db->query("
                SELECT c.*
                FROM sc_category c
                WHERE c.name = 'Request for Service Catalog'
                ")->fetch();
        
        $catId          = isset($result['id']) ? $result['id'] : 0;
        
        if (! $catId) {
            $db->query("
                    INSERT INTO sc_category (
                        id, parent_id, name
                    ) VALUES (
                        '', 0, 'Request for Service Catalog'
                    )
                    ");
            
            $result     = $db->query("SELECT MAX(id) AS id FROM sc_category")->fetch();
            $catId      = isset($result['id']) ? $result['id'] : 0;
            
        }
        
        $title          = 'Staff#'. $aAdmin['firstname'] .' Request for Service Catalog #'. time();
        
        $db->query("
                INSERT INTO sc_service_catalog (
                    id, category_id, staff_id, title, modified
                ) VALUES (
                    '', :catId, :staffId, :title, NOW()
                )
                ", array(
                    ':catId'        => $catId,
                    ':staffId'      => $aAdmin['id'],
                    ':title'        => $title
                ));
        
        $result         = $db->query("SELECT MAX(id) AS id FROM sc_service_catalog")->fetch();
        $id             = isset($result['id']) ? $result['id'] : 0;
        
        // --- Pre-define content --- 
        $db->query("
                INSERT INTO sc_business (
                    id, 
                    service_detail,
                    request_permission,
                    request_order,
                    order_time_available,
                    price_rate,
                    service_related
                ) VALUES (
                    :id, 
                    '<ul><li>link to FAQs หรือ KB หรือ หน้าเว็บเพจ</li><li>link to FAQs หรือ KB หรือ หน้าเว็บเพจ</li></ul>',
                    '<ul><li>Email เจ้าของ client account</li></ul>',
                    '<p>ลูกค้าทั่วไป</p><ul><li>ถ้ามีหน้าเว็บเพจอธิบายขั้นตอนการสั่งซื้อ ให้ link ไปหน้านั้น ถ้าไม่มีให้ link ไป หน้า order ของ product นั้น</li></ul><p>Reseller</p><ul><li>ถ้ามีหน้าเว็บเพจอธิบายขั้นตอนการสั่งซื้อ ให้ link ไปหน้านั้น ถ้าไม่มีให้ link ไป หน้า order ของ product นั้น</li></ul>',
                    '<p>หลังจากได้รับสิ่งต่อไปนี้ <strong>ครบถ้วนทุกรายการ</strong></p><ul><li>Fax slip โอนเงิน หรือ PO</li><li>authorized code หรือ ....</li></ul><p>&nbsp;</p>',
                    '<p>ราคาทั่วไป</p><ul><li>&nbsp;</li></ul><p>ราคา reseller</p><ul><li>&nbsp;</li></ul><p>ส่วนลด/ promotion</p><ul><li>&nbsp;</li></ul>',
                    '<p>บริการฟรี</p><ul><li>&nbsp;</li></ul><p>บริการเสริม เสียค่าบริการ</p><ul><li>&nbsp;</li></ul>'
                )
                ", array(
                    ':id'       => $id,
                ));
        
        $db->query("
                INSERT INTO sc_technical (
                    id, 
                    emergency_info
                ) VALUES (
                    :id, 
                    '<p>ติดต่อ เวลาไหน ได้บ้าง ให้ระบุให้ชัดเจน และ ช่วงที่ติดต่อไม่ได้ ให้ทำอย่างไร</p>'
                )
                ", array(
                    ':id'       => $id,
                ));
                
        $log            = '#'. $aAdmin['firstname'] .' add service catalog 
            <a href="?cmd=servicecataloghandle&action=view&id='. $id .'">#'. $id .' '. $title .'</a>
            ';
        self::_addLogs($log);
        
        header('location:?cmd=servicecataloghandle&action=view&id='. $id);
        exit;
    }
    
    public function requestForIncidentKB ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $result         = $db->query("
                SELECT c.*
                FROM in_category c
                WHERE c.name = 'Request for Incident KB'
                ")->fetch();
        
        $catId          = isset($result['id']) ? $result['id'] : 0;
        
        if (! $catId) {
            $db->query("
                    INSERT INTO in_category (
                        id, parent_id, name
                    ) VALUES (
                        '', 0, 'Request for Incident KB'
                    )
                    ");
            
            $result     = $db->query("SELECT MAX(id) AS id FROM in_category")->fetch();
            $catId      = isset($result['id']) ? $result['id'] : 0;
            
        }
        
        $title          = 'Staff#'. $aAdmin['firstname'] .' Request for Incident KB #'. time();
        
        $db->query("
                INSERT INTO in_incident_kb (
                    id, category_id, staff_id, title, modified
                ) VALUES (
                    '', :catId, :staffId, :title, NOW()
                )
                ", array(
                    ':catId'        => $catId,
                    ':staffId'      => $aAdmin['id'],
                    ':title'        => $title
                ));
        
        $result         = $db->query("SELECT MAX(id) AS id FROM in_incident_kb")->fetch();
        $id             = isset($result['id']) ? $result['id'] : 0;
        
        $log            = '#'. $aAdmin['firstname'] .' add Incident KB 
            <a href="?cmd=servicecataloghandle&action=viewIncidentKB&id='. $id .'">#'. $id .' '. $title .'</a>
            ';
        // self::_addLogs($log);
        
        header('location:?cmd=servicecataloghandle&action=viewIncidentKB&id='. $id);
        exit;
    }
    
    public function view ($request)
    {
        require_once(APPDIR .'/modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $oInfo          = (object) array(
            'title'     => 'View Service Catalog',
            'desc'      => 'ส่วนจัดการรายละเอียด service catalog'
            );
        
        $this->template->assign('oInfo', $oInfo);
        
        $id             = isset($request['id']) ? $request['id'] : 0;
        $isPreview      = isset($request['isPreview']) ? $request['isPreview'] : 0;
        $this->template->assign('serviceCatalogId', $id);
        
        $result         = $db->query("
                SELECT sc.*
                FROM sc_service_catalog sc
                WHERE sc.id = :id
                    AND sc.is_delete = 0
                ", array(
                    ':id'       => $id
                ))->fetch();
        
        if (! isset($result['id'])) {
            $_SESSION['notification']   = array('type' => 'error', 'message' => 'ไม่พบข้อมูลที่ต้องการ');
            header('location:?cmd=servicecataloghandle&action=browse');
            exit;
        }
        
        $oCatalog       = (object) $result;
        if (isset($oCatalog->zendesk_guide_id) && $oCatalog->zendesk_guide_id) {
            $result     = zendeskintegratehandle_controller::singleton()->getGuideIdBy($oCatalog->zendesk_guide_id);
            if (isset($result['title'])) {
                $oCatalog->title    = $result['title'];
                $db->query("
                    UPDATE sc_service_catalog
                    SET title = :title
                    WHERE id = :id
                    ", array(
                        ':title'    => $oCatalog->title,
                        ':id'       => $id
                    ));
            }
        }
        $this->template->assign('oCatalog', $oCatalog);
        
        $oTeam          = self::_myTeam();
        
        $isEditable     = true;
        if ($oTeam->level == 1 && $oCatalog->staff_id != $aAdmin['id']) {
            $isEditable = false;
        }
        $this->template->assign('isEditable', $isEditable);

        $aStaff         = self::listStaff();
        $this->template->assign('aStaff', $aStaff);
        
        $oOwner         = self::_myTeam($oCatalog->staff_id);
        $this->template->assign('oOwner', $oOwner);
        
        $result         = $db->query("
                SELECT b.*
                FROM sc_business b
                WHERE b.id = :id
                ", array(
                    ':id'       => $id
                ))->fetch();
        
        $oBusiness      = isset($result['id']) ? (object) $result : (object) array();
        $this->template->assign('oBusiness', $oBusiness);
        
        $result         = $db->query("
                SELECT t.*
                FROM sc_technical t
                WHERE t.id = :id
                ", array(
                    ':id'       => $id
                ))->fetch();
        
        $oTechnical     = isset($result['id']) ? (object) $result : (object) array();
        $this->template->assign('oTechnical', $oTechnical);
        
        $aCategory      = self::_getCategory();
        $aLists         = array();
        $aLists         = self::_listCategory($aLists, $aCategory);
        $this->template->assign('aCategory', $aLists);
        
        $result         = self::_getReplies($id);
        $this->template->assign('aReplies', $result);
        
        $result         = $db->query("
                SELECT
                    pg.*, pg2.sc_id AS parentServiceCatalogId
                FROM
                    sc_process_group pg
                    LEFT JOIN sc_process_group pg2
                        ON pg2.id = pg.parent_id
                WHERE
                    pg.sc_id = :scId
                ORDER BY
                    pg.orders
                ", array(
                    ':scId'     => $id
                ))->fetchAll();
        
        $aProcessGroup      = array();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $result2    = $db->query("
                    SELECT pg.*
                    FROM sc_process_group pg
                    WHERE pg.parent_id = :parentId
                    ", array(
                        ':parentId'     => $arr['id']
                    ))->fetchAll();
                
                $arr['aShareProcess']   = $result2;
                array_push($aProcessGroup, $arr);
            }
        }
        
        $this->template->assign('aProcessGroup', $aProcessGroup);
        
        $scids          = array();
        array_push($scids, $id);
        if (count($result)) {
            foreach ($result as $arr) {
                if ($arr['parentServiceCatalogId']) {
                    array_push($scids, $arr['parentServiceCatalogId']);
                }
            }
        }
        
        $aProcess       = array();
        
        $result         = $db->query("
                SELECT
                    c2t.*, pt.name, pt.assign_team_id, pt.assign_staff_id, pt.ola_in_minute,
                    t.name AS teamName, ad.firstname
                FROM
                    sc_catalog_2_task c2t,
                    sc_process_task pt,
                    sc_process_group pg,
                    sc_team t,
                    hb_admin_details ad
                WHERE
                    c2t.sc_id IN (". implode(',', $scids) .")
                    AND c2t.pt_id = pt.id
                    AND c2t.pg_id = pg.id
                    AND pt.assign_team_id = t.id
                    AND pt.assign_staff_id = ad.id
                ORDER BY pg.orders ASC, c2t.orders ASC
                ")->fetchAll();
        
        if (count($result)) {
            $idx        = 0;
            $name       = $result[0]['teamName'];
            
            foreach ($result as $arr) {
                $groupId        = $arr['pg_id'];
                $taskId         = $arr['id'];
                
                if (! is_array($aProcess[$groupId])) {
                    $aProcess[$groupId]     = array();
                }
                
                if ($arr['teamName'] != $name) {
                    $name       = $arr['teamName'];
                    $idx++;
                }
                
                if (! is_array($aProcess[$groupId][$idx])) {
                    $aProcess[$groupId][$idx]   = array(
                        'team'      => $arr['teamName'],
                        'task'      => array(),
                        );
                }
                //echo "<pre>{$groupId} {$idx} {$taskId} ".serialize($arr)."</pre>";
                $aProcess[$groupId][$idx]['task'][$taskId]  = $arr;
            }
            
        }
        
        $this->template->assign('aProcess', $aProcess);
        $this->template->assign('aPipedrive', $this->aPipedrive);
        
        
        $result         = $db->query("
                SELECT
                    pg.*, c1.name AS c1Name, c.name AS cName, sc.title
                FROM
                    sc_process_group pg,
                    sc_service_catalog sc,
                    sc_category c
                        LEFT JOIN sc_category c1
                            ON c1.id = c.parent_id
                WHERE
                    pg.sc_id != :scId
                    AND pg.parent_id = 0
                    AND pg.sc_id = sc.id
                    AND sc.category_id = c.id
                    AND sc.is_delete = 0
                ORDER BY
                    c1.orders ASC, c.orders ASC, pg.orders ASC
                ", array(
                    ':scId'     => $id
                ))->fetchAll();
        $aOtherProcessGroup = array();
        foreach ($result as $arr) {
            $arr['title']   = ($arr['c1Name'] ? $arr['c1Name'] .' --- ' : '' )
                //. ($arr['cName'] ? $arr['cName'] .' --- ' : '' )
                . $arr['title'];
            array_push($aOtherProcessGroup, $arr);
        }
        $this->template->assign('aOtherProcessGroup', $aOtherProcessGroup);
        
        if (! $isPreview) {
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/view.tpl',array(), true);
        }
    }
    
    private function _getReplies ($id, $type = '')
    {
        $db             = hbm_db();
        
        if ($type == 'incidentKB') {
            $result         = $db->query("
                    SELECT
                        rt.*
                    FROM
                        in_incident_2_template i2t,
                        sc_reply_template rt
                    WHERE
                        i2t.in_id = :inId
                        AND i2t.rt_id = rt.id
                    ORDER BY i2t.level ASC
                    ", array(
                        ':inId'     => $id
                    ))->fetchAll();
        } else {
            $result         = $db->query("
                    SELECT
                        rt.*
                    FROM
                        sc_catalog_2_template c2t,
                        sc_reply_template rt
                    WHERE
                        c2t.sc_id = :scId
                        AND c2t.rt_id = rt.id
                    ", array(
                        ':scId'     => $id
                    ))->fetchAll();
        }
        
        return $result;
    }
    
    public function viewIncidentKB ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $oInfo          = (object) array(
            'title'     => 'View Incident KB',
            'desc'      => 'ส่วนจัดการรายละเอียด Incident KB'
            );
        
        $this->template->assign('oInfo', $oInfo);
        
        $id             = isset($request['id']) ? $request['id'] : 0;
        $isPreview      = isset($request['isPreview']) ? $request['isPreview'] : 0;
        $this->template->assign('kbId', $id);
        
        $result         = $db->query("
                SELECT kb.*
                FROM in_incident_kb kb
                WHERE kb.id = :id
                    AND kb.is_delete = 0
                ", array(
                    ':id'       => $id
                ))->fetch();
        
        if (! isset($result['id'])) {
            $_SESSION['notification']   = array('type' => 'error', 'message' => 'ไม่พบข้อมูลที่ต้องการ');
            header('location:?cmd=servicecataloghandle&action=browse&type=incidentKB');
            exit;
        }
        
        $oKB            = (object) $result;
        $this->template->assign('oKB', $oKB);
        
        $oTeam          = self::_myTeam();
        
        $isEditable     = true;
        if ($oTeam->level == 1 && $oKB->staff_id != $aAdmin['id']) {
            $isEditable = false;
        }
        $this->template->assign('isEditable', $isEditable);
        
        $aStaff         = self::listStaff();
        $this->template->assign('aStaff', $aStaff);
        
        $oOwner         = self::_myTeam($oKB->staff_id);
        $this->template->assign('oOwner', $oOwner);
        
        $aCategory      = self::_getCategory('incidentKB');
        $aLists         = array();
        $aLists         = self::_listCategory($aLists, $aCategory);
        $this->template->assign('aCategory', $aLists);
        
        $result         = self::_getReplies($id, 'incidentKB');
        $this->template->assign('aReplies', $result);
        
        if (! $isPreview) {
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/view_incident_kb.tpl',array(), true);
        }
    }
    
    public function preview ($request)
    {
        $db         = hbm_db();
        
        $type       = isset($request['type']) ? $request['type'] : '';
        $request['preview']     = 1;
        
        if ($type == 'incidentKB') {
            $this->viewIncidentKB($request);
        } else {
            $this->view($request);
        }
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.preview.tpl',array(), false);
    }
    
    public function removeReplyTemplate ($request)
    {
        $db             = hbm_db();
        
        $serviceCatalogId   = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $kbId               = isset($request['kbId']) ? $request['kbId'] : 0;
        $id                 = isset($request['id']) ? $request['id'] : 0;
        
        if ($kbId) {
            $db->query("
                    DELETE FROM in_incident_2_template 
                    WHERE in_id = :inId
                        AND rt_id = :rtId
                    ", array(
                        ':inId'     => $kbId,
                        ':rtId'     => $id,
                    ));
            
            $_SESSION['notification']   = array('type' => 'success', 'message' => 'ยกเลิการใช้งาน reply template ที่ระบุแล้ว');
            header('location:?cmd=servicecataloghandle&action=viewIncidentKB&id='. $kbId);
            exit;
        } else {
            $db->query("
                    DELETE FROM sc_catalog_2_template 
                    WHERE sc_id = :scId
                        AND rt_id = :rtId
                    ", array(
                        ':scId'     => $serviceCatalogId,
                        ':rtId'     => $id,
                    ));
            
            $_SESSION['notification']   = array('type' => 'success', 'message' => 'ยกเลิการใช้งาน reply template ที่ระบุแล้ว');
            header('location:?cmd=servicecataloghandle&action=view&id='. $serviceCatalogId);
            exit;
        }
    }
    
    public function updateServiceCatalog ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $oTeam          = self::_myTeam();
        
        $id             = isset($request['id']) ? $request['id'] : 0;
        $field          = isset($request['field']) ? $request['field'] : '';
        $value          = isset($request['value']) ? $request['value'] : '';
        
        $result         = $db->query("
                SELECT sc.*
                FROM sc_service_catalog sc
                WHERE sc.id = :id
                ", array(
                    ':id'       => $id
                ))->fetch();
        
        if (! isset($result['id'])) {
            echo '<!-- {"ERROR":["ไม่พบข้อมูล"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $staffId    = $result['staff_id'];
        $newStaffId = $value;
        $title      = $result['title'];
        
        if ($result['category_id'] != 1) {
            if ($oTeam->level <= 1) {
                //  level 1 edit ได้เฉพาะเอกสารตัวเอง หรือเอกสารที่ตัวเอง request
                if ($result['staff_id'] != $aAdmin['id']) {
                    echo '<!-- {"ERROR":["คุณไม่มีสิทธิ์แก้ไขข้อมูลนี้"],"INFO":[]'
                        . ',"STACK":0} -->';
                    exit;
                }
            } else if ($oTeam->level <= 2) {
                // level 2 edit ได้เฉพาะเอกสารตัวเอง และเอกสารของ level 1 ไม่สนใจทีม หรือเอกสารที่ตัวเอง request
                $oStaff         = self::_myTeam($result['staff_id']);
                if ($oStaff->level > 1 && $result['staff_id'] != $aAdmin['id']) {
                    echo '<!-- {"ERROR":["คุณไม่มีสิทธิ์แก้ไขข้อมูลนี้"],"INFO":[]'
                        . ',"STACK":0} -->';
                    exit;
                }
            }
            // level 3 edit ได้ทั้งหมด
        }
        
        $fieldName      = '';
        $fieldBusinessName      = '';
        $fieldTechnicalName     = '';
        
        switch ($field) {
            case 'title'        : 
                $fieldName  = 'title'; 
                $fieldBusinessName  = 'service_name'; 
                $value      = str_replace('"',"'",$value);
                break;
            case 'description'  : $fieldName    = 'description'; break;
            case 'publish'      : $fieldName    = 'is_publish'; break;
            case 'slainminute'  : $fieldName    = 'sla_in_minute'; break;
            case 'staff'        : $fieldName    = 'staff_id'; break;
            case 'detail'       : $fieldName    = 'detail'; break;
            case 'category'     : $fieldName    = 'category_id'; break;
            case 'policy'       : $fieldName    = 'escalation_policy'; break;
            case 'guideId'      : $fieldName    = 'zendesk_guide_id'; break;
            
            case 'serviceName'          : $fieldBusinessName        = 'service_name'; break;
            case 'serviceDetail'        : $fieldBusinessName        = 'service_detail'; break;
            case 'requestPermission'    : $fieldBusinessName        = 'request_permission'; break;
            case 'requestOrder'         : $fieldBusinessName        = 'request_order'; break;
            case 'orderTimeAvailable'   : $fieldBusinessName        = 'order_time_available'; break;
            case 'deliveryTime'         : $fieldBusinessName        = 'delivery_time'; break;
            case 'priceRate'            : $fieldBusinessName        = 'price_rate'; break;
            case 'serviceRelated'       : $fieldBusinessName        = 'service_related'; break;
            case 'servicePolicy'        : $fieldBusinessName        = 'service_policy'; break;
            case 'salePerson'           : $fieldBusinessName        = 'sale_person'; break;
            case 'warrantyRate'         : $fieldBusinessName        = 'warranty_rate'; break;
            
            case 'fulfillmentInfo'      : $fieldTechnicalName       = 'fulfillment_info'; break;
            case 'recoveryInfo'         : $fieldTechnicalName       = 'recovery_info'; break;
            case 'emergencyInfo'        : $fieldTechnicalName       = 'emergency_info'; break;
            
        }
        
        if ($fieldName) {
            $db->query("
                    UPDATE sc_service_catalog
                    SET modified = NOW(),
                        {$fieldName} = :fieldValue
                    WHERE id = :id
                    ", array(
                        ':fieldValue'   => $value,
                        ':id'           => $id,
                    ));
            
            $log        = '#'. $aAdmin['firstname'] .' update service catalog 
                <a href="?cmd=servicecataloghandle&action=view&id='. $id .'">#'. $id .' '. $field .'</a> '. $value .'
                ';
            self::_addLogs($log);
            
        }
        
        if ($fieldBusinessName) {
            $result     = $db->query("SELECT b.id FROM sc_business b WHERE b.id = :id", array(':id' => $id))->fetch();
            if (! isset($result['id'])) {
                $db->query("INSERT INTO sc_business (id) VALUES (:id)", array(':id' => $id));
            }
            
            $db->query("
                    UPDATE sc_business
                    SET {$fieldBusinessName} = :fieldValue
                    WHERE id = :id
                    ", array(
                        ':fieldValue'   => $value,
                        ':id'           => $id,
                    ));
            
            $log        = '#'. $aAdmin['firstname'] .' update service catalog 
                <a href="?cmd=servicecataloghandle&action=view&id='. $id .'">#'. $id .' '. $field .'</a> '. $value .'
                ';
            self::_addLogs($log);
            
        }
         
        if ($fieldTechnicalName) {
            $result     = $db->query("SELECT t.id FROM sc_technical t WHERE t.id = :id", array(':id' => $id))->fetch();
            if (! isset($result['id'])) {
                $db->query("INSERT INTO sc_technical (id) VALUES (:id)", array(':id' => $id));
            }
            
            $db->query("
                    UPDATE sc_technical
                    SET {$fieldTechnicalName} = :fieldValue
                    WHERE id = :id
                    ", array(
                        ':fieldValue'   => $value,
                        ':id'           => $id,
                    ));
            
            $log        = '#'. $aAdmin['firstname'] .' update service catalog 
                <a href="?cmd=servicecataloghandle&action=view&id='. $id .'">#'. $id .' '. $field .'</a> '. $value .'
                ';
            self::_addLogs($log);
            
        }
        
        if ($fieldName == 'staff_id' && $staffId != $newStaffId) {
            $result     = $db->query("
                SELECT *
                FROM hb_client_access
                WHERE id = :id
                ", array(
                    ':id'   => $newStaffId
                ))->fetch();
            
            if (isset($result['id'])) {
                require_once(APPDIR . 'class.general.custom.php');
                $url        = GeneralCustom::singleton()->getAdminUrl()
                            . '?cmd=servicecataloghandle&action=view&id='. $id;
                
                $emailTo    = $result['email'];
                $subject    = $aAdmin['firstname'] .' ได้ Assign Service Catalog #'. $id .' ให้คุณจัดการ';
                $html       = '
                        <h1>'. $title .'</h1>
                        --------------------------------------------------
                        <p>Url: '.$url.'</p>
                        ';
                
                $header     = 'MIME-Version: 1.0' . "\r\n" .
                        'Content-type: text/html; charset=utf-8' . "\r\n" .
                        'From: admin@netway.co.th' . "\r\n" .
                        'Reply-To: admin@netway.co.th' . "\r\n" .
                        'X-Mailer: PHP/' . phpversion();
                
                @mail($emailTo, $subject, $html, $header);
            }
        }
        
        echo '<!-- {"ERROR":[],"INFO":["Update ข้อมูลเรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function updateIncidentKB ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $oTeam          = self::_myTeam();
        
        $id             = isset($request['id']) ? $request['id'] : 0;
        $field          = isset($request['field']) ? $request['field'] : '';
        $value          = isset($request['value']) ? $request['value'] : '';
        
        $result         = $db->query("
                SELECT kb.*
                FROM in_incident_kb kb
                WHERE kb.id = :id
                ", array(
                    ':id'       => $id
                ))->fetch();
        

        if (! isset($result['id'])) {
            echo '<!-- {"ERROR":["ไม่พบข้อมูล"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $staffId    = $result['staff_id'];
        $newStaffId = $value;
        $title      = $result['title'];
        
        if ($result['category_id'] != 1) {
            if ($oTeam->level <= 1) {
                //  level 1 edit ได้เฉพาะเอกสารตัวเอง หรือเอกสารที่ตัวเอง request
                if ($result['staff_id'] != $aAdmin['id']) {
                    echo '<!-- {"ERROR":["คุณไม่มีสิทธิ์แก้ไขข้อมูลนี้"],"INFO":[]'
                        . ',"STACK":0} -->';
                    exit;
                }
            } else if ($oTeam->level <= 2) {
                // level 2 edit ได้เฉพาะเอกสารตัวเอง และเอกสารของ level 1 ไม่สนใจทีม หรือเอกสารที่ตัวเอง request
                $oStaff         = self::_myTeam($result['staff_id']);
                if ($oStaff->level > 1 && $result['staff_id'] != $aAdmin['id']) {
                    echo '<!-- {"ERROR":["คุณไม่มีสิทธิ์แก้ไขข้อมูลนี้"],"INFO":[]'
                        . ',"STACK":0} -->';
                    exit;
                }
            }
            // level 3 edit ได้ทั้งหมด
        }
        
        $fieldName      = '';
        $fieldBusinessName      = '';
        $fieldTechnicalName     = '';
        
        switch ($field) {
            case 'title'        : 
                $fieldName  = 'title';
                $value      = str_replace('"',"'",$value);
                break;
            case 'description'  : $fieldName    = 'description'; break;
            case 'publish'      : $fieldName    = 'is_publish'; break;
            case 'slainminute'  : $fieldName    = 'sla_in_minute'; break;
            case 'staff'        : $fieldName    = 'staff_id'; break;
            case 'category'     : $fieldName    = 'category_id'; break;
            case 'detailHelpdesk'   : $fieldName    = 'detail_helpdesk'; break;
            case 'detailSupport'    : $fieldName    = 'detail_support'; break;
            case 'policy'       : $fieldName    = 'escalation_policy'; break;
            
        }
        
        if ($fieldName) {
            $db->query("
                    UPDATE in_incident_kb
                    SET modified = NOW(),
                        {$fieldName} = :fieldValue
                    WHERE id = :id
                    ", array(
                        ':fieldValue'   => $value,
                        ':id'           => $id,
                    ));
            
            $log        = '#'. $aAdmin['firstname'] .' update Incident KB 
                <a href="?cmd=servicecataloghandle&action=viewIncidentKB&id='. $id .'">#'. $id .' '. $field .'</a> '. $value .'
                ';
            // self::_addLogs($log);
            
        }
        
        if ($fieldName == 'staff_id' && $staffId != $newStaffId) {
            $result     = $db->query("
                SELECT *
                FROM hb_client_access
                WHERE id = :id
                ", array(
                    ':id'   => $newStaffId
                ))->fetch();
            
            if (isset($result['id'])) {
                require_once(APPDIR . 'class.general.custom.php');
                $url        = GeneralCustom::singleton()->getAdminUrl()
                            . '?cmd=servicecataloghandle&action=viewIncidentKB&id='. $id;
                
                $emailTo    = $result['email'];
                $subject    = $aAdmin['firstname'] .' ได้ Assign Service Catalog #'. $id .' ให้คุณจัดการ';
                $html       = '
                        <h1>'. $title .'</h1>
                        --------------------------------------------------
                        <p>Url: '.$url.'</p>
                        ';
                
                $header     = 'MIME-Version: 1.0' . "\r\n" .
                        'Content-type: text/html; charset=utf-8' . "\r\n" .
                        'From: admin@netway.co.th' . "\r\n" .
                        'Reply-To: admin@netway.co.th' . "\r\n" .
                        'X-Mailer: PHP/' . phpversion();
                
                @mail($emailTo, $subject, $html, $header);
            }
        }
        
        echo '<!-- {"ERROR":[],"INFO":["Update ข้อมูลเรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function addReplyTemplate ($request)
    {
        $db             = hbm_db();
        
        $serviceCatalogId   = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $this->template->assign('serviceCatalogId', $serviceCatalogId);
        $kbId           = isset($request['kbId']) ? $request['kbId'] : 0;
        $this->template->assign('kbId', $kbId);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.add_reply_template.tpl',array(), false);
    }
    
    public function editReplyTemplate ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $oTeam          = self::_myTeam();
        
        $serviceCatalogId   = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $this->template->assign('serviceCatalogId', $serviceCatalogId);
        $kbId               = isset($request['kbId']) ? $request['kbId'] : 0;
        $this->template->assign('kbId', $kbId);
        $id                 = isset($request['id']) ? $request['id'] : 0;
        
        $result         = $db->query("
                SELECT
                    rt.*, ad.firstname AS owner
                FROM
                    sc_reply_template rt
                    LEFT JOIN
                        hb_admin_details ad
                        ON ad.id = rt.staff_id
                WHERE
                    rt.id = :id
                ", array(
                    ':id'       => $id
                ))->fetch();
        
        $this->template->assign('aReply', $result);
        
        $isDisable      = false;
        if ($result['staff_id'] != $aAdmin['id'] && $oTeam->level < 2) {
            $isDisable  = true;
        }
        $this->template->assign('isDisable', $isDisable);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.edit_reply_template.tpl',array(), false);
    }
    
    public function relatedByReplyTemplate ($request)
    {
        $db             = hbm_db();
        
        $serviceCatalogId   = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $kbId               = isset($request['kbId']) ? $request['kbId'] : 0;
        $id                 = isset($request['id']) ? $request['id'] : 0;
        $type               = isset($request['type']) ? $request['type'] : '';
        
        if ($type == 'IncidentKB') {
            $result         = $db->query("
                SELECT
                    kb.*
                FROM
                    in_incident_2_template i2t,
                    in_incident_kb kb
                WHERE
                    i2t.in_id = kb.id
                    AND i2t.rt_id = :rtId
                    AND i2t.in_id != :inId
                ", array(
                    ':rtId'     => $id,
                    ':inId'     => $kbId
                ))->fetchAll();
        }
        if ($type == 'ServiceCatalog') {
            $result         = $db->query("
                SELECT
                    sc.*
                FROM
                    sc_catalog_2_template c2t,
                    sc_service_catalog sc
                WHERE
                    c2t.sc_id = sc.id
                    AND c2t.rt_id = :rtId
                    AND c2t.sc_id != :scId
                ", array(
                    ':rtId'     => $id,
                    ':scId'     => $serviceCatalogId
                ))->fetchAll();
        }
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($result));
        $this->json->show();
    }
    
    public function searchReplyTemplate ($request)
    {
        $db             = hbm_db();
        
        $keyword        = isset($request['keyword']) ? $request['keyword'] : '';
        $serviceCatalogId       = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $kbId           = isset($request['kbId']) ? $request['kbId'] : 0;
        
        if ($kbId) {
            $result     = $db->query("
                    SELECT
                        rt.*
                    FROM
                        sc_reply_template rt
                        LEFT JOIN
                            in_incident_2_template i2t
                            ON i2t.rt_id = rt.id
                            AND i2t.in_id = :kbId
                    WHERE
                        i2t.rt_id IS NULL
                        ". ($keyword ? " AND ( rt.subject LIKE '%{$keyword}%' OR rt.message LIKE '%{$keyword}%' ) " : "") ."
                    ", array(
                        ':kbId'     => $kbId
                    ))->fetchAll();
        } else {
            $result     = $db->query("
                    SELECT
                        rt.*
                    FROM
                        sc_reply_template rt
                        LEFT JOIN
                            sc_catalog_2_template c2t
                            ON c2t.rt_id = rt.id
                            AND c2t.sc_id = :scId
                    WHERE
                        c2t.rt_id IS NULL
                        ". ($keyword ? " AND ( rt.subject LIKE '%{$keyword}%' OR rt.message LIKE '%{$keyword}%' ) " : "") ."
                    ", array(
                        ':scId'     => $serviceCatalogId
                    ))->fetchAll();
        }
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($result));
        $this->json->show();
    }
    
    public function createReplyTemplate ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $serviceCatalogId   = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $kbId           = isset($request['kbId']) ? $request['kbId'] : 0;
        $level          = isset($request['level']) ? $request['level'] : 1;
        $subject        = isset($request['subject']) ? $request['subject'] : '';
        $message        = isset($request['message']) ? $request['message'] : '';
        
        $db->query("
                INSERT INTO sc_reply_template (
                    id, staff_id, subject, modified, message
                ) VALUES (
                    '', :staffId, :subject, NOW(), :message
                )
                ", array(
                    ':staffId'      => $aAdmin['id'],
                    ':subject'      => $subject,
                    ':message'      => $message,
                ));
        
        $result     = $db->query("SELECT MAX(id) AS id FROM sc_reply_template")->fetch();
        $id      = isset($result['id']) ? $result['id'] : 0;
        
        $request['id']      = $id;
        
        self::selectReplyTemplate($request);
    }
    
    public function selectReplyTemplate ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $serviceCatalogId   = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $kbId           = isset($request['kbId']) ? $request['kbId'] : 0;
        $level          = isset($request['level']) ? $request['level'] : 0;
        $id             = isset($request['id']) ? $request['id'] : 0;
        
        if ((! $serviceCatalogId && ! $kbId) || ! $id) {
            echo '<!-- {"ERROR":["ไม่พบข้อมูล Service Catalog, Incident KB หรือ reply template"],"INFO":[]'
                . ',"RESULT":["ERROR"]'
                . ',"STACK":0} -->';
            exit;
        }
        
        
        if ($kbId) {
            $db->query("
                    DELETE FROM in_incident_2_template WHERE in_id = :inId AND rt_id = :rtId
                    ", array(
                        ':inId'     => $kbId,
                        ':rtId'     => $id,
                    ));
            
            $db->query("
                    REPLACE INTO in_incident_2_template (
                        in_id, rt_id, level
                    ) VALUES (
                        :inId, :rtId, :level
                    )
                    ", array(
                        ':inId'         => $kbId,
                        ':rtId'         => $id,
                        ':level'        => $level,
                    ));
            
            $log        = '#'. $aAdmin['firstname'] .' select reply template 
                <a href="?cmd=servicecataloghandle&action=viewIncidentKB&id='. $kbId .'">#'. $kbId .' 
                '. $id .'</a> 
                ';
            // self::_addLogs($log);
        } else {
            $db->query("
                    REPLACE INTO sc_catalog_2_template (
                        sc_id, rt_id
                    ) VALUES (
                        :scId, :rtId
                    )
                    ", array(
                        ':scId'         => $serviceCatalogId,
                        ':rtId'         => $id,
                    ));
            
            $log        = '#'. $aAdmin['firstname'] .' select reply template 
                <a href="?cmd=servicecataloghandle&action=view&id='. $serviceCatalogId .'">#'. $serviceCatalogId .' 
                '. $id .'</a> 
                ';
            // self::_addLogs($log);
        }
        
        echo '<!-- {"ERROR":[],"INFO":["บันทึกข้อมูลเรียบร้อย"]'
            . ',"RESULT":["INFO"]'
            . ',"STACK":0} -->';
        exit;
    }

    public function viewReplyTemplate ($request)
    {
        $db             = hbm_db();
        
        $id             = isset($request['id']) ? $request['id'] : 0;
        
        $result         = $db->query("
                SELECT
                    rt.*, ad.firstname AS owner
                FROM
                    sc_reply_template rt
                    LEFT JOIN
                        hb_admin_details ad
                        ON ad.id = rt.staff_id
                WHERE
                    rt.id = :id
                ", array(
                    ':id'       => $id
                ))->fetch();
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($result));
        $this->json->show();
    }
    
    public function updateReplyTemplate ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $serviceCatalogId   = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $id             = isset($request['id']) ? $request['id'] : 0;
        $subject        = isset($request['subject']) ? $request['subject'] : '';
        $message        = isset($request['message']) ? $request['message'] : '';
        
        $oTeam          = self::_myTeam();
        
        $result         = $db->query("
                SELECT rt.*
                FROM sc_reply_template rt
                WHERE rt.id = :id
                ", array(
                    ':id'       => $id
                ))->fetch();
        
        if ($result['staff_id'] != $aAdmin['id'] && $oTeam->level < 2) {
            echo '<!-- {"ERROR":["คุณไม่มีสิทธิ์แก้ไขข้อมูลนี้"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $db->query("
                UPDATE
                    sc_reply_template
                SET
                    subject = :subject,
                    message = :message,
                    modified = NOW()
                WHERE
                    id = :id
                ", array(
                    ':subject'      => $subject,
                    ':message'      => $message,
                    ':id'           => $id,
                ));
        
        $log        = '#'. $aAdmin['firstname'] .' update reply template 
            <a href="?cmd=servicecataloghandle&action=view&id='. $serviceCatalogId .'">#'. $serviceCatalogId .' 
            '. $id .'</a> '. $subject .' '. $message .'
            ';
        self::_addLogs($log);
        
        echo '<!-- {"ERROR":[],"INFO":["บันทึกข้อมูลเรียบร้อย"]'
            . ',"RESULT":["INFO"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function createProcessGroup ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $serviceCatalogId   = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $name               = isset($request['name']) ? $request['name'] : '';
        $fromId             = isset($request['from']) ? $request['from'] : '';
        $tag                = isset($request['tag']) ? $request['tag'] : '';
        $parentId           = 0;
        
        if (! $serviceCatalogId && (! $name || ! $fromId) ) {
            echo '<!-- {"ERROR":["ข้อมูลไม่ครบถ้าน"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $result         = $db->query("
            SELECT *
            FROM sc_process_group
            WHERE id = :id
            ", array(
                ':id'   => $fromId
            ))->fetch();
        
        if (isset($result['id'])) {
            $parentId   = $result['id'];
            $name       = $result['name'];
            $tag        = $result['sla_tag'];
        }
        
        $db->query("
                INSERT INTO sc_process_group (
                    id, sc_id, name, orders, parent_id, sla_tag
                ) VALUES (
                    '', :scId, :name, 9, :parentId, :tag
                )
                ", array(
                    ':scId'     => $serviceCatalogId,
                    ':name'     => $name,
                    ':parentId' => $parentId,
                    ':tag'      => $tag,
                ));
        
        $log        = '#'. $aAdmin['firstname'] .' add process group 
            <a href="?cmd=servicecataloghandle&action=view&id='. $serviceCatalogId .'">#'. $serviceCatalogId .' 
            '. $name .'</a>
            ';
        self::_addLogs($log);
        
        echo '<!-- {"ERROR":[],"INFO":["บันทึกข้อมูลเรียบร้อย"]'
            . ',"RESULT":["INFO"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function updateProcessGroup ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $serviceCatalogId       = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $groupId        = isset($request['groupId']) ? $request['groupId'] : 0;
        $name           = isset($request['name']) ? $request['name'] : '';
        $tag            = isset($request['tag']) ? $request['tag'] : '';
        
        if (! $groupId) {
            echo '<!-- {"ERROR":["ข้อมูลไม่ครบถ้าน"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        if ($name) {
            $db->query("
                    UPDATE sc_process_group 
                    SET name = :name
                    WHERE id = :id
                    ", array(
                        ':id'       => $groupId,
                        ':name'     => $name,
                    ));
        }
        
        if ($tag) {
            $db->query("
                    UPDATE sc_process_group 
                    SET sla_tag = :tag
                    WHERE id = :id
                    ", array(
                        ':id'       => $groupId,
                        ':tag'      => $tag,
                    ));
        }
        
        $log        = '#'. $aAdmin['firstname'] .' rename process group 
            <a href="?cmd=servicecataloghandle&action=view&id='. $serviceCatalogId .'">#'. $serviceCatalogId .' 
            '. $name .'</a>
            ';
        self::_addLogs($log);
        
        echo '<!-- {"ERROR":[],"INFO":["บันทึกข้อมูลเรียบร้อย"]'
            . ',"RESULT":["INFO"]'
            . ',"STACK":0} -->';
        exit;
    }

    public function addTaskToList ($request)
    {
        $db             = hbm_db();
        
        $serviceCatalogId       = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $groupId        = isset($request['groupId']) ? $request['groupId'] : 0;
        
        $this->template->assign('serviceCatalogId', $serviceCatalogId);
        $this->template->assign('groupId', $groupId);
        
        $aAssign        = self::_listAssignStaff();
        $this->template->assign('aAssign', $aAssign);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.add_task_to_list.tpl',array(), false);
    }
    
    public function searchFulfillmentTask ($request)
    {
        $db             = hbm_db();
        
        $keyword        = isset($request['keyword']) ? $request['keyword'] : '';
        $serviceCatalogId       = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $groupId        = isset($request['groupId']) ? $request['groupId'] : 0;
        
        $result         = $db->query("
                SELECT
                    pt.*
                FROM
                    sc_process_task pt
                    LEFT JOIN
                        sc_catalog_2_task c2t
                        ON c2t.pt_id = pt.id
                        AND c2t.sc_id = :scId
                        AND c2t.pg_id = :pgId
                WHERE
                    c2t.pt_id IS NULL
                    ". ($keyword ? " AND ( pt.name LIKE '%{$keyword}%' OR pt.detail LIKE '%{$keyword}%' ) " : "") ."
                ", array(
                    ':scId'     => $serviceCatalogId,
                    ':pgId'     => $groupId
                ))->fetchAll();
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($result));
        $this->json->show();
    }
    
    public function selectFulfillmentTask ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $serviceCatalogId   = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $groupId            = isset($request['groupId']) ? $request['groupId'] : 0;
        $id             = isset($request['id']) ? $request['id'] : 0;
        
        if (! $serviceCatalogId || ! $groupId || ! $id) {
            echo '<!-- {"ERROR":["ไม่พบข้อมูล service catalog id หรือ fulfillment task"],"INFO":[]'
                . ',"RESULT":["ERROR"]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $db->query("
                INSERT INTO sc_catalog_2_task (
                    id, sc_id, pg_id, pt_id, orders
                ) VALUES (
                    '', :scId, :pgId, :ptId, 99
                )
                ", array(
                    ':scId'         => $serviceCatalogId,
                    ':pgId'         => $groupId,
                    ':ptId'         => $id
                ));
        
        $log        = '#'. $aAdmin['firstname'] .' add fulfillment task to task list 
            <a href="?cmd=servicecataloghandle&action=view&id='. $serviceCatalogId .'">#'. $serviceCatalogId .' 
            '. $id .'</a> 
            ';
        self::_addLogs($log);
        
        echo '<!-- {"ERROR":[],"INFO":["บันทึกข้อมูลเรียบร้อย"]'
            . ',"RESULT":["INFO"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function viewFulfillmentTask ($request)
    {
        $db             = hbm_db();
        
        $id             = isset($request['id']) ? $request['id'] : 0;
        
        $oTeam          = $this->_myTeam();
        
        $result         = $db->query("
                SELECT
                    pt.*, ad.firstname AS owner,
                    t.name AS team, adx.firstname AS staffname
                FROM
                    sc_process_task pt
                    LEFT JOIN
                        hb_admin_details ad
                        ON ad.id = pt.staff_id
                    LEFT JOIN
                        sc_team t
                        ON t.id = pt.assign_team_id
                    LEFT JOIN
                        hb_admin_details adx
                        ON adx.id = pt.assign_staff_id
                WHERE
                    pt.id = :id
                ", array(
                    ':id'       => $id
                ))->fetch();
        
        if (isset($result['id']) && isset($oTeam->level)) {
            $result['isDeleteAble'] = ($oTeam->level == 3) ? $oTeam->level : 0;
        }
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($result));
        $this->json->show();
    }
    
    public function createFulfillmentTask ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $serviceCatalogId   = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $groupId        = isset($request['groupId']) ? $request['groupId'] : 0;
        $name           = isset($request['name']) ? $request['name'] : '';
        $assignStaffId  = isset($request['assign']) ? $request['assign'] : 0;
        $detail         = isset($request['detail']) ? $request['detail'] : '';
        $ola            = isset($request['ola']) ? $request['ola'] : 0;
        $linkGForm		= isset($request['linkGForm']) ? $request['linkGForm'] : '';
        $linkGFormResponse	= isset($request['linkGFormResponse']) ? $request['linkGFormResponse'] : '';
        
        $result         = $db->query("
                SELECT tm.*
                FROM sc_team_member tm
                WHERE tm.staff_id = :staffId
                ", array(
                    ':staffId'      => $assignStaffId
                ))->fetch();
        
        $teamId         = isset($result['team_id']) ? $result['team_id'] : 0;
        
        $db->query("
                INSERT INTO sc_process_task (
                    id, staff_id, name, modified, detail, assign_team_id, assign_staff_id, ola_in_minute, link_google_form, link_response_google_form
                ) VALUES (
                    '', :staffId, :name, NOW(), :detail, :teamId, :assignStaffId, :ola, :linkGForm, :linkGFormResponse
                )
                ", array(
                    ':staffId'      => $aAdmin['id'],
                    ':name'         => $name,
                    ':detail'       => $detail,
                    ':teamId'       => $teamId,
                    ':assignStaffId'=> $assignStaffId,
                    ':ola'          => $ola,
                    ':linkGForm'	=> $linkGForm,
                    ':linkGFormResponse'	=> $linkGFormResponse
                ));
        
        $result     = $db->query("SELECT MAX(id) AS id FROM sc_process_task")->fetch();
        $id      = isset($result['id']) ? $result['id'] : 0;
        
        if (! $serviceCatalogId || ! $id || ! $groupId) {
            echo '<!-- {"ERROR":["ไม่พบข้อมูล service catalog id หรือ task id หรือ group id "],"INFO":[]'
                . ',"RESULT":["ERROR"]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $db->query("
                INSERT INTO sc_catalog_2_task (
                    id, sc_id, pg_id, pt_id, orders
                ) VALUES (
                    '', :scId, :pgId, :ptId, 99
                )
                ", array(
                    ':scId'         => $serviceCatalogId,
                    ':pgId'         => $groupId,
                    ':ptId'         => $id,
                ));
        
        $log        = '#'. $aAdmin['firstname'] .' create new fulfillment task 
            <a href="?cmd=servicecataloghandle&action=view&id='. $serviceCatalogId .'">#'. $serviceCatalogId .' 
            '. $id .' '. $name .'</a>
            ';
        self::_addLogs($log);
        
        echo '<!-- {"ERROR":[],"INFO":["บันทึกข้อมูลเรียบร้อย"]'
            . ',"RESULT":["INFO"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function editFulfillmentTask ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $oTeam          = self::_myTeam();
        
        $serviceCatalogId   = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $id                 = isset($request['id']) ? $request['id'] : 0;
        $this->template->assign('c2tid', $id);
        $this->template->assign('serviceCatalogId', $serviceCatalogId);
        
        $result         = $db->query("
                SELECT
                    pt.*, ad.firstname AS owner
                FROM
                    sc_catalog_2_task c2t,
                    sc_process_task pt
                    LEFT JOIN
                        hb_admin_details ad
                        ON ad.id = pt.staff_id
                WHERE
                    c2t.id = :id
                    AND c2t.pt_id = pt.id
                ", array(
                    ':id'       => $id
                ))->fetch();
        
        $this->template->assign('aTask', $result);
        
        $isDisable      = false;
        if ($result['staff_id'] != $aAdmin['id'] && $oTeam->level < 2) {
            $isDisable  = true;
        }
        $this->template->assign('isDisable', $isDisable);
        
        $aAssign        = self::_listAssignStaff();
        $this->template->assign('aAssign', $aAssign);
        
        $result         = self::lsitActivityModule();
        $this->template->assign('aActivityModule', $result);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.edit_fulfillment_task.tpl',array(), false);
    }
    
    public function updateFulfillmentActivityModule ($request)
    {
        $db         = hbm_db();
        
        $processTaskId  = isset($request['processTaskId']) ? $request['processTaskId'] : 0;
        $moduleId       = isset($request['moduleId']) ? $request['moduleId'] : 0;
        
        $db->query("
            UPDATE sc_process_task
            SET module_id = :moduleId
            WHERE id = :id
            ", array(
                ':moduleId' => $moduleId,
                ':id'       => $processTaskId
            ));
        
        $result         = $db->query("
            SELECT module
            FROM hb_modules_configuration
            WHERE id = :id
            ", array(
                ':id'   => $moduleId
            ))->fetch();
        
        $moduleName     = isset($result['module']) ? $result['module'] : '';
        
        if ($moduleName && $processTaskId) {
            require_once(APPDIR .'modules/Other/'. $moduleName .'/admin/class.'. $moduleName .'_controller.php');
            $className      = $moduleName .'_controller';
            $obj            = new $className();
            $obj->configActivityModule($request);
        }
        
        
        echo '<!-- {"ERROR":[],"INFO":["เลือก module เรียบร้อยแล้ว"]'
            . ',"RESULT":["INFO"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function lsitActivityModule ()
    {
        $db         = hbm_db();
        
        $aModule    = array();
        
        $result     = $db->query("
            SELECT *
            FROM hb_modules_configuration
            WHERE `type` = 'Other'
                AND active = 1
            ORDER BY module ASC
            ")->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $aConfig    = unserialize($arr['config']);
                if (isset($aConfig['Fulfillment Activity Module']) && $aConfig['Fulfillment Activity Module']['value']) {
                    array_push($aModule, $arr);
                }
            }
        }
       
       return $aModule;
    }
    
    private function _listAssignStaff ()
    {
        $db             = hbm_db();
        
        $aAssign        = array();
        
        $result         = $db->query("
                SELECT t.id AS teamId, t.name AS teamName,
                    tm.staff_id, tm.level, ad.firstname
                FROM sc_team t,
                    sc_team_member tm,
                    hb_admin_details ad
                WHERE
                    t.id = tm.team_id
                    AND tm.staff_id = ad.id
                ORDER BY t.name ASC, tm.level ASC, ad.firstname ASC
                ")->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $teamId         = $arr['teamId'];
                $staffId        = $arr['staff_id'];
                
                if (! isset($aAssign[$teamId])) {
                    $aAssign[$teamId]   = array(
                        'team'          => $arr['teamName'],
                        'staff'         => array(),
                        );
                }
                
                $aAssign[$teamId]['staff'][$staffId]    = array(
                    'firstname'     => $arr['firstname'],
                    'level'         => $arr['level'],
                    );
                
            }
        }
        
        return $aAssign;
    }
    
    public function updateFulfillmentTask ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $serviceCatalogId   = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $taskId         = isset($request['taskId']) ? $request['taskId'] : 0;
        $assignStaffId  = isset($request['assign']) ? $request['assign'] : 0;
        $name           = isset($request['name']) ? $request['name'] : '';
        $ola            = isset($request['ola']) ? $request['ola'] : 0;
        $detail         = isset($request['detail']) ? $request['detail'] : '';
		$linkGForm		= isset($request['linkGForm']) ? $request['linkGForm'] : '';
        $linkGFormResponse	= isset($request['linkGFormResponse']) ? $request['linkGFormResponse'] : '';
        
        $result         = $db->query("
                SELECT tm.*
                FROM sc_team_member tm
                WHERE tm.staff_id = :staffId
                ", array(
                    ':staffId'      => $assignStaffId
                ))->fetch();
        
        $teamId         = isset($result['team_id']) ? $result['team_id'] : 0;
        
        $oTeam          = self::_myTeam();
        
        $result         = $db->query("
                SELECT pt.*
                FROM sc_process_task pt
                WHERE pt.id = :id
                ", array(
                    ':id'       => $taskId
                ))->fetch();
        
        if ($result['staff_id'] != $aAdmin['id'] && $oTeam->level < 2) {
            echo '<!-- {"ERROR":["คุณไม่มีสิทธิ์แก้ไขข้อมูลนี้"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $db->query("
                UPDATE
                    sc_process_task
                SET
                    name = :name,
                    detail = :detail,
                    ola_in_minute = :ola,
                    assign_team_id = :teamId,
                    assign_staff_id = :staffId,
                    modified = NOW(),
                    link_google_form = :link_google_form,
                    link_response_google_form = :link_response_google_form
                WHERE
                    id = :id
                ", array(
                    ':name'         => $name,
                    ':detail'       => $detail,
                    ':ola'          => $ola,
                    ':teamId'       => $teamId,
                    ':staffId'      => $assignStaffId,
                    ':id'           => $taskId,
                    ':link_google_form'				=> $linkGForm,
                    ':link_response_google_form'	=> $linkGFormResponse
                ));
        
        $log        = '#'. $aAdmin['firstname'] .' update fulfillment task 
            <a href="?cmd=servicecataloghandle&action=view&id='. $serviceCatalogId .'">#'. $serviceCatalogId .' 
            '. $taskId .' '. $name .'</a>
            ';
        self::_addLogs($log);
        
        echo '<!-- {"ERROR":[],"INFO":["บันทึกข้อมูลเรียบร้อย"]'
            . ',"RESULT":["INFO"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function relatedByFulfillmentTask ($request)
    {
        $db             = hbm_db();
        
        $serviceCatalogId   = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $taskId             = isset($request['taskId']) ? $request['taskId'] : 0;
        
        $result         = $db->query("
            SELECT
                sc.*
            FROM
                sc_catalog_2_task c2t,
                sc_service_catalog sc
            WHERE
                c2t.sc_id = sc.id
                AND c2t.pt_id = :ptId
                AND c2t.sc_id != :scId
            ", array(
                ':ptId'     => $taskId,
                ':scId'     => $serviceCatalogId
            ))->fetchAll();
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($result));
        $this->json->show();
    }
    
    public function removeFulfillmentTask ($request)
    {
        $db             = hbm_db();
        
        $serviceCatalogId   = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $id                 = isset($request['id']) ? $request['id'] : 0;
        
        $db->query("
                DELETE FROM sc_catalog_2_task
                WHERE id = :id
                ", array(
                    ':id'       => $id,
                ));
        
        $_SESSION['notification']   = array('type' => 'success', 'message' => 'ลบ task ออกจากรายการ fulfillment process เรียบร้อยแล้ว');
        header('location:?cmd=servicecataloghandle&action=view&id='. $serviceCatalogId);
        exit;
    }
    
    public function sortProcessGroup ($request)
    {
        $db             = hbm_db();
        
        $serviceCatalogId       = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $this->template->assign('serviceCatalogId', $serviceCatalogId);
        
        $result         = $db->query("
                SELECT pg.*
                FROM sc_process_group pg
                WHERE pg.sc_id = :scId
                ORDER BY pg.orders ASC
                ", array(
                    ':scId'     => $serviceCatalogId
                ))->fetchAll();
        
        $this->template->assign('aGroups', $result);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.sort_process_group.tpl',array(), false);
    }
    
    public function orderProcessGroup ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $serviceCatalogId       = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $aLists         = isset($request['lists']) ? explode(',', $request['lists']) : array();
        
        if (! count($aLists)) {
            echo '<!-- {"ERROR":["ไม่พบรายการที่ต้องการให้จัดการ"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        foreach ($aLists as $k => $id) {
            $db->query("
                    UPDATE 
                        sc_process_group
                    SET 
                        orders = :orders
                    WHERE
                        id = :id
                        AND sc_id = :scId
                    ", array(
                        ':orders'       => $k,
                        ':id'           => $id,
                        ':scId'         => $serviceCatalogId,
                    ));
            
        }
        
        $log        = '#'. $aAdmin['firstname'] .' usort process group
            <a href="?cmd=servicecataloghandle&action=view&id='. $serviceCatalogId .'">#'. $serviceCatalogId .' 
            '. implode(', ', $aLists) .'</a>
            ';
        self::_addLogs($log);
        
        echo '<!-- {"ERROR":[],"INFO":["เรียงลำดับเรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function sortProcess ($request)
    {
        $db             = hbm_db();
        
        $serviceCatalogId       = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $groupId        = isset($request['groupId']) ? $request['groupId'] : 0;
        $this->template->assign('serviceCatalogId', $serviceCatalogId);
        $this->template->assign('groupId', $groupId);
        
        $result         = $db->query("
                SELECT c2t.*, pt.name
                FROM sc_catalog_2_task c2t,
                    sc_process_task pt
                WHERE c2t.sc_id = :scId
                    AND c2t.pg_id = :pgId
                    AND c2t.pt_id = pt.id
                ORDER BY c2t.orders ASC
                ", array(
                    ':scId'     => $serviceCatalogId,
                    ':pgId'     => $groupId,
                ))->fetchAll();
        
        $this->template->assign('aProcess', $result);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.sort_process.tpl',array(), false);
    }
    
    public function orderProcess ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $serviceCatalogId       = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $groupId        = isset($request['groupId']) ? $request['groupId'] : 0;
        $aLists         = isset($request['lists']) ? explode(',', $request['lists']) : array();
        
        if (! count($aLists)) {
            echo '<!-- {"ERROR":["ไม่พบรายการที่ต้องการให้จัดการ"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        foreach ($aLists as $k => $id) {
            $db->query("
                    UPDATE 
                        sc_catalog_2_task
                    SET 
                        orders = :orders
                    WHERE
                        id = :id
                        AND sc_id = :scId
                        AND pg_id = :pgId
                    ", array(
                        ':orders'       => $k,
                        ':id'           => $id,
                        ':scId'         => $serviceCatalogId,
                        ':pgId'         => $groupId,
                    ));
            
        }
        
        $log        = '#'. $aAdmin['firstname'] .' usort process
            <a href="?cmd=servicecataloghandle&action=view&id='. $serviceCatalogId .'">#'. $serviceCatalogId .' 
            '. implode(', ', $aLists) .'</a>
            ';
        self::_addLogs($log);
        
        echo '<!-- {"ERROR":[],"INFO":["เรียงลำดับเรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function addCategory ($request)
    {
        $db             = hbm_db();
        
        $type           = isset($request['type']) ? $request['type'] : '';
        $this->template->assign('type', $type);
        
        $aCategory      = self::_getCategory($type);
        $aLists         = array();
        $aLists         = self::_listCategory($aLists, $aCategory);
        $this->template->assign('aLists', $aLists);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.add_category.tpl',array(), false);
    }
    
    public function createCategory ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $name           = isset($request['name']) ? $request['name'] : '';
        $parentId       = isset($request['parentId']) ? $request['parentId'] : 0;
        $type           = isset($request['type']) ? $request['type'] : '';
        
        if (! $name ) {
            echo '<!-- {"ERROR":[],"INFO":["ชื่อ Category เกิดข้อผิดพลาด"]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $table          = ($type == 'incidentKB') ? 'in_category' : 'sc_category';
        
        $db->query("
                INSERT INTO {$table} (
                id, parent_id, name, orders
                ) VALUES (
                '', :parentId, :name, 10000
                )
                ", array(
                    ':parentId'     => $parentId,
                    ':name'         => $name
                ));
        
        $log            = '#'. $aAdmin['firstname'] .' create category 
            <a href="index.php?cmd=servicecataloghandle&action=browse&type='. $type .'">'. $name .'</a>
            ';
        // self::_addLogs($log);
        
        echo '<!-- {"ERROR":[],"INFO":["เพิ่ม Category เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function _getCategory ($type = '')
    {
        $db             = hbm_db();
        
        $table          = ($type == 'incidentKB') ? " in_category " : " sc_category ";
        
        $result         = $db->query("
                SELECT c.*
                FROM {$table} c
                ORDER BY c.orders ASC
                ")->fetchAll();
        
        $aCategory      = array();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $catId          = $arr['id'];
                $parentId       = $arr['parent_id'];
                $aCategory[$parentId][$catId]      = $arr;
            }
        }
        
        return $aCategory;
    }
    
    private function _listCategory ($aLists, $aCategory, $parentId = 0, $level = 0)
    {
        if (! count($aCategory[$parentId])) {
            return $aLists;
        }
        
        $level++;
        $aCategory_temp     = $aCategory[$parentId];
        
        foreach ($aCategory_temp as $catId => $arr) {
            $arr['level']   = str_repeat('--- ', $level);
            array_push($aLists, $arr);
            $aLists         = self::_listCategory($aLists, $aCategory, $catId, $level);
        }
        
        return $aLists;
    }
    
    /*
     * update team ให้ staff
     */
    public function assignTeam ($request) 
    {
        $db             = hbm_db();
        
        $staffId        = isset($request['staffId']) ? $request['staffId'] : 0;
        $teamId         = isset($request['teamId']) ? $request['teamId'] : 0;
        $level          = isset($request['level']) ? $request['level'] : 0;
        $policy1        = isset($request['escalation_policy_1']) ? $request['escalation_policy_1'] : '';
        $policy2        = isset($request['escalation_policy_2']) ? $request['escalation_policy_2'] : '';
        $policy3        = isset($request['escalation_policy_3']) ? $request['escalation_policy_3'] : '';
        
        $tel21          = isset($request['tel21']) ? $request['tel21'] : '';
        $tel22          = isset($request['tel22']) ? $request['tel22'] : '';
        $tel31          = isset($request['tel31']) ? $request['tel31'] : '';
        $tel32          = isset($request['tel32']) ? $request['tel32'] : '';
        
        $policy1        = preg_replace('/\s\[\[[^\]]*\]\]\s/', ' [['. $tel21 .']] ', $policy1);
        $policy1        = preg_replace('/\s\[\[\[[^\]]*\]\]\]/', ' [[['. $tel22 .']]]', $policy1);
        $policy1        = preg_replace('/\s\{\{[^\}]*\}\}\s/', ' {{'. $tel31 .'}} ', $policy1);
        $policy1        = preg_replace('/\s\{\{\{[^\}]*\}\}\}/', ' {{{'. $tel32 .'}}}', $policy1);
        
        $result         = $db->query("
                SELECT
                    tm.*
                FROM
                    sc_team_member tm
                WHERE
                    tm.staff_id = :staffId
                ", array(
                    ':staffId'      => $staffId
                ))->fetch();
        
        if (! isset($result['id']) ) {
            $db->query("
                    INSERT INTO sc_team_member (
                        id, staff_id, team_id, level
                    ) VALUES (
                        '', :staffId, :teamId, :level
                    )
                    ", array(
                        ':teamId'       => $teamId,
                        ':level'        => $level,
                        ':staffId'      => $staffId,
                    ));
        }
        
        $db->query("
                UPDATE
                    sc_team_member
                SET
                    team_id = :teamId,
                    level = :level,
                    escalation_policy_1 = :policy1,
                    escalation_policy_2 = :policy2,
                    escalation_policy_3 = :policy3
                WHERE
                    staff_id = :staffId
                ", array(
                    ':teamId'       => $teamId,
                    ':level'        => $level,
                    ':staffId'      => $staffId,
                    ':policy1'      => $policy1,
                    ':policy2'      => $policy2,
                    ':policy3'      => $policy3,
                ));
        
        echo '<!-- {"ERROR":[],"INFO":[]'
            . ',"RESULT":"บันทึกข้อมูล Team สำหรับ Staff เรียบร้อย"'
            . ',"STACK":0} -->';
        exit;
    }
    
    private function _myTeam ($id = 0)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $oTeam          = (object) array('level' => 0, 'teamId' => 0);
        
        $staffId        = ($id) ? $id :  $aAdmin['id'];
        
        $result         = $db->query("
                SELECT tm.*, t.manager, ad.firstname
                FROM sc_team_member tm
                    LEFT JOIN sc_team t
                        ON t.id = tm.team_id
                    LEFT JOIN hb_admin_details ad
                        ON tm.staff_id = ad.id
                WHERE tm.staff_id = :staffId
                ", array(
                    ':staffId'      => $staffId
                ))->fetch();
        
        if (isset($result['id'])) {
            $owner              = $result['firstname'];
            $manager            = $result['manager'];
            $oTeam->level       = $result['level'];
            $oTeam->teamId      = $result['team_id'];
            $oTeam->policy1     = $result['escalation_policy_1'];
            $oTeam->policy1     = preg_replace('/\{\$manager\}/', '<u>'. $manager .'</u>', $oTeam->policy1);
            $oTeam->policy1     = preg_replace('/\{\$owner\}/', '<u>'. $owner .'</u>', $oTeam->policy1);
            $oTeam->policy2     = $result['escalation_policy_2'];
            $oTeam->policy2     = preg_replace('/\{\$manager\}/', '<u>'. $manager .'</u>', $oTeam->policy2);
            $oTeam->policy2     = preg_replace('/\{\$owner\}/', '<u>'. $owner .'</u>', $oTeam->policy2);
            $oTeam->policy3     = $result['escalation_policy_3'];
            $oTeam->policy3     = preg_replace('/\{\$manager\}/', '<u>'. $manager .'</u>', $oTeam->policy3);
            $oTeam->policy3     = preg_replace('/\{\$owner\}/', '<u>'. $owner .'</u>', $oTeam->policy3);
        }
        
        return $oTeam;
    }
    
    private function _addLogs ($log)
    {
        /*
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $db->query("
                INSERT INTO sc_logs (
                    id, staff_id, date, event, log
                ) VALUES (
                    '', :staffId, NOW(), 'createCategory', :log
                )
                ", array(
                    ':staffId'      => $aAdmin['id'],
                    ':log'          => $log
                ));
        */
    }
    
    public function listStaff ()
    {
        $db             = hbm_db();
        
        $aStaff         = array();
        
        $result         = $db->query("
                SELECT 
                    aa.id, ad.firstname
                FROM 
                    hb_admin_access aa,
                    hb_admin_details ad
                WHERE 
                    aa.id = ad.id
                    AND aa.status = 'Active'
                ORDER BY ad.firstname ASC
                ")->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $aStaff[$arr['id']]     = $arr['firstname'];
            }
        }
        
        return $aStaff;
    }
    
    public function globalEmailTemplate ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $oInfo          = (object) array(
            'title'     => 'Global Email Template',
            'desc'      => 'รายการ email reply template ที่ใช้ร่วมกันได้กับทุก service catalog'
            );
        
        $this->template->assign('oInfo', $oInfo);
        $this->template->assign('aAdmin', $aAdmin);
        
        $result         = $db->query("
                SELECT rtg.*,
                    ad.firstname
                FROM sc_reply_template_global rtg,
                    hb_admin_details ad
                WHERE rtg.staff_id = ad.id
                    AND rtg.is_delete = 0
                ORDER BY rtg.orders ASC
                ")->fetchAll();
        
        $this->template->assign('aLists', $result);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/global_email_template.tpl',array(), true);
    }
    
    public function addGlobalTemplate ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $subject        = isset($request['subject']) ? $request['subject'] : '';
        
        $db->query("
            INSERT INTO sc_reply_template_global (
                id, staff_id, subject, modified, orders
            ) VALUES (
                '', :stadffId, :subject, NOW(), 999
            )
            ", array(
                ':stadffId'     => $aAdmin['id'],
                ':subject'      => $subject,
            ));
        
        $result         = $db->query("SELECT MAX(id) AS id FROM sc_reply_template_global ")->fetch();
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($result));
        $this->json->show();
    }
    
    public function editGlobalTemplate ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $oInfo          = (object) array(
            'title'     => 'Edit Email Template',
            'desc'      => 'แก้ไข email reply template ที่ใช้ร่วมกันได้กับทุก service catalog'
            );
        
        $this->template->assign('oInfo', $oInfo);
        $this->template->assign('aAdmin', $aAdmin);
        
        $id             = isset($request['id']) ? $request['id'] : 0;
        
        $result         = $db->query("
                SELECT
                    rtg.*,
                    ad.firstname
                FROM
                    sc_reply_template_global rtg,
                    hb_admin_details ad
                WHERE
                    rtg.id = :id
                    AND rtg.staff_id = ad.id
                ", array(
                    ':id'       => $id
                ))->fetch();
        
        $this->template->assign('aData', $result);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/global_email_template_edit.tpl',array(), true);
    }

    public function updateGlobalTemplate ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $id             = isset($request['id']) ? $request['id'] : 0;
        $subject        = isset($request['subject']) ? $request['subject'] : '';
        $message        = isset($request['message']) ? $request['message'] : '';
        
        $db->query("
            UPDATE sc_reply_template_global
            SET subject = :subject,
                message = :message
            WHERE id = :id
            ", array(
                ':id'       => $id,
                ':subject'  => $subject,
                ':message'  => $message
            ));
        
        $_SESSION['notification']   = array('type' => 'success', 'message' => 'บันทึกข้อมูลเรียบร้อยแล้ว');
        header('location:?cmd=servicecataloghandle&action=globalEmailTemplate');
        exit;
    }
    
    public function deleteGlobalTemplate ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $id             = isset($request['id']) ? $request['id'] : 0;
        
        $db->query("UPDATE sc_reply_template_global SET is_delete = 1 WHERE id = :id ", array(':id' => $id));
        
        $log            = '#'. $aAdmin['firstname'] .' delete reply template #'. $id .'';
        self::_addLogs($log);
        
        $_SESSION['notification']   = array('type' => 'success', 'message' => 'ลบข้อมูลเรียบร้อยแล้ว');
        header('location:?cmd=servicecataloghandle&action=globalEmailTemplate');
        exit;
    }
    
    public function sortGlobalTemplate ($request)
    {
        $db             = hbm_db();
        
        $result         = $db->query("
            SELECT rtg.id, rtg.subject
            FROM sc_reply_template_global rtg
            WHERE rtg.is_delete = 0
            ORDER BY rtg.orders ASC
            ")->fetchAll();
        
        $this->template->assign('aLists', $result);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.sort_global_email_template.tpl',array(), false);
    }
    
    public function orderGlobalTemplate ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $aLists         = isset($request['lists']) ? explode(',', $request['lists']) : array();
        
        if (! count($aLists)) {
            echo '<!-- {"ERROR":["ไม่พบรายการ ที่ต้องการให้จัดการ"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        foreach ($aLists as $k => $id) {
            $db->query("
                    UPDATE 
                        sc_reply_template_global
                    SET 
                        orders = :orders
                    WHERE
                        id = :id
                    ", array(
                        ':orders'       => $k,
                        ':id'           => $id
                    ));
            
        }
        
        $log            = '#'. $aAdmin['firstname'] .' sort global email reply template 
            <a href="index.php?cmd=servicecataloghandle&action=globalEmailTemplate">#'. implode(', ', $aLists) .'</a>
            ';
        self::_addLogs($log);
        
        echo '<!-- {"ERROR":[],"INFO":["เรียงลำดับรายการ เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }

	public function duplicateFulfillmentProcessGroup($request){
		
		$db             = hbm_db();
		$processGroupId			= isset($request['processGroupId']) ? $request['processGroupId'] : 0;
		$serviceCatalogId		= isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
		
		$db->query("
					INSERT INTO sc_process_group (sc_id, name, orders, dla_in_minute)
					SELECT  sc_id, CONCAT(name,'_copy') as name, orders, dla_in_minute
					FROM   sc_process_group
					WHERE  id = :processGroupId
				", array(
					':processGroupId'	=>	$processGroupId
				));
				
		$result         				= $db->query("SELECT MAX(id) AS id FROM sc_process_group ")->fetch();
        $newProcessGroupId	            = isset($result['id']) ? $result['id'] : 0;
		
		$result	=	$db->query("
							SELECT
								*
							FROM
								sc_catalog_2_task
							WHERE
								sc_id = :serviceCatalogId
								AND pg_id = :processGroupId
						", array(
							':serviceCatalogId'		=>	$serviceCatalogId,
							':processGroupId'		=>	$processGroupId
						))->fetchAll();
						
		foreach($result as $aTasks){
			
			$db->query("
					INSERT INTO sc_catalog_2_task 
						(id, sc_id, pg_id, pt_id, orders)
					VALUES('', :sc_id, :pg_id, :pt_id, :orders)
				", array(
					':sc_id'			=> $serviceCatalogId,
					':pg_id'			=> $newProcessGroupId,
					':pt_id'			=> $aTasks['pt_id'],
					':orders'			=> $aTasks['orders'],
				));
			
		}
		
		echo '<!-- {"ERROR":[],"INFO":["Duplicate เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
		
		
	}

	public function deleteFulfillmentProcessGroup($request){
		
		$db             = hbm_db();
		$processGroupId			= isset($request['processGroupId']) ? $request['processGroupId'] : 0;
		$serviceCatalogId		= isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
		
		$db->query("
				DELETE 
				FROM sc_catalog_2_task
				WHERE
					sc_id = :sc_id
					AND pg_id = :pg_id
			", array(
				':sc_id'		=>	$serviceCatalogId,
				':pg_id'		=>	$processGroupId
			));
		
		$db->query("
				DELETE 
				FROM sc_process_group
				WHERE
					id = :id
					AND sc_id = :sc_id
			", array(
				':id'		=>	$processGroupId,
				':sc_id'	=>	$serviceCatalogId	
			));
		
		echo '<!-- {"ERROR":[],"INFO":["DELETE เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
		
	}

    public function deleteFulfillmentProcessTask($request)
    {
        $db         = hbm_db();
        $taskId     = isset($request['taskId']) ? $request['taskId'] : 0;
        
        $result     = $db->query("
            SELECT c2t.id, sc.is_delete AS isDelete
            FROM sc_catalog_2_task c2t
                LEFT JOIN sc_service_catalog sc
                    ON sc.id = c2t.sc_id
            WHERE c2t.pt_id = :taskId
            ", array(
                ':taskId'   => $taskId
            ))->fetch();
        
        if (isset($result['id']) && ! $result['isDelete']) {
            echo '<!-- {"ERROR":["ถูกใช้งานอยู่ที่ service catalog #'
                . '<a href=\"?cmd=servicecataloghandle&action=view&id='. $result['sc_id'] 
                . '\" target=\"_blank\">'. $result['sc_id'] .'</a>"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $db->query("
                DELETE 
                FROM sc_catalog_2_task
                WHERE
                    pt_id = :taskId
            ", array(
                ':taskId'   =>  $taskId
            ));
        
        $db->query("
                DELETE 
                FROM sc_process_task
                WHERE
                    id = :taskId
            ", array(
                ':taskId'   =>  $taskId
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["DELETE เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
        
    }
    
    public function editProcessTemplate ($request)
    {
        $db             = hbm_db();
        
        $serviceCatalogId   = isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0;
        $processGroupId     = isset($request['processGroupId']) ? $request['processGroupId'] : 0;
        
        $result         = $db->query("
            SELECT pg.*
            FROM sc_process_group pg
            WHERE pg.id = :id
            ", array(
                ':id'   => $processGroupId
            ))->fetch();
        
        $this->template->assign('aData', $result);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.process_information_template.tpl',array(), false);
    }

    public function updateProcessTemplate ($request)
    {
        $db             = hbm_db();
        
        $processGroupId     = isset($request['processGroupId']) ? $request['processGroupId'] : 0;
        $dataTemplate       = isset($request['dataTemplate']) ? $request['dataTemplate'] : '';
        
        $db->query("
            UPDATE sc_process_group
            SET data_template = :dataTemplate 
            WHERE id = :id
            ", array(
                ':dataTemplate' =>  $dataTemplate,
                ':id'           =>  $processGroupId,
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Update เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function afterCall ($request)
    {
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('oAdmin', (object)$aAdmin);
        
        $oTeam          = self::_myTeam();
        $this->template->assign('oTeam', $oTeam);
        
        $_SESSION['notification']   = array();
    }
}