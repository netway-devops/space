<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class dbcproducthandle_model {

    private static  $instance;
    private $db;
     
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }
    
    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }
    
    private function __construct () 
    {
        $this->db       = hbm_db();
        
    }
    
    public function getAllCategory ()
    {
        $result     = $this->db->query("
            SELECT c.*
            FROM hb_categories c
            ORDER BY c.sort_order ASC
            ")->fetchAll();
        
        return $result;
    }
    
    public function getAllProduct ()
    {
        $result     = $this->db->query("
            SELECT p.*
            FROM hb_products p
            ORDER BY p.sort_order ASC
            ")->fetchAll();
        
        return $result;
    }
    
    public function getAllDBCProduct ()
    {
        $result     = $this->db->query("
            SELECT p.*, pu.code
            FROM dbc_product p
                LEFT JOIN dbc_product_unit pu
                ON pu.dbc_item_id = p.dbc_item_id
                AND pu.is_active = 1
            WHERE p.is_active = 1
            ")->fetchAll();
        
        return $result;
    }
    
    public function getAllDBCProductUnit ()
    {
        $result     = $this->db->query("
            SELECT pu.*
            FROM dbc_product_unit pu
            WHERE pu.is_active = 1
            ")->fetchAll();
        
        return $result;
    }
    
    public function getAllProductPrice ()
    {
        $result     = $this->db->query("
            SELECT *
            FROM hb_common
            WHERE 1
            ")->fetchAll();
        
        return $result;
    }
    
    public function getAllDomainPrice ()
    {
        $result     = $this->db->query("
            SELECT *
            FROM hb_domain_periods
            WHERE 1
            ")->fetchAll();
        
        return $result;
    }
    
    
    public function getDbcProductByProductId ($productId)
    {
        $result     = $this->db->query("
            SELECT p.*
            FROM dbc_product p
            WHERE product_id = '{$productId}'
            ")->fetch();
        
        return $result;
    }
    
    public function setDbcProductActiveAll ($isActive)
    {
        $this->db->query("
            UPDATE dbc_product
            SET is_active = '{$isActive}'
            WHERE 1
            ");
    }
    
    public function addUpdate ($data)
    {
        $productId  = isset($data['productId']) ? $data['productId'] : 0;
        $dbcNo      = isset($data['dbcNo']) ? $data['dbcNo'] : '';
        if (! $productId) {
            return false;
        }
        
        $result     = $this->getDbcProductByProductId($productId);
        
        if (isset($result['id'])) {
            $this->db->query("
                UPDATE dbc_product
                SET dbc_no = '{$dbcNo}',
                    is_active = 1
                WHERE product_id = '{$productId}'
                ");
            
        } else {
            $this->db->query("
                INSERT INTO dbc_product (
                dbc_no, product_id, is_active
                ) VALUES (
                '{$dbcNo}', '{$productId}', 1
                )
                ");
            
        }
        
        return true;
    }
    
    public function updateItem ($data)
    {
        if (! count($data) || !isset($data[0]['id'])) {
            return false;
        }
        
        $this->db->query("
            UPDATE dbc_product_unit
            SET is_active = 0
            WHERE 1
            ");
        
        foreach ($data as $arr) {
            $number     = $arr['number'];
            if (! $number) {
                continue;
            }
            
            $itemId     = $arr['id'];
            $itemName   = $arr['displayName'];
            $unitPrice  = $arr['unitPrice'];
            $categoryCode   = $arr['itemCategoryCode'];
            
            $this->db->query("
                UPDATE dbc_product
                SET dbc_item_id =  :dbc_item_id,
                    dbc_description = :dbc_description,
                    dbc_unit_price = :unit_price,
                    dbc_item_category_code = :dbc_item_category_code
                WHERE dbc_no = :dbc_no
                ", array(
                    ':dbc_item_id'      => $itemId,
                    ':dbc_description'  => $itemName,
                    ':dbc_no'           => $number,
                    ':unit_price'       => $unitPrice,
                    ':dbc_item_category_code'   => $categoryCode,
                ));
            
            if (isset($arr['baseUnitOfMeasure']['code'])) {
                
                $code       = $arr['baseUnitOfMeasure']['code'];
                $name       = $arr['baseUnitOfMeasure']['displayName'];
                
                $result     = $this->db->query("
                    SELECT *
                    FROM dbc_product_unit
                    WHERE code = '{$code}'
                        AND dbc_item_id = '{$itemId}'
                    ")->fetch();
                
                if (isset($result['id'])) {
                    $this->db->query("
                        UPDATE dbc_product_unit
                        SET name = '{$name}',
                            is_active = 1
                        WHERE id = '". $result['id'] ."'
                        ");
                    
                } else {
                    $this->db->query("
                        INSERT INTO dbc_product_unit (
                        dbc_item_id, code, name, is_active
                        ) VALUES (
                        '{$itemId}', '{$code}', '{$name}', 1
                        )
                        ");
                    
                }
                
            }
            
        }
        
        return true;
    }
    
}
