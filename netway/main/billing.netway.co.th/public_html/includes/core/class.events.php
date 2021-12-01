<?php

/**
 * http://wiki.hostbillapp.com/index.php?title=Events
 *
 *
 * HostBill uses Event-Driven architecture - what it basically means is that
 * after certain action is being taken HostBill fires Event and passes related
 * params to it. For example after new order is being placed HostBill invokes
 * function NewOrder and passes related order id as function argument.
 * Its just one way of extending HostBill functionality - its great for invoking
 * custom scripts without creating extra plugins/addons.
 *
 * THIS FILE IS DIVIDED INTO SECTIONS:
 * - CLIENT RELATED EVENTS
 * - ACCOUNT RELATED EVENTS
 * - ADDON RELATED EVENTS
 * - BILLING RELATED EVENTS
 * - DOMAIN RELATED EVENTS
 */

class Events implements Observer {

    /**
     * $db holds initialized PDO (or PDO-compilant on servers without PDO available)
     * object. PDO is already connected to HostBill database, so you can easily
     * perform queries on it.
     *
     * @see http://php.net/manual/en/book.pdo.php
     */
    private $db = null;
    /**
     * $api holds APIWrapper object - its great method to getting data from HostBill
     * without direct access to database.
     *
     * For more informations on APIWrapper object and its methods visit:
     * @see http://wiki.hostbillapp.com/index.php?title=Custom_Modules#APIWrapper
     *
     * APIWrappers shares all methods of HBWrapper, for full list of API methods visit:
     * @see http://wiki.hostbillapp.com/index.php?title=API
     */
    private $api = null;

    public function __construct() {
        $this->db = Engine::singleton()->getObject('db');
        $this->api = new ApiWrapper();
    }

    /**
     * This event is called when adminarea header is rendered -
     * use this to inject your custom scripts/meta tags etc.
     */
    function before_displayadminheader() {

    }

    /**
     * This event is called when clientarea header is rendered -
     * use this to inject your custom scripts/meta tags etc.
     */
    function before_displayuserheader() {

    }

    /**
     * This event is called when adminarea footer is rendered -
     * use this to inject your custom scripts/meta tags etc.
     */
    function before_displayadminfooter() {

    }

    /**
     * This event is called when clientarea footer is rendered -
     * use this to inject your custom scripts/meta tags etc.
     */
    function before_displayuserfooter() {

    }

    /**
     * This event is invoked every 5 minutes with cron run
     */
    function after_cronrun() {

    }

    /**
     * Client posted sign-up form, but he is not registered yet/
     * This event is called BEFORE HostBill validates/sanitizes input
     * @param array $details Contains posted form fields values.
     * Some of keys available (note: if you have custom registration fields they may differ):
     * $details['type']; // Personal or Organization account
     * $details['companyname']; // Supplied company name
     * $details['firstname']; //
     * $details['lastname']; //
     * $details['password']; //
     * $details['password2']; //
     * $details['email']; //
     * $details['address1']; //
     * $details['address2']; //
     * $details['city']; //
     * $details['state']; //
     * $details['postcode']; //
     * $details['country']; //
     * $details['phonenumber']; //
     */
    function before_clientadded($details) {

    }

    /**
     * New client has been registered in database,
     * @param array $details contains informations that were stored.
     * Some of keys available (note: if you have custom registration fields they may differ):
     * $details['id']; // new client ID
     * $details['type']; // Personal or Organization account
     * $details['companyname']; // Supplied company name
     * $details['firstname']; //
     * $details['lastname']; //
     * $details['password']; //
     * $details['password2']; //
     * $details['email']; //
     * $details['address1']; //
     * $details['address2']; //
     * $details['city']; //
     * $details['state']; //
     * $details['postcode']; //
     * $details['country']; //
     * $details['phonenumber']; //
     */
    function after_clientadded($details) {

    }

