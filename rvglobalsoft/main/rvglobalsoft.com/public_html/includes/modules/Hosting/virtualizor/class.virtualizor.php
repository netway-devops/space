<?php

/*
 * http://www.virtualizor.com/wiki/Admin_API
 * http://www.virtualizor.com/wiki/Client_API
 */
require_once HBFDIR_LIBS . 'resty' . DS . 'class.resty.php';

class Virtualizor extends VPSModule {

    public function __construct() {
        parent::__construct();
        
        #licensesnippet#
    }
    protected $modname = 'Virtualizor';
    protected $description = 'Virtualizor provisioning module';
    protected $version = '2.7.5.20160504';
    protected $_repository = "hosting_virtualizor";
    protected $serverFieldsDescription = array(
        'username' => 'Key',
        'password' => 'API Key',
        'field2' => 'User prefix'
    );
    protected $serverFields = array(
        'hostname' => true,
        'ip' => true,
        'maxaccounts' => false,
        'status_url' => false,
        'username' => true,
        'password' => true,
        'hash' => false,
        'ssl' => false,
        'nameservers' => false,
        'field2' => true
    );
    protected $options = array(
        'vpstype' => array(
            'name' => 'type',
            'value' => false,
            'default' => array(
                'openvz',
                'xen',
                'xenhvm',
                'kvm'
            )
        ),
        'vpsplan' => array(
            'name' => 'vpsplan',
            'value' => false,
            'variable' => 'vpsplan',
        ),
        'server' => array(
            'name' => 'server',
            'value' => false,
            'variable' => 'server',
        ),
        'servergroups' => array(
            'name' => 'servergroups',
            'value' => false,
            'variable' => 'servergroups',
        ),
        'disksize' => array(
            'name' => 'disksize',
            'value' => false,
            'variable' => 'disk_size',
        ),
        'cpus' => array(
            'name' => 'cpus',
            'value' => false,
            'variable' => 'cpu_cores',
        ),
        'memory' => array(
            'name' => 'memory',
            'value' => false,
            'variable' => 'memory',
        ),
        'swap' => array(
            'name' => 'swap',
            'value' => false,
            'variable' => 'burstmem',
        ),
        'ips' => array(
            'name' => 'ips',
            'value' => false,
            'variable' => 'ip_address',
        ),
        'portspeed' => array(
            'name' => 'portspeed',
            'value' => false,
            'variable' => 'portspeed',
        ),
        'bandwidth' => array(
            'name' => 'bandwidth',
            'value' => false,
            'variable' => 'bandwidth',
        ),
        'option4' => array(
            'name' => 'ostemplate',
            'value' => false,
            'variable' => 'os',
        ),
        'mediagroup' => array(
            'name' => 'mediagroup',
            'value' => false,
            'variable' => 'mediagroup',
        )
    );
    protected $details = array(
        'option4' => array(
            'name' => 'domain',
            'value' => false,
            'type' => 'input',
            'default' => false
        ),
        'option1' => array(
            'name' => 'username',
            'value' => false,
            'type' => 'input',
            'default' => false
        ),
        'option2' => array(
            'name' => 'password',
            'value' => false,
            'type' => 'input',
            'default' => false
        ),
        'option5' => array(
            'name' => 'rootpassword',
            'value' => false,
            'type' => 'input',
            'default' => false
        ),
        'option6' => array(
            'name' => 'VPS ID',
            'value' => false,
            'type' => 'input',
            'default' => false
        ),
    );
    protected $cache = array();
    protected $api_key;
    protected $api_url;
    protected $api_cookie;
    protected $clientapi_url;

    /**
     * @var Resty
     */
    public $api;
    protected $user_prefix = 'HB';
    protected $plan_default;

    protected function getPlanValue($name, $default = 0) {
        return isset($this->plan_default[$name]) ? $this->plan_default[$name] : $default;
    }

    public function getConfigValue($name) {
        if (isset($this->options[$name])) {
            if (!empty($this->options[$name]['variable'])) {
                if (isset($this->account_config[$this->options[$name]['variable']])) {
                    $config = $this->account_config[$this->options[$name]['variable']];
                    if (isset($config['variable_id']) && !empty($config['variable_id']))
                        return $config['variable_id'];
                    if (isset($config['qty']) && !empty($config['qty']) && $config['qty'] > 1)
                        return $config['qty'];
                    if (isset($config['value']) && !empty($config['value']))
                        return $config['value'];
                }
            }
            $opt = $this->options[$name]['value'];
            if (empty($opt) && $opt !== '0' && isset($this->plan_default[$name]))
                return $this->plan_default[$name];

            return $opt;
        }
        throw new HBException('Configuration error: missing "' . $optname . '"', 1);
    }

