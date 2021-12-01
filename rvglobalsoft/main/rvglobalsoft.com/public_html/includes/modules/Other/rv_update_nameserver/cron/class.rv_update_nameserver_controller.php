<?php
/****************************************************************
 * setup : เอาไว้ merge client id จาก hostbilll เข้า database ของ rvskin
 * 
 * 
 ***************************************************************/
class rv_update_nameserver_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    public $connsk;
    public $connsb;
    
    /**
     * Delete ticket ที่ถูก tag ว่าเป็น spam
     * @return string
     */
    public function call_EveryRun()
    {
         $db         = hbm_db();
         //=== 1. update ip from rvskin
         //date_nameserver
         //$resConnSK = $this->_dbconnectSK();
         $msg = '';
         //if ($resConnSK) {
         $sqlsk = "
            SELECT
                main_ip,license_id
            FROM
                rvskin_license
            WHERE
                license_id !=''
            ORDER BY
                date_nameserver 
            LIMIT 0,10    
         ";
         $aData = $db->query($sqlsk,array())->fetchall();
         //REPLACE INTO `hb_server_name` (`host_id`, `ip_user`, `hostname`, `hostdate`) VALUES(1, '99.66.44.55', 'adsl-99-66-44-55.dsl.wotnoh.sbcglobal.net', 1376992302);
         $aId = array();
         $datenow = time();
         foreach ($aData as $k => $data) {
             $hostname = gethostbyaddr($data['main_ip']);
            
             $dbup = $db->query("
                REPLACE INTO
                    hb_server_name
                    (ip_user,hostname,hostdate)
                VALUES
                    (:ip,:hostname,:hostdate)
                ",
                array(
                    ':ip' 		=> $data['main_ip'],
                    ':hostname' => $hostname,
                    ':hostdate' => $datenow
                    )
                );
             if ($dbup) {
                 array_push($aId,$data['license_id']);     
             }
         }
         $listid 		= join(',',$aId);
         $aDataUpTime 	= "UPDATE rvskin_license SET date_nameserver = :datanow WHERE license_id in (".$listid.")";
         $aDataUpTime2 	= $db->query($aDataUpTime, array(':datanow' => $datenow));  
         $msg.="rvskin ok" . "\n";           
   
         $sqlsb = "
            SELECT
                primary_ip,license_id
            FROM
                 rvsitebuilder_license
            WHERE
                license_id !=''
            ORDER BY
                date_nameserver 
            LIMIT 0,10    
         ";
         $aData = $db->query($sqlsb,array())->fetchall();
         $aId 	= array();
         $datenow = time();
         foreach ($aData as $k => $data) {
             $hostname = gethostbyaddr($data['primary_ip']);
            
             $dbup = $db->query("
                REPLACE INTO
                    hb_server_name
                    (ip_user,hostname,hostdate)
                VALUES
                    (:ip,:hostname,:hostdate)
                ",
                array(
                    ':ip' 		=> $data['primary_ip'],
                    ':hostname' => $hostname,
                    ':hostdate' => $datenow
                    )
                );
             if ($dbup) {
                 array_push($aId,$data['license_id']);     
             }
         }
         $listid = join(',',$aId);
		 $aDataUpTime = $db->query("UPDATE rvsitebuilder_license SET date_nameserver = :datenow WHERE license_id in (".$listid.")",array(':datenow'=>$datenow));
         $msg.="rvsitebuilder ok" . "\n";           
         echo $msg;
		 return $msg;
    }
   
    
}
