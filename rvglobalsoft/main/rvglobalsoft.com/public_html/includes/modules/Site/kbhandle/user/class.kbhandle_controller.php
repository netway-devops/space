<?php


class kbhandle_controller extends HBController {

    public function beforeCall ($request)
    {
        $this->_beforeRender();
    }
    
    public function _default ($request)
    {
        $db             = hbm_db();
        
        
        //$this->template->assign('aDatas', $aDatas);
        //$this->template->render(dirname(dirname(__FILE__)) .'/templates/user/ajax.result.tpl', array(), false);
    }
    
    public function _getCategory ($request = array())
    {
        $db             = hbm_db();
        
        require_once(APPDIR . 'class.general.custom.php');
        
        $aCategories    = array();
        
        $result         = $db->query("
                SELECT
                    kc.*
                FROM
                    hb_knowledgebase_cat kc
                WHERE
                    1
                    and kc.is_delete <> 1
                ORDER BY 
                    kc.weight DESC
                ")->fetchAll();
        
        if (! count($result)) {
            return $aCategories;
        }
        
        foreach ($result as $aList) {
            $catId          = $aList['id'];
            $parentId       = $aList['parent_cat'];
            $aList['slug']  = GeneralCustom::singleton()->urlFriendlyThai($aList['name']);
            $aCategories[$parentId][$catId]     = $aList;
        }
        
        return $aCategories;
    }
    
    public function _listCategory ($request)
    {
        $aCategories    = self::_getCategory();
        
        if (! count($aCategories)) {
            return $aCategories;
        }
        
        $parentId       = isset($request['parentId']) ? $request['parentId'] : 0;
        
        $aLists         = array();
        
        $aLists         = self::_listCategoryChild($aLists, $aCategories, $parentId);
        
        return $aLists;
    }
    
    private function _listCategoryChild ($aLists, $aCategories, $parentId = 0, $level = 0)
    {
        if (! count($aCategories[$parentId])) {
            return $aLists;
        }
        
        $level++;
        $aCategories_temp   = $aCategories[$parentId];
        
        foreach ($aCategories_temp as $catId => $arr) {
            $arr['level']   = $level;
            array_push($aLists, $arr);
            $aLists     = self::_listCategoryChild($aLists, $aCategories, $catId, $level);
        }
        
        return $aLists;
    }
    
    public function _buildJumpMenuCategory ($request)
    {
        $aLists         = self::_listCategory($request);
        
        if (! count($aLists)) {
            return $aLists;
        }
        
        $linkUrl        = $request['linkUrl'];
        $target         = isset($request['target']) ? ' target="'. $request['target'] .'" ' : '';
        
        $aMenus         = array();
        for ($i = 0; $i < count($aLists); $i++) {
            array_push($aMenus, array('content' => '<li'.
                ( (isset($aLists[$i+1]) 
                && $aLists[$i]['level'] < $aLists[$i+1]['level']) ? ' class="dropdown-submenu" ' : '')
                .'>'));
            
            array_push($aMenus, array('content' => '    <a tabindex="-1" href="'.
                    $linkUrl .'/'. $aLists[$i]['id'] .'/'. $aLists[$i]['slug'] .'/'
                    . '" '. $target .'>'. $aLists[$i]['name'] .'</a>'));
            
            if (isset($aLists[$i+1]) && $aLists[$i]['level'] < $aLists[$i+1]['level']) {
                array_push($aMenus, array('content' => '    <ul class="dropdown-menu" style="width:350px;">'));
                continue;
            }
            if (isset($aLists[$i+1]) && $aLists[$i]['level'] > $aLists[$i+1]['level']) {
                $level      = $aLists[$i]['level'] - $aLists[$i+1]['level'];
                for ($j = 1; $j <= $level; $j++) {
                    array_push($aMenus, array('content' => '        </li>'));
                    array_push($aMenus, array('content' => '    </ul>'));
                }
                array_push($aMenus, array('content' => '</li>'));
                continue;
            }
            if (($i+1) == count($aLists) && ($aLists[$i]['level'] > 1)) {
                $level      = $aLists[$i]['level'] - 1;
                for ($j = 1; $j <= $level; $j++) {
                    array_push($aMenus, array('content' => '        </li>'));
                    array_push($aMenus, array('content' => '    </ul>'));
                }
            }
            array_push($aMenus, array('content' => '</li>'));
        }
        
        return $aMenus;
    }

    public function _listArticle ($request)
    {
        $db         = hbm_db();
        
        require_once(APPDIR . 'class.general.custom.php');
        
        $catId      = isset($request['catId']) ? $request['catId'] : 0;
        $aLists     = array();
        
        $result     = $db->query("
                SELECT
                    kb.*
                FROM
                    hb_knowledgebase kb
                WHERE
                    ". ((is_array($catId)) ? 
                            " kb.cat_id IN (". implode(',', $catId) .") " 
                            : " kb.cat_id = {$catId} " ) ."
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
                ")->fetchAll();
        
        if (! count($result)) {
            return $aLists;
        }
        
        foreach ($result as $arr) {
            if (isset($arr['tags']) && $arr['tags']) {
                $aTags          = explode(',', $arr['tags']);
                $arr['tags']    = '<a href="#" class="search-tags">'
                                    . implode('</a>, <a href="#" class="search-tags">', $aTags) .'</a>';
            }
            $aLists[$arr['id']]         = $arr;
            $aLists[$arr['id']]['slug'] = GeneralCustom::singleton()->urlFriendlyThai($arr['title']);
        }
        
        return $aLists;
    }
    
    /**
     * JSON Output
     * ดึงหัวข้อบทความที่เกี่ยวกับหมวด
     */
    public function listArticleByCatategoryId ($request)
    {
        $result     = self::_listArticle($request);
        
        if (! count($result)) {
            echo '<!-- {"ERROR":[],"INFO":[]'
                . ',"DATA":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $aList      = array();
        
        foreach ($result as $id => $arr) {
            array_push($aList, array(
                'id'        => $arr['id'],
                'title'     => $arr['title']
                ));
        }
        
        echo '<!-- {"ERROR":[],"INFO":[]'
            . ',"DATA":['. json_encode($aList) .']'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function listArticleByKeyword ($request)
    {
        $db         = hbm_db();
        
        require_once(APPDIR . 'class.general.custom.php');
        
        $catId      = isset($request['catId']) ? $request['catId'] : 0;
        $keyword    = isset($request['keyword']) ? trim($request['keyword']) : '';
        
        if (! $keyword) {
            echo '<!-- {"ERROR":[],"INFO":[]'
                . ',"DATA":['. json_encode(array()) .']'
                . ',"STACK":0} -->';
            exit;
        }
        
        $aCategory  = array($catId);
        
        $result     = self::_listCategory(array('parentId' => $catId));
        
        if (count($result)) {
            foreach ($result as $arr) {
                array_push($aCategory, $arr['id']);
            }
        }
        
        $keyword    = GeneralCustom::singleton()->removeCommonWords($keyword);
        
        $title      = GeneralCustom::singleton()->buildSearchTerm('', ' kb.title ', $keyword, 'OR');
        $description= GeneralCustom::singleton()->buildSearchTerm('', ' kb.description ', $keyword, 'OR');
        $tags       = GeneralCustom::singleton()->buildSearchTerm('', ' kb.tags ', $keyword, 'OR');
        
        $result     = $db->query("
                SELECT
                    kb.*
                FROM
                    hb_knowledgebase kb
                WHERE
                    kb.cat_id IN (". implode(',', $aCategory) .")
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
                    AND (
                        {$title}
                        OR {$description}
                        OR {$tags}
                    )
                ORDER BY
                    kb.last_sync_date DESC
                ")->fetchAll();
        
        
        if (! count($result)) {
            echo '<!-- {"ERROR":[],"INFO":[]'
                . ',"DATA":['. json_encode(array()) .']'
                . ',"STACK":0} -->';
            exit;
        }
        
        $aList      = array();
        
        foreach ($result as $arr) {
            array_push($aList, array(
                'id'        => $arr['id'],
                'title'     => $arr['title']
                ));
        }
        
        echo '<!-- {"ERROR":[],"INFO":[]'
            . ',"DATA":['. json_encode($aList) .']'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function _searchArticle ($result)
    {
        
        require_once(APPDIR . 'class.general.custom.php');
        
        $db         = hbm_db();
    
        $query      = isset($result['query']) ? trim($result['query']) : '';
        $search     = '';
        if (preg_match('/^tag\:/', $query)) {
            $query  = substr($query, 4);
            $search = 'tag';
        }
        $term       = (isset($result['term']) && $result['term'] == 'AND') ? 'AND' : 'OR';
        
        $title      = GeneralCustom::singleton()->buildSearchTerm('', ' k.title ', $query, $term);
        $body       = GeneralCustom::singleton()->buildSearchTerm('', ' k.body ', $query, $term);
        $description= GeneralCustom::singleton()->buildSearchTerm('', ' k.description ', $query, $term);
        $tags       = GeneralCustom::singleton()->buildSearchTerm('', ' k.tags ', $query, $term);
        
        $result     = $db->query("
                SELECT
                    k.id, k.title, k.options AS accuracy,
                    k.description, k.tags
                FROM
                    hb_knowledgebase k
                WHERE
                    ". (($search == 'tag') ? "
                        {$tags}
                    " : "
                        ( {$title}
                            OR {$body}
                            OR {$description}
                            OR {$tags} )
                    ") ."
                    AND k.language_id = (
                            SELECT 
                                language_id 
                            FROM 
                                hb_knowledgebase b 
                            WHERE 
                                k.id = b.id  
                            ORDER BY 
                                b.language_id 
                            DESC LIMIT 1 
                        )
                LIMIT 50
                ")->fetchAll();
                
        $aResults   = array();
        
        if (count($result)) {
            foreach ($result as $v) {
                if (isset($v['tags']) && $v['tags']) {
                    $aTags          = explode(',', $v['tags']);
                    $v['tags']      = '<a href="#" class="search-tags">'
                                        . implode('</a>, <a href="#" class="search-tags">', $aTags) .'</a>';
                }
                array_push($aResults, $v);
            }
            
        }
        
        return $aResults;
    }

    public function indexing ($request)
    {
        $db         = hbm_db();
        
        require_once(APPDIR . 'modules/Site/supporthandle/user/class.supporthandle_controller.php');
        
        $catId      = isset($request['catId']) ? $request['catId'] : 0;
        
        $aCategory  = supporthandle_controller::_listKbSubCateogry(array('catId' => $catId));
        
        $aCatId     = array();
        $aList      = array();
        
        if (! count($aCategory)) {
            echo '<!-- {"ERROR":[],"INFO":[]'
                . ',"DATA":['. json_encode($aList) .']'
                . ',"STACK":0} -->';
            exit;
        }
        
        foreach ($aCategory as $arr) {
            array_push($aCatId, $arr['id']);
        }
        
        $aLists     = self::_listArticle(array('catId' => $aCatId));
        
        if (count($aLists)) {
            foreach ($aLists as $arr) {
                array_push($aList, array(
                    'id'        => $arr['id'],
                    'catId'     => $arr['cat_id'],
                    'title'     => $arr['title'],
                    'desc'      => $arr['description'],
                    'tags'      => strip_tags($arr['tags']),
                    'slug'      => $arr['slug']
                    ));
            }
        }
        
        
        echo '<!-- {"ERROR":[],"INFO":[]'
            . ',"DATA":['. json_encode($aList) .']'
            . ',"STACK":0} -->';
        exit;
    }

    public function view ($request)
    {
        $gFile          = isset($request['gFile']) ? $request['gFile'] : '';
        
        if (! $gFile) {
            exit;
        }
        
        $aContent           = file_get_contents('https://docs.google.com/document/d/'. $gFile 
                            .'/pub?embed?start=false&loop=false&delayms=3000');
        $aContent           = preg_replace('/<a\s/i', '<a target="_blank" ', $aContent);
        echo $aContent;
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