    /**
     * Client details has been updated in database
     * @param array $details contains previous and currend details.
     * Sample $details keys available:
     * $details['previous']['id'];
     * $details['previous']['firstname'];
     * $details['previous']['lastname'];
     * $details['previous']['comapnyname'];
     * $details['previous']['email'];
     * $details['previous']['address1'];
     * $details['previous']['address2'];
     * $details['previous']['city'];
     * $details['previous']['state'];
     * $details['previous']['postcode'];
     * $details['previous']['country'];
     * $details['previous']['phonenumber'];
     * $details['new']['id'];
     *  $details['new']['firstname'];
     *  $details['new']['lastname'];
     *  $details['new']['comapnyname'];
     *  $details['new']['email'];
     *  $details['new']['address1'];
     *  $details['new']['address2'];
     *  $details['new']['city'];
     *  $details['new']['state'];
     *  $details['new']['postcode'];
     *  $details['new']['country'];
     *  $details['new']['phonenumber']; //
     */
    function after_clientedit($details) {

    }

    /**
     * Client with ID=$details just logged out
     * @param integer $details client id in HostBill
     */
    function after_clientlogout($details) {

    }

    /**
    * Client is atempting to log in with:
     * 
    * @param array $details 
    * $details['email'] - email address provided in client login form. Note: Email is just arbitrary,
    * you can modify your clientarea "email" label in login form and have client provide his username
    * to authentincate with
    * 
    * $details['password'] - password client proivied in client login form
    * 
    * You can use this hook to authenticate client against external database/auth service.
    * To do so, after successfull auth, simply return client id that HostBill should log in.
    * ie. return 10; //login client with id=10 (hb_client_access.id=10).
    * 
    * If client have provided wrong credentials - dont return any value - this way HostBill
    * will fall-back to its internal authentication methods.
    * 
    * @return null|integer
    */
    function before_clientlogin($details) {

    }

    
    /**
     * Client with ID=$details just logged in
     * @param integer $details  Client id in HostBill
     */
    function after_clientlogin($details) {

    }

    /**
     * Client  has just been deleted from HostBill database
     * @param array $details contains informations about deleted client, from API::getClientDetails call
     * Some of keys available (note: if you have custom registration fields they may differ):
     * $details['id']; // new client ID
     * $details['type']; // Personal or Organization account
     * $details['companyname']; // Supplied company name
     * $details['firstname']; //
     * $details['lastname']; //
     * $details['password']; //
     * $details['password2']; //
     * $details['email']; //
     * $details['address1']; //
     * $details['address2']; //
     * $details['city']; //
     * $details['state']; //
     * $details['postcode']; //
     * $details['country']; //
     * $details['phonenumber']; //
     */
    function after_clientdelete($details) {

    }

    /**
     * Client  has just been deleted from HostBill database
     * @param array $details contains informations about deleted client, from API::getClientDetails call
     * Some of keys available (note: if you have custom registration fields they may differ):
     * $details['id']; // new client ID
     * $details['type']; // Personal or Organization account
     * $details['companyname']; // Supplied company name
     * $details['firstname']; //
     * $details['lastname']; //
     * $details['password']; //
     * $details['password2']; //
     * $details['email']; //
     * $details['address1']; //
     * $details['address2']; //
     * $details['city']; //
     * $details['state']; //
     * $details['postcode']; //
     * $details['country']; //
     * $details['phonenumber']; //
     */
    function before_clientdelete($details) {

    }

    /**
     * Client just changed his password
     * @param array $details  Items available:
     * $details['client_id']; // Related client ID
     * $details['password']; // New client password
     */
    function after_clientchangepassword($details) {
    }

    /**
     * Client posted cancelation request for account
     * @param array $details an array with basic cancelation details
     * $details['reason']; // Cancellation reason
     * $details['acc_id']; // Related account id
     */
    function after_cancellationrequest($details) {

    }

    /**
     * Account-related module (for ex. cPanel) successfully changed package on server
     * @param array $details $details=array('account'=>ACCOUNT DETAILS ARRAY)
     */
    function after_accountchangepackage($details) {

    }

    /**
     * Order data is about to be build (inserted into database)
     * @param array $details Following details are passed:
     * $details['product'] - array with ordered pacakge details
     * $details['configuration'] - array with ordered Form elements
     * $details['addons'] - array with ordered addons
     * $details['domains'] - array with ordered domains
     * $details['notes'] - order notes
     * $details['discounts'] - discounts applied in cart during order
     * $details['subproducts'] - subpackages ordered with main package
     * $details['client_id'] - client id that place this order.
     */
    function before_orderbuild($details) {
    }

