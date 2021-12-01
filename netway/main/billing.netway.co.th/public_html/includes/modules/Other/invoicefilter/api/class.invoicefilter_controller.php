<?php

class invoicefilter_controller extends HBController {
    
    public function unpaidOverdueDomain ($request)
    {
        
        $db         = hbm_db();
        
        $limit          = isset($request['limit']) ? $request['limit'] : 25;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        $total          = 0;
        
        $currentDate    = date('Y-m-d');
        
        $sqlSelect  = " COUNT(DISTINCT(i.id)) AS total ";
        $sqlFormat  = "
                    SELECT
                        %s
                    FROM
                        hb_domains d,
                        hb_orders o,
                        hb_invoices i,
                        hb_invoice_items ii
                    WHERE
                        d.type = 'Renew'
                        AND o.id = d.order_id
                        AND i.id = o.invoice_id
                        AND i.duedate < :currentDate
                        AND ii.invoice_id = i.id
                        AND ii.item_id = d.id
                        AND ii.type = 'Domain Renew'
                        AND i.status = 'Unpaid'
                    %s
                    ";
        $sql        = sprintf($sqlFormat,$sqlSelect, '');
        $result     = $db->query($sql, array(
                        ':currentDate'  => $currentDate
                    ))->fetch();
        
        if (isset($result['total']) && $result['total']) {
            $total  = $result['total'];
        }
        
        $aInvoices  = array();
        
        $sqlSelect  = "i.*";
        $sqlLimit   = " ORDER BY i.date DESC LIMIT {$offset}, {$limit} ";
        $sql        = sprintf($sqlFormat,$sqlSelect, $sqlLimit);
        $result     = $db->query($sql, array(
                        ':currentDate'  => $currentDate
                    ))->fetchAll();
        if (count($result)) {
            foreach ($result as $aInvoice) {
                array_push($aInvoices, $aInvoice['id']);
            }
        }
        
        
        
        return array(true, array(
            'success'   => true,
            'total'     => $total,
            'aInvoices' => $aInvoices,
            'sql'       => $sqlFormat
        ));
    }
    
    
    public function unpaidNewDomain ($request)
    {
        
        $db         = hbm_db();
        
        $limit          = isset($request['limit']) ? $request['limit'] : 25;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        $total          = 0;
        
        
        $sqlSelect  = " COUNT(DISTINCT(i.id)) AS total ";
        $sqlFormat  = "
                    SELECT
                        %s
                    FROM
                        hb_domains d,
                        hb_orders o,
                        hb_invoices i,
                        hb_invoice_items ii
                    WHERE
                        d.type IN('Register','Transfer')
                        AND o.id = d.order_id
                        AND i.id = o.invoice_id
                        AND ii.invoice_id = i.id
                        AND ii.item_id = d.id
                        AND ii.type LIKE :typeDomain
                        AND i.status = 'Unpaid'
                    %s
                    ";
        $sql        = sprintf($sqlFormat,$sqlSelect, '');
        $result     = $db->query($sql, array(
                        ':typeDomain'   => 'Domain %'
                    ))->fetch();
        
        if (isset($result['total']) && $result['total']) {
            $total  = $result['total'];
        }
        
        $aInvoices  = array();
        
        $sqlSelect  = "i.*";
        $sqlLimit   = " ORDER BY i.date DESC LIMIT {$offset}, {$limit} ";
        $sql        = sprintf($sqlFormat,$sqlSelect, $sqlLimit);
        $result     = $db->query($sql, array(
                        ':typeDomain'   => 'Domain %'
                    ))->fetchAll();
        if (count($result)) {
            foreach ($result as $aInvoice) {
                array_push($aInvoices, $aInvoice['id']);
            }
        }
        
        
        
        return array(true, array(
            'success'   => true,
            'total'     => $total,
            'aInvoices' => $aInvoices,
            'sql'       => $sqlFormat
        ));
    }
    
    
    public function unpaidOverdueService ($request)
    {
        
        $db         = hbm_db();
        
        $limit          = isset($request['limit']) ? $request['limit'] : 25;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        $total          = 0;
        
        $currentDate    = date('Y-m-d');
        
        $sqlSelect  = " COUNT(*) AS total ";
        $sqlFormat  = "
                    SELECT
                        %s
                    FROM
                        hb_invoices xi
                    WHERE
                        xi.id IN (
                            SELECT
                                i.id
                            FROM
                                hb_invoices i,
                                hb_invoice_items ii,
                                hb_accounts a,
                                hb_orders o
                            WHERE
                                i.duedate < :currentDate
                                AND i.status = 'Unpaid'
                                AND ii.invoice_id = i.id
                                AND a.id = ii.item_id
                                AND ii.type = 'Hosting'
                                AND o.id = a.order_id
                                AND o.invoice_id != i.id
                        UNION
                            SELECT
                                i.id
                            FROM
                                hb_invoices i,
                                hb_invoice_items ii,
                                hb_accounts_addons aa,
                                hb_orders o
                            WHERE
                                i.duedate < :currentDate
                                AND i.status = 'Unpaid'
                                AND ii.invoice_id = i.id
                                AND aa.id = ii.item_id
                                AND ii.type = 'Addon'
                                AND o.id = aa.order_id
                                AND o.invoice_id != i.id
                        )
                    %s
                    ";
        $sql        = sprintf($sqlFormat,$sqlSelect, '');
        $result     = $db->query($sql, array(
                        ':currentDate'  => $currentDate
                    ))->fetch();
        
        if (isset($result['total']) && $result['total']) {
            $total  = $result['total'];
        }
        
        $aInvoices  = array();
        
        $sqlSelect  = "xi.*";
        $sqlLimit   = " ORDER BY xi.date DESC LIMIT {$offset}, {$limit} ";
        $sql        = sprintf($sqlFormat,$sqlSelect, $sqlLimit);
        $result     = $db->query($sql, array(
                        ':currentDate'  => $currentDate
                    ))->fetchAll();
        if (count($result)) {
            foreach ($result as $aInvoice) {
                array_push($aInvoices, $aInvoice['id']);
            }
        }
        
        
        
        return array(true, array(
            'success'   => true,
            'total'     => $total,
            'aInvoices' => $aInvoices,
            'sql'       => $sqlFormat
        ));
    }
    
    
    public function unpaidNewService ($request)
    {
        
        $db         = hbm_db();
        
        $limit          = isset($request['limit']) ? $request['limit'] : 25;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        $total          = 0;
        
        $sqlSelect  = " COUNT(*) AS total ";
        $sqlFormat  = "
                    SELECT
                        %s
                    FROM
                        hb_invoices xi
                    WHERE
                        xi.id IN (
                            SELECT
                                i.id
                            FROM
                                hb_accounts a,
                                hb_orders o,
                                hb_invoices i,
                                hb_invoice_items ii
                            WHERE
                                o.id = a.order_id
                                AND i.id = o.invoice_id
                                AND i.status = 'Unpaid'
                                AND ii.invoice_id = i.id
                                AND ii.item_id = a.id
                                AND ii.type = 'Hosting'
                        UNION
                            SELECT
                                i.id
                            FROM
                                hb_accounts_addons aa,
                                hb_orders o,
                                hb_invoices i,
                                hb_invoice_items ii
                            WHERE
                                o.id = aa.order_id
                                AND i.id = o.invoice_id
                                AND i.status = 'Unpaid'
                                AND ii.invoice_id = i.id
                                AND ii.item_id = aa.id
                                AND ii.type = 'Addon'
                        )
                    %s
                    ";
        $sql        = sprintf($sqlFormat,$sqlSelect, '');
        $result     = $db->query($sql)->fetch();
        
        if (isset($result['total']) && $result['total']) {
            $total  = $result['total'];
        }
        
        $aInvoices  = array();
        
        $sqlSelect  = "xi.*";
        $sqlLimit   = " ORDER BY xi.date DESC LIMIT {$offset}, {$limit} ";
        $sql        = sprintf($sqlFormat,$sqlSelect, $sqlLimit);
        $result     = $db->query($sql)->fetchAll();
        if (count($result)) {
            foreach ($result as $aInvoice) {
                array_push($aInvoices, $aInvoice['id']);
            }
        }
        
        
        
        return array(true, array(
            'success'   => true,
            'total'     => $total,
            'aInvoices' => $aInvoices,
            'sql'       => $sqlFormat
        ));
    }
    
    
    public function unpaidIsShipped ($request)
    {
        
        $db         = hbm_db();
        
        $limit          = isset($request['limit']) ? $request['limit'] : 25;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        $total          = 0;
        
        $sqlSelect  = " COUNT(DISTINCT(i.id)) AS total ";
        $sqlFormat  = "
                    SELECT
                        %s
                    FROM
                        hb_invoices i,
                        hb_invoice_items ii
                    WHERE
                        i.status = 'Unpaid'
                        AND ii.invoice_id = i.id
                        AND ii.is_shipped = 1
                    %s
                    ";
        $sql        = sprintf($sqlFormat,$sqlSelect, '');
        $result     = $db->query($sql, array(
                        ':currentDate'  => $currentDate
                    ))->fetch();
        
        if (isset($result['total']) && $result['total']) {
            $total  = $result['total'];
        }
        
        $aInvoices  = array();
        
        $sqlSelect  = "i.*";
        $sqlLimit   = " ORDER BY i.date DESC LIMIT {$offset}, {$limit} ";
        $sql        = sprintf($sqlFormat,$sqlSelect, $sqlLimit);
        $result     = $db->query($sql, array(
                        ':currentDate'  => $currentDate
                    ))->fetchAll();
        if (count($result)) {
            foreach ($result as $aInvoice) {
                array_push($aInvoices, $aInvoice['id']);
            }
        }
        
        
        
        return array(true, array(
            'success'   => true,
            'total'     => $total,
            'aInvoices' => $aInvoices,
            'sql'       => $sqlFormat
        ));
    }
    
    
    public function customStatus ($request)
    {
        
        $db         = hbm_db();
        
        $status         = isset($request['statusExt']) ? $request['statusExt'] : '';
        $limit          = isset($request['limit']) ? $request['limit'] : 25;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        $total          = 0;
        
        $sqlSelect  = " COUNT(DISTINCT(i.id)) AS total ";
        $sqlFormat  = "
                    SELECT
                        %s
                    FROM
                        hb_invoices i,
                        hb_invoice_items ii
                    WHERE
                        i.status = '%s'
                        AND ii.invoice_id = i.id
                    %s
                    ";
        $sql        = sprintf($sqlFormat,$sqlSelect, $status, '');
        $result     = $db->query($sql)->fetch();
        
        if (isset($result['total']) && $result['total']) {
            $total  = $result['total'];
        }
        
        $aInvoices  = array();
        
        $sqlSelect  = "i.*";
        $sqlLimit   = " ORDER BY i.date DESC LIMIT {$offset}, {$limit} ";
        $sql        = sprintf($sqlFormat,$sqlSelect, $status, $sqlLimit);
        $result     = $db->query($sql)->fetchAll();
        if (count($result)) {
            foreach ($result as $aInvoice) {
                array_push($aInvoices, $aInvoice['id']);
            }
        }
        
        
        
        return array(true, array(
            'success'   => true,
            'total'     => $total,
            'aInvoices' => $aInvoices,
            'sql'       => $sqlFormat
        ));
    }
    
    
    public function invoiceNumber ($request)
    {
        
        $db         = hbm_db();
        
        $total          = 0;
        
        $timePeriod     = isset($request['timePeriod']) ? $request['timePeriod'] : '';

        switch ($timePeriod) {
            case 'last3Month':   {
                $currentTime        = mktime(0,0,0,(date('n')-3),date('j'),date('Y'));
                break;
            }
            case 'last2Month':   {
                $currentTime        = mktime(0,0,0,(date('n')-2),date('j'),date('Y'));
                break;
            }
            case 'lastMonth':   {
                $currentTime        = mktime(0,0,0,(date('n')-1),date('j'),date('Y'));
                break;
            }
            default: {
                $currentTime        = time();
            }
        }
        
        $invoicePrefix      = 'HS'. substr((date('Y', $currentTime)),-2) . date('m', $currentTime).'-%';
        
        $sqlSelect  = " COUNT(DISTINCT(i.id)) AS total ";
        $sqlFormat  = "
                    SELECT
                        %s
                    FROM
                        hb_invoices i
                    WHERE
                        i.invoice_number LIKE '%s'
                    %s
                    ";
        $sql        = sprintf($sqlFormat,$sqlSelect, $invoicePrefix, '');
        $result     = $db->query($sql)->fetch();
        
        if (isset($result['total']) && $result['total']) {
            $total  = $result['total'];
        }
        
        $aInvoices  = array();
        
        $sqlSelect  = "i.*";
        $sqlLimit   = " ORDER BY i.invoice_number ASC ";
        $sql        = sprintf($sqlFormat,$sqlSelect, $invoicePrefix, $sqlLimit);
        $result     = $db->query($sql)->fetchAll();
        
        if (count($result)) {
            foreach ($result as $aInvoice) {
                array_push($aInvoices, $aInvoice['id']);
            }
        }
        
        
        
        return array(true, array(
            'success'   => true,
            'total'     => $total,
            'aInvoices' => $aInvoices,
            'sql'       => $sqlFormat
        ));
    }
    
    
    public function clientInvoice ($request)
    {
        
        $db         = hbm_db();
        
        $limit          = isset($request['limit']) ? $request['limit'] : 25;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        $clientId       = isset($request['clientId']) ? $request['clientId'] : 0;
        $status         = isset($request['status']) ? $request['status'] : '';
        $total          = 0;
        
        $sqlSelect  = " COUNT(*) AS total ";
        $sqlFormat  = "
                    SELECT
                        %s
                    FROM
                        hb_invoices i
                    WHERE
                        i.client_id = :clientId
                        AND i.status = :status
                    %s
                    ";
        $sql        = sprintf($sqlFormat,$sqlSelect, '');
        $result     = $db->query($sql, array(
                        ':clientId'     => $clientId,
                        ':status'       => $status
                    ))->fetch();
        
        if (isset($result['total']) && $result['total']) {
            $total  = $result['total'];
        }
        
        $aInvoices  = array();
        
        $sqlSelect  = "i.*";
        $sqlLimit   = " ORDER BY i.date DESC LIMIT {$offset}, {$limit} ";
        $sql        = sprintf($sqlFormat,$sqlSelect, $sqlLimit);
        $result     = $db->query($sql, array(
                        ':clientId'     => $clientId,
                        ':status'       => $status
                    ))->fetchAll();
        if (count($result)) {
            foreach ($result as $aInvoice) {
                array_push($aInvoices, $aInvoice['id']);
            }
        }
        
        
        
        return array(true, array(
            'success'   => true,
            'total'     => $total,
            'aInvoices' => $aInvoices,
            'sql'       => $sqlFormat
        ));
    }
    
    
}