    public function connect($connect) {
        //$this->api_keyz = $connect['username'];
        //$this->api_pass = $connect['password'];
        $key = Utilities::generatePassword(8);
        $this->api_key = $key . md5($connect['password'] . $key);
        $this->user_prefix = empty($connect['field2']) ? $this->user_prefix : $connect['field2'];
        $host = !empty($connect['ip']) ? $connect['ip'] : $connect['host'];
        $this->api_url = "https://{$host}:4085";
        $this->clientapi_url = "https://{$host}:4083";

        $this->api = new Resty();
        //$this->api->setBaseURL($this->url);
        $this->api->useCurl(true);
        $this->api->setUserAgent('Softaculous');
        $this->api->setDefaultTimeout(20);
        $this->connection = $connect;
    }

    protected function clientAction($action, $querydata = array()) {
        if (empty($querydata))
            $querydata = array();
        $url = $this->clientapi_url . '/index.php';
        $querydata['act'] = $action;
        $querydata['svs'] = $this->veid;
        $querydata['api'] = 'serialize';
        $querydata['apikey'] = $this->api_key;
        try {
            $result = $this->api->get($url, $querydata);
        } catch (Exception $e) {
            $this->addError($e->getMessage());
            return false;
        }
        $respone = $this->parseResponse($result);
        if ($respone) {
            return $respone;
        }
        return false;
    }

    protected function get($action, $querydata = array(), $silently = false) {
        if (empty($querydata) || !is_array($querydata))
            $querydata = array();
        $url = $this->api_url . '/index.php';
        $querydata['act'] = $action;
        $querydata['api'] = 'serialize';
        $querydata['apikey'] = $this->api_key;
        try {
            $result = $this->api->get($url, $querydata, array('Cookie' => $this->api_cookie));
        } catch (Exception $e) {
            $this->addError($e->getMessage());
            return false;
        }
        $respone = $this->parseResponse($result, $silently);
        if ($respone) {
            return $respone;
        }
        return false;
    }

    protected function post($action, $querydata = false, $silently = false) {
        $url = $this->api_url . '/index.php?act=' . $action . '&api=serialize&apikey=' . rawurlencode($this->api_key);
        try {
            $result = $this->api->post($url, $querydata, array('Cookie' => $this->api_cookie));
        } catch (Exception $e) {
            $this->addError($e->getMessage());
            return false;
        }
        $respone = $this->parseResponse($result, $silently);
        if ($respone) {
            return $respone;
        }
        return false;
    }

    protected function parseResponse($resp, $silently = false) {
        if (empty($resp) || empty($resp['body'])) {
            if (!$silently) {
                $this->addError('No response from server');
            }
            return false;
        }

        $resp['body_raw'] = $resp['body'];
        $resp['body'] = @unserialize($resp['body_raw']);
        if (empty($resp['body'])) {
            $resp['body'] = preg_replace('!s:(\d+):"(.*?)";!se', "'s:'.strlen('$2').':\"$2\";'", $resp['body_raw']);
            $resp['body'] = @unserialize($resp['body']);
        }

        if (empty($resp['body'])) {
            if (!$silently) {
                if (strstr($resp['body_raw'], 'password')) {
                    $this->addError('Api key invalid');
                }
                $this->addError('Invalid response from server');
            }
            return false;
        }
        if (!$silently && !empty($resp['body']['error'])) {
            if (is_array($resp['body']['error']))
                foreach ($resp['body']['error'] as $error) {
                    $this->addError($error);
                } else
                $this->addError($resp['body']['error']);
        }
        return $resp['body'];
    }

    public function testConnection() {
        $server = $this->get('servers');
        return !empty($server);
    }

    public function Install() {
        
    }

    public function upgrade($old_version) {
        
    }