    /**
     * Account is about to be created.
     * Throw exception here to stop it from creation
     * @param array $details  An array with following keys/values:
     * $details['id'] - account id
     * $details['account'] - account data from hb_accounts table
     */
    function before_accountcreate($details) {

    }

    /**
     * Account is about to be suspended
     * Throw exception here to stop it from suspending
     * @param array $details  An array with following keys/values:
     * $details['id'] - account id
     * $details['account'] - account data from hb_accounts table
     */
    function before_accountsuspend($details) {

    }

    /**
     * Account is about to be unsuspended
     * Throw exception here to stop it from suspending
     * @param array $details  An array with following keys/values:
     * $details['id'] - account id
     * $details['account'] - account data from hb_accounts table
     */
    function before_accountunsuspend($details) {

    }
    /**
     * Account is about to be terminated
     * Throw exception here to stop it from termination
     * @param array $details  An array with following keys/values:
     * $details['id'] - account id
     * $details['account'] - account data from hb_accounts table
     */
    function before_accountterminate($details) {

    }


    /**
     * Account-related module (for ex. cPanel) successfully changed password of account
     * @param array $details $details=array('account'=>ACCOUNT DETAILS ARRAY, 'newpassword' => NEW SERVICE PASS)
     */
    function after_accountchangepassword($details) {

    }

    /**
     * Account-related module (for ex. cPanel) successfully suspended account ID=$details
     * @param integer $details  Related account id
     */
    function after_accountsuspend($details) {

    }

    /**
     * Account-related module (for ex. cPanel) successfully unsuspended account ID=$details
     * @param integer $details  Related account id
     */
    function after_accountunsuspend($details) {

    }

    /**
     * Account-related module (for ex. cPanel) successfully created account
     * @param array $details $details = array('service' => ACCOUNT DETAILS ARRAY,
     * 'account_id' => ACCOUNT ID, 'server' => RELATED SERVER DETAILS ARRAY)
     */
    function after_accountcreate($details) {

    }

    /**
     * Account-related module (for ex. cPanel) successfully terminated account
     * @param array $details
     * * $details = array('service' => ACCOUNT DETAILS ARRAY,
     * 'account_id' => ACCOUNT ID, 'server' => RELATED SERVER DETAILS ARRAY)
     */
    function after_accountterminate($details) {

    }

    /**
     * Client ordered field upgrade/downgrade and it has changed by accepting order (auto or manual)
     * @param array $details
     * $details=array('account_id'=>ACCOUNT ID,
     * 'old_field'=>array(config_cat=>... config_id=>..., qty=>..., data=>...), //old field with value/qty,
     * 'new_field'=>array(config_cat=>...new_config_id=>.... new_qty=>...) //new field with value, qty
     */
    function after_accountformsupgrade($details) {
    }

    /**
     * Addon was activated
     * @param integer $details is ID property in hb_accounts_addons table
     */
    function after_addoncreate($details) {
    }

    /**
     * Addon was terminated
     * @param integer $details is ID property in hb_accounts_addons table
     */
    function after_addonterminate($details) {
    }

    /**
     * Addon was suspended
     * @param integer $details is ID property in hb_accounts_addons table
     */
    function after_addonsuspend($details) {

    }

    /**
     * Refund from admin interface was successfull
     * @param array $details Array contains
     * client_id - related client id
     * invoice_id - related invoice id
     * transaction_id - original transaction id that was subject of refund
     * amount - amount refunded
     */
    function after_refund($details) {

    }

    /**
     * New order has been placed
     * @param array $details  is ID property in hb_orders table
     */
    function after_ordercreate($details) {

    }

    /**
     * Transaction has been sucessfully stored in HostBill database
     * @param array $details  new transaction details, following keys are available:
     * $details['client_id']; //RELATED CLIENT ID,
     * $details['invoice_id']; //RELATED INVOICE ID
     * $details['module']; //RELATED GATEWAY NAME,
     * $details['date']; //TRANSACTION DATE,
     * $details['descr']; //TRANSACTION DESCRIPTION,
     * $details['in']; //IN AMOUNT,
     * $details['fee']; //APPLIED FEEs (if any),
     * $details['out']; //AMOUNT SENT to gateway from your account (if any)
     * $details['trans_id'];  //GATEWAY SPECIFIC Transaction ID)
     * $details['currency_id']; //Transaction currency id, default=0
     */
    function after_transactionadd($details) {

    }

