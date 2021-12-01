<?php
/**
 * VMware vCloud SDK for PHP
 *
 * PHP version 5
 * *******************************************************
 * Copyright VMware, Inc. 2010-2013. All Rights Reserved.
 * *******************************************************
 *
 * @category    VMware
 * @package     VMware_VCloud_SDK
 * @subpackage  Samples
 * @author      Ecosystem Engineering
 * @disclaimer  this program is provided to you "as is" without
 *              warranties or conditions # of any kind, whether oral or written,
 *              express or implied. the author specifically # disclaims any implied
 *              warranties or conditions of merchantability, satisfactory # quality,
 *              non-infringement and fitness for a particular purpose.
 * @SDK version 5.5.0
 */

/*
 * @package VMware_VCloud_SDK
 */
class VMware_VCloud_SDK_Exception extends Exception{
    
}

class VMware_VCloud_SDK_ApiException extends Exception{
    protected $minor;
    
    public function __construct($message = "", $minor='', $major= 0, \Exception $previous = null) {
        $this->minor = $minor ?: $major;
        parent::__construct($message, $major, $previous);
    }
    
    public function getMinor(){
        return $this->minor;
    }
}

?>
