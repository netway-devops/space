<?php

class RVSymantecApi
{
    protected $url = 'http://127.0.0.1:5000/';
    private $secret_code = 'QW9A8Mi22z13A2O8zN7M29W367oT419k';
    protected $partner_code = null;
    protected $username = null;
    protected $password = null;
    protected $mode = 'real';
    protected $verbose = false;

    public function __construct()
    {}

    public static function &connect($partner_code, $username, $password, $test_mode = false)
    {
        $class      = __CLASS__;
        $o_class    = new $class();

        $o_class->partner_code  = $partner_code;
        $o_class->username      = $username;
        $o_class->password      = $password;

        if ($test_mode == true) {
            $o_class->mode = 'test';
        }
        return $o_class;
    }

    public function setDebug()
    {
        $this->verbose = true;
    }

    public function getInfo(){
    	return (object) array(
    			'partner_code' => $this->partner_code
    			, 'username' => $this->username
    			, 'mode' => $this->mode
    			);
    }

    public function send($apiType, $command, $params = array())
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->url);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_USERAGENT, 'RVGLOBALSOFT API VERSION 1.0.1');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            "SYM_PARTNER_CODE: {$this->partner_code}",
            "SYM_USERNAME: {$this->username}",
            "SYM_PASSWORD: {$this->password}",
            "RV_API_SECRET_CODE: {$this->secret_code}",
            "RV_API_MODE: {$this->mode}",
            "RV_API_REQUEST: {$apiType}",
            "RV_API_COMMAND: {$command}"
        ));
        $a_send_param = array();
        foreach ($params as $key => $val) {
            if (is_array($val)) {
                $a_send_param[$key] = serialize($val);
            } else {
                $a_send_param[$key] = $val;
            }
        }

        if ($this->verbose === true) {
            echo "<i>Send</i><br />\n<pre>";
            print_r($a_send_param);
            echo "</pre>\n";
        }

        curl_setopt($ch, CURLOPT_POSTFIELDS, $a_send_param);
        $data = curl_exec($ch);

        if (curl_errno($ch)) {
            $respond = array(
                'status'    => '0',
                'code'      => '501',
                'details'   => array(
                    'header'    => 'ERROR CURL',
                    'message'   => curl_error($ch)
                )
            );
        } else {
            try {
                $respond = json_decode($data);
            } catch (Exception $e) {
                $respond = array(
                    'status'    => '0',
                    'code'      => '601',
                    'details'   => array(
                        'header'    => 'ERROR JSON Decode',
                        'message'   => $e->getMessage()
                    )
                );
            }
        }
        curl_close($ch);
        return $respond;
    }

    // ######################################################################################
    // QUERY
    // ######################################################################################
    public function hello($msg)
    {
        return $this->send('query', 'hello', array(
            'input' => $msg
        ));
    }

    /**
     * Returns detailed order information for the order matching the PartnerOrderID.
     * The PartnerOrderID can optionally be supplied during a QuickInvite or
     * QuickOrder command. If the PartnerOrderID is not supplied, GeoTrust
     * automatically generates a PartnerOrderID for an order after it is successfully
     * submitted. A PartnerOrderID must be unique and cannot be reused.
     *
     * NOTE: This operation currently returns only orders. It does not return invitations
     * that have not been converted into orders (the results of a QuickInvite).
     *
     * **Required Parameters**
     * PartnerOrderID : string
     *
     * **Optional Parameters**
     * ReturnProductDetail : bool
     * ReturnContacts : bool
     * ReturnCertificateInfo : bool
     * ReturnFulfillment : bool
     * ReturnCACerts : bool
     * ReturnPKCS7Cert : bool
     * ReturnOrderAttributes : bool
     * ReturnAuthenticationComments : bool
     * ReturnAuthenticationStatuses : bool
     * ReturnTrustServicesSummary : bool
     * ReturnTrustServicesDetails : bool
     * ReturnVulnerabilityScanSummary : bool
     * ReturnVulnerabilityScanDetails : bool
     * ReturnFileAuthDVSummary : bool
     * ReturnDNSAuthDVSummary : bool
     *
     * @param
     *            string - PartnerOrderID
     * @param
     *            array of key => value pairs
     * @return array of strings
     * @access public
     */
    public function GetOrderByPartnerOrderID($partnerOrderID, $options = array())
    {
        return $this->send('query', 'GetOrderByPartnerOrderID', array(
            'partnerOrderID'    => $partnerOrderID,
            'options'           => $options
        ));
    }

    /**
     * Returns the fulfillment of an order.
     *
     * @param
     *            string - PartnerOrderID
     * @param
     *            array of key => value pairs
     * @return array of strings
     * @access public
     */
    public function GetFulfillment($partnerOrderID, $options = array())
    {
        return $this->send('query', 'GetFulfillment', array(
            'partnerOrderID'    => $partnerOrderID,
            'options'           => $options
        ));
    }

    /**
     * Returns order detail records for all orders whose status was modified
     * in the specified date range.
     * This operation should ideally be run on a periodic basis (e.g. every 10
     * or 15 minutes) so that order status can be keupt up to date in a partner's
     * system. If no orders have changed status, a return count of zero is returned.
     *
     * @param
     *            string - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)
     * @param
     *            string - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)
     * @param
     *            array of key => value pairs
     * @return array of strings
     * @access public
     */
    public function GetModifiedOrders($fromDate, $toDate, $options = array())
    {
        return $this->send('query', 'GetModifiedOrders', array(
            'fromDate'  => $fromDate,
            'toDate'    => $toDate,
            'options'   => $options
        ));
    }

    /**
     * Returns the complete list of valid approver email messages for a specified domain.
     * This list contains three "types" of email addresses.
     *
     * @param
     *            string - domain (example: 'yahoo.com')
     * @param
     *            array of key => value pairs
     * @return array of strings
     * @access public
     */
    public function GetQuickApproverList($domain, $options = array())
    {
        return $this->send('query', 'GetQuickApproverList', array(
            'domain'    => $domain,
            'options'   => $options
        ));
    }

    /**
     * Returns order detail records for all orders whose status was modified
     * in the specified date range.
     * This operation should ideally be run on a periodic basis (e.g. every 10
     * or 15 minutes) so that order status can be keupt up to date in a partner's
     * system. If no orders have changed status, a return count of zero is returned.
     *
     * @param
     *            string - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)
     * @param
     *            string - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)
     * @param
     *            array of key => value pairs
     * @return array of strings
     * @access public
     */
    public function GetOrdersByDateRange($fromDate, $toDate, $options = array())
    {
        return $this->send('query', 'GetOrdersByDateRange', array(
            'fromDate'  => $fromDate,
            'toDate'    => $toDate,
            'options'   => $options
        ));
    }

    /**
     * The GetUserAgreement operation allows partners to request the appropriate user agreement
     * for a particular product.
     *
     * Possible values for 'AgreementType' are 'ORDERING' and 'VULNERABILITY'.
     *
     * @param
     *            string - ProductCode
     * @param
     *            array of key => value pairs
     * @return array of strings
     * @access public
     */
    public function GetUserAgreement($productCode, $options = array())
    {
        return $this->send('query', 'GetUserAgreement', array(
            'productsCode'  => $productCode,
            'options'       => $options
        ));
    }

    /**
     * Parses a CSR and returns its' content.
     *
     * Possible values for 'AgreementType' are 'ORDERING' and 'VULNERABILITY'.
     *
     * @param
     *            string - CSR
     * @param
     *            array of key => value pairs
     * @return array of strings
     * @access public
     */
    public function ParseCSR($CSR, $options = array())
    {
        return $this->send('query', 'ParseCSR', array(
            'CSR'       => $CSR,
            'options'   => $options
        ));
    }

    /**
     * Returns the processing status of the order.
     *
     * @param
     *            string - PartnerOrderID
     * @param
     *            array of key => value pairs
     * @return array of strings
     * @access public
     */
    public function CheckStatus($partnerOrderID, $options = array())
    {
        return $this->send('query', 'CheckStatus', array(
            'partnerOrderID'    => $partnerOrderID,
            'options'           => $options
        ));
    }

    // ######################################################################################
    // Order
    // ######################################################################################

    /**
     * The QuickOrder command allows partners to perform all the actions that requestors would
     * typically perform using our Web forms to place an order with one API operation call.
     * This includes submitting the full order information, such as technical contact,
     * administrative contact, and CSR, as well as approver email address (if applicable).
     * Our system validates that the approver email address matches the set of approver email
     * addresses that would have been presented to the requestor. Orders can only be successfully
     * placed if there is a match between the addresses.
     *
     * @param
     *            array - OrderParameters: ValidityPeriod, CSR, WebServerType
     * @param
     *            array - OrganizationInfo: OrganizationName, OrganizationAddress (array), ...
     * @param
     *            array - AdminContact: FirstName, LastName, Phone, Email, Title, ...
     * @param
     *            array - TechContact: FirstName, LastName, Phone, Email, Title, ...
     * @param
     *            array - BillingContact: FirstName, LastName, Phone, Email, Title, ...
     * @param
     *            string - ApproverEmail: required for TrueBusinessID with EV. If you have another
     *            product, you can put an empty string here.
     * @param
     *            array of key => value pairs
     * @return array of strings
     * @access public
     */
    public function QuickOrder($productCode, $orderParameters, $organizationInfo, $adminContact, $techContact, $billingContact = array(), $approverEmail, $options)
    {
        return $this->send('order', 'QuickOrder', array(
            'productCode'       => $productCode,
            'orderParameters'   => $orderParameters,
            'organizationInfo'  => $organizationInfo,
            'adminContact'      => $adminContact,
            'techContact'       => $techContact,
            'billingContact'    => $billingContact,
            'approverEmail'     => $approverEmail,
            'options'           => $options
        ));
    }

    /**
     * QuickInvite is a mechanism that allows partners to invite a third party to complete an order. With QuickInvite, partners can pre-fill a subset of order data. Upon receiving a submission, our system sends an email to the requestor inviting the requestor to complete the order. The information provided by the partner is protected and cannot be edited by the requestor. From this point, the order process proceeds in the same manner as a typical Domain Vetted, Organization Vetted, or Domain and Organization Vetted order. Section 5.3.1 contains a complete profile of the fields used in the QuickInvite command for all product categories.
     *
     * @param array - OrderParameters: ValidityPeriod, CSR, WebServerType
     * @param array - OrganizationInfo: OrganizationName, OrganizationAddress (array), ...
     * @param array - AdminContact: FirstName, LastName, Phone, Email, Title, ...
     * @param array - TechContact: FirstName, LastName, Phone, Email, Title, ...
     * @param array - BillingContact: FirstName, LastName, Phone, Email, Title, ...
     * @param string - ApproverEmail: required for TrueBusinessID with EV. If you have another
     *					product, you can put an empty string here.
     * @param array of key => value pairs
     * @return array of strings
     * @access public
     */
    public function QuickInvite($productCode, $orderParameters, $organizationInfo, $adminContact, $techContact, $billingContact, $approverEmail, $options)
    {
        return $this->send('order', 'QuickInvite', array(
            'productCode'       => $productCode,
        	'orderParameters'   => $orderParameters,
        	'organizationInfo'  => $organizationInfo,
        	'adminContact'      => $adminContact,
        	'techContact'       => $techContact,
        	'billingContact'    => $billingContact,
        	'approverEmail'     => $approverEmail,
        	'options'           => $options
        ));
    }

    /**
     * The ChangeApproverEmail operation allows partners to change the domain approver email for orders where the domain approval
     * process has not been completed. This operation applies to all GeoTrust and Thawte domain validated and organization and domain
     * validated certificates.
     *
     * @param array of key => value pairs
     * @return array of strings
     * @access public
     */
    public function ChangeApproverEmail($partnerOrderID, $approverEmail, $options)
    {
        return $this->send('order', 'ChangeApproverEmail', array(
        	'partnerOrderID'   => $partnerOrderID,
        	'approverEmail'    => $approverEmail,
        	'options'          => $options,
        ));
    }

    /**
     * Lets you modify your order. This function only works in the test environment
     * and is to help you simulate a fully processed order.
     *
     * Possible "ModifyOrderOperation" Values: (See API Section 5.3.4.12)
     *        APPROVE, RESELLER_APPROVE, RESELLER_DISAPPROVE, APPROVE_ESSL,
     *        REJECT, CANCEL, UPDATE_POST_STATUS, DEACTIVATE, REQUEST_ON_DEMAND_SCAN,
     *        UPDATE_SEAL_PREFERENCES, REQUEST_VULNERABILITY SCAN
     *
     * @param array of key => value pairs
     * @return array of strings
     * @access public
     */
    public function ModifyOrder($partnerOrderID, $orderOperation, $options)
    {
        return $this->send('order', 'ModifyOrder', array(
            'partnerOrderID'   => $partnerOrderID,
        	'orderOperation'   => $orderOperation,
        	'options'          => $options
        ));
    }

    /**
     * The Reissue operation allows partners to initiate the reissue of an order so that customers
     * do not need to visit the GeoTrust website to initiate a reissue. Partners are expected to
     * properly validate the authority of customers to initiate certificate reissues prior to using
     * the API command to help assure that only an authorized person initiates the reissue.
     *
     * @param string
     * @param string reissue email
     * @param array of key => value pairs
     * @return array of strings
     * @access public
     */
    public function Reissue($partnerOrderID, $reissueEmail, $options)
    {
        return $this->send('order', 'Reissue', array(
            'partnerOrderID'    => $partnerOrderID,
            'reissueEmail'      => $reissueEmail,
            'options'           => $options
        ));
    }

    /**
     * The ResendEmail operation allows partners to resend various email messages sent by GeoTrust
     * in the course of processing orders. Certain email types may not apply for a particular order.
     *
     * @param string: ProductCode
     * @param string: PartnerOrderID
     * @param string: Possible values: InviteEmail, ApproverEmail, PickUpEmail, FulfillmentEmail, PhoneAuthEmail
     * @param array of key => value pairs
     * @return array of strings
     * @access public
     */
    public function ResendEmail($productCode, $partnerOrderID, $resendMailType, $options=array())
    {
        return $this->send('order', 'ResendEmail', array(
        		'productCode'     => $productCode,
        		'partnerOrderID'  => $partnerOrderID,
        		'resendMailType'  => $resendMailType,
        		'options'         => $options,
        ));
    }

    /**
     * GeoTrust SSL revoke
     * The following revoke functionality is currently available for GeoTrust certificates only.
     * One of two reasons must be cited when submitting a GeoTrust revocation request via the API.
     *
     * - 'cessation of service' – this revocation request is used when a partner wants to ensure
     * 	non-use of a certificate the end customer has stopped paying for. In this instance,
     *	Symantec verifies the certificate is still live on a server prior to revoking the certificate.
     *
     * - 'key Compromise' – this reason is cited when the certificates private key has been compromised.
     *	Symantec immediately revokes the certificate on approval when this reason is cited in the request.
     *
     * In each case, the request must be confirmed via a link sent in an email to the technical contact.
     *
     * @param string: Certificate
     * @param string: Reason why you are revoking
     * @param array of key => value pairs
     * @return array of strings
     * @access public
     */
    public function Revoke($certificate, $revokeReason, $options=array())
    {
        return $this->send('order', 'Revoke', array(
        		'certificate'     => $certificate,
        		'revokeReason'    => $revokeReason,
        		'options'         => $options,
        ));
    }

    /**
     * Allows partners to validate a number of order fields in one API message. This allows partners to perform
     * validation prior to submitting an order, which provides a better UI experience for users.
     * If any of the fields are invalid, an error will be returned listing all the errors. If there are no errors,
     * the operation will provide responses for many of the values and include additional information.
     * Optionally, the ValidateOrderParameters operation can also be invoked, specifying only the CSR to exclusively test validity of the CSR.
     *
     * @param string Product code
     * @param array of key => value pairs: order parameters
     * @param array of key => value pairs: further optional parameters (add ReplayToken here)
     * @return array of strings
     * @access public
     */
    public function ValidateOrderParameters($productCode, $orderParams, $options=array())
    {
        return $this->send('order', 'ValidateOrderParameters', array(
            'productCode'   => $productCode,
        	'orderParams'   => $orderParams,
        	'options'       => $options,
        ));
    }
}