    /**
     * Invoice has been fully paid
     * @param array $details   This array of invoice details contains following keys:
     * $details["id"]; // Invoice id
     * $details["status"]; //Current invoice status
     * $details["client_id"]; //Owner of invoice
     * $details["date"]; //Invoice generation date
     * $details["subtotal"]; //Subtotal
     * $details["credit"]; //Credit applied to invoice
     * $details["tax"]; //Tax applied to invoice
     * $details["total"]; //Invoice total
     * $details["payment_module"]; //ID of gateway used with invoice
     * $details["currency_id"]; //ID of invoice currency, default =0
     * $details["notes"]; //Invoice notes
     * $details["items"]; // Invoice items are listed under this key, sample item:
     * $details["items"][0]["type"]; //Item type (ie. Hosting, Domain)
     * $details["items"][0]["item_id"]; //Item id, for type=Hosting this relates to hb_accounts.id field
     * $details["items"][0]["description"]; //Item line text
     * $details["items"][0]["amount"]; //Item price
     * $details["items"][0]["taxed"]; //Is item taxed? 1/0
     * $details["items"][0]["qty"]; //Item quantitiy
     *
     */
    function after_invoicefullpaid($details) {

    }

    /**
     * Partial payment to invoice has been applied
     * NOTE: Applying partial payment doesnt mean that invoice was fully paid.
     * @param integer $details  This variable keeps invoice id that payment was applied for
     */
    function after_invoicepartialpayment($details) {

    }

    /**
     * Invoice total amount has been changed (new item has been added/items edited etc)
     * @param integer $details  This variable keeps invoice id that total was updated
     */
    function after_invoiceupdatetotal($details) {

    }

    /**
     * New invoice has just been created with ID=$details
     *  This event is called after every items saved for the invoice.
     *  So if you will get this event you will be sure that invoice has been successfully created.
     * @param integer $details  This variable keeps invoice id
     */
    function after_invoicecreate($details) {

    }
    
    /**
     * New invoice is about to be created.
     * $details contains params of the invoice, without its id.
     * @param type $details
     */
    function BeforeInvoiceCreated($details) {
        
    }

    /**
     * New estimate has just been created with ID=$details
     * @param  integer $details  This variable keeps estimate id
     */
    function after_estimatecreate($details) {

    }

    /**
     * Late fee has been applied to invoice ID=$invoice_id
     * @param array $invoice_id
     */
    function after_invoicelatefee($details) {

    }

    /**
     * New support ticket has just been created
     * $details =array('ticket_id'=>RELATED TICKET ID IN HOSTBILL DB,
     * 'ticket_number'=>RELATED TICKET NUMBER,
     * 'acc_hash'=>REMOTE ACCESS HASH FOR NON_REGISTERED VIEWS,
     * 'dept_id'=>RELATED DEPARTMENT ID,
     * 'client_id'=>RELATED CLIENT ID (IF ANY),
     * 'name'=>SUBMITTER NAME,
     *  'email'=>SUBMITTER EMAIL,
     *  'subject'=>TICKET SUBJECT,
     *  'body'=>TICKET BODY,
     *  'status'=>TICKET STATUS)
     * @param array $details
     */
    function after_ticketopen($details) {

    }

    /**
     * Administrator deleted ticket
     * $details =array('id'=>RELATED TICKET ID IN HOSTBILL DB,
     * 'ticket_number'=>RELATED TICKET NUMBER,
     * 'acc_hash'=>REMOTE ACCESS HASH FOR NON_REGISTERED VIEWS,
     * 'dept_id'=>RELATED DEPARTMENT ID,
     * 'client_id'=>RELATED CLIENT ID (IF ANY),
     * 'name'=>SUBMITTER NAME,
     *  'email'=>SUBMITTER EMAIL,
     *  'subject'=>TICKET SUBJECT,
     *  'body'=>TICKET BODY,
     *  'status'=>TICKET STATUS)
     * @param array $details
     */
    function after_ticketdelete($details) {

    }

