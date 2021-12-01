<?php
/**
 * This is just test device, do not use it for production
 */

namespace Hosting\PDU_SNMP\Devices\TestDevice;

class TestDevice {
    public $data = [

    ];

    protected $ver = '2';
    protected $file = '';

    public function __construct() {
        $this->file = \HBConfig::getConfig('HBTempatesC') . DS . 'testdevice' . $this->ver . '.json';
        $this->reload();
    }

    public function reload() {
        $this->data = json_decode(file_get_contents($this->file), true) ?: [
            'name' => 'Test Device',
            'description' => 'Fake device to test data readouts, power state changes, etc.',
            'ports' => array_fill_keys(['a1', 'a2', 'a3', 'a4', 'b1', 'b2', 'b3', 'b4'], [
                'state' => true,
                'power' => 700,
                'kwh' => 0
            ])
        ];
    }

    public function save() {
        file_put_contents($this->file, json_encode($this->data, JSON_PRETTY_PRINT));
        return $this;
    }

    public function listPorts() {
        return array_combine(
            array_keys($this->data['ports']),
            array_column($this->data['ports'], 'state')
        );
    }

    public function togglePort($port, $onoff) {
        if (isset($this->data['ports'][$port])) {
            $this->data['ports'][$port]['state'] = (bool) $onoff;
            $this->save();
            return true;
        }

        return false;
    }

    public function portState($port) {
        if (isset($this->data['ports'][$port])) {
            return $this->data['ports'][$port]['state'];
        }

        return false;
    }

    public function readKwh($port) {
        if (isset($this->data['ports'][$port])) {
            $data = $this->data['ports'][$port];

            $flux = $data['power'] * 0.2;
            $data['power'] += round(mt_rand(-$flux, $flux));
            $data['kwh'] += round($data['power'] / 1000, 2);

            $this->data['ports'][$port] = $data;
            $this->save();

            return $data['kwh'];
        }

        return false;
    }

}