    public function Create($vm) {

        $server = $this->getConfigValue('server');
        $servergroup = $this->getConfigValue('servergroup');
        $ostemplate = $this->getConfigValue('option4');
        
        $this->details['option5']['value'] = empty($this->details['option5']['value']) ?
                (empty($this->details['option2']['value']) ? Utilities::generatePassword() : $this->details['option2']['value']) : $this->details['option5']['value'];

        $virttype = $this->getConfigValue('vpstype');
        $this->plan_default = $this->getPlan($this->getConfigValue('vpsplan'), $virttype);

        $data = $this->get('addvs', array(), true);

        if (isset($servergroup) && $servergroup >= 0) {
            $groups = $this->getServerGroups($data);
            $sgtmp = null;
            foreach ($groups as $k => $v) {
                if ($v['id'] == $servergroup) {
                    $sgtmp = $v;
                    break;
                }
            }
            if (empty($sgtmp))
                $servergroup = false;
        }else {
            $servergroup = false;
        }

        $servers = $this->getServers($virttype, $data);
        if (!empty($server)) {
            if (!is_array($server))
                $server = array($server);
            $server = array_map('strtolower', $server);
        }else {
            $server = array();
            foreach ($servers[$virttype] as $v)
                $server[] = $v['id'];
        }

        $tmpsort = array();
        $reject = array();
        
        foreach ($servers[$virttype] as $k => $v) {
            if ($servergroup && $v['sgid'] != $servergroup)
                continue;

            if (!in_array('auto-assign', $server) && !in_array($v['id'], $server)) {
                continue;
            }
            
            if(isset($v['locked']) && $v['locked'] == '1'){
                $reject[$v['id']] = "Server is locked";
            }
            
            // Master servers cannot be here
            $req_ram = $this->getConfigValue('memory');
           // $v['ram'] = $v['total_ram']  - $v['alloc_ram']; //  returned $v['ram'] is strange
            // overselling is possible w. virtualizor.
            $v['space'] = $v['total_space'] - $v['alloc_space']; // space was ok, added just to be sure

            if ($v['ram'] < $req_ram){
                $reject[$v['id']] = "Low memory, $req_ram required, {$v['ram']} available";
                continue;
            }
 
            $req_space = $this->getConfigValue('disksize');
            if (isset($v['space']) && $v['space'] < $req_space){
                $reject[$v['id']] = "Low disk space, $req_space required, {$v['space']} available";
                continue;
            }

            $tmpsort[$k] = $v['numvps'];
        }


        // Did we get a list of Slave Servers
        if (empty($tmpsort)) {
            if(!empty($reject)){
                $this->addError('No server with sufficient resources. ' . $virttype . ( $servergroup ? ', server group: ' . $sgtmp['name'] : ''));
            }else{
                $this->addError('No server found for virtualization type: ' . $virttype . ( $servergroup ? ', server group: ' . $sgtmp['name'] : ''));
            }
            return false;
        }
        asort($tmpsort);
        $tmpsort = array_keys($tmpsort);
        while(true){
            $tmp = array_shift($tmpsort);
            $server = $servers[$virttype][$tmp];
            // Is there a valid slave server ?
            if (empty($server)) {
                $this->addError('Available servers reached vm limit. Please correct configuration with the right server/group');
                return false;
            }
            
            $this->api_cookie = $data['globals']['cookie_name'] . '_server=' . $server['id'];
            $srvdata = $this->get('config_slave');

            if($srvdata['info']['is_master_only'] || ($srvdata['info']['vpslimit'] > 0 && $server['numvps'] + 1 > $srvdata['info']['vpslimit'])){
                continue;
            }
            break;
        }
        
        
        $post = array();
        if(is_array($this->plan_default))
            $post = $this->plan_default;
        
        /*
         * Plan id - doesnt work like in solus, empty values do not default to plan values
         * $post['plid'] = $this->getConfigValue('vpsplan');
         */
        
        // Search does the user exist
        //$data = $this->post('users', array('search' => true, 'email' => $this->client_data['email']));
        foreach ($data['users'] as $k => $v) {
            if (strtolower($v['email']) == strtolower($this->client_data['email'])) {
                $post['uid'] = $v['uid'];
            }
        }

        // Was the user there ?
        if (empty($post['uid'])) {
            $post['user_email'] = $this->client_data['email'];
            $post['user_pass'] = $this->details['option2']['value'];
        }

        // Search the OS ID
        $oslist = $this->getOSTemplates($virttype, $data);
        foreach ($oslist[$virttype] as $k => $v) {
            if ($v['id'] == $ostemplate) {
                $post['osid'] = $v['id'];
                //$post['iso'] = $vv;
                break;
            }
        }

        // Is the OS template there
        if (empty($post['osid'])) {

            $this->addError('Could not find the OS Template');
            return false;
        }

        $numips = $this->getConfigValue('ips');
        $post['ipv6count'] = $this->getPlanValue('ips6', 0);
        // Assign the IPs
        if ($numips || $post['ipv6count']) {
            $freeips = $this->getFreeIps();
            $post['ips'] = array();
            foreach ($freeips['v4'] as $k => $v) {
                if ($numips == count($post['ips'])) {
                    break;
                }
                $post['ips'][] = $v['ip'];
            }

            $post['ipv6'] = array();
            foreach ($freeips['v6'] as $k => $v) {
                if ($post['ipv6count'] == count($post['ipv6'])) {
                    break;
                }
                $post['ipv6'][] = $v['ip'];
            }

            // Were there enough IPs
            if (count($post['ips']) < $numips) {
                $this->addError('There are insufficient IPs on the server');
                return false;
            }
            if (count($post['ipv6']) < $post['ipv6count']) {
                $this->addError('There are insufficient IPv6 on the server');
            }
        }
        $post['ips6_subnet'] = $this->getPlanValue('ips6_subnet', 0);
        if($post['ips6_subnet'] > 0){
            $freeSubs = $this->getFreeSubnets();
            $subnets = array();
            
            foreach ($freeSubs['v6'] as $k => $v) {
                if ($post['ips6_subnet'] == count($subnets)) {
                    break;
                }
                $subnets[] = $v['ip'];
            }
            
            // Were there enough IPs
            if (count($subnets) < $post['ips6_subnet']) {
                $this->addError('Insufficient number of IPv6 Subnets');
                return false;
            }
            $post['ipv6_subnet'] = $subnets;
        }

        $post['hostname'] = Utilities::translate2Ascii($this->details['option4']['value']);
        $post['rootpass'] = $this->details['option5']['value'];

        $post['space'] = $this->getConfigValue('disksize');
        $post['ram'] = $this->getConfigValue('memory');
        $post['bandwidth'] = $this->getConfigValue('bandwidth');
        $post['cores'] = $this->getConfigValue('cpus');
        $post['network_speed'] = $this->getConfigValue('portspeed');

        $post['addvps'] = 1;


        // Is is OpenVZ
        if ($virttype == 'openvz') {
            $post['burst'] = $this->getConfigValue('swap');

            $post['cpu'] = $this->getPlanValue('cpu', 256);
            $post['cpu_percent'] = $this->getPlanValue('cpu_percent', 0);
            $post['priority'] = $this->getPlanValue('io', 3);
        } elseif ($virttype == 'xen') {
            $post['swapram'] = $this->getConfigValue('swap');
            $post['vnc'] = 1;
            $post['cpu'] = $this->getPlanValue('cpu', 256);
            $post['vncpass'] = $this->details['option5']['value'];
        } elseif ($virttype == 'xenhvm') {
            $post['hvm'] = $this->getPlanValue('hvm', 1);
            $post['cpu'] = $this->getPlanValue('cpu', 256);
            $post['shadow'] = $this->getPlanValue('shadow', 8);

            $post['swapram'] = $this->getConfigValue('swap');
            $post['vnc'] = 1;
            $post['vncpass'] = $this->details['option5']['value'];
        } elseif ($virttype == 'kvm') {
            $post['swapram'] = $this->getConfigValue('swap');
            $post['vnc'] = 1;
            $post['vncpass'] = $this->details['option5']['value'];
        }

        $ret = $this->post('addvs', $post);

        if (!empty($ret['newvs']['vpsid'])) {

            // vpsid of virtualizor
            $this->veid = (int) $ret['newvs']['vpsid'];
            $this->details['option6']['value'] = $this->veid;

            $this->vpstype = $virttype == 'xen' ? 'Xen' : ($type == 'xenhvm' ? 'Xen HVM' : ($type == 'openvz' ? 'OpenVZ' : ($type == 'kvm' ? 'KVM' : 'Other')));
            $this->ostemplate = isset($ret['ostemplates'][$ostemplate]) ? $ret['ostemplates'][$ostemplate]['name'] : $ostemplate;

            $this->details['option5']['value'] = $this->rootpswd = (string) $ret['newvs']['pass'];
            $this->mainIP = (string) array_shift($ret['newvs']['ips']);
            $this->additionalIP = $ret['newvs']['ips'];

            if (!empty($ret['newvs']['space']))
                $this->disk_limit = (int) $ret['newvs']['space'];

            if (!empty($ret['newvs']['bandwidth']))
                $this->bw_limit = (int) $ret['newvs']['bandwidth'];

            if (!empty($ret['newvs']['ram']))
                $this->guaranteed_ram = (int) $ret['newvs']['ram'];

            if (!empty($ret['newvs']['burst']))
                $this->burstable_ram = (int) $ret['newvs']['burst'];
            return true;
        }
        $this->addError('Failed to deploy vps');
        return false;
    }