    /**
     * Administrator has just posted reply to a ticket
     * $details = array('id'=>REPLY ID,
     * 'ticket_id'=>RELATED TICKET ID,
     * ticket_number'=>RELATED TICKET NUMBER,
     * 'replier_id'=>REPLIER ID (IF ANY),
     * 'name'=>REPLIER NAME,
     * 'email'=>REPLIER EMAIL,
     * 'body'=>REPLY MESSAGE BODY,
     * 'type'=>REPLIER TYPE (Admin or Client),
     * 'date'=>REPLY DATE)
     * @param array $details
     */
    function after_ticketadminreply($details) {

    }

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
     * @param array $details
     */
    function after_ticketclientreply($details) {

    }

    /**
     * Ticket SLA policy has just breached
     * @param array $details
     * 'ticket' => contains ticket details in array
     * 'policy' => contains sla policy in array (id,name,level,macro_id,trigger,trigger_name)
     */
    function after_ticketslabreach($details) {

    }

    
    /**
     * HostBill has just set this ticket as escalated
     * @deprecated Use after_ticketslabreach instead
     * @param int $details Ticket ID
     */
    function after_ticketescalate($details){
        
    }
    
    /**
     * HostBill has just set this ticket as overdue
     * @deprecated Use after_ticketslabreach instead
     * @param int $details  Ticket ID
     */
    function after_ticketoverdue($details){
        
    }
    
    /**
     * HostBill checked all it's import pre filters and is about to add a ticket/reply
     * You can add additional checks here, returning any positive value will stop Hostbill from importing this message
     * It will be noted in Email import logs as rejected email
     * $details = array(
     *  'subject' => EMAIL SUBJECT
     *  'body' => EMAIL BODY
     *  'from' => SENDER EMAIL
     *  'from_name' => SENDER NAME
     *  'to' => (array) RECEIVERS
     *  'cc' => (array) CARBON COPY
     *  'bcc' => (array) BLIND CARBON COPY
     *  'client_id' => RELATED CLIENT, IF ANY
     *  'department' => (array/int) DEPARTMENT INFO/ID
     *  'ticket_number' => RELATED TICKET NUMBER, IF ANY
     *  'senderip' => SENDER IP
     *  'files' => (array) ATTACHMENTS
     *  'additional' => (array) ADDITIONAL EMAIL INFORMATION)
     * @param type $details 
     * @return boolean
     */
    function after_ticketprefilter($details){
        
    }

    /**
     * Hostbill has already created new ticket an checked it's post filters
     * $details = array(
     * 'date' => TICKET CREATION DATE
     * 'ticket_number' => TICKET NUMBER
     * 'acc_hash' => ACC HASH
     * 'dept_id' => DEPARTMENT ID
     * 'client_id' => RELATE CLIENT ID
     * 'name'=> SENDER NAME
     * 'email' => SENDER EMAIL
     * 'cc' => CARBON COPY
     * 'subject' => TICKET SUBJECT
     * 'body' => TICKET BODY
     * 'status' => TICKET STATUS
     * 'priority' => TICKET PRIORITY
     * 'notes' => IF TICKET HAS NOTES THAN 1 ELSE 0
     * 'admin_read' => IF ADMIN SEEN THIS TICKET THEN 1 ELSE 0
     * 'client_read' => IF CLIENT SEEN THIS TICKET THEN 1 ELSE 0
     * 'type' => WHO CREATED THIS TICKET: Client / Admin
     * 'senderip' => SENDER IP
     * 'owner_id' => ASSIGNED ADMIN ID )
     * @param type $details 
     */
    function after_ticketpostfilter($details){
        
    }
    
    /**
     * HostBill is about to take an attempt to register domain
     * $details = array('id'=>RELATED DOMAIN ID IN HOSTBILL,
     * 'name'=>DOMAIN NAME);
     * Throw exception here to stop domain registration
     * @param array $details
     */
    function before_domainregister($details) {

    }

    /**
     * HostBill is about to take an attempt to transfer domain
     * Throw exception here to stop domain transfer
     * @param array $details array containing two elements
     * $details['id'] = domain id
     * $details['name'] = domain name
     */
    function before_domaintransfer($details) {

    }

