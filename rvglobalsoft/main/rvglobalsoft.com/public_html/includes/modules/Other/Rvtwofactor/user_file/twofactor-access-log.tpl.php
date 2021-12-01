<?php 
# WebSite:  https://rvglobalsoft.com/rv2factor
# Unauthorized copying is strictly forbidden and may result in severe legal action.
# Copyright (c) 2013 RV Global Soft Co.,Ltd. All rights reserved.
#
# =====YOU MUST KEEP THIS COPYRIGHTS NOTICE INTACT AND CAN NOT BE REMOVE =======
# Copyright (c) 2013 RV Global Soft Co.,Ltd. All rights reserved.
# This Agreement is a legal contract, which specifies the terms of the license
# and warranty limitation between you and RV Global Soft Co.,Ltd. and RV2Factor for Apps Product for RV Global Soft.
# You should carefully read the following terms and conditions before
# installing or using this software.  Unless you have a different license
# agreement obtained from RV Global Soft Co.,Ltd., installation or use of this software
# indicates your acceptance of the license and warranty limitation terms
# contained in this Agreement. If you do not agree to the terms of this
# Agreement, promptly delete and destroy all copies of the Software.
#
# =====  Grant of License =======
# The Software may only be installed and used on a single host machine.
#
# =====  Disclaimer of Warranty =======
# THIS SOFTWARE AND ACCOMPANYING DOCUMENTATION ARE PROVIDED "AS IS" AND
# WITHOUT WARRANTIES AS TO PERFORMANCE OF MERCHANTABILITY OR ANY OTHER
# WARRANTIES WHETHER EXPRESSED OR IMPLIED.   BECAUSE OF THE VARIOUS HARDWARE
# AND SOFTWARE ENVIRONMENTS INTO WHICH RV SITE BUILDER MAY BE USED, NO WARRANTY OF
# FITNESS FOR A PARTICULAR PURPOSE IS OFFERED.  THE USER MUST ASSUME THE
# ENTIRE RISK OF USING THIS PROGRAM.  ANY LIABILITY OF RV GLOBAL SOFT CO.,LTD. WILL BE
# LIMITED EXCLUSIVELY TO PRODUCT REPLACEMENT OR REFUND OF PURCHASE PRICE.
# IN NO CASE SHALL RV GLOBAL SOFT CO.,LTD. BE LIABLE FOR ANY INCIDENTAL, SPECIAL OR
# CONSEQUENTIAL DAMAGES OR LOSS, INCLUDING, WITHOUT LIMITATION, LOST PROFITS
# OR THE INABILITY TO USE EQUIPMENT OR ACCESS DATA, WHETHER SUCH DAMAGES ARE
# BASED UPON A BREACH OF EXPRESS OR IMPLIED WARRANTIES, BREACH OF CONTRACT,
# NEGLIGENCE, STRICT TORT, OR ANY OTHER LEGAL THEORY. THIS IS TRUE EVEN IF
# RV GLOBAL SOFT CO.,LTD. IS ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. IN NO CASE WILL
# RV GLOBAL SOFT CO.,LTD.'S LIABILITY EXCEED THE AMOUNT OF THE LICENSE FEE ACTUALLY PAID
# BY LICENSEE TO RV GLOBAL SOFT CO.,LTD.
# ===============================

?>
<style>
table.padtable{
	padding:0;
	margin:0;
}
table.padtable td{
	line-height:25px;
	padding:5px;
	border-bottom:1px solid #bebebe;
}
</style>
<?php

if ($_SERVER['SERVER_NAME'] == 'netway.co.th')
{
	$rv2factor_label = "Netway2Factor";
} else {
	$rv2factor_label = "RV2Factor";
}

Class ReadLogFile {
	
	private $return_log;
	
	public function ReadLogFile()
	{
		//$this->return_log = $this->readfile_chunked($user_login, $filename, true);
	}

	public function readfile_chunked($user_login, $filename, $retbytes=true)
	{
		$chunksize = 1*(1024*1024); // how many bytes per chunk
		$buffer = '';
		$cnt = 0;
		$handle = fopen($filename, 'rb');
		if ($handle === false) {
			return false;
		}
		while (!feof($handle)) {
			$buffer = fread($handle, $chunksize);
			$bufferz = explode("\r\n", $buffer);
			$cnt_row = count($bufferz);
			for ($ii=0;$ii<$cnt_row;$ii++) {
				$buff = explode(",", $bufferz[$ii]);
				if ($user_login == $buff[8]) {
					$row_log .= "<tr>
       		 			   <td align='center'>".date("Y-m-d H:i:s" ,$buff[0])."</td>
       		 			   <td align='center'>".$buff[6]."</td>
       		 			   <td align='center'>".$buff[2]."</td>
       		 			   <td align='center'>".$buff[9]."</td>
       		 		  </tr>";
				}
			}
				
			ob_flush();
			flush();
			if($retbytes) {
				$cnt += strlen($buffer);
			}
		}
		$status = fclose($handle);
		return $row_log;
	}

}

echo "<h4>".$rv2factor_label." > Access Log</h4><br />";

$cpPath = explode("/" , $_SERVER['DOCUMENT_ROOT']);
$cpPathLog = "/".$cpPath[1]."/".$cpPath[2]; 
$path3 = $cpPathLog."/.rvglobalsoft/symantecvip/logs/vipAppsAccesslogs";
$strFileName = $path3."/".$appsuser_id.".log";

$oLog = new ReadLogFile();
$row_log = $oLog->readfile_chunked($user_login, $strFileName , true);

if($row_log != '') {
	echo "<table width='100%' cellpadding='3' cellspacing=0 border='0' class='padtable'>
			<tr>
				<td align='center' class='serv_head1'>Log Date</td>
				<td align='center' class='serv_head1'>Credential ID</td>
				<td align='center' class='serv_head1'>Access</td>
				<td align='center' class='serv_head1'>IP Address</td>
			</tr>";
	echo $row_log;
	echo "</table>";
} else {
	echo "Not has any access log";
}


?>