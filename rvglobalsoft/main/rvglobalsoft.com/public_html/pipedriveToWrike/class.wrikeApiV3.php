<?php

    require_once('Client.php');
    require('GrantType/IGrantType.php');
    require('GrantType/AuthorizationCode.php');
    require('GrantType/RefreshToken.php');

    class wrikeV3 {
           
           public $CLIENT_ID     = '9jPQjjyF';
           public $CLIENT_SECRET = 'kHbqabP89g1QcGsIn7OYHyY4BHfbQZ16JAtIrqUGhsD4Tlm9piWSM8OxZtdm2v6c';
           /***************************** Panya *********************************/
           //public $REFRESH_TOKEN = 'Pu1fUN1MXsYGqaFbGEpKyWuYkahh7SkMVOH6z5LyjjSedAN7yC7Iyq4xJbfDoXkD-A-N';
           /*********************************************************************/
           /***************************** Pairote *********************************/
           public $REFRESH_TOKEN = 'XwLxFuChZ6pFXIbhHk0fzEfY26SlIkA3ygUpsBkYmUK6ujgM4TV8X1dqmxqAAxVI-A-N';
           /*********************************************************************/
            
           //public $REDIRECT_URI           = 'http://localhost/OAuth2/wrike.apiV3.php';
           public $AUTHORIZATION_ENDPOINT = 'https://www.wrike.com/oauth2/authorize';
           public $TOKEN_ENDPOINT         = 'https://www.wrike.com/oauth2/token';
            
    
           public function getTask($taskID){
                
                $client = new OAuth2\Client($this->CLIENT_ID, $this->CLIENT_SECRET);
                
                $params = array(
                        'client_id'     =>  $this->CLIENT_ID,
                        'client_secret' =>  $this->CLIENT_SECRET,
                        'grant_type'    =>  'refresh_token',
                        'refresh_token' =>  $this->REFRESH_TOKEN
                        );
                             
                $response = $client->getAccessToken($this->TOKEN_ENDPOINT, 'refresh_token', $params);
                $client->setAccessTokenType(1);
                //echo '<pre>'. print_r($response,TRUE) .'</pre>';
                
                $client->setAccessToken($response['result']['access_token']);
                
                $response = $client->fetch('https://www.wrike.com/api/v3/tasks/' . $taskID
                                            ,array()
                                            , 'GET'
                                           );
                //echo '<pre>'. print_r($response['result']['data'],TRUE) .'</pre>';
                return $response;
                
            }

            public function addTask($title,$desc,$status,$parent){
                
                $client = new OAuth2\Client($this->CLIENT_ID, $this->CLIENT_SECRET);
                
                $params = array(
                        'client_id'     =>  $this->CLIENT_ID,
                        'client_secret' =>  $this->CLIENT_SECRET,
                        'grant_type'    =>  'refresh_token',
                        'refresh_token' =>  $this->REFRESH_TOKEN
                        );
                             
                $response = $client->getAccessToken($this->TOKEN_ENDPOINT, 'refresh_token', $params);
                
                $client->setAccessToken($response['result']['access_token']);
                $client->setAccessTokenType(1);
                
                $response = $client->fetch('https://www.wrike.com/api/v3/folders/' . $parent . '/tasks'
                                            , array(
                                                'description'    =>  $desc ,
                                                'title'          =>  $title ,
                                                'status'         =>  $status
                                                )
                                            , 'POST'
                                            );
                                            
                return $response;
                
            }

            public function updateTask($taskID,$title,$desc,$status){
                
                $client = new OAuth2\Client($this->CLIENT_ID, $this->CLIENT_SECRET);
                
                $params = array(
                        'client_id'     =>  $this->CLIENT_ID,
                        'client_secret' =>  $this->CLIENT_SECRET,
                        'grant_type'    =>  'refresh_token',
                        'refresh_token' =>  $this->REFRESH_TOKEN
                        );
                             
                $response = $client->getAccessToken($this->TOKEN_ENDPOINT, 'refresh_token', $params);
              //echo '<pre>'. print_r($response,TRUE) .'</pre>';
                $client->setAccessToken($response['result']['access_token']);
                $client->setAccessTokenType(1);
                
                $response = $client->fetch('https://www.wrike.com/api/v3/tasks/' . $taskID
                                            , array(
                                                'description'    =>  $desc ,
                                                'title'          =>  $title ,
                                                'status'         =>  $status
                                                )
                                            , 'PUT'
                                            );
                                            
                return $response;
               
            }
            

            public function deleteTask($taskID){
                
                $client = new OAuth2\Client($this->CLIENT_ID, $this->CLIENT_SECRET);
                
                $params = array(
                        'client_id'     =>  $this->CLIENT_ID,
                        'client_secret' =>  $this->CLIENT_SECRET,
                        'grant_type'    =>  'refresh_token',
                        'refresh_token' =>  $this->REFRESH_TOKEN
                        );
                             
                $response = $client->getAccessToken($this->TOKEN_ENDPOINT, 'refresh_token', $params);
                
                $client->setAccessToken($response['result']['access_token']);
                $client->setAccessTokenType(1);
                
                $response = $client->fetch('https://www.wrike.com/api/v3/tasks/' . $taskID
                                            , array()
                                            , 'DELETE'
                                            );
                                            
                return $response;
                
            }
            

            public function addComment($taskID,$text){
                
                $client = new OAuth2\Client($this->CLIENT_ID, $this->CLIENT_SECRET);
                
                $params = array(
                        'client_id'     =>  $this->CLIENT_ID,
                        'client_secret' =>  $this->CLIENT_SECRET,
                        'grant_type'    =>  'refresh_token',
                        'refresh_token' =>  $this->REFRESH_TOKEN
                        );
                             
                $response = $client->getAccessToken($this->TOKEN_ENDPOINT, 'refresh_token', $params);
                
                $client->setAccessToken($response['result']['access_token']);
                $client->setAccessTokenType(1);
                
                $response = $client->fetch('https://www.wrike.com/api/v3/tasks/' . $taskID . '/comments'
                                            , array(
                                                'plainText'    =>  'true' ,
                                                'text'          =>  $text
                                                )
                                            , 'POST'
                                            );
                                            
                return $response;
                
            }
    
    }  

?>