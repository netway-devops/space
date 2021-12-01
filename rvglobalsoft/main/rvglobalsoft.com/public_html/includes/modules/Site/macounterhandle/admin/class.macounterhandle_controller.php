<?php

class macounterhandle_controller extends HBController {

    public function beforeCall ($request)
    {
        $this->_beforeRender();
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
        
        //$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.result.tpl', array(), false);
    }
    
    public function startCount ($request)
    {
        $db     = hbm_db();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        
        $result         = $db->query("
                SELECT
                    tmc.*
                FROM
                    hb_ticket_ma_counter tmc
                WHERE
                    tmc.ticket_id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        if (! isset($result['id'])) {
            $db->query("
                INSERT INTO hb_ticket_ma_counter (
                    id, ticket_id, date, start_counter, counter_in_minute
                ) VALUES (
                    '', :ticketId, NOW(), NOW(), 0
                )
                ", array(
                    ':ticketId'     => $ticketId
                ));
        } else {
            $db->query("
                UPDATE
                    hb_ticket_ma_counter
                SET
                    start_counter = NOW()
                WHERE
                    ticket_id = :ticketId
                ", array(
                    ':ticketId'             => $ticketId
                ));
        }
        
        /* --- Add tag #MACounter --- */
        $result         = $db->query("
                SELECT
                    t.*
                FROM
                    hb_tags t
                WHERE
                    t.tag = '#MACounter'
                ")->fetch();
        
        if (isset($result['id'])) {
            $tagId      = $result['id'];
        } else {
            $db->query("
                INSERT INTO hb_tags (
                    id, tag
                ) VALUES (
                    '', '#MACounter'
                )
                ");
            $tagId      = mysql_insert_id();
        }
        
        $db->query("
            REPLACE INTO hb_tickets_tags (
                tag_id, ticket_id
            ) VALUES (
                :tagId, :ticketId
            )
            ", array(
                ':tagId'        => $tagId,
                ':ticketId'     => $ticketId
            ));
        
        
        echo '<!-- {"ERROR":[],"INFO":["MA Counter is starting."]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function stopCount ($request)
    {
        $db             = hbm_db();
        
        $oAdmin         = (object) hbm_logged_admin();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $isAjax         = isset($request['isAjax']) ? $request['isAjax'] : true;
        $isActionComment    = isset($request['isActionComment']) ? $request['isActionComment'] : '';
        
        if ($isActionComment && isset($oAdmin->access['maCounterTicket'])) {
            return false;
        }
        
        $result         = $db->query("
                SELECT
                    tmc.*, UNIX_TIMESTAMP(start_counter) AS startCounter
                FROM
                    hb_ticket_ma_counter tmc
                WHERE
                    tmc.ticket_id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        if (! isset($result['id'])) {
            if ($isAjax) {
                echo '<!-- {"ERROR":["Invalid ma counter ticket id"],"INFO":[]'
                    . ',"STACK":0} -->';
                exit;
            } else {
                return false;
            }
        }
        
        $maCounterActive    = $result['startCounter'] ? 1 : 0;
        $maCounterInMunute  = $result['counter_in_minute'];
        
        if ($maCounterActive) {
            $minute             = intval((time() - $result['startCounter']) / 60);
            $maCounterInMunute  = $maCounterInMunute + $minute;
        }
        
        $db->query("
            UPDATE
                hb_ticket_ma_counter
            SET
                start_counter = '0000-00-00 00:00:00',
                counter_in_minute = :maCounterInMunute
            WHERE
                ticket_id = :ticketId
            ", array(
                ':maCounterInMunute'    => $maCounterInMunute,
                ':ticketId'             => $ticketId
            ));
        
        /* --- remove tag #MACounter from ticket --- */
        $result         = $db->query("
                SELECT
                    t.*
                FROM
                    hb_tags t
                WHERE
                    t.tag = '#MACounter'
                ")->fetch();
        
        if (isset($result['id'])) {
            $db->query("
                DELETE FROM hb_tickets_tags
                WHERE
                    ticket_id = :ticketId
                    AND tag_id = :tagId
                ", array(
                    ':ticketId'     => $ticketId,
                    ':tagId'        => $result['id']
                ));
        }
        
        if ($isAjax) {
            echo '<!-- {"ERROR":[],"INFO":["MA Counter is stoped."]'
                . ',"STACK":0} -->';
            exit;
        } else {
            return true;
        }
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