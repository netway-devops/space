<?php

class zendeskintegratehandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    public function call_EveryRun()
    {
        $message    = '';
        
        self::_user();
        self::_organization();
        self::_setorgclientid();
        self::_getTicketComment();
        
        return $message;
    }
    
    public function call_Hourly()  
    {
        $db     = hbm_db();
        
        self::_updateHelpCenterArticlePrivate();
        //self::_updateHelpCenterArticleContentLink();
        
    }
    
    private function _updateHelpCenterArticlePrivate ()
    {
        

        require_once(APPDIR . 'class.config.custom.php');
        $page           = ConfigCustom::singleton()->getValue('nwZendeskHelpCenterArticlePrivatePrefix');
        $page++;
        
        $aParam     = array(
            'url'       => '/help_center/th/articles.json?sort_by=created_at&sort_order=asc&page='. $page,
            'method'    => 'get',
            'data'      => array(
            )
        );
        $result     = self::_send($aParam);
        
        if (! isset($result['articles']) || ! count($result['articles'])) {
            return true;
        }
        
        if ($result['page_count'] == $page) {
            $page       = 0;
        }
        
        $aArticles      = $result['articles'];
        
        foreach ($aArticles as $aArticle) {
            $articleId  = $aArticle['id'];
            $title      = $aArticle['title'];
            $sectionId  = $aArticle['section_id'];
            
            $aParam     = array(
                'url'       => '/help_center/sections/'. $sectionId .'/access_policy.json',
                'method'    => 'get',
                'data'      => array(
                )
            );
            $result     = self::_send($aParam);
            
            if (isset($result['access_policy']['viewable_by']) && $result['access_policy']['viewable_by'] == 'staff') {
                if (! preg_match('/^\⚠/', $title)) {
                    $title  = '⚠ '. $title;
                }
            } else {
                $title      = preg_replace('/^\⚠\ ?/', '', $title);
            }
            
            
            $aParam     = array(
                'url'       => '/help_center/articles/'. $articleId .'/translations/th.json',
                'method'    => 'put',
                'data'      => array(
                    'translation'   => array(
                        'title'     => $title
                    )
                )
            );
            $result     = self::_send($aParam);
            
        }
        
        ConfigCustom::singleton()->setValue('nwZendeskHelpCenterArticlePrivatePrefix', $page);
        
        
        return true;
    }
    
    private function _updateHelpCenterArticleContentLink ()
    {
        
        require_once(APPDIR . 'class.config.custom.php');
        $page           = ConfigCustom::singleton()->getValue('nwZendeskHelpCenterArticleContentLink');
        $page++;
        
        $aParam     = array(
            'url'       => '/help_center/th/articles.json?sort_by=created_at&sort_order=asc&page='. $page,
            'method'    => 'get',
            'data'      => array(
            )
        );
        $result     = self::_send($aParam);
        
        if (! isset($result['articles']) || ! count($result['articles'])) {
            return true;
        }
        
        if ($result['page_count'] == $page) {
            $page       = 0;
        }
        
        $aArticles      = $result['articles'];
        $log            = '';
        
        foreach ($aArticles as $aArticle) {
            $articleId  = $aArticle['id'];
            $url        = $aArticle['url'];
            $body       = $aArticle['body'];
            
            // preg_match_all('/https\:\/\/www\.google\.com\/url\?q=(((?!sa=).)+)/i', $body, $match);
            preg_match_all('/"https\:\/\/www\.google\.com\/url\?q=([^"]+)/i', $body, $match);
            
            if (! count($match[1])) {
                continue;
            }
            
            $log    .= "\n". $url;
            foreach ($match[1] as $k => $v) {
                $v      = preg_replace('/&amp;sa=.*/i', '', $v);
                $body   = str_replace($match[0][$k] .'"', '"'. $v .'"', $body);
                $log    .= "\n". $match[0][$k] .'"';
                $log    .= "\n". '"'. $v .'"';
            }
            
            $aParam     = array(
                'url'       => '/help_center/articles/'. $articleId .'/translations/th.json',
                'method'    => 'put',
                'data'      => array(
                    'translation'   => array(
                        'body'      => $body
                    )
                )
            );
            $result     = self::_send($aParam);
            
        }
        
        ConfigCustom::singleton()->setValue('nwZendeskHelpCenterArticleContentLink', $page);
        
        echo $log;
        
        return true;
    }
    
    private function _user ()
    {/*
        require_once(APPDIR . 'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        
        $aRequert   = array(
            'isReturn'  => 1
        );
        $result     = zendeskintegratehandle_controller::singleton()->user($aRequert);
        
    */}
    
    private function _organization ()
    {/*
        require_once(APPDIR . 'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        
        $aRequert   = array(
            'isReturn'  => 1
        );
        $result     = zendeskintegratehandle_controller::singleton()->organization($aRequert);
        
    */}
    
    private function _setorgclientid ()
    {/*
        require_once(APPDIR . 'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');
        
        $aRequert   = array(
            'isReturn'  => 1
        );
        $result     = zendeskintegratehandle_controller::singleton()->setorgclientid($aRequert);
        
    */}
    
    private function _getTicketComment ()
    {
        $db         = hbm_db();
        
        require_once(APPDIR . 'class.config.custom.php');
        $ticketId   = ConfigCustom::singleton()->getValue('nwZendeskTicketComment');
        $ticketId++;
        ConfigCustom::singleton()->setValue('nwZendeskTicketComment', $ticketId);
        
        $request    = array(
            'url'       => '/tickets/'. $ticketId .'.json',
            'method'    => 'get',
            'data'      => array()
        );
        $result     = self::_send($request);
        $ticketId   = isset($result['ticket']['id']) ? $result['ticket']['id'] : 0;
        if (! $ticketId) {
            return false;
        }
        $aTicket    = $result['ticket'];
        $subject    = $aTicket['subject'];
        
        $request    = array(
            'url'       => '/tickets/'. $ticketId .'/comments.json',
            'method'    => 'get',
            'data'      => array()
        );
        $result     = self::_send($request);
        $aComment   = count($result['comments']) ? $result['comments'] : array();
        
        $aAuthor    = array();
        if (count($aComment)) {
            foreach ($aComment as $arr) {
                
                $isPublic   = $arr['public'];
                $authorId   = $arr['author_id'];
                $comment    = $arr['plain_body'];
                
                if (! in_array($authorId, $aAuthor)) {
                    $request    = array(
                        'url'       => '/users/'. $authorId .'.json',
                        'method'    => 'get',
                        'data'      => array()
                    );
                    $result     = self::_send($request);
                    $role       = isset($result['user']['role']) ? $result['user']['role'] : '';
                    
                    $aAuthor[$authorId] = $role;
                }
                $agentReply     = '';
                $userReply      = '';
                $agentComment   = '';
                if ($isPublic) {
                    if (! $aAuthor[$authorId] || $aAuthor[$authorId] == 'end-user') {
                        $userReply  = $comment;
                    } else {
                        $agentReply = $comment;
                    }
                } else {
                    $agentComment   = $comment;
                }
                
                $db->query("
                    INSERT INTO zendesk_ticket_comment (
                    id, ticket_id, subject, agent_reply, user_reply, agent_comment
                    ) VALUES (
                    '', :ticketId, :subject, :agentReply, :userReply, :agentComment
                    )
                    ", array(
                        ':ticketId'     => $ticketId,
                        ':subject'      => $subject,
                        ':agentReply'   => $agentReply,
                        ':userReply'    => $userReply,
                        ':agentComment' => $agentComment,
                    ));
                
                
            }
        }
        
        return true;
        
    }
    
    private function _send ($request)
    {
        $url        = $request['url'];
        $method     = isset($request['method']) ? $request['method'] : 'get';
        $data       = isset($request['data']) ? json_encode($request['data']) : array();
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, 'https://pdi-netway.zendesk.com/api/v2/'. $url);
        if ($method == 'post') {
            curl_setopt($ch, CURLOPT_POST, 1);
        }
        if ($method == 'put') {
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
        }
        if ($method != 'get') {
            curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        }
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_USERPWD, 'prasit@netway.co.th/token:mbPrx5uPCbCjez9QZ0oBSy4WBmYrm4wly382yJw1');
        curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
        $data   = curl_exec($ch);
        curl_close($ch);
        $result = json_decode($data, true);
        
        return $result;
    }

}
