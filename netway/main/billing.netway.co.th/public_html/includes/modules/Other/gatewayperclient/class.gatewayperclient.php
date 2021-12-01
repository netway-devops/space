<?php

/**
 * Class gatewayperclient
 * HostBill plugin / other module / app
 *
 * @author HostBill Module Generator <cs@hostbillapp.com>
 */
class gatewayperclient extends OtherModule implements Observer
{

    use \Components\Traits\LoggerTrait;

    const ALL_COUNTRIES = '0ALL';
    /**
     * Module version. Make sure to increase version any time you add some
     * new functions in this class!
     * @var string
     */
    protected $version = '13.2021-09-22';

    /**
     * Module name, visible in admin portal.
     * @var string
     */
    protected $modname = 'Gateway Per Client';


    /**
     * Module description, visible in admin portal
     * @var string
     */
    protected $description = 'Allows staff to select which gateways customer will have access to. Allow to select gateways that will be available to user who\'s order was marked as fraud. 
    Give ability to pay for fraud order. Module requires enabled queue.';



    /**
     * Module info array - HostBill uses it to determine what features module offer.
     * @var array
     */
    protected $info = array(
        'haveadmin' => true,
        'havetpl' => true,
        'isobserver' => true,
        'extras_menu' => true
    );


    /**
     * @var string
     */
    protected $_repository = 'plugin_gatewayperclient';

    /**
     * @var bool
     */
    public $invoice_id = false;

    /**
     * @var bool
     */
    public $order_id = false;

    /**
     * HostBill will auto-propagate values for this configuration before calling any method from module
     * @var array
     */
    protected $configuration = [
        'Gateways for fraud order' => [
            'value' => '', //this will auto-load from db
            'description' => 'Gateways selected here will be available to customer who made fraud order',
            'type' => 'checklist',
            'default' => [],
        ],
        'Allow pay for fraud order' => [
            'value' => '', //this will auto-load from db
            'description' => 'If customer made fraud order invoice is canceled. With this option enabled customer will have option to pay for it using gateways from list above',
            'type' => 'check',
            'default' => '',
        ],
        'Redirect to invoice after fraud with alert message' => [
            'value' => '', //this will auto-load from db
            'description' => 'Redirect to invoice after fraud with alert message',
            'type' => 'check',
            'default' => '',
        ],
        'Hide the alert message after choosing certain payment gateways' => [
            'value' => '', //this will auto-load from db
            'description' => 'Hide a message about a fraud order after redirection if the client has chosen the payment gateway that is on the list above in this module',
            'type' => 'check',
            'default' => '',
        ],
        'Ignore redirect to invoice and redirect to payment gateway after choosing certain payment gateways' => [
            'value' => '', //this will auto-load from db
            'description' => 'Redirect to payment gateway after choosing certain payment gateways. Redirect to invoice will be ignored',
            'type' => 'check',
            'default' => '',
        ],
        'Limit initial set of gateways' => [
            'value' => '', //this will auto-load from db
            'description' => 'When enabled, unregistered and new customers will see only a subset (selected below) of gateways available. Once customer is trusted you can add more gateway in his profile',
            'type' => 'check',
            'default' => '',
        ],
        'Initial set of gateways' => [
            'value' => '', //this will auto-load from db
            'description' => 'Gateways selected here will be available to new customers',
            'type' => 'checklist',
            'default' => [],
        ],
    ];

    /**
     * gatewayperclient constructor.
     */
    public function __construct()
    {
        parent::__construct();

        $gateways = ModuleFactory::singleton()->getPaymentModules(false, true);
        foreach ($gateways as $gtw) {
            $this->configuration['Gateways for fraud order']['default'][] = $gtw;
            $this->configuration['Initial set of gateways']['default'][] = $gtw;
        }
    }