    protected function getPlan($id, $virttype) {
        if (!$id)
            return array();

        $data = $this->get('editplan', array(
            'plid' => $id
                ), true);
        
        if ($data['plan']) {
            $tmp = $data['plan'];
            $tmp = array_merge($tmp, array(
                'disksize' => $tmp['space'],
                'memory' => $tmp['ram'],
                'bandwidth' => $tmp['bandwidth'],
                'cpus' => $tmp['cores'],
                'portspeed' => $tmp['network_speed'],
                'swap' => $virttype == 'openvz' ? $tmp['burst'] : $tmp['swap'],
            ));
            
            $tmp = array_filter($tmp, function($in){
                return $in !== '0'; 
            });
            
            return $tmp;
        }
        return array();
    }

    public function ChangePackage() {

        return false;
    }

    public function Suspend() {
        $ret = $this->post('vs', array('suspend' => $this->veid));
        if (!empty($ret['done'])) {
            return true;
        }
        if (empty($ret) || empty($ret['error'])) {
            $ret = $this->get('editvs', array('vpsid' => $this->veid));
            if ($ret['vps']['suspended'] == "1")
                return true;
        }

        return false;
    }

    public function Unsuspend() {
        $ret = $this->post('vs', array('unsuspend' => $this->veid));
        if (!empty($ret['done'])) {
            return true;
        }
        if (empty($ret) || empty($ret['error'])) {
            $ret = $this->get('editvs', array('vpsid' => $this->veid));
            if ($ret['vps']['suspended'] == "0")
                return true;
        }
        return false;
    }

