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
<?php 
$action_do = $_GET['action_do'];
if($action_do == 'add-cred-app') {
	$save_but = "<input type='submit' name='save_cred_more' value='Next' class='btn' />";
} else {
	$save_but = "<input type='submit' name='save_admin_vip_but' value='Next' class='btn' />";
}

if ($_SERVER['SERVER_NAME'] == 'netway.co.th')
{
	$rv2factor_label = "Netway2Factor";
} else {
	$rv2factor_label = "RV2Factor";
}


echo "<h4>".$rv2factor_label." > Add Credential</span></h4>"; ?>

<center>
			
<style type='text/css'>				
.add-symantect{
	border:#000000 solid 1px; 
	padding:2px;
	font-family:Arial, Helvetica, sans-serif; 
	color:#333333;
	font-size:14px;
	margin-top:20px;   
}
.add-symantect .block-l{
	float:left; 
	width:250px; 
	height:220px;
	height:260px\9; 
	background:#fff; 
	text-align:center; 
	padding-top:30px;
}
.add-symantect .block-r{
	float:left;  
	background:#fff; 
	text-align:center; 
	padding:20px;
	padding-top:30px;
	padding-top:20px\9;
}
.add-symantect .block-r div{
	padding-bottom:5px;
}
.add-symantect .block-r div.pad{
	padding-top:10px;
}
.add-symantect .btn, .add-symantect .btn:visited, .add-symantect .btn:hover, .add-symantect .btn:active{ 
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
.add-symantect .btn:hover, .add-symantect .btn:active{ 
	color:#fff; 
	background:#636363; 
}
.add-symantect a, .add-symantect a:visited, .add-symantect a:hover, .add-symantect a:active{ 
	color:#c74b00; 
	text-decoration: underline; 
	font-size:12px;
	font-family:Arial, Helvetica, sans-serif;
}
.add-symantect a:hover, .add-symantect a:active{ 
	color:#000; 
}
.add-symantect .box{ 
	border:#757575 solid 1px; 
	background:#FFFFFF; 
	width:200px; 
	padding:4px; 
}
.add-symantect h2{ 
	font-family:Arial, Helvetica, sans-serif; 
	font-size:16px; 
}
.add-symantect .clear{ 
	clear:both; 
	padding:0; 
	margin:0;
}
.add-symantect .name{ 
	color:#0066CC;
}
</style>

<script type='text/javascript'>
					function check_frm(frm) {
						if(frm.credentIdone.value=='') {
							alert('Please type Credential ID');
							frm.credentIdone.focus();
							return false;
						}
						if(frm.vip_acct_comment.value=='') {
							alert('Please type Note');
							frm.vip_acct_comment.focus();
							return false;
						}
						return true;
					}
				</script>
				

<script type='text/javascript'>
	window.onload = function() {
  		document.getElementById('credentIdone').focus();
	};
</script> 

<center>
<table cellpadding='0' cellspacing='3'>
	<tr>
		<td align='left' valign='top'>
			<div class='add-symantect'>
				<div class='block-l'><img src='/includes/modules/Other/Rvtwofactor/images/symantec-logo.png' alt='' width='200' height='192' /></div>
				<div class='block-r'>
		
					<form action='index.php?cmd=clientarea&action=rvlist&rvaction=twofactor&action_do=addvip' method='post' onsubmit='return check_frm(this)'>
									<br clear='all' />
                                    <div align='left'><label for='credentIdone'>Credential ID</label> </div>
									<div align='left'><input type='text' name='credentialId' id='credentIdone' class='box' autocomplete='off' /></div>
									<div align='left'>Note</div>
									<div align='left'><input type='text' name='vip_acct_comment' id='vip_acct_comment' class='box' autocomplete='off' /></div>
									<div align='left'><?php echo $save_but; ?></div>
					</form>
					<div class='clear'></div>
					<div class='clear'></div>
					<div align='left'><a href='https://m.vip.symantec.com/home.v' target='_blank'>Get VIP Access</a> </div>
				</div>
				<div style='clear:both;'></div>
			</div>
		</td>
	</tr>
</table><br />