    /**
     *
     */
    public function install()
    {
        $this->db->exec("
            REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
            SELECT id, 'clientarea', 'gatewayperclient_fraud_message', 'We are sorry but our system has detected that this order is fraud. You can still pay for your order, however, using a limited number of payment gateways.' FROM hb_language WHERE target='user';");

        $this->upgrade('12.2019-09-10');
    }

    /**
     * @param $ver
     */
    public function upgrade($ver)
    {
        $this->db->exec("REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
            SELECT id, 'clientarea', 'gatewayperclient_fraud_message', 'We are sorry but our system has detected that this order is fraud. You can still pay for your order, however, using a limited number of payment gateways.' FROM hb_language WHERE target='user';");

        if (version_compare($ver, '12.2019-09-11', '<')) {
            try {
                $this->db->exec("
                    CREATE TABLE IF NOT EXISTS `hb_gateway_config` (
                     `id` INT(11) NOT NULL AUTO_INCREMENT,
                     `type` ENUM('product', 'cycle', 'country') DEFAULT 'product',
                     `items` TEXT,
                     `gateways` TEXT,
                     PRIMARY KEY(`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;");
            } catch (Exception $ex) {
                //
            }
        }
        if (version_compare($ver, '12.2019-10-17', '<')) {
            try {
                $this->db->exec("
                    ALTER TABLE `hb_gateway_config` CHANGE `type` `type` ENUM('group', 'product', 'cycle', 'country') DEFAULT 'product';");
            } catch (Exception $ex) {
                //
            }
        }
        if (version_compare($ver, '13.2020-11-10', '<')) {
            try {
                $this->db->exec("
                    ALTER TABLE `hb_gateway_config` CHANGE `type` `type` ENUM('group', 'product', 'cycle', 'country','cart') DEFAULT 'product';");
            } catch (Exception $ex) {
                //
            }
        }


    }

    /**
     * @param $client_id
     * @param $all
     * @param array $list
     */
    public function saveGateways($client_id, $all, $list = [])
    {
        if ($all)
            $gtw = 'all';
        else
            $gtw = json_encode($list);

        HBConfig::setConfig("Gateways_" . $client_id, $gtw, true);
        if (Engine::getType() == 'admin') {
            $this->addInfo("Gateway list saved");
        }
    }

    /**
     * @return array
     */
    public function getProducts()
    {
        $q = $this->db->prepare('SELECT p.id, p.name, p.category_id, pc.name as category_name
            FROM  hb_products p
            LEFT JOIN hb_categories pc ON pc.id = p.category_id ORDER BY pc.name, p.name');
        $q->execute(array());
        $products = $q->fetchAll(PDO::FETCH_ASSOC);
        $return = [];
        foreach ($products as $product) {
            if (!isset($return[$product['category_id']]))
                $return[$product['category_id']]['name'] = $product['category_name'];
            $return[$product['category_id']]['products'][] = $product;
        }
        return $return;
    }

    /**
     * @param $data
     * @return bool
     */
    public function addConfig($data)
    {
        try {
            $query = $this->db->prepare("INSERT INTO hb_gateway_config (`type`,`items`, `gateways`) VALUES (?, ?, ?)");
            $query->execute(array(
                $data['type'],
                serialize($data['items']),
                serialize($data['gateways']),
            ));
            $query->closeCursor();
            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * @param $type
     * @return array
     */
    public function listConfigs($type)
    {
        $configs = $this->getConfigs($type);

        switch ($type) {
            case 'group':
                $cg = HBLoader::LoadModel('Clients/ClientGroup');
                foreach ($configs as $key => &$config) {
                    $config['groups'] = $config['items'];
                    foreach ($config['groups'] as $group) {
                        $config['_groups'][] = $cg->getGroup($group);
                    }
                }
                break;
            case 'product':
                foreach ($configs as $key => &$config) {
                    $config['products'] = $config['items'];
                    $products = array_filter($config['products'], function ($v) {
                        return (int)$v > 0;
                    });
                    if (!empty($products)) {
                        $ids = implode(',', array_fill(0, count($products), '?'));
                        $q = $this->db->prepare("
                        SELECT p.id, p.name, p.category_id, pc.name as category_name
                        FROM hb_products p
                        LEFT JOIN hb_categories pc ON pc.id = p.category_id
                        WHERE p.id IN (" . $ids . ")");
                        $q->execute(array_values($products));
                        $results = $q->fetchAll(PDO::FETCH_ASSOC);
                        $q->closeCursor();


                        foreach ($results as $result) {
                            $result['category_name'] = Language::parse($result['category_name']);
                            $result['name'] = Language::parse($result['name']);
                            $result['type'] = 'product';
                            $config['_products'][] = $result;
                        }
                    }

                    $categories = array_filter($config['products'], function ($v) {
                        return (int)$v < 0;
                    });
                    $categories = array_map("abs", $categories);
                    if (!empty($categories)) {
                        $ids = implode(',', array_fill(0, count($categories), '?'));
                        $q = $this->db->prepare("SELECT pc.id, pc.name
                        FROM hb_categories pc 
                        WHERE pc.id IN ($ids)");
                        $q->execute(array_values($categories));
                        $results = $q->fetchAll(PDO::FETCH_ASSOC);
                        foreach ($results as $result) {
                            $result['name'] = Language::parse($result['name']);
                            $result['type'] = 'category';
                            $config['_products'][] = $result;
                        }
                    }
                }


                break;

            case 'cycle':
                foreach ($configs as $key => &$config) {
                    $config['cycles'] = $config['items'];
                    foreach ($config['cycles'] as $cycle) {
                        $config['_cycles'][] = Utilities::translateCycle($cycle);
                    }
                }
                break;

            case 'country':
                foreach ($configs as $key => &$config) {
                    $config['countries'] = $config['items'];
                    foreach ($config['countries'] as $country) {
                        $config['_countries'][] = $country === self::ALL_COUNTRIES ? 'All Countries' :  Utilities::get_country_name($country);
                    }
                }
                break;
        }
        foreach ($configs as $key => &$config) {
            $ids = implode(',', array_fill(0, count($config['gateways']), '?'));
            $q = $this->db->prepare("SELECT * FROM hb_modules_configuration mc
                        WHERE type = 'Payment'
                        AND mc.id IN ($ids)");
            $q->execute($config['gateways']);
            $results = $q->fetchAll(PDO::FETCH_ASSOC);
            foreach ($results as $result) {
                $config['_gateways'][] = [
                    'id' => $result['id'],
                    'name' => $result['modname'],
                ];
            }
        }
        return $configs;
    }

    /**
     * @param bool $type
     * @return array
     */
    public function getConfigs($type = false)
    {
        if ($type !== false && !in_array($type, ['group', 'product', 'cycle', 'country','cart']))
            return [];

        $sql = 'SELECT * FROM hb_gateway_config ';
        if ($type !== false)
            $sql .= ' WHERE type = ?';

        $q = $this->db->prepare($sql);
        $q->execute($type !== false ? [$type] : []);
        $configs = $q->fetchAll(PDO::FETCH_ASSOC);
        if (empty($configs))
            return [];

        foreach ($configs as $key => &$config) {
            $config['gateways'] = unserialize($config['gateways']);
            $config['items'] = unserialize($config['items']);
        }
        return $configs;
    }

    /**
     * Removes configuration.
     * @param $id
     * @return bool
     */
    public function removeConfig($id)
    {
        try {
            $query = $this->db->prepare("DELETE FROM hb_gateway_config WHERE `id` = ?");
            $query->execute(array($id));
            $query->closeCursor();
            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * @param $details
     */
    public function after_fraudneworder($details)
    {
        if (!$this->configuration['Allow pay for fraud order']['value'])
            return;

        $q = $this->db->prepare("SELECT client_id,invoice_id FROM hb_orders WHERE id =? LIMIT 1");
        $q->execute([$details['order_id']]);
        $d = $q->fetch(PDO::FETCH_ASSOC);
        $q->closeCursor();
        if (empty($d))
            return;
        $client_id = $d['client_id'];
        $order_id = $details['order_id'];

        $gateways = ModuleFactory::singleton()->getPaymentModules(false, true);
        $selected = $this->configuration['Gateways for fraud order']['value'];

        if (!$selected) {
            $this->saveGateways($client_id, false, []);
            return;
        } else {
            $gateways = array_intersect($gateways, $selected);
            $gateways = array_combine(array_keys($gateways), array_keys($gateways));
            $this->saveGateways($client_id, false, $gateways);
        }

        //unlock and mark invoice for payment
        HBConfig::storeSetting($order_id, 'gtwprcl:order:' . $client_id);
        HBConfig::storeSetting($details['gateway'], 'gtwprcl:gateway:' . $client_id);
    }

    /**
     * @param Template $tpl
     * @throws RedirectInterrupt
     */
    public function before_display(Template $tpl)
    {
        $client_id = HBConfig::getSetting('login')['id'];
        HBConfig::deleteSetting("Gateways_" . $client_id);
        $order_id = HBConfig::getSetting('gtwprcl:order:' . $client_id);
        if ($order_id) {
            $gateway_id = HBConfig::getSetting('gtwprcl:gateway:' . $client_id);
            HBConfig::deleteSetting('gtwprcl:order:' . $client_id);
            $this->enableInvoice(false, $order_id);

            if ($this->configuration['Redirect to invoice after fraud with alert message']['value'] == '1') {
                $alert = true;
                if ($this->configuration['Hide the alert message after choosing certain payment gateways']['value'] == '1') {
                    $gateways = ModuleFactory::singleton()->getPaymentModules(false, true);
                    $gateway = $gateways[$gateway_id];
                    if ($gateway !== null) {
                        $module_gateways = $this->configuration['Gateways for fraud order']['value'];
                        $alert = (array_search($gateway, $module_gateways) === false ? true : false);
                    }
                }
                if ($alert) {
                    HBConfig::storeSetting(true, 'gtwprcl:showalert:' . $client_id);
                } elseif (!$alert && $this->configuration['Ignore redirect to invoice and redirect to payment gateway after choosing certain payment gateways']['value'] == '1') {
                    $invoice_id = $this->getInvoiceByOrder($order_id);
                    $_SESSION['Checkout']['invoice_id'] = (int)$invoice_id;
                    Utilities::redirect('?cmd=cart&step=5', false);
                }
            }
            Utilities::redirect('?cmd=clientarea&action=invoice&id=' . $this->invoice_id);
        }
    }


    /**
     * @param $list
     * @return array
     */
    public function before_gatewaylist(&$list)
    {

        $existing = $list;

        if (HBF_TYPE != 'user')
            return $list;

        $login = HBConfig::getSetting('login');
        $client_id = $login['id'];
        if ($client_id) {
            $client_id = $login['id'];
            $client_gateways = HBConfig::getConfig("Gateways_" . $client_id);
            if ($client_gateways && $client_gateways != 'all') {
                $list = array_intersect_key($list, json_decode($client_gateways, true));
                return $list;
            }
        }

        $groups = $products = $categories = $cycles = $gateways = [];
        $r = RequestHandler::singleton();

        if ($client_id && $login['group_id'] != 0) {
            $groups[] = $login['group_id'];
        }

        $stop = false;

        if ($client_id && $r->getController() == 'clientarea' && $r->getAction() == 'invoice') {
            $params = $r->getParams();
            $invoice_id = isset($params['id']) ? $params['id'] : false;
            if (!$invoice_id)
                $invoice_id = isset($params['path_info'][2]) && is_numeric($params['path_info'][2]) ? $params['path_info'][2] : false;

            if ($invoice_id) {
                $invoice = Invoice::createInvoice($invoice_id, Invoice::VIEW_ONLY_MODE);
            }
            if ($invoice->getInvoiceId() && $client_id == $invoice->getClientId()) {
                foreach ($invoice->getInvoiceItems() as $iitem) {
                    if (!$iitem['type'] || !$iitem['item_id'])
                        continue;

                    switch ($iitem['type']) {
                        case HBC\DOMAIN\RENEW:
                        case HBC\DOMAIN\REGISTER:
                        case HBC\DOMAIN\TRANSFER:
                        case HBC\TYPE\DOMAIN:
                            $q = $this->db->prepare('SELECT tld_id FROM hb_domains WHERE id = ? LIMIT 1');
                            $q->execute([$iitem['item_id']]);
                            $d = $q->fetch(PDO::FETCH_ASSOC);
                            if (!$d) continue;
                            $products[] = $d['tld_id'];
                            break;

                        case HBC\TYPE\HOSTING:
                            $q = $this->db->prepare('SELECT ac.product_id, pc.id as category_id, ac.billingcycle 
                                    FROM hb_accounts ac 
                                    LEFT JOIN hb_products pr ON ac.product_id = pr.id
                                    LEFT JOIN hb_categories pc ON pr.category_id = pc.id
                                    WHERE ac.id = ? LIMIT 1');
                            $q->execute([$iitem['item_id']]);
                            $d = $q->fetch(PDO::FETCH_ASSOC);
                            if (!$d) continue;

                            $products[] = $d['product_id'];
                            $categories[] = $d['category_id'] * -1;
                            $cycles[] = Utilities::translateCycle($d['billingcycle'], true);
                            break;
                    }
                }
            }
        }

        if (!$stop && $r->getController() == 'cart') {
            $multicart = HBConfig::getConfig("ShopingCartMode") == '1';
            if ($multicart) {
                $cart = HBConfig::getSetting('Cart');
                foreach ($cart as $cartitem) {
                    $products[] = $cartitem['product']['id'];
                    $categories[] = $cartitem['product']['category_id'] * -1;
                    $cycles[] = $cartitem['product']['recurring'];
                }
            } else {
                $cart = $_SESSION['Cart'][1];
                $products[] = $cart['id'];
                $categories[] = $cart['category_id'] * -1;
                $cycles[] = $cart['recurring'];
            }
        }

        $groups = array_map('intval', array_unique($groups));
        $categories = array_map('intval', array_unique($categories));
        $products = array_map('intval', array_unique($products));
        $cycles = array_unique($cycles);

        $group_gateways = $this->listConfigs('group');
        if (!empty($groups) && !empty($group_gateways)) {
            foreach ($group_gateways as $group_gateway) {
                if (!empty(array_intersect($groups, $group_gateway['groups']))) {
                    $stop = true;
                    $gateways = array_merge($gateways, $group_gateway['_gateways']);
                }
            }
        }

        $product_gateways = $this->listConfigs('product');
        if (!$stop && (!empty($products) || !empty($categories)) && !empty($product_gateways)) {
            foreach ($product_gateways as $product_gateway) {
                $pproducts = array_map('intval', $product_gateway['products']);
                if (!empty(array_intersect($products, $pproducts)) ||
                    !empty(array_intersect($categories, $pproducts))) {
                    $stop = true;
                    $gateways = array_merge($gateways, $product_gateway['_gateways']);
                }
            }
        }

        $cycle_gateways = $this->listConfigs('cycle');
        if (!$stop && !empty($cycles) && !empty($cycle_gateways)) {
            foreach ($cycle_gateways as $cycle_gateway) {
                if (!empty(array_intersect($cycles, $cycle_gateway['cycles']))) {
                    $stop = true;
                    $gateways = array_merge($gateways, $cycle_gateway['_gateways']);
                }
            }
        }

        $country_gateways = $this->listConfigs('country');
        $georule = HBConfig::getSetting('_geolocation_rule');
        if (!$stop && !empty($country_gateways)) {
            foreach ($country_gateways as $country_gateway) {
                if (in_array($login['country'], $country_gateway['countries']) || (!$georule && in_array(self::ALL_COUNTRIES, $country_gateway['countries']))) {
                    $stop = true;
                    $gateways = array_merge($gateways, $country_gateway['_gateways']);
                }
            }
        }

        if (!$stop && $r->getController() == 'cart') {
            $cart_gateways = $this->listConfigs('cart');
            if (!empty($cart_gateways)) {
                foreach ($cart_gateways as $cart_gateway) {
                    if (!empty($cart_gateway['_gateways'])) {
                        $stop = true;
                        $gateways = array_merge($gateways, $cart_gateway['_gateways']);
                    }
                }
            }
        }

        if(!$client_id && $this->configuration['Limit initial set of gateways']['value'] && $selected = $this->configuration['Initial set of gateways']['value']) {
            $stop = true;

            $selected = array_intersect($list, $selected);
            foreach($selected as $k=>$gtw) {
                $gateways[]=[
                    'id'=>$k,
                    'name'=>$gtw
                ];
            }
        }

        if ($stop) {
            $list = [];
            foreach ($gateways as $gateway) {
                if(isset($existing[$gateway['id']])) {
                    $list[$gateway['id']] = $gateway['name'];
                }
            }
            $list = array_intersect_assoc($existing,$list);

        }

//        HBDebug::debug('end ' . json_encode($list), [
//            '$groups' => $groups,
//            '$cycles' => $cycles,
//            '$products' => $products,
//            '$categories' => $categories,
//            '$list' => $list,
//            '$gateways' => $gateways,
//            'cmd' => $r->getController(),
//            'action' => $r->getAction(),
//            'params' => $r->getParams(),
//            '$group_gateways' => $group_gateways,
//            '$product_gateways' => $product_gateways,
//            '$cycle_gateways' => $cycle_gateways,
//            '$country_gateways' => $country_gateways,
//            '$template_vars' => $template_vars,
//            'cart' => HBConfig::getSetting('Cart'),
//            'session' => $_SESSION,
//        ]);
    }


    public function after_clientadded($client) {

        if( $this->configuration['Limit initial set of gateways']['value'] && $selected = $this->configuration['Initial set of gateways']['value']) {
            $gateways = ModuleFactory::singleton()->getPaymentModules(false, true);


                $gateways = array_intersect($gateways, $selected);
                $gateways = array_combine(array_keys($gateways), array_keys($gateways));
                $this->saveGateways($client['id'], false, $gateways);

        }
    }

    /**
     * @param $order_id
     * @return bool
     */
    private function getInvoiceByOrder($order_id)
    {
        $q = $this->db->prepare("SELECT client_id,invoice_id FROM hb_orders WHERE id = ? LIMIT 1");
        $q->execute([$order_id]);
        $d = $q->fetch(PDO::FETCH_ASSOC);
        $this->logger()->info("Fraud order. Invoice for unblocking", ['data' => $d, 'order' => $order_id]);
        $q->closeCursor();
        if (!$d)
            return false;
        return $d['invoice_id'];
    }

    /**
     * @param $invoice_id
     * @param $order_id
     */
    private function enableInvoice($invoice_id, $order_id)
    {
        $invoice_id = $this->getInvoiceByOrder($order_id);
        $order = new Order($order_id);
        $order->changeStatus('Pending');

        $invoice = Invoice::createInvoice($invoice_id);
        $this->invoice_id = $invoice_id;
        $scenario = HBLoader::LoadComponent('OrderScenario', array('nocache' => true));
        $scenario->setorderId($order_id);
        try {
            $scenario->executeStep('sendInvoice', $invoice, false);
            $scenario->skipStep('Authorize', 'Marked step as authorized');
        } catch (HBException $e) {
        }
        $invoice->setInvoiceLock(0);
        $invoice->notifyClient();
        $invoice->setStatus(Invoice::STATUS_UNPAID);
        $status = $invoice->saveChanges();

        $qa = $this->db->prepare("UPDATE hb_accounts SET status='Pending' WHERE order_id=? AND status='Fraud'");
        $qa->execute([$order_id]);
        $qa = $this->db->prepare("UPDATE hb_accounts_addons SET status='Pending' WHERE order_id=? AND status='Fraud'");
        $qa->execute([$order_id]);
        $qa = $this->db->prepare("UPDATE hb_domains SET status='Pending' WHERE order_id=? AND status='Fraud'");
        $qa->execute([$order_id]);

        HBEventManager::notify('InvoiceCreated', array('invoice' => $invoice));
    }


    /**
     *
     */
    public function before_displayuserheader()
    {
        $client_id = HBConfig::getSetting('login')['id'];
        $alert = HBConfig::getSetting('gtwprcl:showalert:' . $client_id);
        if ($alert) {
            HBConfig::deleteSetting('gtwprcl:showalert:' . $client_id);
            $message = HBRegistry::language()->parseTag("{\$lang.gatewayperclient_fraud_message}");
            $message = html_entity_decode($message, ENT_QUOTES | ENT_HTML5);

            $js_url = Utilities::checkSecureURL(HBConfig::getConfig('InstallURL') . 'includes/modules/Other/' . strtolower($this->getModuleDirName()) . '/admin/js/alert.js');

            echo '<script src="' . $js_url . '"></script>';
            echo '<script>
                    $(document).ready(function() {
                        swal({
                            text: "' . $message . '",
                            icon: "warning",
                            dangerMode: true,
                        });
                    });
                 </script>';
        }
    }


    /**
     * @param $params
     * @return array
     */
    public function adminwidget_clients_profilewidgets($params)
    {
        $smarty_vars = $params['smarty_vars'];
        $gateways = $gateways_translated = ModuleFactory::singleton()->getPaymentModules(false, true);
        $lang = HBRegistry::singleton()->getObject('language');

        $gat = [];
        foreach ($gateways_translated as &$gtw) {
            $gat[$gtw] = $lang->parseTag($gtw);
        }
        $client_id = $smarty_vars['client']['id'];
        $gtw = HBConfig::getConfig("Gateways_" . $client_id);
        if (!$gtw || $gtw === 'all') {
            $selectall = true;
        } else {
            $selectall = false;
            $selected = json_decode($gtw, true);
        }
        return [
            "variables" => [
                'allgateways' => $gateways,
                'selectall' => $selectall,
                'selected' => $selected,
                'translated' => $gat
            ],
            "template" => MAINDIR . 'includes/modules/Other/gatewayperclient/admin/ajax.clientwidget.tpl',
            "name" => $this->getModName(),
        ];
    }
}