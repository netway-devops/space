{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'clientarea/rvglobalsoft_api.tpl.php');
{/php}
{literal}
<script type="text/JavaScript">
function copy(name){
var tempval=document.getElementById(name);
tempval.focus();
tempval.select();

try {
therange=tempval.createTextRange()
therange.execCommand("Copy")
} catch (err) {}

}
</script>
{/literal}

<div class="container client-area">
	<ul class="tabs_commission">
		<!-- <li><a href="index.php?cmd=clientarea&rvaction=rootcommission">Root Commission</a></li> -->
		<!-- <li><a href="clientarea&rvaction=apikey" class="current">API Key</a></li> -->
	</ul>
	<h2 class="padd">API Key</h2>
	<br />
	<div class="row-fluid">
		<div class="span12">
			<div class="padd acenter"><img src="{$template_dir}images/client/api-info.jpg" alt="RVGlobalSoft" width="1063" height="305" /></div>
			<div class="padd">In order to connect with RVGlobalSoft Reseller Platform and start a transparent reselling between your clients and you, we suggest you to connect via our APi below. There are two AP for you to choose. One for your Billing (WHMCS) and the other is for your client control panel (WHM/cPanel). Please be noted that your email should be valid and the same as on registered with RVGlobalSoft.com.  </div>
		</div>
	</div>
	<div class="row-fluid padd">
		<div class="span12 bggray">The below API(s) must be used with your registered email: <span class="mail">{$showapikey.email}</span></div>
	</div>

	<div class="row-fluid padd">
		<div id="ajaxMessage" class="message"><!-- Do not remove, MSIE fix --></div>
		<form method="post" id="frmaddview" name="frmaddview" action="">
			<input type="hidden" name="rv_action" value="dogen" />
			<div class="span6" style="padding:0; margin:0;">
				<h2 class="txt-api"><label for="resConf[accesskey]">Billing API Key ​</label></h2>
				<div><textarea name="resConf[accesskey]" id="resConf[accesskey]" readonly="readonly" rows="10" class="resapi" style="cursor: default">{$showapikey.billing_accesskey}</textarea></div>
			</div>
			<div class="span6">
				<h2 class="txt-api"><label for="resConf[accesskey]">Control Panel API Key </label></h2>
				<div><textarea name="resConf[accesskey]" id="resConf[accesskey]" readonly="readonly" rows="10"  class="resapi" style="cursor: default">{$showapikey.cp_accesskey}</textarea></div>
			</div>
		</form>
	</div>
</div>