    /**
     * HostBill is about to take an attempt to renew domain
     * Throw exception here to stop domain renewal
     * @param array $details array containing two elements
     * $details['id'] = domain id
     * $details['name'] = domain name
     */
    function before_domainrenew($details) {

    }



    /**
     * HostBill succesfully registered domain
     * $details = array('id'=>RELATED DOMAIN ID IN HOSTBILL,
     * 'name'=>DOMAIN NAME);
     * @param array $details
     */
    function after_domainregister($details) {

    }

    /**
     * HostBill succesfully transfered domain
     * $details = array('id'=>RELATED DOMAIN ID IN HOSTBILL,
     * 'name'=>DOMAIN NAME);
     * @param array $details
     */
    function after_domaintransfer($details) {

    }

    /**
     * HostBill succesfully renewed domain
     * $details = array('id'=>RELATED DOMAIN ID IN HOSTBILL,
     * 'name'=>DOMAIN NAME);
     * @param array $details
     */
    function after_domainrenew($details) {

    }

    /**
     * Domain details has been changed
     * @param array $details POST params from domain details save form.
     * Some of available keys:
     * $details['id']; // Domain id in hb_domains table
     * $details['period']; // Domain registartion period (in years)
     * $details['expires']; // Domain expiration date
     * $details['date_created']; // Domain registartion date
     * $details['reg_module']; // Domain registrar module ID
     * $details['firstpayment']; // Domain registration price
     * $details['status']; // Current domain status
     * $details['recurring_amount']; // Current domain renewal price
     * $details['name']; // Domain name, ie. example.com
     * $details['nameservers']['ns1']; // Domain NS1
     * $details['nameservers']['ns2']; // Domain NS2
     * $details['epp_code']; // Domain Epp Code
     * $details['autorenew']; // Is aytorenew enabled
     * $details['notes']; // Domain notes
     */
    function after_domainsave($details) {

    }

    /**
     * User has rated staff response to a ticket
     * @param array $details Array with score and reply data.
     * Available keys:
     * $details['reply_id']; // Rated reply id
     * $details['ticket_id']; // Related ticket
     * $details['ticket_number']; // Related ticket number
     * $details['date']; // Date of submission
     * $details['rating']; // User selected score
     * $details['replier_id']; // Id of staff member
     */
    function after_responserate($details){
        
    }
    
    /**
     * User has started live chat session
     * @param array $details Array with question and user contact info.
     * Available keys:
     * $details['subject']; // Question asked
     * $details['name']; // User name
     * $details['email']; // User email
     * $details['cid']; // Chat session id
     */
    function after_chatinit($details){
        
    }
    
    /**
     * Domain entry has been deleted from HostBill database
     * @param array $details contains informations about deleted domain
     * Some of keys available:
     * $detais['id']; // Domain id
     * $detais['client_id']; // Client id
     * $detais['order_id']; // Order id
     * $detais['tld_id']; // Product id
     * $detais['name']; // Domain name
     * $detais['reg_module']; // Registrar module
     * $detais['date_created']; // Date of creation
     * $detais['firstpayment']; // First payment amount
     * $detais['recurring_amount']; // Renewal payment amount
     * $detais['period']; // Domain period in years
     * $detais['expires']; // Expire date
     * $detais['type']; // Register/Transfer/Renew
     * $detais['status']; // Status of this domain
     * $detais['next_due']; // Next due date
     * $detais['next_invoice']; // Next invoice date
     * $detais['nameservers']; // nameserver for that domain
     * $detais['autorenew']; // autorenew option
     * $detais['notes']; // notes
     * $detais['extended']; // additional domain information
     * $detais['synch_date']; // last synchronization date
     * $detais['nsips']; // nameserver ips
     */
    function after_domaindelete($details) {

    }
    
    
    /**
     * Next invoice paid id has been requsted
     * Use this call to modify paid id (For eu billing).
     * Modify id by updating reference array. Ie $array[id] = 10;
     * 
     * 
     * @param array $array keys: id -> HostBill-generated next paid id, date -> invoice paid date
     * 
     */
    function after_invoicenextpaidid(&$array) {
        
    }
    
}
