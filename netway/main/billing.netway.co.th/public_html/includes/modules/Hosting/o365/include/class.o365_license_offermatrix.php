<?php

class o365LicenseOffermatrix {
    protected $aLicenseOffermatrix = array();
    protected $aResellerPricelistFile = array();
    private $licenseOffermatrixFile = __DIR__ . DIRECTORY_SEPARATOR . '../data/license_offermatrix_sheets.csv';
    private $resellerPricelistFile = __DIR__ . DIRECTORY_SEPARATOR . '../data/Cloud-Reseller-Pricelist-USD.csv';
    function __construct() 
    {
        $this->_load();
    }
    
    private function _loadConfig()
    {
        $string = file_get_contents(__DIR__ . DIRECTORY_SEPARATOR . "../data/configs.json");
        return json_decode($string, true);
    }

    public  function getConfig($key)
    {
        $aConfig = $this->_loadConfig();
        return isset($aConfig[$key]) ? $aConfig[$key] : null;
    }

    private function _load()
    {
        try {
            $aConfig = $this->_loadConfig();
            $this->licenseOffermatrixFile = __DIR__ . DIRECTORY_SEPARATOR . '../data/' . $aConfig['pricingOn'] . '-legacy_license_offermatrix_sheets.csv';
            $this->resellerPricelistFile = __DIR__ . DIRECTORY_SEPARATOR . '../data/' . $aConfig['pricingOn'] . '-Cloud-Reseller-Pricelist.csv';

            if (file_exists($this->licenseOffermatrixFile)) {
                $this->aLicenseOffermatrix = $this->csv_to_array($this->licenseOffermatrixFile);
            }
            if (file_exists($this->resellerPricelistFile)) {
                $this->aResellerPricelistFile = $this->csv_to_array($this->resellerPricelistFile);
            }
        } catch (Exception $ex) {
            echo $ex->getMessage();
        }
    }

    private function csv_to_array($filename='', $delimiter=',')
    {
        if(!file_exists($filename) || !is_readable($filename))
            return FALSE;
        $header = NULL;
        $data = array();
        if (($handle = fopen($filename, 'r')) !== FALSE)
        {
            while (($row = fgetcsv($handle, 40000, $delimiter)) !== FALSE)
            {
                if (!$header) {
                    $header = $row;
                } else {
                    $_data = array_combine($header, $row);
                    if (isset($_data['Durable Offer ID']) || isset($_data['Offer ID'])) {
                        if (isset($_data['Billing Frequency'])) {
                            $_data['Billing Frequency'] = explode(';', $_data['Billing Frequency']);
                        }
                        if (isset($_data['Allowed Countries'])) {
                            $_data['Allowed Countries'] = explode(';', $_data['Allowed Countries']);
                        }
                        $data[] = $_data;
                    }
                }
            }
            fclose($handle);
        }
        return $data;
    }

    public function getAll()
    {
        return $this->aLicenseOffermatrix;
    }

    public function getByAllowedCountries($aCountries=array()) {
        if (count($aCountries) <= 0) {
            return $this->aLicenseOffermatrix;
        } else {
            $data = array();
            foreach ($this->aLicenseOffermatrix as $item) {
                foreach ($aCountries as $search) {
                    if (in_array($search, $item['Allowed Countries'])) {
                        $data[] = $item;
                    }
                }
            }
            return $data;
        }
    }

    public function getOfferDetailsByDurableOfferID($id)
    {
        $result = null;
        foreach ($this->aLicenseOffermatrix as $item) {
            if (trim(strtolower($item['Durable Offer ID'])) == trim(strtolower($id))) {
                $result = $item;
                break;
            }
        }
        return $result;
    }

    public function getPriceDetailsByDurableOfferID($id)
    {
        $result = null;
        foreach ($this->aResellerPricelistFile as $item) {
            if (trim(strtolower($item['Offer ID'])) == trim(strtolower($id))) {
                $result = $item;
                break;
            }
        }
        return $result;
    }
}