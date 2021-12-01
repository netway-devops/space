<?php

class informationhandle_controller extends HBController {
    
    public function getProductPrice($request) {
        $db     = hbm_db();
        
        $aReturn        = array();
        
        $callback       = isset($request['callback']) ? $request['callback'] : '';
        $productId      = isset($request['productId']) ? $request['productId'] : 0;
        
        $result         = $db->query("
                SELECT
                    c.*
                FROM
                    hb_common c
                WHERE
                    c.rel = 'Product'
                    AND c.paytype = 'Regular'
                    AND c.id = :productId
                ", array(
                    ':productId'    => $productId
                ))->fetch();
        
        if (isset($result['id'])) {
            $aReturn    = $result;
        }
        
        // JSONP callback
        if ($callback) {
            echo $callback .'('. json_encode($aReturn) .');';
            exit;
        }
        
        return array(true, $aReturn);
    }
}
