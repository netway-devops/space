<?php

class zendeskintegratehandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;


    /**
     * 
     * @return string
     */
    public function call_Hourly ()
    {
        self::listFeature();
        
        return $message;
    }
    
    private function listFeature()
    {
        $db              = hbm_db();  
        
        $result     = $db->query("
                         SELECT MAX(post_id) AS maxId
                         FROM hb_feature_request
                      ")->fetch();
        $maxPortId  = $result['maxId'] + 0;
        
        $request    = array(
            'url'       => 'community/posts.json',
            'method'    => 'get',
            'data'      => array()
        );
        
        $result     = self::_send($request);
                
        $aPosts     = $result['posts'];
        foreach($aPosts as $aFeature){
              if($aFeature['topic_id'] == '360000661673' ){//id topic feedback
                continue;
            }
               
               $postId        = isset($aFeature['id']) ? $aFeature['id']:'';      
               $authorId      = isset($aFeature['author_id']) ? $aFeature['author_id']:0;      
               $title         = isset($aFeature['title']) ? 'Feature Request '.$aFeature['title']:'';
               $description   = isset($aFeature['details']) ? strip_tags($aFeature['details']):'';
               $created_at    = isset($aFeature['created_at']) ? $aFeature['created_at']:'';
               $updated_at    = isset($aFeature['updated_at']) ? $aFeature['updated_at']:'';
             
                if ($postId <= $maxPortId ) {
                    continue;
                }
                
                   $aParam     = array(
                      'ticket'    => array(
                          'requester_id'  => $authorId,
                          'submitter_id'  => $authorId,
                          'subject'       => $title,
                          'tags'          => array('skip_sla'),
                          'created_at'    => $created_at,
                          'updated_at'    => $updated_at,
                          'comment'       => array(
                            'body'        => $description,
                              'public'    => false
                            )       
                           )
                      );  
                                        
                      $request    = array(
                            'url'       => 'tickets.json',
                            'method'    => 'post',
                            'data'      => $aParam
                      );
                      $result     = self::_send($request);
                    echo '<pre>'. print_r($result, true) .'</pre>';     
                 
                    $result     = isset($result['ticket']) ? $result['ticket'] : array();
                    $ticketId   = isset($result['id']) ? $result['id'] : 0;
                    
                     $db->query("
                        INSERT INTO hb_feature_request ( 
                            id, create_date, author_id,
                            post_id, ticket_id 
                            )   VALUES (
                               null,  :create_date, :author_id,
                               :post_id,  :ticket_id
                             )
                            ", array(
                                ':create_date'           => $aFeature['created_at'],
                                ':author_id'             => $aFeature['author_id'],
                                ':post_id'               => $postId,
                                ':ticket_id'             => $ticketId
                            ));
                          echo $postId;

        }
    }

    private function _send ($request)
    {
        $url        = $request['url'];
        $method     = isset($request['method']) ? $request['method'] : 'get';
        $data       = isset($request['data']) ? json_encode($request['data']) : array();
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, 'https://rvglobalsoft.zendesk.com/api/v2/'. $url);
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
        curl_setopt($ch, CURLOPT_USERPWD, 'prasit+rv@netway.co.th/token:rzkJaKdbWg2cptxaVZjsezCiIY8mxgrpG89kobAg');
        curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
        $data   = curl_exec($ch);
        curl_close($ch);
        $result = json_decode($data, true);
        
        return $result;
    }
    
    
  } 