<?php

/**
 * 
 * Symantecvip Common
 * 
 */

class SymantecvipCommon {
	
    /**
     * Returns a singleton SymantecvipCommon instance.
     *
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * 		   Isara Wongnonglaeng <isara@rvglobalsoft.com>
     * @param bool $autoload
     * @return obj
     * 
     */
     public static function &singleton($autoload=false) {
        static $instance;
        // If the instance is not there, create one
        if (!isset($instance) || $autoload) {
            $class = __CLASS__;
            $instance = new $class();
        }
        return $instance;
    }
        
    
}