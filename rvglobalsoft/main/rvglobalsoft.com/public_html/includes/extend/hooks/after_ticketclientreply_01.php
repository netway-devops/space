<?php

/**
 * Client has just posted reply to a ticket
 * $details = array('id'=>REPLY ID,
 * 'ticket_id'=>RELATED TICKET ID,
 * 'replier_id'=>REPLIER ID (IF ANY),
 * 'name'=>REPLIER NAME,
 * 'email'=>REPLIER EMAIL,
 * 'body'=>REPLY MESSAGE BODY,
 * 'type'=>REPLIER TYPE (Admin or Client),
 * 'date'=>REPLY DATE)
 * Following variable is available to use in this file:  $details
 */
// --- hostbill helper ---
$db         = hbm_db();
$db->query("SELECT '". __FILE__ ."' ");
// --- hostbill helper ---