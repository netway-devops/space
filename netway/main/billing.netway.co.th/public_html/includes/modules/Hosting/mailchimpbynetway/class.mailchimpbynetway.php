<?php
/**
 * Module ติดต่อกับ MailChimp API
 * http://apidocs.mailchimp.com/
 */

class mailchimpbynetway extends HostingModule {
    
    protected $modname      = 'MailChimp Email Marketing';
    protected $commands = array(
            'Create', 'Terminate', 'Access'
        );
    protected $options      = array();
    protected $details      = array(
        'domainname'        => array (
            'name'      => 'Domainname',
            'value'     => false,
            'type'      => 'input',
            'default'   => false
        ),
        'api_key'           => array (
            'name'      => 'API Key',
            'value'     => false,
            'type'      => 'input',
            'default'   => false
        ),
        'staff_username'    => array (
            'name'      => 'Staff Username',
            'value'     => false,
            'type'      => 'input',
            'default'   => false
        ),
        'staff_password'    => array (
            'name'      => 'Staff Password',
            'value'     => false,
            'type'      => 'input',
            'default'   => false
        ),
        'client_username'   => array (
            'name'      => 'Client Username',
            'value'     => false,
            'type'      => 'input',
            'default'   => false
        ),
        'client_password'   => array (
            'name'      => 'Client Password',
            'value'     => false,
            'type'      => 'input',
            'default'   => false
        )
        );
    
    public $aConfig;
    public $apiMailchimp;
    
    public function connect ($details)
    {
        
    }
    
    public function getConfig ()
    {
        $this->aConfig      = array(
            'staff_username'        => $this->details['staff_username'],
            'staff_password'        => $this->details['staff_password'],
            'client_username'       => $this->details['client_username'],
            'client_password'       => $this->details['client_password'],
            );
        return $this->aConfig;
    }
    
    public function testConnection ()
    {
        require_once(APPDIR . 'modules/Hosting/mailchimpbynetway/libs/Mailchimp.php');
        
        $apiKey         = isset($this->details['api_key']['value']) ? $this->details['api_key']['value'] : '';
        
        $this->apiMailchimp = new Mailchimp($apiKey);
        
        try {
            $this->apiMailchimp->helper->ping();
        } catch (Mailchimp_Invalid_ApiKey $e) {
            $this->addError('The API key is invalid.');
            return false;
        } catch (Mailchimp_Error $e) {
            if ($e->getMessage()) {
                $this->addError($e->getMessage());
            } else {
                $this->addError('An unknown error occurred');
            }
            return false;
        }
        
        return true;
    }
    
    public function Create ()
    {
        return $this->testConnection();
    }
    
    public function Terminate ()
    {
        return true;
    }
    
    public function Access ()
    {
        if (! $this->testConnection()) {
            return false;
        }
        
        $aDetails       = $this->details;
        $username       = isset($aDetails['staff_username']['value']) ? $aDetails['staff_username']['value'] : '';
        $password       = isset($aDetails['staff_password']['value']) ? $aDetails['staff_password']['value'] : '';
        $domainname     = isset($aDetails['domainname']['value']) ? $aDetails['domainname']['value'] : '';
        $accountId      = isset($_POST['account_id']) ? $_POST['account_id'] : 0;
        
        header ('Content-type: text/html; charset=utf-8'); 
        echo '
        <div align="center">
            <p>
                <form action="https://login.mailchimp.com/login/post/" method="post" target="_blank">
                    <input type="hidden" name="username" value="'. $username .'" />
                    <input type="hidden" name="password" value="'. $password .'" />
                    <input type="submit" {*name="submit"*} value="Access MailChimp&reg; for '. $domainname .' as staff" 
                    style="height: 2em; font-size:2em;" />
                </form>
            </p>
            <p><a href="?cmd=accounts&action=edit&id='. $accountId .'">กลับไปหน้า account detail.</a></p>
        </div>
        ';
        exit;
        
        return true;
    }
}
