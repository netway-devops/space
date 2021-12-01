<?php


class simplepayment extends CreditCardModule implements PaymentAuth_Interface
{
    protected $version      = '2.6';
    protected $modname      = 'Simple Payment';
    protected $description  = 'Simple payment with authorize method';
    
    protected $supportedCurrencies = array('THB','USD');
    protected $lang = array(
        'english' => array('AuthorizeNet_AIMx_login' => 'API Login', 'AuthorizeNet_AIMx_tran_key' => 'Transaction Key', 'CreditCardmd5_hash' => 'MD5 Hash', 'AuthorizeNet_AIMtest_mode' => 'Test Account')
        );
    protected $configuration = array(
        'x_login'    => array('value' => '', 'type' => 'input'),
        'x_tran_key' => array('value' => '', 'type' => 'input'),
        'test_mode'  => array('value' => '1', 'type' => 'check', 'description' => 'Switch this option on if you are using a test account.')
        );
    
    public function __construct()
    {
        parent::__construct();
    }
    
    public function authorize ($ccdetails)
    {
        $this->_postData($ccdetails);
        $results    = PaymentModule::PAYMENT_FAILURE;
        $this->logActivity(array('output' => $this->response, 'result' => $results));
        return array(false, 'Authorization failed');
    }

    public function sendData ($ccdetails)
    {
        $this->_postData($ccdetails);
        $results    = PaymentModule::PAYMENT_FAILURE;
        $this->logActivity(array('output' => $this->response, 'result' => $results));
        return false;
    }

    private function _postData($ccdetails)
    {
        $this->response['STATUS']   = 0;
        $this->response['TRANS_ID'] = 0;
        
        $this->response['MESSAGE']  = $this->response['Error'] = 'Error';
    }

    public function refund ($transaction_number, $amount)
    {
        return false;
    }
    
    public function callback ()
    {
    }

}