    public function Terminate() {

        $this->setClientDetails($this->account_details['client_id']);
        //$data = $this->clientAction('listvs');
//        $data = $this->post('users', array('search' => true, 'email' => $this->client_data['email']));
//        foreach ($data['users'] as $k => $v) {
//            if (strtolower($v['email']) == strtolower($this->client_data['email'])) {
//                $ret = $this->get('users', array('delete' => $v['uid']));
//            }
//        }
//        Found no reliable way to list user vms, both commands return 0 vs

        $ret = $this->post('vs', array('delete' => $this->veid));
        if (!empty($ret['done'])) {
            return true;
        }
        return false;
    }

    public function PowerON() {
        $data = $this->clientAction('start', array('do' => '1'));
        return !empty($data);
    }

    public function PowerOff() {
        $data = $this->clientAction('stop', array('do' => '1'));
        return !empty($data);
    }

    public function Reboot() {
        $data = $this->clientAction('restart', array('do' => '1'));
        return !empty($data);
    }

    public function Reinstall($image_id) {
        /* $data = $this->clientAction('ostemplate', array(
          'newos' => $image_id,
          'newpass' => $this->details['option2']['value'],
          'conf' => $this->details['option2']['value'],
          'reinsos' => 'Reinstall'
          )); */

        $vm = $this->getUserVM();

        $data = $this->get('addvs');
        $this->api_cookie = $data['globals']['cookie_name'] . '_server=' . $vm['serid'];

        $params = array(
            'vpsid' => (string) $this->veid,
            'osid' => $image_id,
            'newpass' => $this->details['option2']['value'],
            'conf' => $this->details['option2']['value'],
            'serid' => $vm['serid'],
            'reos' => 1,
        );
        $data = $this->post('rebuild', $params);
        return !empty($data) && empty($data['error']);
    }

    public function Synchronize($db = true, $id = false) {
        
    }

    public function getOSTemplates($types = 'all', $data = array()) {
        if (empty($data['ostemplates']))
            $data = $this->get('ostemplates');

        if ($types == 'all')
            $types = array('openvz', 'xen', 'xenhvm', 'kvm');
        elseif (!is_array($types))
            $types = array($types);
        $tmp = $tpl = array();
        foreach ($data['ostemplates'] as $osid => $os) {
            if(empty($os['osid']))
                $os['osid'] = $osid;
            
            $os['id'] = $os['osid'];
            if ($os['type'] == 'xen' && $os['hvm'] == 1)
                $os['type'] = 'xenhvm';
            $tmp[$os['type']][] = $os;
        }
        foreach ($types as $type)
            $tpl[$type] = $tmp[$type];
        return $tpl;
    }

