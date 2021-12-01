<?php

class kbhandle_controller extends HBController {

    public function beforeCall ($request)
    {
        $this->_beforeRender();
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
 
    }

    public function sorter ($request)
    {
        $db         = hbm_db();
        
        $catId      = isset($request['catId']) ? $request['catId'] : 0;
        $this->template->assign('catId', $catId);
        
        $aCats      = array();
        
        $result     = $db->query("
                SELECT
                    kc.*
                FROM
                    hb_knowledgebase_cat kc
                WHERE
                    kc.parent_cat = :catId
                ORDER BY
                    kc.weight DESC
                ", array(
                    ':catId'    => $catId
                ))->fetchAll();
        
        if (count($result)) {
            $this->template->assign('aCats', $result);
        }
        
        $aItems      = array();
        
        $result     = $db->query("
                SELECT
                    kb.*
                FROM
                    hb_knowledgebase kb
                WHERE
                    kb.cat_id = :catId
                    AND kb.language_id = (
                        SELECT 
                            language_id 
                        FROM 
                            hb_knowledgebase b 
                        WHERE 
                            kb.id = b.id  
                        ORDER BY 
                            b.language_id 
                        DESC LIMIT 1 
                    )
                    
                ORDER BY
                    kb.weight DESC
                ", array(
                    ':catId'    => $catId
                ))->fetchAll();
        
        if (count($result)) {
            $this->template->assign('aItems', $result);
        }
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.sorter.tpl', array(), false);
    }

    public function sorterUpdate ($request)
    {
        $db         = hbm_db();
        
        $catId      = isset($request['catId']) ? $request['catId'] : 0;
        $type       = isset($request['type']) ? $request['type'] : '';
        $lists      = isset($request['lists']) ? $request['lists'] : '';
        
        $aList      = explode(',', $lists);
        
        if (! count($aList) || ! $type) {
            echo '<!-- {"ERROR":["Update kb '. $type .' fail."],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $i          = count($aList); 
        
        foreach ($aList as $id) {
            $db->query("
                UPDATE
                    ". (($type == 'cat') ? 'hb_knowledgebase_cat':'hb_knowledgebase') ."
                SET
                    weight = :weight
                WHERE
                    id = :id
                ", array(
                    ':weight'   => $i,
                    ':id'       => $id
                ));
                
            $i--;
        }
        
        echo '<!-- {"ERROR":[],"INFO":["Update kb '. $type .' successfully."]'
            . ',"STACK":0} -->';
        exit;
    }
    
    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function afterCall ($request)
    {
        
    }
}