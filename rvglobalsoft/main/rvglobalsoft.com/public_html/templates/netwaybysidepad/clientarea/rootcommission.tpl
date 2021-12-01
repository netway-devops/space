{php}
    if (isset($_GET['rvpage']) && $_GET['rvpage'] == 'withdrawn') {
{/php}
    {include file='clientarea/rootcommissionwithdrawn.tpl'}
{php}
    } else if (isset($_GET['rvpage']) && $_GET['rvpage'] == 'historywithdrawn') {
{/php}
        {include file='clientarea/rootcommissionhistorywithdrawn.tpl'}
{php}
    } else {
        $templatePath   = $this->get_template_vars('template_path');
        include($templatePath . 'clientarea/rootcommission.tpl.php');
{/php}

{if isset($isRoot) && $isRoot==1}

<div class="client-area">
    <div class="text-block clear clearfix">
		<ul class="tabs_commission">
			<li><a href="index.php?cmd=clientarea&rvaction=rootcommission" class="current">Root Commission</a></li>
			<li><a href="clientarea&rvaction=apikey">API</a></li>
		</ul>
		<h2 class="padd">Root Commission</h2>
		<div class="padd acenter"><img src="{$template_dir}images/client/commission-info.jpg" alt="RVGlobalSoft" width="1215" height="530" /></div>
		<div class="padd"><b>Root Commission</b> perfectly fits your Reseller Hosting model. By activating reseller access on RVGlobalSoft Manager, a one-stop service module on your control panel, your resellers will be able  to resell such products as SSL Certificates and VIP (RV2Factor). If your reseller accounts on your server buy SSL Certificates and VIP (RV2Factor) from control panel, you as root server will get 5% commission from their sales records. These commission payback is calculated on monthly basis here: </div>
		<div class="padd aright">Visit Terminology Page to find out more about Root Commission.</div>

		<p></p>
		<div class="clear clearfix">
			Commission Balance: <font color="blue">{$CommissionBalance|price}</font> 
			| Total withdrawn: <font color="red">{$TotalWithdrawn|price}</font> 
			| <a href="?cmd=clientarea&rvaction=rootcommission&rvpage=withdrawn">Withdrawn</a> 
			| <a href="?cmd=clientarea&rvaction=rootcommission&rvpage=historywithdrawn">History withdrawn</a>
		</div>
		<p></p>
		<div class="clear clearfix">
			<b>Reports:</b> 
			<select id="repostdate" name="repostdate" onchange="updateRootCommissionReport();">
			{foreach from=$aReportDate key="mykey" item="myitem" }
				<option value="{$myitem}">{$myitem}</option>
			{/foreach}
			<option value="08/2013">08/2013</option>    
			</select>
		</div>
		<div></div>
		<div id="rootcommissionblock"></div>  
	</div>
</div>

<script type="text/javascript">
{literal}
function updateRootCommissionReport()
{

    date = $("#repostdate").val();
    $('#rootcommissionblock').html("Loading data....");
    $.post("?cmd=rootcommission&action=getreport&date=" + date, false, function(data){
        $('#rootcommissionblock').html(data);
    });
}
{/literal}
updateRootCommissionReport();
</script>
{else}
    {include file='clientarea/rootcommission-notice.tpl'}
{/if}
{php}
}
{/php}

