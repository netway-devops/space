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
input.btn, input.btn:visited, input.btn:hover, input.btn:active{ 
	color:#fff; 
	text-decoration:none;
	background:#4f4f4f; 
	display:inline; 
	border:0;
	border-radius:3px; 
	padding:5px 15px; 
	margin-right:3px; 
	width:90px; 
	white-space:nowrap; 
	cursor:pointer;
}
input.btn:hover, input.btn:active{ 
	color:#fff; 
	background:#636363; 
}
</style>

<?php

if ($_SERVER['SERVER_NAME'] == 'netway.co.th')
{
	$rv2factor_label = "Netway2Factor";
} else {
	$rv2factor_label = "RV2Factor";
}

echo "<h4>".$rv2factor_label." > Validate Credential ID</span></h4>"; 


		
				echo '

	<div class="wrap">
	
	<center>
	<br /><br />
	
	<b>Please Validate Credential ID</b>
	
	<br /><br />
	
	
	<script type="text/javascript">
	function chk_val_frm(frm) {
		if(frm.otp.value=="") {
			alert("Please type Security Code");
			frm.otp.focus();
			return false;
		}
		return true;
	}
</script>

<script type="text/javascript">
	window.onload = function() {
  document.getElementById("otp").focus();
};
</script> 							

	
	<form name="validate_cred" method="post" action="" onsubmit="return chk_val_frm(this)">
	
	<input type="hidden" name="userId" value="'.$appsuser_id.'">
	<input type="hidden" name="vip_acct_id" value="'.$vip_acct_id.'">
	<input type="hidden" name="credentialId" value="'.$credentialId.'">
	

	
	<table class="widefat fixed" cellspacing="0" style="line-height:25px;">
	<tr>
		<td align=right>Credential ID : </td>
		<td>'.$credentialId.'</td>
	</tr>
	
	<tr>
		<td align=right valign="top" style="padding-top:3px;">Security Code : </td>
		<td><input type="text" name="otp" id="otp" MAXLENGTH="6"></td>
	</tr>
	
	<tr>
		<td> </td>
		<td><input type="submit" name="validate_cred_but" value="Validate" class="btn"></td>
	</tr>
	
	</table>
	
	</form>
	
	</div>
	</center>
	
	';

?>