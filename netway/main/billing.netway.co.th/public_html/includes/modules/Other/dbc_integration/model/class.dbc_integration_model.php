<?php
require_once(APPDIR . 'libs/hbapiwrapper/hbApiWrapper.php');
class dbc_integration_model {
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
        $this->api = new ApiWrapper();
    }

    private function print_debug($value, $message=null)
    {
        echo "<pre>";
        if (!is_null($message)) {
            echo "$message\n";
        }
        print_r($value);
        echo "</pre>";
    }

    public function getUnitsOfMeasure($id=null)
    {
        $tablename = 'dbc_unitofmeasure';
        if ($id == null) {
            return $this->db->query("
                SELECT 
                    * 
                FROM 
                    `$tablename`
                ", array());
        } else {
            return $this->db->query("
                SELECT 
                    * 
                FROM 
                    `$tablename` 
                WHERE 
                    id = :id
                ;
            ", array(':id' => $id));
        }
    }

    public function getDimensionByName($name)
    {
            return $this->db->query("
                SELECT 
                    id, code, name
                FROM 
                    `dbc_dimension` 
                WHERE 
                    name = :name
                ;
            ", array(':name' => $name));
    }

    public function replaceUnitsOfMeasureByID($id, $aParams=array())
    {
        try {
            $tablename = 'dbc_unitofmeasure';
            $aOuerySet =  array(
                ':id' => $id,
                ':code' => isset($aParams['code']) ? $aParams['code'] : '',
                ':displayName' => isset($aParams['displayName']) ? $aParams['displayName'] : ''
            );

            $this->db->query("
                REPLACE INTO 
                    `$tablename` (`id`, `code`, `displayName`) 
                VALUES 
                    (:id, :code, :displayName)
                ;
            ", $aOuerySet);
            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    public function deleteUnitsOfMeasureByID($id)
    {
        try {
            $tablename = 'dbc_unitofmeasure';
            $this->db->query("
                DELETE FROM
                    `$tablename`
                WHERE 
                    id = :id
                ;
            ",
            array(
                'id' => $id
            ));
            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    public function updateDBCCategoryIdWithProductCategoryID($id, $dbcCategoryId) 
    {
        try {
            $this->db->query("
                UPDATE 
                    hb_categories
                SET
                    dbcCategoryId = :dbcCategoryId
                WHERE 
                    id = :id
                ;
            ",
            array(
                'id' => $id,
                'dbcCategoryId' => $dbcCategoryId
            ));
            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    public function getProductCategories($id=null)
    {
        $query = '';
        $aQuery = array();
        if ($id != null) {
            $query = 'AND hc.id = :id';
            $aQuery = array('id' => $id);
        }
        if ($id != null) {
            $query = 'WHERE id = :id';
            $aQuery = array('id' => $id);
        }

        return $this->db->query("
            SELECT 
                id, name, codeName, dbcCategoryId 
            FROM 
                hb_categories hc
            WHERE
                hc.codeName IS NOT NULL
                $query
            ORDER BY hc.id ASC
            ;
        ", $aQuery);

    }

    public function getWebhooks($id=null)
    {
        $query = '';
        $aQuery = array();
        if ($id != null) {
            $query = 'AND hw.id = :id';
            $aQuery = array(':id' => $id);
        }
        
        return $this->db->query("
            SELECT 
                id, name, method, url 
            FROM 
                dbc_webhooks hw
            WHERE
                hw.name IS NOT NULL
            $query
            ;
        ", $aQuery);
    }

    public function updateWebhooks($id, $url)
    {
        try {
            $tablename = 'dbc_webhooks';
            $this->db->query("
                UPDATE $tablename 
                SET 
                    url = :url
                WHERE
                    id = :id
                ;
            ", array(
                'id' => $id,
                'url' => $url
            ));
            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    public function getProducts($id=null)
    {
        $query = 'WHERE hp.category_id = hc.id AND hpt.id = hp.type AND hp.visible != -1 AND hc.visible != -1';
        $aQuery = array();
        if ($id != null) {
            $query .= ' AND hp.id = :id';
            $aQuery = array('id' => (int) $id);
        }

        return $this->db->query("
            SELECT 
                hp.id AS id, 
                hp.name AS name, 
                hp.visible AS visible,
                hp.category_id AS category_id, 
                hc.dbcCategoryId AS dbcCategoryId,
                hc.name AS catName,
                hc.codeName AS catCodeName,
                hp.baseUnitOfMeasureCode AS baseUnitOfMeasureCode, 
                hp.baseUnitOfMeasureId AS baseUnitOfMeasureId,
                hp.dbcItemId AS dbcItemId, 
                hp.dbcItemType AS dbcItemType,
                hp.stock AS stock,
                hp.qty AS qty,
                hp.codeName AS codeName,
                hpt.type AS type,
                hp.revenue_group AS revenue_group,
                hp.line_group_id AS line_group_id,
                hp.dimensionCodeBUId AS dimensionCodeBUId
            FROM 
                hb_products hp,
                hb_categories hc,
                hb_product_types hpt
                $query
            ORDER BY hp.id ASC
            ;
        ", $aQuery);
    }

    public function genFullProductCode($hbProductID)
    {
        $aProductQuery = $this->getProducts($hbProductID)->fetchAll();
        if (count($aProductQuery) > 0) {
            $aProductDetail = $aProductQuery[0];
            if (!empty(trim($aProductDetail['catCodeName'])) && !empty(trim($aProductDetail['codeName']))) {
                return sprintf('%s.%s.%s', strtoupper(trim($aProductDetail['catCodeName'])), $hbProductID, strtoupper(trim($aProductDetail['codeName'])));
            } else {
                return '';
            }
        } else {
            return '';
        }
    }

    public function updateDBCItemIdByProductId($hbProductId, $dbcItemId)
    {
        return $this->db->query("
            UPDATE 
                hb_products
            SET 
                dbcItemId = :dbcItemId
            WHERE
                id = :id
            ;
        ", array(
            'id' => $hbProductId,
            'dbcItemId' => $dbcItemId
        ));
    }

    public function updateDBCDimensionCodeBUIDByhbProductID($hbProductId, $dimensionCodeBUId)
    {
        return $this->db->query("
            UPDATE 
                hb_products
            SET 
                dimensionCodeBUId = :dimensionCodeBUId
            WHERE
                id = :id
            ;
        ", array(
            'id' => $hbProductId,
            'dimensionCodeBUId' => $dimensionCodeBUId
        ));
    }

    public function updateDBCItemIdWithProductId($hbProductId, $dbcItemId, $unitOfMeasureId, $unitOfMeasureCode)
    {
        return $this->db->query("
            UPDATE 
                hb_products
            SET 
                dbcItemId = :dbcItemId,
                baseUnitOfMeasureId = :baseUnitOfMeasureId,
                baseUnitOfMeasureCode = :baseUnitOfMeasureCode
            WHERE
                id = :id
            ;
        ", array(
            'id' => $hbProductId,
            'dbcItemId' => $dbcItemId,
            'baseUnitOfMeasureId' => $unitOfMeasureId,
            'baseUnitOfMeasureCode' => $unitOfMeasureCode
        ));
    }

    public function getCategoryCodeByName($codename)
    {
        try {
            return $this->db->query("
                SELECT
                    id, parent_id, name
                FROM 
                    hb_categories
                WHERE
                    codeName = :codeName
                ;
            ", array(
                ':codeName' => $codename
            ));
        } catch (Exception $e) {
            return $e;
        }
    }

    public function updateCategoryCodename($id, $codename) 
    {
        try {
            $this->db->query("
                UPDATE 
                    hb_categories
                SET 
                    codeName = :codeName
                WHERE
                    id = :id
                ;
            ", array(
                ':id' => $id,
                ':codeName' => $codename
            ));
            $this->syncCategoryToDBC($id);
            return true;
        } catch (Exception $e) {
            return $e;
        }
    }

    public function getCategoryDetail($categoryID)
    {
        return $this->db->query("
            SELECT
                id, parent_id, name, description, visible, codeName, dbcCategoryId 
            FROM
                hb_categories
            WHERE
                id = :id
            ;
        ", array('id' => $categoryID));
    }

    public function genDimensionCodeBU($hbProductId, $revenueGroup=null, $lineGroup=null)
    {
        try {
            $aProductDetail = $this->getProducts($hbProductId)->fetchAll();
            if (count($aProductDetail) <= 0) {
                if (!$this->isProduction) {
                    $aProductDetail = $this->getProducts($hbProductId, true)->fetchAll();
                }
                if (count($aProductDetail) <= 0) {
                    throw new Exception('Find not fount product ID ' . $hbProductId . '.');
                }
            }

            $aProductDetail = $aProductDetail[0];
            $aProductCategory = $this->getCategoryDetail($aProductDetail['category_id'])->fetchAll();
            if (count($aProductCategory) <= 0) {
                throw new Exception('Find not fount category ID ' . $aProductDetail['category_id'] . '.');
            }
            $aProductCategory = $aProductCategory[0];

            $degisProduct = str_pad($aProductDetail['id'], 5, '0', STR_PAD_LEFT);

            if ($aProductCategory['parent_id'] == 0) {
                $subCate =  0;
                $parentCate =  $aProductCategory['id'];
            } else {
                $subCate = $aProductCategory['id'];
                $parentCate =  $aProductCategory['parent_id'];
            }

            if (is_null($revenueGroup)) {
                $revenueGroup = $aProductDetail['revenue_group'];
            }

            if (is_null($lineGroup)) {
                $lineGroup = $aProductDetail['line_group_id'];
            }

            return sprintf('%s-%s-%s-%s-%s', 
                $revenueGroup, 
                str_pad($lineGroup, 2, '0', STR_PAD_LEFT), 
                str_pad($parentCate, 4, '0', STR_PAD_LEFT), 
                str_pad($subCate, 4, '0', STR_PAD_LEFT), 
                str_pad($aProductDetail['id'], 5, '0', STR_PAD_LEFT));
        } catch (Exception $e) {
            throw new Exception($e);
        }
    }

    public function updateProductCodename($prodictID, $codename)
    {
        return $this->db->query("
            UPDATE
                hb_products
            SET
                codeName = :codeName
            WHERE
                id = :id
            ;
        ", array(
            ':id' => $prodictID,
            ':codeName' => $codename
        ));
    }

    public function updateRevenueGroup($prodictID, $revenueGroup)
    {
        return $this->db->query("
            UPDATE
                hb_products
            SET
                revenue_group = :revenueGroup
            WHERE
                id = :id
            ;
        ", array(
            ':id' => $prodictID,
            ':revenueGroup' => $revenueGroup
        ));
    }

    public function updateLineGroupId($prodictID, $lineGroupId)
    {
        return $this->db->query("
            UPDATE
                hb_products
            SET
                line_group_id = :lineGroupId
            WHERE
                id = :id
            ;
        ", array(
            ':id' => $prodictID,
            ':lineGroupId' => $lineGroupId
        ));
    }

    public function updateItemType($prodictID, $itemType)
    {
        return $this->db->query("
            UPDATE
                hb_products
            SET
                dbcItemType = :itemType
            WHERE
                id = :id
            ;
        ", array(
            ':id' => $prodictID,
            ':itemType' => $itemType
        ));
    }

    public function getDBCCustomerIDByHBClientID($hbClientID) 
    {
        $dbcCustomerID = '';
        $aResponsebClientDetails = $this->api->getClientDetails(array('id' => $hbClientID));
        if (isset($aResponsebClientDetails['client']['dbccustomerguid'])) {
            $dbcCustomerID = trim($aResponsebClientDetails['client']['dbccustomerguid']);
        }
        return  $dbcCustomerID;
    }

    public function getDBCItemIDByHBProductID($hbProductID)
    {
        $dbcItemID = '';
        $aQueryProduct = $this->getProducts($hbProductID)->fetchAll();
        if (count($aQueryProduct) > 0) {
            $dbcItemID = isset($aQueryProduct[0]['dbcItemId']) ? $aQueryProduct[0]['dbcItemId'] : '';
        }
        return $dbcItemID;
    }

    private function getClientbyInvoiceID($hbInvoiceId)
    {
        $aOuery = $this->db->query("
            SELECT 
                id, client_id, invoice_number, duedate 
            FROM 
                hb_invoices
            WHERE
                id = :id
            ;
        ", array(
            'id' => $hbInvoiceId
        ))->fetchAll();
        return isset($aOuery[0]) ? $aOuery[0]: array();
    }


    public function getSalesOrderDetailByInvoiceId($hbInvoiceId)
    {
        try {
            $api = new ApiWrapper();
            $aResponseInvoiceDetails = $api->getInvoiceDetails(array('id' => $hbInvoiceId));
            $aResult = array();

            if (!isset($aResponseInvoiceDetails['success']) || $aResponseInvoiceDetails['success'] != true ) {
                throw new Exception('Find not fount invoice ID ' . $hbInvoiceId . '.');
            } else {
                $aInvoiceDetails = $aResponseInvoiceDetails['invoice'];
                $aTransactions = $aResponseInvoiceDetails['transactions'];

                $dbcCustomerID = $this->getDBCCustomerIDByHBClientID($aInvoiceDetails['client_id']);
                if (empty($dbcCustomerID)) {
                    throw new Exception('DBC Customer ID for Hostbill client ID: ' . $aInvoiceDetails['client_id'] . ' is empty. (invoice id: '. $hbInvoiceId . ')');
                }

                if (empty($aInvoiceDetails['invoice_number'])) {
                    throw new Exception('Invoice number is empty. (invoice id: '. $hbInvoiceId . ')');
                }

                $aResult['SalesOrder'] = array(
                    'invoice_id' => $hbInvoiceId,
                    'salesorderNumber' => $aInvoiceDetails['invoice_number'],
                    'orderDate' => $aInvoiceDetails['duedate'],
                    'customerId' => $dbcCustomerID,
                    'items' => array(
                    )
                );

                foreach ($aInvoiceDetails['items'] as $item) {
                    $hbItemID =  $item['item_id'];
                    $hbItemDescription = $item['description'];

                    $hbContractDescription = '';

                    $aSplitItemDescription = preg_split('/-/', $hbItemDescription, 3);
                    
                    if (preg_match_all('/\([^\)]+\)/i', $hbItemDescription, $aMatch)) {
                        $hbContractDescription = $aMatch[0][count($aMatch[0]) - 1];
                    }
                    
                    $aSplitWithContract = array();
                    if ($hbContractDescription != '') {
                        $aSplitWithContract = preg_split('/' . preg_quote($hbContractDescription, '/') . '/i', $hbItemDescription);
                    }

                    $aItemLine = array();

                    $hbItemDetail = array();
                    if (preg_match('/^Domain/', $item['type'])) {
                        $aResponseDomainDetails = $this->api->getDomainDetails(array('id' => $hbItemID));
                        $hbDomainDetails = $aResponseDomainDetails['details'];

                        $hbItemDetail = array(
                            'product_id' => $hbDomainDetails['tld_id'],
                            'domain' => $hbDomainDetails['name'],
                            'expires' => $hbDomainDetails['expires'],
                            'next_due' => $hbDomainDetails['next_due'],
                            'type'  => $hbDomainDetails['type'],
                        );
                    } else {
                        $aResponseAccountDetails = $this->api->getAccountDetails(array('id' => $hbItemID));
                        $aAccountDetails = $aResponseAccountDetails['details'];

                        $aResponseOrderDetails = $this->api->getOrderDetails(array('id' => $aAccountDetails['order_id']));
                        $aOrderDetails = $aResponseOrderDetails['details'];

                        $hbItemDetail = array(
                            'product_id' => $aAccountDetails['product_id'],
                            'domain' => $aAccountDetails['domain'],
                            'expires' => $aAccountDetails['expiry_date'],
                            'next_due' => $aAccountDetails['next_due'],
                            'type'  => (trim($item['invoice_id']) != $aOrderDetails['invoice_id']) ? 'Renew' : 'New',
                        );
                    }
                    
                    $hbProductDetail = array();
                    $aQueryProduct = $this->getProducts($hbItemDetail['product_id'])->fetchAll();
                    if (count( $aQueryProduct ) <= 0) {
                        throw new Exception('Find not found Hostbill product ID: ' . $aResponseAccountDetails['details']['product_id'] . '.');
                    } else {
                        $hbProductDetail = $aQueryProduct[0];
                    }

                    if (!empty(trim($aSplitItemDescription[0])) && !empty(trim($aSplitItemDescription[1]))) {
                        $itemDescription = sprintf("%s - %s", trim($aSplitItemDescription[0]), str_replace('Addon : ', '', trim($aSplitItemDescription[1])));
                    } else if (empty(trim($aSplitItemDescription[0])) && !empty(trim($aSplitItemDescription[1]))) {
                        $itemDescription = sprintf("%s", str_replace('Addon : ', '', trim($aSplitItemDescription[1])));
                    } else {
                        $itemDescription = sprintf("%s - %s", $hbProductDetail['catName'], $hbProductDetail['name']);
                    }

                    $dbcItemID = $this->getDBCItemIDByHBProductID($aResponseAccountDetails['details']['product_id']);

                    if (empty($hbProductDetail['dbcItemId'])) {
                        continue;
                    }

                    $discount = 0;
                    $subAmount = ($item['unit_price'] * intval($item['quantity']));
                    if ($item['discount_price'] > 0 && ($subAmount >= $item['discount_price'])) {
                        $discount = $item['discount_price'];
                    }

                    $aItemLine = array(
                        'lineType' => 'Item',
                        'description' => $itemDescription,
                        'itemId' => $dbcItemID,
                        'quantity' => intval($item['quantity']),
                        'unitPrice' => $item['unit_price'],
                        'discountAmount' => strval($discount),
                        'amount' => $item['amount'],
                        'amountExcludingTax' => $item['linetotal'],
                        'type'  => strtoupper($hbItemDetail['type']),
                        'comments' => array()
                    );

                    array_push($aItemLine['comments'], array(
                        'description' => ': ' .  $hbItemDetail['domain'],
                    ));

                    if (!empty($hbContractDescription)) {
                        $_buffer = preg_replace('/\(|\)/', '', $hbContractDescription);
                        $aSplitContractDescription = preg_split('/\-/', $_buffer);
                        $strContractDate = '';
                        $strExpDate = '';
                        try {
                            $aSplitcontractDate = preg_split('/\//', trim($aSplitContractDescription[0]));
                            if (count($aSplitcontractDate) == 3) {
                                $contractDate = new DateTime(sprintf("%s/%s/%s", intval($aSplitcontractDate[2]), intval($aSplitcontractDate[1]), intval($aSplitcontractDate[0])));
                            } else {
                                $contractDate = new DateTime(trim($aSplitContractDescription[0]));
                            }
                            $strContractDate = $contractDate->format('d M Y');
                        } catch (Exception $ex) {
                            $strContractDate = $ex->getMessage(). ' ' . $aSplitContractDescription[0];
                        }

                        try {
                            $aSplitExpDate = preg_split('/\//', trim($aSplitContractDescription[1]));

                            if (count($aSplitExpDate) == 3) {
                                $expDate = new DateTime(sprintf("%s/%s/%s", $aSplitExpDate[2], $aSplitExpDate[1], $aSplitExpDate[0]));
                            } else {
                                $expDate = new DateTime(trim($aSplitContractDescription[1]));
                            }
                            $strExpDate = $expDate->format('d M Y');
                        } catch (Exception $ex) {
                            $strExpDate = $ex->getMessage(). ' (' . $aSplitContractDescription[1];
                        }

                        array_push($aItemLine['comments'], array(
                            'description' =>  sprintf('(%s - %s)', $strContractDate, $strExpDate),
                        ));
                    }


                    if (isset($aSplitWithContract[1]) && !empty(trim($aSplitWithContract[1]))) {
                        $aSplit = preg_split("/\n/", trim($aSplitWithContract[1]));
                        $inLine = '';
                        
                        foreach ($aSplit as $line) {
                            $line = trim($line);
                            if ($inLine == '' && strlen($line) > 100) {
                                array_push($aItemLine['comments'], array(
                                    'description' =>  substr($line, 0, 97) . '...'
                                ));
                            } else {
                                $countStr =  strlen($line) + strlen($inLine);
                                if ($countStr >= 100) {
                                    array_push($aItemLine['comments'], array(
                                        'description' =>  $inLine
                                    ));
                                    $inLine = $line;
                                } else {
                                    $inLine .= $inLine == '' ? $line : "\n" . $line; 
                                }
                            }
                        }
                        if ($inLine != '') {
                            array_push($aItemLine['comments'], array(
                                'description' =>  $inLine
                            ));
                        }
                    }

                    array_push( $aResult['SalesOrder']['items'], $aItemLine);
                }
            }
            return $aResult;
        } catch (Exception $ex) {
            return array(
                'isError' => true,
                'message' => $ex->getMessage()
            );
        }
    }

    public function genSalesOrderNumber()
    {
        $year = date("y");
        $count = 1;
        return sprintf("SOD%s%s", $year, str_pad($count, 5, '0', STR_PAD_LEFT));
    }

    public function updateSalesOrderLogs($event, $hbInvoiceId, $dbcSOId=null, $dbcSONumber=null)
    {
        if ($event == 'create') {
            $this->db->query("
                INSERT INTO `dbc_salesorder` (`invoice_id`, `status`) 
                VALUES 
                    (:invoice_id, 'pending')
                ;
            ", array(
                'invoice_id' => $hbInvoiceId
            ));
        } else if ($event == 'update') {
            $setQuery = 'update_at = update_at';
            if (!is_null($dbcSONumber)) {
                $setQuery .= ', dbc_salesorder_number = :dbc_salesorder_number';
            }
            if (!is_null($dbcSOId)) {
                $setQuery = ', dbc_salesorder_id = :dbc_salesorder_id';
            }
            $this->db->query("
                UPDATE 
                    `dbc_salesorder`
                SET 
                   $setQuery
                WHERE
                    invoice_id = :invoice_id
            ", array(
                'invoice_id' => $hbInvoiceId,
                'update_at' => time(),
                'dbc_salesorder_id' => $dbcSOId,
                '$dbc_salesorder_number' => $dbcSONumber
            ));
            
        }
    }
}