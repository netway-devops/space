<?php
/**
 * 
 * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
 * 
 * @link http://www.andrehonsberg.com/article/php-mysql-class-for-easy-and-simple-mysql-manipulation
 *
 */

class Database {
 
    private $host;
    private $user;
    private $pass;
    private $name;
    private $link;
    private $error;
    private $errno;
    private $query;
 
    /**
     * Returns a singleton HostbillApi instance.
     *
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
     * @param bool $autoload
     * @return obj
     * 
     */
     public function &singleton($autoload=false) {
        static $instance;
        // If the instance is not there, create one
        if (!isset($instance) || $autoload) {
            $class = __CLASS__;
            $instance = new $class();
        }
        return $instance;
    }
    
    /**
     * Connect DB Power DNS (pdns.netway.co.th)
     * 
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
     * @return $OBJECT
     * @example
     * 
     * 
     * Database::singleton()->connect_pwdns();
     * $query = "SELECT * FROM hb_vps_details WHERE account_id='437'";
     * $aRes = Database::singleton()->fetch_all_array($q);
     * print_r($aRes);
     * 
     * OR
     * 
     * $db = Database::singleton();
     * $db->connect_pwdns();
     * $query = "SELECT * FROM hb_vps_details WHERE account_id='437'";
     * $aRes = $bb->fetch_all_array($q);
     * print_r($aRes);
     * 
     */
    public function connect_pwdns() {
        
        $aServerConf = HostbillApi::singleton()->getServerDetailsByServerId('64'); // Fix: Server name 'powerdns' id=64
        
        if (isset($aServerConf['server']['name']) && $aServerConf['server']['name'] != ''
            && isset($aServerConf['server']['host']) && $aServerConf['server']['host'] != ''
            && isset($aServerConf['server']['username']) && $aServerConf['server']['username'] != ''
            && isset($aServerConf['server']['password']) && $aServerConf['server']['password'] != '') {
            
            $this->host = $aServerConf['server']['host'];
            $this->user = $aServerConf['server']['username'];
            $this->pass = $aServerConf['server']['password'];
            $this->name = $aServerConf['server']['name'];
            
            // TODO Test
            /* $this->host = 'localhost';
            $this->user = 'root';
            $this->pass = 'test';
            $this->name = 'managene_hostbill2'; */
            
            if ($this->link = mysql_connect($this->host, $this->user, $this->pass)) {
                if (!mysql_select_db($this->name)) {
                    return $this->exception("Could not connect to the database!");
                }
            } else {
                return $this->exception("Could not create database connection!");
            }
            
            mysql_query("SET NAMES 'utf8' ");
            mysql_query("SET CHARACTER_SET 'utf8' ");
            
        } else {
            return $this->exception("Connot get config servers 'powerdns'. Please Check Apps » rDns » powerdns");
        }
        
        
        return array(
            "isValid" => true,
            "raiseError" => '',
            "raiseMsgError" => ''
        );
    }
 
    public function close() {
        @mysql_close($this->link);
    }
 
    public function query($sql) {
        if ($this->query = @mysql_query($sql)) {
            return $this->query;
        } else {
            return $this->exception("Could not query database!");
        }
    }
 
    public function num_rows($qid) {
        if (empty($qid)) {         
            return $this->exception("Could not get number of rows because no query id was supplied!");
        } else {
            return mysql_num_rows($qid);
        }
    }
 
    public function fetch_array($qid) {
        if (empty($qid)) {
            return $this->exception("Could not fetch array because no query id was supplied!");
        } else {
            $data = mysql_fetch_array($qid);
        }
        return $data;
    }
 
    public function fetch_array_assoc($qid) {
        if (empty($qid)) {
            return $this->exception("Could not fetch array assoc because no query id was supplied!");
        } else {
            $data = mysql_fetch_array($qid, MYSQL_ASSOC);
        }
        return $data;
    }
 
    public function fetch_all_array($sql, $assoc = true) {
        $data = array();
        if ($qid = $this->query($sql)) {
            if ($assoc) {
                while ($row = $this->fetch_array_assoc($qid)) {
                    $data[] = $row;
                }
            } else {
                while ($row = $this->fetch_array($qid)) {
                    $data[] = $row;
                }
            }
        } else {
            return false;
        }
        return $data;
    }
 
    public function last_id() {
        if ($id = mysql_insert_id()) {
            return $id;
        } else {
            return false;
        }
    }
 
    /**
     * Exception
     * 
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
     * @param STRING - $message
     * @return ARRAY
     *
     */
    private function exception($message) {
        if ($this->link) {
            $this->error = mysql_error($this->link);
        } else {
            $this->error = mysql_error();
        }
        
        return array(
            "isValid" => false,
            "raiseError" => $this->error,
            "raiseMsgError" => $message
        );
    }
 
}