    public function getPlans($types = 'all') {
        $data = $this->get('plans');

        if ($types == 'all')
            $types = array('openvz', 'xen', 'xenhvm', 'kvm');
        elseif (!is_array($types))
            $types = array($types);

        $tmp = $plans = array();
        foreach ($data['plans'] as $plan) {
            $plan['id'] = $plan['plid'];
            $plan['name'] = $plan['plan_name'];
            if ($plan['virt'] == 'xen')
                $tmp['xenhvm'][] = $plan;
            $tmp[$plan['virt']][] = $plan;
        }
        foreach ($types as $type)
            $plans[$type] = $tmp[$type];
        return $plans;
    }

    public function getServers($type = 'all', $data = array()) {
        if (empty($data['servers']))
            $data = $this->get('servers');

        if ($type == 'all')
            $types = array('openvz', 'xen', 'xenhvm', 'kvm');
        elseif (!is_array($type))
            $types = array($type);
        else
            $types = $type;
        $tmp = $servers = array();

        foreach ($data['servers'] as $server) {
            $server['id'] = $server['serid'];
            $server['name'] = $server['server_name'];
            if ($server['virt'] == 'xen' && $server['hvm'] == 1) {
                $tmp['xenhvm'][] = $server;
                $tmp[$server['virt']][] = $server;
            } else
                $tmp[$server['virt']][] = $server;
        }
        foreach ($types as $type)
            $servers[$type] = $tmp[$type];
        return $servers;
    }

    public function getServerGroups($data = array()) {
        if (empty($data['servergroups']))
            $data = $this->get('servergroups');

        foreach ($data['servergroups'] as $k => $g) {
            $g['id'] = $g['sgid'];
            $g['name'] = $g['sg_name'];
            $data['servergroups'][$k] = $g;
        }
        return $data['servergroups'];
    }

    public function getFreeSubnets() {
        $page = 1;
        $collection = array();
        while (1) {
            $data = $this->get('ipranges', array('page' => $page));
            $page++;
            if (!$data || empty($data['ips']))
                break;
            $collection = array_merge($collection, $data['ips']);
        }
        $tmp = array(
            'v4' => array(),
            'v6' => array()
        );
        foreach ($collection as $k => $g) {
            if ($g['vpsid'] != 0)
                continue;
            $g['id'] = $g['ipid'];
            $tmp[($g['ipv6'] == '1' || stripos($g['ip'], ':') !== false) ? 'v6' : 'v4'][] = $g;
        }
        return $tmp;
    }
    
    public function getFreeIps() {
        $page = 1;
        $collection = array();
        while (1) {
            $data = $this->get('ips', array('page' => $page));
            $page++;
            if (!$data || empty($data['ips']))
                break;
            $collection = array_merge($collection, $data['ips']);
        }
        $tmp = array(
            'v4' => array(),
            'v6' => array()
        );
        foreach ($collection as $k => $g) {
            if ($g['vpsid'] != 0)
                continue;
            $g['id'] = $g['ipid'];
            $tmp[($g['ipv6'] == '1' || stripos($g['ip'], ':') !== false) ? 'v6' : 'v4'][] = $g;
        }
        return $tmp;
    }

    public function getUserVM() {
        $vms = array();
        $data = $this->get('editvs', array('vpsid' => $this->veid));

        if (!empty($data['vps'])) {
            $vms = $data['vps'];
            $vms['server'] = $data['servers'][$vms['serid']];
            $vms['os'] = $data['ostemplates'][$vms['osid']];

            $data = $this->get('vs', array('vs_status' => $this->veid));
            $vms['status'] = 'off';

            if (!empty($data['status']) && $data['status'][$this->veid]["status"] == 1)
                $vms['status'] = 'active';
        } else
            $this->addError('Virtual server not found');
        return $vms;
    }

    public function getConsoleInfo() {
        $data = $this->clientAction('vnc', array('launch' => 1));
        if ($data)
            return $data['info'];
        return false;
    }

    public function prepareDetails($details) {
        parent::prepareDetails($details);
        if (!empty($details['option6']))
            $this->veid = $details['option6'];
    }

    public function addVeid($veid) {
        $this->veid = empty($this->veid) ? $veid : $this->veid;
    }

}
