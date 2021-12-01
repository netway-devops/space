<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>HostBill - {$business_name} </title>
	<link href="{$template_dir}dist/stylesheets/application.css?v={$hb_version}" rel="stylesheet" media="all" />
	<script type="text/javascript" src="{$template_dir}js/jquery.js?v={$hb_version}"></script>
<style>{literal}


	.lighterblue {
		background: #EBF3FF;
	}
html, body {

	min-height:100%;
	position:relative;

}{/literal}
</style>
</head>

<body style="" onload="$('#username').focus();">


<div class="login-box"><img src="{$template_dir}img/hostbill-logo.png" style="margin-bottom:10px;width:109px" />
	<div style="border:3px solid #85a8c8; padding:2px;margin-bottom:4px;background:#ffffff;">

		<div>






		<div class="lighterblue" style="padding:15px;font-size:11px;">
		Provide your One Time Password:
                </div>
			<div style="padding:15px;">
	<form name="loginform" action="?cmd=onetimepasswords&action=verify" method="post">
<input name="make" value="login" type="hidden"/>
{securitytoken}
			<table border="0" width="100%" cellpadding="0" cellspacing="0">

				{if $error}
				<tr><td colspan="2" style="border:1px solid #DDDDDD;background:#FFFFDF;font-size:11px;padding:10px;">
				{foreach from=$error item=blad}
					<span class="error">{$blad}<br /></span>
				{/foreach}
				</td></tr>
				{/if}

				
				<tr>
				<td colspan="2">One Time Password:</td>
				</tr>
				<tr>
					<td colspan="2" style="padding-bottom:10px;"><input name="otp" id='username' class="form-control input-sm" type="text"/></td>
				</tr>
				

				<tr>
				<td width="50%"  align="left"></td>
				<td width="50%" align="right"><input type="submit" class="btn btn-primary" value="Login" style="font-weight:bold"/></td>
				</tr>
			</table></form></div>

		</div>

	</div>
	<div style="text-align:right;"><small>Powered by <a href="http://hostbillapp.com" target="_blank" >HostBill</a></small></div>
</div>





</body>
</html>