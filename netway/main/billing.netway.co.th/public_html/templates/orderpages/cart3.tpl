{if $custom_overrides.cart3}
    {include file=$custom_overrides.cart3}
{else}
{php}
$templatePath   = $this->get_template_vars('template_path');
include(dirname($templatePath) . '/orderpages/cart3.tpl.php');
{/php}
<script type="text/javascript" src="{$template_dir}js/common.js"></script>
<link href="{$template_dir}css/fileuploader.css?v={$hb_version}" rel="stylesheet" media="all" />
<link href="{$template_dir}css/bootstrap-slider.css" rel="stylesheet"/>
<script src="{$template_dir}js/bootstrap-slider.js"></script>
<script src="{$template_dir}js/fileuploader.js"></script>

<!-- <pre>{$smarty.post|@print_r}</pre> -->
{literal}
<style type="text/css">
@media (max-width: 480px) {
	.drinkcard-cc{
		counter-reset: step;
		width: 110px;
    	height: 80px;
		margin-right: -36px;
	}
}
</style>
<script type="text/javascript">

function changeCycle(forms) {
	$(forms).append('<input type="hidden" name="ccycle" value="true"/>').submit();
	return true;
}
function verifyDomain() {

	 $.post('?cmd=serviceshandle&action=verifyDomain',{
		 hostname: $("#domain").val()
     },function(data) {
         // CALL BACK
         data = jQuery.parseJSON(data);

         if (data.ERROR != "" || data.ERROR != null || data.ERROR != undefined) {
        	 $("#rv-site-error-domain").html(''+data.ERROR);
        	 $("#rv-site-error-domain1").html(''+data.ERROR);
         } else {
        	 $("#rv-site-error-domain").html("");     
        	 $("#rv-site-error-domain1").html("");   
         }
         
     });

}
</script>
{/literal}

{if $product.id == 410}
    <a href="http://thaivps.com">กลับไป ThaiVPS.com</a>
{/if}
<form action="" method="post" id="cart3" enctype="multipart/form-data" {if $product.category_id == 83 || $product.category_id == 84 || $product.category_id == 98 || $product.category_id == 99} class="formcart3Cloud"{/if}>

            {if $parent_account}
                <div class="wbox">
                    <div class="wbox_header">
                        <strong>{$lang.relatedservice}</strong>
                    </div>
                    <div class="wbox_content">
                        <span>{$lang.iamorderingforaccount}</span>
                        <a target="_blank" href="{$ca_url}clientarea&action=services&service={$parent_account.id}">#{$parent_account.id} {$parent_account.category_name} - {$parent_account.product_name} {if $parent_account.label} <small>({$parent_account.label})</small> {/if}</a>
                    </div>
                </div>
            {/if}

{if $product.description!='' || $product.paytype=='Once' || $product.paytype=='Free'}
	{if $product.category_id == 83 || $product.category_id == 84 || $product.category_id == 98 || $product.category_id == 99}
		{foreach from=$custom item=value key=keyaa}
			{if $value.variable == 'os'}
				{assign var=dataa value=$value.items}
			{/if}
			{if $value.variable == 'cpu_cores'}
				{if $smarty.post.custom[$keyaa]}
					{assign var=aCustomCpuValue value=$value.items}
				{/if}
				{assign var=customCpuId value=$value.id}
			{/if}
			{if $value.variable == 'memory'}
				{if $smarty.post.custom[$keyaa]}
					{assign var=aCustomRamValue value=$value.items}
				{/if}
				{assign var=customRamId value=$value.id}
			{/if}
			{if $value.variable == 'disk_size'}
				{if $smarty.post.custom[$keyaa]}
					{assign var=aCustomHddValue value=$value.items}
				{/if}
				{assign var=customHddId value=$value.id}
			{/if}
		{/foreach}
		{assign var=CustomCpuValue value=$smarty.session.currentCloudSelectData.cpu}
		{assign var=CustomRamValue value=$smarty.session.currentCloudSelectData.ram}
		{assign var=CustomHddValue value=$smarty.session.currentCloudSelectData.hdd}
		<div class="select-cloud">
			<div id="order-cloud-step-1" class="header-order-cloud">
				<h5>1.Select Cloud</h5>
			</div>
			<div class="cc-selector cloud-step-1">
					
					<input type="hidden" name="curRam" id="curRam">
					<input type="hidden" name="curCpu" id="curCpu">
					<input type="hidden" name="curHdd" id="curHdd">
				
			        <input id="server-vps" type="radio" name="server" value="vps" style="margin-left: 3px;" {if preg_match("/vps/i",$product.name)} checked="checked" {/if} /> 
			        <label class="drinkcard-cc server-vps" for="server-vps"></label>
			        
			        <input id="server-vmware" type="radio" name="server" value="vmware" style="margin-left: 3px;" {if $product.id == 883 || $product.id == 993} checked="checked" {/if} />
			        <label class="drinkcard-cc server-vm" for="server-vmware"></label>
			        
			        <input id="server-azure" type="radio" name="server" value="azure" style="margin-left: 3px;" onclick="return false;" {if $product.id == '??'} checked="checked" {/if} />
			        <label class="drinkcard-cc server-azure" for="server-azure"></label>
			        <br>
			        <h6>Choose billing cycle</h6>
					<select id="cloudCycle" name="cloudCycle" onchange="changeRealCycle();" class="pg_inr_drop_1" style="margin: 0px 10px 10px 0px">
						{if $product.h!=0}<option value="h" {if $cycle=='h'} selected="selected"{/if}>{$lang.h} {if isset($aProduct.hDiscount) && $aProduct.hDiscount > 0} ได้รับส่วนลด {$aProduct.hDiscount|price:$currency} เหลือ {/if}{$product.h|price:$currency} {*$lang.h*}{if $product.h_setup!=0} + {$product.h_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Hourly} {$lang.freedomain}{/if}</option>{/if}
					    {if $product.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$lang.d} {if isset($aProduct.dDiscount) && $aProduct.dDiscount > 0} ได้รับส่วนลด {$aProduct.dDiscount|price:$currency} เหลือ {/if}{$product.d|price:$currency} {*$lang.d*}{if $product.d_setup!=0} + {$product.d_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Daily} {$lang.freedomain}{/if}</option>{/if}
					    {if $product.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$lang.w} {if isset($aProduct.wDiscount) && $aProduct.wDiscount > 0} ได้รับส่วนลด {$aProduct.wDiscount|price:$currency} เหลือ {/if}{$product.w|price:$currency} {*$lang.w*}{if $product.w_setup!=0} + {$product.w_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Weekly} {$lang.freedomain}{/if}</option>{/if}
					    {if $product.m!=0 && $product.category_id != 22}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{if $aProduct.id=='882' || $aProduct.id=='883'}{$lang.m}{else}{$lang.m} {if isset($aProduct.mDiscount) && $aProduct.mDiscount > 0} ได้รับส่วนลด {$aProduct.mDiscount|price:$currency} เหลือ {/if}{$product.m|price:$currency} {/if}{*$lang.m*}{if $product.m_setup!=0} + {$product.m_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Monthly} {$lang.freedomain}{/if}</option>{/if}
					    {if $product.q!=0 && $product.category_id != 22}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{if $aProduct.id=='882' || $aProduct.id=='883'}{$lang.q}{else}{$lang.q}{if isset($aProduct.qDiscount) && $aProduct.qDiscount > 0} ได้รับส่วนลด {$aProduct.qDiscount|price:$currency} เหลือ {/if}{$product.q|price:$currency} {/if}{*$lang.q*}{if $product.q_setup!=0} + {$product.q_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Quarterly} {$lang.freedomain}{/if}</option>{/if}
					    {if $product.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{if $aProduct.id=='882' || $aProduct.id=='883'}{$lang.s}{else}{$lang.s} {if isset($aProduct.sDiscount) && $aProduct.sDiscount > 0} ได้รับส่วนลด {$aProduct.sDiscount|price:$currency} เหลือ {/if}{$product.s|price:$currency} {/if}{*$lang.s*}{if $product.s_setup!=0} + {$product.s_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.SemiAnnually}{$lang.freedomain}{/if}</option>{/if}
					    {if $product.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{if $aProduct.id=='882' || $aProduct.id=='883'}{$lang.a}{else}{$lang.a} {if isset($aProduct.aDiscount) && $aProduct.aDiscount > 0} ได้รับส่วนลด {$aProduct.aDiscount|price:$currency} เหลือ {/if}{$product.a|price:$currency} {/if}{*$lang.a*}{if $product.a_setup!=0} + {$product.a_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Annually}{$lang.freedomain}{/if}</option>{/if}
					    {if $product.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$lang.b} {if isset($aProduct.bDiscount) && $aProduct.bDiscount > 0} ได้รับส่วนลด {$aProduct.bDiscount|price:$currency} เหลือ {/if}{$product.b|price:$currency} {*$lang.b*}{if $product.b_setup!=0} + {$product.b_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Biennially}{$lang.freedomain}{/if}</option>{/if}
						{if $product.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$lang.t} {if isset($aProduct.tDiscount) && $aProduct.tDiscount > 0} ได้รับส่วนลด {$aProduct.tDiscount|price:$currency} เหลือ {/if}{$product.t|price:$currency} {*$lang.t*}{if $product.t_setup!=0} + {$product.t_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Triennially}{$lang.freedomain}{/if}</option>{/if}
						{if $product.p4!=0}<option value="p4" {if $cycle=='p4'} selected="selected"{/if}>{$lang.p4} {if isset($aProduct.p4Discount) && $aProduct.p4Discount > 0} ได้รับส่วนลด {$aProduct.p4Discount|price:$currency} เหลือ {/if}{$product.p4|price:$currency} {*$lang.p4*}{if $product.p4_setup!=0} + {$product.p4_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Triennially}{$lang.freedomain}{/if}</option>{/if}
						{if $product.p5!=0}<option value="p5" {if $cycle=='p5'} selected="selected"{/if}>{$lang.p5} {if isset($aProduct.p5Discount) && $aProduct.p5Discount > 0} ได้รับส่วนลด {$aProduct.o5Discount|price:$currency} เหลือ {/if}{$product.p5|price:$currency} {*$lang.p5*}{if $product.p5_setup!=0} + {$product.p5_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Triennially}{$lang.freedomain}{/if}</option>{/if}
					</select><br>
					{if $aProduct.id=='882'}
						{if $cycle=='s'}<input type="text" value="IDN9IGXUO26U"  style="font-weight:bold;border-color: #4CAF50;color: green;border: 1px solid;padding: 14px 13px;font-size: 15px;background-color: white;width: 160px;" >&nbsp;&nbsp;Use this code to get 5% discount
						{/if}
						{if $cycle=='a'}<input type="text" value="OYFI78DTED7" style="font-weight:bold;border-color: #4CAF50;color: green;border: 1px solid;padding: 14px 13px;font-size: 15px;background-color: white;width: 160px;" >&nbsp;&nbsp;Use this code to get 10% discount
						{/if}
					{elseif $aProduct.id=='883' }
						{if $cycle=='s'}<input type="text" value="0SFO311GABK" style="font-weight:bold;border-color: #4CAF50;color: green;border: 1px solid;padding: 14px 13px;font-size: 15px;background-color: white;width: 160px;" >&nbsp;&nbsp;Use this code to get 5% discount
				     	{/if}
					 {if $cycle=='a'}<input type="text" value="V7FVJ19VBZFN"  style="font-weight:bold;border-color: #4CAF50;color: green;border: 1px solid;padding: 14px 13px;font-size: 15px;background-color: white;width: 160px;" >&nbsp;&nbsp;Use this code to get 10% discount
					 {/if}
					{/if}
					<h6>Hostname *</h6>
					<span id="rv-site-error-domain1" class="alert-error"></span>
					<input id="forCloudDomain" name="forCloudDomain" type="text" value="" class="styled" size="50" onchange="addToDomain();" style="margin: 0px 10px 10px 0px; width: 95%; height: 25px">
					<br><small style="color: gray;">Example Domain Name (FQDN): vps.yourdomainname.com</small><br><br>
			        {if count($cloudLocationProduct) > 1}
			        <select id="cloud-location" class="pg_inr_drop_1">
			        	{foreach from=$cloudLocationProduct item=value key=k}
			        		<option value="{$value.value.id}" >{$value.location}</option>
			        	{/foreach}
			        </select><br><br>
			        {/if}
			</div>
		</div>
		<div class="select-cloud">
			<div id="order-cloud-step-2" class="header-order-cloud">
				<h5>2.Select OS Template</h5>
			</div>
			<div class="cc-selector cloud-step-2">
				
			<h6>OS Template</h6>
			<select id="selectOsTemplate" name="selectOsTemplate" onchange="" class="pg_inr_drop_1" style="margin: 0px 10px 10px 0px">
				{if $product.category_id == 83 || $product.category_id == 84}
				<!-- <option value="0" selected="selected">Centos 6.9</option>
				<option value="1">Centos 7.5</option>
				<option value="3">Ubuntu 18</option> -->
				<option data-server="linux" data-virtualizor_api_id="883" value="5" >CentOS 7.7 (64Bit) </option>
                <option data-server="linux" data-virtualizor_api_id="870" value="6">CentOS 7.6 (64Bit) </option>
                <option data-server="linux" data-virtualizor_api_id="848" value="7">CentOS 6.10 (64Bit) </option>
                <option data-server="linux" data-virtualizor_api_id="626" value="8">CentOS 6.9 (64Bit) </option>
                <option data-server="linux" data-virtualizor_api_id="625" value="9">CentOS 6.9 (32Bit) </option>
                <option data-server="linux" data-virtualizor_api_id="889" value="10">Ubuntu 19.04 (64Bit)</option>
                <option data-server="linux" data-virtualizor_api_id="860" value="11">Ubuntu 18.10 (64Bit)</option>
                <option data-server="linux" data-virtualizor_api_id="812" value="12">Ubuntu 18.04 (64Bit)</option>
                <option data-server="linux" data-virtualizor_api_id="817" value="13">Ubuntu 18.04 (32Bit) </option>
                <option data-server="linux" data-virtualizor_api_id="878" value="14">Debian 10 (64Bit) </option>
                <option data-server="linux" data-virtualizor_api_id="771" value="15">Debian 9.4 (64Bit) </option>
                <option data-server="linux" data-virtualizor_api_id="776" value="16">Debian 9.4 (32Bit)</option>
                <option data-server="linux" data-virtualizor_api_id="796" value="17">Fedora 27 (64Bit) </option>
                <option data-server="linux" data-virtualizor_api_id="390" value="18">Fedora 21 (64Bit)</option>
                <option data-server="linux" data-virtualizor_api_id="278" value="19">Fedora 20 (64Bit)</option>
                <option data-server="linux" data-virtualizor_api_id="277" value="20">Fedora 20 (32Bit)</option>    
                <option data-server="linux" data-virtualizor_api_id="100056" value="24">Nextcloud18 (64Bit)</option>
                <option data-server="linux" data-virtualizor_api_id="100057" value="25">ownCloud10 (64Bit)</option>    
                
				{/if}
				{if $product.category_id == 99 || $product.category_id == 98}
				<option data-server="windows" data-virtualizor_api_id="" value="21">Windows Server 2019 (64Bit)</option> 
                <option data-server="windows" data-virtualizor_api_id="" value="4">Windows Server 2016 (64Bit)</option>
                <option data-server="windows" data-virtualizor_api_id="100043" value="23">Windows Server 2012 R2 (64Bit)</option>
                <option data-server="windows" data-virtualizor_api_id="" value="2">Windows Server 2012 (64Bit)</option>  
				{/if}
			</select><br>
			<div id="div-selectCpanelLinux">
			<h6>Control Panel</h6>
			<select id="selectCpanelLinux" name="selectCpanelLinux" onchange="" class="pg_inr_drop_1" style="margin: 0px 10px 10px 0px">
				<option value="0" selected="selected">ไม่ติดตั้ง</option>
				<!-- <option value="1">DirectAdmin (+100)</option>
				<option value="2">cPanel&WHM (+700)</option> 
				<option value="4">cPanel Cloud Admin (Up to 5 cPanel accounts)</option>
                <option value="5">cPanel Cloud Pro (Up to 30 cPanel accounts)</option>
                <option value="6">cPanel Cloud Plus (Up to 50 cPanel accounts)</option>
                <option value="7">cPanel Cloud Premier (Up to 100 cPanel accounts</option>
                <option value="8">Plesk Web Admin (Up to 10 Account)</option>
                <option value="9">Plesk Web Pro (Up to 30 Account)</option>
                <option value="10">Plesk Web Host (Unlimited Account)</option>
                <option value="11">DirectAdmin (Unimited Account and Domain)</option>-->
				
			</select>
			<br>
                
			</div>
			<div id="div-selectCpanelWindows" style="display: none">
			<h6>Control Panel</h6>
			<select id="selectCpanelWindows" name="selectCpanelWindows" onchange="" class="pg_inr_drop_1" style="margin: 0px 10px 10px 0px">
				<option value="0" selected="selected">ไม่ติดตั้ง</option>
				<option value="3">Plesk12 (+520)</option>
			</select><br>
			</div>
			<div id="div-selectDatabase" style="display: none">
			<h6>Database</h6>
			<select id="selectDatabase" name="selectDatabase" onchange="" class="pg_inr_drop_1" style="margin: 0px 10px 10px 0px">
				<option value="0" selected="selected">ไม่ติดตั้ง</option>
				<option value="1">SQL Express (Free)</option>
				<option value="2">MSSQL 2012 (+1000)</option>
			</select><br>
			</div>
			<br>
			{*
			{assign var=first value=0}		
			{foreach from=$dataa item=value key=keyaa}
				{assign var=first value=$first+1}
				{foreach from=$aCloudOsTempConfig item=v key=k}
					{assign var='match' value=$v.cloud}
					{if $value.variable_id == $v.apiId && preg_match("/$match/i",$product.name)}
						<input id="os-template-ubuntu {$value.id}" type="radio" name="os" value="{$value.id}" style="margin-left: 3px;" {if $first== 1} checked="checked" {/if} />
			    		<label class="drinkcard-cc {$value.id}" for="os-template-ubuntu {$value.id}" style="background-image: url(data:{$v.ext};base64,{$v.image|base64_encode}) !important;"></label>
			    		{break}
			    	{/if}
				{/foreach}
			{/foreach}
			*}
			</div>
		</div>
		<div class="select-cloud" id="server-resource">
			<div id="order-cloud-step-3" class="header-order-cloud">
				<h5>3.Server Resource</h5>
			</div>
			<div class="cc-selector cloud-step-3" style="width: 29%; display: inline-block;">
				  <div align="left" style="display: inline-block"><img src="{$template_dir}images/icon-png-ram.png" width="50px"/></div>
				  <div align="right" style="display: inline-block; margin-left: 5px;">
				  	RAM [MB]
				  </div>
			      <div align="center" style="margin-left: -45px;">
			      	<table>
				      	<tbody>
				      		<tr>
								<td>
									<div id="slider1" class="rslider"></div>
								</td>
							</tr>
				      	</tbody>
			      	</table>
			      </div>
			      <br>
			</div>
			<div class="cc-selector cloud-step-3" style="width: 29%; display: inline-block;">
				  <div align="left" style="display: inline-block"><img src="{$template_dir}images/icon-png-cpu.png" width="50px"/></div>
			      <div align="right" style="display: inline-block; margin-left: 5px;">
				  	CPU Cores
				  </div>
			      <div align="center" style="margin-left: -45px;">
			      	<table>
				      	<tbody>
				      		<tr>
								<td>
									<div id="slider2" class="rslider"></div>
								</td>
							</tr>
				      	</tbody>
			      	</table>
			      </div>
			      <br>
			</div>
			<div class="cc-selector cloud-step-3" style="width: 29%; display: inline-block;">
				  <div align="left" style="display: inline-block">
				  	<img src="{$template_dir}images/icon-png-harddisk.png" width="50px"/>
				  </div>
				  <div align="right" style="display: inline-block; margin-left: 5px;">
				  	Disk Size [GB]
				  </div>
			      <div align="center" style="margin-left: -45px;">
			      	<table>
				      	<tbody>
				      		<tr>
								<td>
									<div id="slider3" class="rslider"></div>
								</td>
							</tr>
				      	</tbody>
			      	</table>
			      </div>
			      <br>
			</div>
		<!--text for Nextcloud18 OSTemplate  -->		
		<p class = 'diskPromo' style="color: rgb(0, 111, 29);font-weight: 600;margin-top: 12px;display:none">Promotion Disk จะถูกเพิ่มหลังชำระค่าบริการเรียบร้อยแล้ว</p>
		</div>
		{if $addons}
			<div class="select-cloud">
				<div id="order-cloud-step-4" class="header-order-cloud">
					<h5>4.Add-ons</h5>
				</div>
				<div class="cc-selector-2 cloud-step-4" style="margin-bottom: 20px;font-size: 14px;">
					<p>{$lang.addons_single_desc}</p>
			        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
			            <colgroup class="firstcol"></colgroup>
			            <colgroup class="alternatecol"></colgroup>
			            <colgroup class="firstcol"></colgroup>
			
			            {foreach from=$addons item=a key=k}
						
						{assign var="aProduct" value=$aAddons[$k]}
						 {if  $a.name == 'Addon : Premium Managed' || $a.name == 'Addon : Standard Managed'}
						{else}	
			            <tr>
			                <td width="20">
			                    {if $a.name == 'Free Monitoring'}
			                        <input name="addon[{$k}]" type="checkbox" value="1" checked="checked" onchange="simulateCart('#cart3');"/>
			                        {literal}
										<script type="text/javascript">
										$(document).ready(function () {
											simulateCart('#cart3');
									    });
										</script>
									{/literal}
			                    {else}
									 <input name="addon[{$k}]" type="checkbox" value="1" {if $selected_addons.$k}checked="checked"{/if}  onchange="simulateCart('#cart3');"/> 
								{/if}
			                </td>
			                <td>
			                    <strong>{$a.name}</strong>{if $a.description!=''} - {$a.description}{/if}
			                </td>
			                <td>
			                    {if $a.paytype=='Free'}
			                    {$lang.free}
			                    <input type="hidden" name="addon_cycles[{$k}]" value="free"/>
			                    {elseif $a.paytype=='Once'}
			                    <input type="hidden" name="addon_cycles[{$k}]" value="once"/>
			                    {$a.m|price:$currency} {$lang.once} {if $a.m_setup!=0}/ {$a.m_setup|price:$currency} {$lang.setupfee}{/if}
			                    {else}
			                    <select name="addon_cycles[{$k}]"   onchange="if($('input[name=\'addon[{$k}]\']').is(':checked'))simulateCart('#cart3');" class="pg_inr_drop_1" style="margin: 0px 10px 10px 0px">
				 					{if $a.h!=0}<option value="h" {if $cycle=='h'} selected="selected"{/if}>{$lang.h} {if isset($aProduct.hDiscount) && $aProduct.hDiscount > 0} ได้รับส่วนลด {$aProduct.hDiscount|price:$currency} เหลือ {/if}{$a.h|price:$currency} {*$lang.h*}{if $a.h_setup!=0} + {$a.h_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
			                        {if $a.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$lang.d} {if isset($aProduct.dDiscount) && $aProduct.dDiscount > 0} ได้รับส่วนลด {$aProduct.dDiscount|price:$currency} เหลือ {/if}{$a.d|price:$currency} {*$lang.d*}{if $a.d_setup!=0} + {$a.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
			                        {if $a.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$lang.w} {if isset($aProduct.wDiscount) && $aProduct.wDiscount > 0} ได้รับส่วนลด {$aProduct.wDiscount|price:$currency} เหลือ {/if}{$a.w|price:$currency} {*$lang.w*}{if $a.w_setup!=0} + {$a.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
			                        {if $a.m!=0 && $product.category_id != 22}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$lang.m} {if isset($aProduct.mDiscount) && $aProduct.mDiscount > 0} ได้รับส่วนลด {$aProduct.mDiscount|price:$currency} เหลือ {/if}{$a.m|price:$currency} {*$lang.m*}{if $a.m_setup!=0} + {$a.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
			                        {if $a.q!=0 && $product.category_id != 22}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$lang.q} {if isset($aProduct.qDiscount) && $aProduct.qDiscount > 0} ได้รับส่วนลด {$aProduct.qDiscount|price:$currency} เหลือ {/if}{$a.q|price:$currency} {*$lang.q*}{if $a.q_setup!=0} + {$a.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
			                        {if $a.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$lang.s} {if isset($aProduct.sDiscount) && $aProduct.sDiscount > 0} ได้รับส่วนลด {$aProduct.sDiscount|price:$currency} เหลือ {/if}{$a.s|price:$currency} {*$lang.s*}{if $a.s_setup!=0} + {$a.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
			                        {if $a.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$lang.a} {if isset($aProduct.aDiscount) && $aProduct.aDiscount > 0} ได้รับส่วนลด {$aProduct.aDiscount|price:$currency} เหลือ {/if}{$a.a|price:$currency} {*$lang.a*}{if $a.a_setup!=0} + {$a.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
			                        {if $a.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$lang.b} {if isset($aProduct.bDiscount) && $aProduct.bDiscount > 0} ได้รับส่วนลด {$aProduct.bDiscount|price:$currency} เหลือ {/if}{$a.b|price:$currency} {*$lang.b*}{if $a.b_setup!=0} + {$a.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
			                        {if $a.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$lang.t} {if isset($aProduct.tDiscount) && $aProduct.tDiscount > 0} ได้รับส่วนลด {$aProduct.tDiscount|price:$currency} เหลือ {/if}{$a.t|price:$currency} {*$lang.t*}{if $a.t_setup!=0} + {$a.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
									{if $a.p4!=0}<option value="p4" {if $cycle=='p4'} selected="selected"{/if}>{$lang.p4} {if isset($aProduct.p4Discount) && $aProduct.p4Discount > 0} ได้รับส่วนลด {$aProduct.p4Discount|price:$currency} เหลือ {/if}{$a.p4|price:$currency} {*$lang.p4*}{if $a.p4_setup!=0} + {$a.p4_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
									{if $a.p5!=0}<option value="p5" {if $cycle=='p5'} selected="selected"{/if}>{$lang.p5} {if isset($aProduct.p5Discount) && $aProduct.p5Discount > 0} ได้รับส่วนลด {$aProduct.p5Discount|price:$currency} เหลือ {/if}{$a.p5|price:$currency} {*$lang.p5*}{if $a.p5_setup!=0} + {$a.p5_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
			                    </select>
			                    {/if}
			                </td>
			            </tr>
						{/if}
			            {/foreach}
			        </table> 
			        <br>
				</div>
			</div>
		{/if}
	{else if}
		<div class="wbox">
		  	<div class="wbox_header">
				<strong>{$product.name}</strong>
				</div>
				<div class="wbox_content" id="product_description">
			
					{$product.description}
			
			{if $product.paytype=='Free'}<br />
			<input type="hidden" name="cycle" value="Free" />
			{$lang.price} <strong>{$lang.free}</strong>
			
			{elseif $product.paytype=='Once'}<br />
			<input type="hidden" name="cycle" value="Once" />
			{$lang.price}  <strong>{$product.m|price:$currency}</strong> {$lang.once} / {$product.m_setup|price:$currency} {$lang.setupfee}
			{/if}
			</div>
		</div>
	{/if}
  
{/if}




{if   $product.type=='Dedicated' || $product.type=='Server' || $product.hostname || $custom || ($product.paytype!='Once' && $product.paytype!='Free')}

<div class="wbox" {if $product.category_id == 84 || $product.category_id == 83 || $product.category_id == 98 || $product.category_id == 99}style="display:none;"{/if}>
  	<div class="wbox_header">
	<strong>{$lang.config_options}</strong>
	</div>
	<div class="wbox_content">
	

<table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
<colgroup class="firstcol"></colgroup>
<colgroup class="alternatecol"></colgroup>




{if $product.paytype!='Once' && $product.paytype!='Free'}

	
	<tr><td class="pb10"  width="175"><strong>{$lang.pickcycle}</strong></td><td class="pb10">
<select name="cycle"   onchange="{if $custom}changeCycle('#cart3');{else}simulateCart('#cart3');{/if}" style="width:99%">
  
    {if $product.h!=0}<option value="h" {if $cycle=='h'} selected="selected"{/if}>{$lang.h} {if isset($aProduct.hDiscount) && $aProduct.hDiscount > 0} ได้รับส่วนลด {$aProduct.hDiscount|price:$currency} เหลือ {/if}{$product.h|price:$currency} {*$lang.h*}{if $product.h_setup!=0} + {$product.h_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Hourly} {$lang.freedomain}{/if}</option>{/if}
    {if $product.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$lang.d} {if isset($aProduct.dDiscount) && $aProduct.dDiscount > 0} ได้รับส่วนลด {$aProduct.dDiscount|price:$currency} เหลือ {/if}{$product.d|price:$currency} {*$lang.d*}{if $product.d_setup!=0} + {$product.d_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Daily} {$lang.freedomain}{/if}</option>{/if}
    {if $product.m!=0 && $product.category_id != 22}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$lang.m} {if isset($aProduct.mDiscount) && $aProduct.mDiscount > 0} ได้รับส่วนลด {$aProduct.mDiscount|price:$currency} เหลือ {/if}{$product.m|price:$currency} {*$lang.m*}{if $product.m_setup!=0} + {$product.m_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Monthly} {$lang.freedomain}{/if}</option>{/if}
    {if $product.q!=0 && $product.category_id != 22}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$lang.q} {if isset($aProduct.qDiscount) && $aProduct.qDiscount > 0} ได้รับส่วนลด {$aProduct.qDiscount|price:$currency} เหลือ {/if}{$product.q|price:$currency} {*$lang.q*}{if $product.q_setup!=0} + {$product.q_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Quarterly} {$lang.freedomain}{/if}</option>{/if}
    {if $product.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$lang.s} {if isset($aProduct.sDiscount) && $aProduct.sDiscount > 0} ได้รับส่วนลด {$aProduct.sDiscount|price:$currency} เหลือ {/if}{$product.s|price:$currency} {*$lang.s*}{if $product.s_setup!=0} + {$product.s_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.SemiAnnually}{$lang.freedomain}{/if}</option>{/if}
    {if $product.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$lang.a} {if isset($aProduct.aDiscount) && $aProduct.aDiscount > 0} ได้รับส่วนลด {$aProduct.aDiscount|price:$currency} เหลือ {/if}{$product.a|price:$currency} {*$lang.a*}{if $product.a_setup!=0} + {$product.a_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Annually}{$lang.freedomain}{/if}</option>{/if}
    {if $product.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$lang.b} {if isset($aProduct.bDiscount) && $aProduct.bDiscount > 0} ได้รับส่วนลด {$aProduct.bDiscount|price:$currency} เหลือ {/if}{$product.b|price:$currency} {*$lang.b*}{if $product.b_setup!=0} + {$product.b_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Biennially}{$lang.freedomain}{/if}</option>{/if}
	{if $product.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$lang.t} {if isset($aProduct.tDiscount) && $aProduct.tDiscount > 0} ได้รับส่วนลด {$aProduct.tDiscount|price:$currency} เหลือ {/if}{$product.t|price:$currency} {*$lang.t*}{if $product.t_setup!=0} + {$product.t_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Triennially}{$lang.freedomain}{/if}</option>{/if}
	{if $product.p4!=0}<option value="p4" {if $cycle=='p4'} selected="selected"{/if}>{$lang.p4} {if isset($aProduct.p4Discount) && $aProduct.p4Discount > 0} ได้รับส่วนลด {$aProduct.p4Discount|price:$currency} เหลือ {/if}{$product.p4|price:$currency} {*$lang.p4*}{if $product.p4_setup!=0} + {$product.p4_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Triennially}{$lang.freedomain}{/if}</option>{/if}
	{if $product.p5!=0}<option value="p5" {if $cycle=='p5'} selected="selected"{/if}>{$lang.p5} {if isset($aProduct.p5Discount) && $aProduct.p5Discount > 0} ได้รับส่วนลด {$aProduct.o5Discount|price:$currency} เหลือ {/if}{$product.p5|price:$currency} {*$lang.p5*}{if $product.p5_setup!=0} + {$product.p5_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Triennially}{$lang.freedomain}{/if}</option>{/if}

            

</select></td></tr>{/if}

{if $product.hostname}
<tr>
	<td class="pb10" width="175"><strong>{$lang.hostname}</strong> *</td>
	<td class="pb10"><span id="rv-site-error-domain" class="alert-error"></span><input id="domain" name="domain" type="text" value="{$item.domain}" class="styled" size="50" style="width:96%" onchange="verifyDomain();"/></td>
</tr>


{/if}

{if $custom} <input type="hidden" name="custom[-1]" value="dummy" />
	{foreach from=$custom item=cf key=iKey} 
	{if $cf.items}
	<tr>
		<td colspan="2" class="{$cf.key} cf_option">
		
			<label for="custom[{$cf.id}]" class="styled">{$cf.name} {if $cf.options & 1}*{/if}</label>
			{if $cf.description!=''}<div class="fs11 descr" style="">{$cf.description}</div>{/if}
			
                         {include file=$cf.configtemplates.cart}
			
			<div>
				<blockquote class="text-error">
				{$aCustom[$iKey].discount}
				</blockquote>
			</div>
			
		</td>
	</tr>
	{/if}
	{/foreach}

{/if}


	</table>
	
 <small>{$lang.field_marked_required}</small>
 
 </div></div>
{/if}


{if $subproducts}
<div class="wbox container">
    <div class="wbox_header">
        <strong>{$lang.additional_services}</strong>
    </div>
    <div class="wbox_content">
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
            <colgroup class="firstcol"></colgroup>
            <colgroup class="alternatecol"></colgroup>
            <colgroup class="firstcol"></colgroup>

            {foreach from=$subproducts item=a key=k}
			{assign var="aProduct" value=$aSubProducts[$k]}
            <tr><td width="20"><input name="subproducts[{$k}]" type="checkbox" value="1" {if $selected_subproducts.$k}checked="checked"{/if}  onchange="simulateCart('#cart3');"/></td>
                <td>
                    <strong>{$a.category_name} - {$a.name}</strong>
                </td>
                <td>
                    {if $a.paytype=='Free'}
                    {$lang.free}
                    <input type="hidden" name="subproducts_cycles[{$k}]" value="free"/>
                    {elseif $a.paytype=='Once'}
                    <input type="hidden" name="subproducts_cycles[{$k}]" value="once"/>
                    {$a.m|price:$currency} {$lang.once} {if $a.m_setup!=0}/ {$a.m_setup|price:$currency} {$lang.setupfee}{/if}
                    {else}
                    {if $custom}
	 {if $a.h!=0}{if $cycle=='h'} {$lang.h} {if isset($aProduct.hDiscount) && $aProduct.hDiscount > 0} ได้รับส่วนลด {$aProduct.hDiscount|price:$currency} เหลือ {/if}{$a.h|price:$currency} {*$lang.h*}{if $a.h_setup!=0} + {$a.h_setup|price:$currency} {$lang.setupfee}{/if}{/if}{/if}
                        {if $a.d!=0}{if $cycle=='d'}{$lang.d} {if isset($aProduct.dDiscount) && $aProduct.dDiscount > 0} ได้รับส่วนลด {$aProduct.dDiscount|price:$currency} เหลือ {/if}{$a.d|price:$currency} {*$lang.d*}{if $a.d_setup!=0} + {$a.d_setup|price:$currency} {$lang.setupfee}{/if}{$lang.d} {if isset($aProduct.dDiscount) && $aProduct.dDiscount > 0} ได้รับส่วนลด {$aProduct.dDiscount|price:$currency} เหลือ {/if}{$a.d|price:$currency} {*$lang.d*}{if $a.d_setup!=0} + {$a.d_setup|price:$currency} {$lang.setupfee}{/if}{/if}{/if}
                        {if $a.w!=0}{if $cycle=='w'}{$lang.w} {if isset($aProduct.wDiscount) && $aProduct.wDiscount > 0} ได้รับส่วนลด {$aProduct.wDiscount|price:$currency} เหลือ {/if}{$a.w|price:$currency} {*$lang.w*}{if $a.w_setup!=0} + {$a.w_setup|price:$currency} {$lang.setupfee}{/if}{/if}{/if}
                        {if $a.m!=0}{if $cycle=='m'}{$lang.m} {if isset($aProduct.mDiscount) && $aProduct.mDiscount > 0} ได้รับส่วนลด {$aProduct.mDiscount|price:$currency} เหลือ {/if}{$a.m|price:$currency} {*$lang.m*}{if $a.m_setup!=0} + {$a.m_setup|price:$currency} {$lang.setupfee}{/if}{/if}{/if}
                        {if $a.q!=0}{if $cycle=='q'}{$lang.q} {if isset($aProduct.qDiscount) && $aProduct.qDiscount > 0} ได้รับส่วนลด {$aProduct.qDiscount|price:$currency} เหลือ {/if}{$a.q|price:$currency} {*$lang.q*}{if $a.q_setup!=0} + {$a.q_setup|price:$currency} {$lang.setupfee}{/if}{/if}{/if}
                        {if $a.s!=0}{if $cycle=='s'}{$lang.s} {if isset($aProduct.sDiscount) && $aProduct.sDiscount > 0} ได้รับส่วนลด {$aProduct.sDiscount|price:$currency} เหลือ {/if}{$a.s|price:$currency} {*$lang.s*}{if $a.s_setup!=0} + {$a.s_setup|price:$currency} {$lang.setupfee}{/if}{/if}{/if}
                        {if $a.a!=0}{if $cycle=='a'}{$lang.a} {if isset($aProduct.aDiscount) && $aProduct.aDiscount > 0} ได้รับส่วนลด {$aProduct.aDiscount|price:$currency} เหลือ {/if}{$a.a|price:$currency} {*$lang.a*}{if $a.a_setup!=0} + {$a.a_setup|price:$currency} {$lang.setupfee}{/if}{/if}{/if}
                        {if $a.b!=0}{if $cycle=='b'}{$lang.b} {if isset($aProduct.bDiscount) && $aProduct.bDiscount > 0} ได้รับส่วนลด {$aProduct.bDiscount|price:$currency} เหลือ {/if}{$a.b|price:$currency} {*$lang.b*}{if $a.b_setup!=0} + {$a.b_setup|price:$currency} {$lang.setupfee}{/if}{/if}{/if}
                        {if $a.t!=0}{if $cycle=='t'}{$lang.t} {if isset($aProduct.tDiscount) && $aProduct.tDiscount > 0} ได้รับส่วนลด {$aProduct.tDiscount|price:$currency} เหลือ {/if}{$a.t|price:$currency} {*$lang.t*}{if $a.t_setup!=0} + {$a.t_setup|price:$currency} {$lang.setupfee}{/if}{/if}{/if}
						{if $a.p4!=0}{if $cycle=='p4'}{$lang.p4} {if isset($aProduct.p4Discount) && $aProduct.p4Discount > 0} ได้รับส่วนลด {$aProduct.p4Discount|price:$currency} เหลือ {/if}{$a.p4|price:$currency} {*$lang.p4*}{if $a.p4_setup!=0} + {$a.p4_setup|price:$currency} {$lang.setupfee}{/if}{/if}{/if}
						{if $a.p5!=0}{if $cycle=='p5'}{$lang.p5} {if isset($aProduct.p5Discount) && $aProduct.p5Discount > 0} ได้รับส่วนลด {$aProduct.p5Discount|price:$currency} เหลือ {/if}{$a.p5|price:$currency} {*$lang.p5*}{if $a.p5_setup!=0} + {$a.p5_setup|price:$currency} {$lang.setupfee}{/if}{/if}{/if}

                   {/if} 
                    <select name="subproducts_cycles[{$k}]" {if $custom}style="display:none;"{/if}   onchange="if($('input[name=\'subproducts[{$k}]\']').is(':checked'))simulateCart('#cart3');">
	 {if $a.h!=0}<option value="h" {if $cycle=='h'} selected="selected"{/if}>{$lang.h} {if isset($aProduct.hDiscount) && $aProduct.hDiscount > 0} ได้รับส่วนลด {$aProduct.hDiscount|price:$currency} เหลือ {/if}{$a.h|price:$currency} {*$lang.h*}{if $a.h_setup!=0} + {$a.h_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$lang.d} {if isset($aProduct.dDiscount) && $aProduct.dDiscount > 0} ได้รับส่วนลด {$aProduct.dDiscount|price:$currency} เหลือ {/if}{$a.d|price:$currency} {*$lang.d*}{if $a.d_setup!=0} + {$a.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$lang.w} {if isset($aProduct.wDiscount) && $aProduct.wDiscount > 0} ได้รับส่วนลด {$aProduct.wDiscount|price:$currency} เหลือ {/if}{$a.w|price:$currency} {*$lang.w*}{if $a.w_setup!=0} + {$a.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.m!=0}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$lang.m} {if isset($aProduct.mDiscount) && $aProduct.mDiscount > 0} ได้รับส่วนลด {$aProduct.mDiscount|price:$currency} เหลือ {/if}{$a.m|price:$currency} {*$lang.m*}{if $a.m_setup!=0} + {$a.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.q!=0}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$lang.q} {if isset($aProduct.qDiscount) && $aProduct.qDiscount > 0} ได้รับส่วนลด {$aProduct.qDiscount|price:$currency} เหลือ {/if}{$a.q|price:$currency} {*$lang.q*}{if $a.q_setup!=0} + {$a.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$lang.s} {if isset($aProduct.sDiscount) && $aProduct.sDiscount > 0} ได้รับส่วนลด {$aProduct.sDiscount|price:$currency} เหลือ {/if}{$a.s|price:$currency} {*$lang.s*}{if $a.s_setup!=0} + {$a.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$lang.a} {if isset($aProduct.aDiscount) && $aProduct.aDiscount > 0} ได้รับส่วนลด {$aProduct.aDiscount|price:$currency} เหลือ {/if}{$a.a|price:$currency} {*$lang.a*}{if $a.a_setup!=0} + {$a.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$lang.b} {if isset($aProduct.bDiscount) && $aProduct.bDiscount > 0} ได้รับส่วนลด {$aProduct.bDiscount|price:$currency} เหลือ {/if}{$a.b|price:$currency} {*$lang.b*}{if $a.b_setup!=0} + {$a.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$lang.t} {if isset($aProduct.tDiscount) && $aProduct.tDiscount > 0} ได้รับส่วนลด {$aProduct.tDiscount|price:$currency} เหลือ {/if}{$a.t|price:$currency} {*$lang.t*}{if $a.t_setup!=0} + {$a.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
						{if $a.p4!=0}<option value="p4" {if $cycle=='p4'} selected="selected"{/if}>{$lang.p4} {if isset($aProduct.p4Discount) && $aProduct.p4Discount > 0} ได้รับส่วนลด {$aProduct.p4Discount|price:$currency} เหลือ {/if}{$a.p4|price:$currency} {*$lang.p4*}{if $a.p4_setup!=0} + {$a.p4_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
						{if $a.p5!=0}<option value="p5" {if $cycle=='p5'} selected="selected"{/if}>{$lang.p5} {if isset($aProduct.p5Discount) && $aProduct.p5Discount > 0} ได้รับส่วนลด {$aProduct.p5Discount|price:$currency} เหลือ {/if}{$a.p5|price:$currency} {*$lang.p5*}{if $a.p5_setup!=0} + {$a.p5_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                    </select>
                    {/if}
                </td>
            </tr>
            {/foreach}
        </table>
    </div></div>
{/if}

{if $addons && $product.category_id != 84 && $product.category_id != 83 && $product.category_id != 98 && $product.category_id != 99}
<div class="wbox container">
    <div class="wbox_header">
        <strong>{$lang.addons_single}</strong>
    </div>
    <div class="wbox_content">
        <p>{$lang.addons_single_desc}</p>
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
            <colgroup class="firstcol"></colgroup>
            <colgroup class="alternatecol"></colgroup>
            <colgroup class="firstcol"></colgroup>

            {foreach from=$addons item=a key=k}
			{assign var="aProduct" value=$aAddons[$k]}
            <tr>
                <td width="20">
                    {if $a.name == 'Free Monitoring'}
                        <input name="addon[{$k}]" type="checkbox" value="1" checked="checked" onchange="simulateCart('#cart3');"/>
                        {literal}
							<script type="text/javascript">
							$(document).ready(function () {
								simulateCart('#cart3');
						    });
							</script>
						{/literal}
                    {else}
                        <input name="addon[{$k}]" type="checkbox" value="1" {if $selected_addons.$k}checked="checked"{/if}  onchange="simulateCart('#cart3');"/>
                    {/if}
                </td>
                <td>
                    <strong>{$a.name}</strong>{if $a.description!=''} - {$a.description}{/if}
                </td>
                <td>
                    {if $a.paytype=='Free'}
                    {$lang.free}
                    <input type="hidden" name="addon_cycles[{$k}]" value="free"/>
                    {elseif $a.paytype=='Once'}
                    <input type="hidden" name="addon_cycles[{$k}]" value="once"/>
                    {$a.m|price:$currency} {$lang.once} {if $a.m_setup!=0}/ {$a.m_setup|price:$currency} {$lang.setupfee}{/if}
                    {else}
                    <select name="addon_cycles[{$k}]"   onchange="if($('input[name=\'addon[{$k}]\']').is(':checked'))simulateCart('#cart3');">
	 {if $a.h!=0}<option value="h" {if $cycle=='h'} selected="selected"{/if}>{$lang.h} {if isset($aProduct.hDiscount) && $aProduct.hDiscount > 0} ได้รับส่วนลด {$aProduct.hDiscount|price:$currency} เหลือ {/if}{$a.h|price:$currency} {*$lang.h*}{if $a.h_setup!=0} + {$a.h_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$lang.d} {if isset($aProduct.dDiscount) && $aProduct.dDiscount > 0} ได้รับส่วนลด {$aProduct.dDiscount|price:$currency} เหลือ {/if}{$a.d|price:$currency} {*$lang.d*}{if $a.d_setup!=0} + {$a.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$lang.w} {if isset($aProduct.wDiscount) && $aProduct.wDiscount > 0} ได้รับส่วนลด {$aProduct.wDiscount|price:$currency} เหลือ {/if}{$a.w|price:$currency} {*$lang.w*}{if $a.w_setup!=0} + {$a.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.m!=0 && $product.category_id != 22}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$lang.m} {if isset($aProduct.mDiscount) && $aProduct.mDiscount > 0} ได้รับส่วนลด {$aProduct.mDiscount|price:$currency} เหลือ {/if}{$a.m|price:$currency} {*$lang.m*}{if $a.m_setup!=0} + {$a.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.q!=0 && $product.category_id != 22}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$lang.q} {if isset($aProduct.qDiscount) && $aProduct.qDiscount > 0} ได้รับส่วนลด {$aProduct.qDiscount|price:$currency} เหลือ {/if}{$a.q|price:$currency} {*$lang.q*}{if $a.q_setup!=0} + {$a.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$lang.s} {if isset($aProduct.sDiscount) && $aProduct.sDiscount > 0} ได้รับส่วนลด {$aProduct.sDiscount|price:$currency} เหลือ {/if}{$a.s|price:$currency} {*$lang.s*}{if $a.s_setup!=0} + {$a.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$lang.a} {if isset($aProduct.aDiscount) && $aProduct.aDiscount > 0} ได้รับส่วนลด {$aProduct.aDiscount|price:$currency} เหลือ {/if}{$a.a|price:$currency} {*$lang.a*}{if $a.a_setup!=0} + {$a.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$lang.b} {if isset($aProduct.bDiscount) && $aProduct.bDiscount > 0} ได้รับส่วนลด {$aProduct.bDiscount|price:$currency} เหลือ {/if}{$a.b|price:$currency} {*$lang.b*}{if $a.b_setup!=0} + {$a.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$lang.t} {if isset($aProduct.tDiscount) && $aProduct.tDiscount > 0} ได้รับส่วนลด {$aProduct.tDiscount|price:$currency} เหลือ {/if}{$a.t|price:$currency} {*$lang.t*}{if $a.t_setup!=0} + {$a.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
						{if $a.p4!=0}<option value="p4" {if $cycle=='p4'} selected="selected"{/if}>{$lang.p4} {if isset($aProduct.p4Discount) && $aProduct.p4Discount > 0} ได้รับส่วนลด {$aProduct.p4Discount|price:$currency} เหลือ {/if}{$a.p4|price:$currency} {*$lang.p4*}{if $a.p4_setup!=0} + {$a.p4_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
						{if $a.p5!=0}<option value="p5" {if $cycle=='p5'} selected="selected"{/if}>{$lang.p5} {if isset($aProduct.p5Discount) && $aProduct.p5Discount > 0} ได้รับส่วนลด {$aProduct.p5Discount|price:$currency} เหลือ {/if}{$a.p5|price:$currency} {*$lang.p5*}{if $a.p5_setup!=0} + {$a.p5_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                    </select>
                    {/if}
                </td>
            </tr>
            {/foreach}
        </table>
    </div></div>
{/if}





<input name='action' value='addconfig' type='hidden' /><br />

<div class="orderbox">
	<div class="orderboxpadding">
		<center>
			<input type="submit" value="{$lang.continue}" style="font-weight:bold;font-size:12px;"  class="padded btn  btn-primary" {if $product.category_id == 83 || $product.category_id == 84 || $product.category_id == 98 || $product.category_id == 99} id="cart3Cloud"{/if}/>
		</center>
	</div>
</div>

</form>

<script language="JavaScript">
{literal}
    $("#cart3Cloud").click(function(event){
         event.preventDefault();
         $.post('?cmd=serviceshandle&action=verifyDomain',{
             hostname: $("#domain").val()
         },function(data) {
             // CALL BACK
             data = jQuery.parseJSON(data);
             
             if (data.ERROR != "") {
                 $("#rv-site-error-domain").html(''+data.ERROR);
                 $("#rv-site-error-domain1").html(''+data.ERROR);
                 $("#forCloudDomain").focus();
                 $("#forCloudDomain").select();
                 return false;
             } else {
                 $(".formcart3Cloud").submit();    
             }
             
         });
    });
  
    var ramid = $('label:contains("RAM [GB]")').attr('for');
    var cpuid = $('label:contains("CPU Cores")').attr('for');
    var hddid = $('label:contains("Disk Size [GB]")').attr('for');
    
	function changeCloud(id){
		$('#cart3').attr('action' , '?cmd=cart');
		$('#cart3').append('<input name=\"action\" value=\"add\" type=\"hidden\"> ');
		$('#cart3').append('<input name=\"id\" value=\"' + id + '\" type=\"hidden\"> ');
		$('#cart3').submit();
	}

	$('#server-vps').click(function(){
		updateSession('cloudLocation',882);
		changeCloud(882);
		//window.open('?cmd=cart&action=add&id=836','_self');
	});
	$('#server-vmware').click(function(){
		updateSession('cloudLocation',883);
		changeCloud(883);
	});

	$("input[name^='os']").click(function( event ) {
		var id = $('label:contains("OS Template")').next().next().attr('id');
        $('#'+id+' option[value=\''+$(this).val()+'\']').prop('selected', true);
        simulateCart('#cart3');
        /*$('html, body').animate({
	        scrollTop: $("#server-resource").offset().top
	    }, 1000);*/
    });
    
    $('#cloud-location').change(function(){
    	updateSession('cloudLocation',$(this).val());
    	changeCloud($(this).val());
    });
    
    
    $("#slider1").change(function(){
		
    	var obj = $("#slider1").data("roundSlider");
		var value = obj.getValue();
		var str   =  ramid;
		var ramNewId  = str.substring(str.indexOf("[")+1, str.length - 1);
    	$('#custom_field_'+ramNewId).val(value);
    	$('#custom_field_'+ramNewId).change();

    	updateSession('curRam',value);
    });
    
    $("#slider2").change(function(){
    	
    	var obj = $("#slider2").data("roundSlider");
		var value = obj.getValue();
		var str   =  cpuid;
  		var cpuNewId  = str.substring(str.indexOf("[")+1, str.length - 1);
    	$('#custom_field_'+cpuNewId).val(value);
    	$('#custom_field_'+cpuNewId).change();

    	updateSession('curCpu',value);
    	
    });
    
    $("#slider3").change(function(){
    	
    	var obj   = $("#slider3").data("roundSlider");
	    var value = obj.getValue();
		var str   =  hddid;
  		var hddNewId  = str.substring(str.indexOf("[")+1, str.length - 1);
    	//$('#'+hddid).val(value);
    	//$('#'+hddid).change();
		$('#custom_field_'+hddNewId).val(value);
    	$('#custom_field_'+hddNewId).change();
    	updateSession('curHdd',value);
    	
    });
    		
	$("#slider1").roundSlider({
		min: '{/literal}{$custom[$customRamId].config.minvalue}{literal}',
	    max: '{/literal}{$custom[$customRamId].config.maxvalue}{literal}',
	    step: '{/literal}{$custom[$customRamId].config.step}{literal}',
	    value: '{/literal}{if $CustomRamValue}{$CustomRamValue}{else}{$custom[$customRamId].config.initialval}{/if}{literal}',
	    sliderType: "min-range",
	    editableTooltip: false,
	    radius: 80,
	});
	
	$("#slider2").roundSlider({
		min: '{/literal}{$custom[$customCpuId].config.minvalue}{literal}',
	    max: '{/literal}{$custom[$customCpuId].config.maxvalue}{literal}',
	    step: '{/literal}{$custom[$customCpuId].config.step}{literal}',
	    value: '{/literal}{if $CustomCpuValue}{$CustomCpuValue}{else}{$custom[$customCpuId].config.initialval}{/if}{literal}',
	    sliderType: "min-range",
	    editableTooltip: false,
	    radius: 80,
	});
	
	$("#slider3").roundSlider({
		min: '{/literal}{$custom[$customHddId].config.minvalue}{literal}',
	    max: '{/literal}{$custom[$customHddId].config.maxvalue}{literal}',
	    step: '{/literal}{$custom[$customHddId].config.step}{literal}',
	    value: '{/literal}{if $CustomHddValue}{$CustomHddValue}{else}{$custom[$customHddId].config.initialval}{/if}{literal}',
	    sliderType: "min-range",
	    editableTooltip: false,
	    radius: 80,
	});
	
	$('#order-cloud-step-1').click(function(){
		$('.cloud-step-1').toggle('slow');
	});
	$('#order-cloud-step-2').click(function(){
		$('.cloud-step-2').toggle('slow');
	});
	$('#order-cloud-step-3').click(function(){
		$('.cloud-step-3').toggle('slow');
	});
	$('#order-cloud-step-4').click(function(){
		$('.cloud-step-4').toggle('slow');
	});
	
	$('#selectOsTemplate').change(function(){
		var server 	= $(this).find(':selected').attr('data-server');

		if (server == 'linux') {
			$('#div-selectCpanelLinux').hide();
			$('#div-selectCpanelWindows').hide();
			$('#div-selectDatabase').hide();
		}else if (server == 'windows') {
			$('#div-selectCpanelLinux').hide();
			$('#div-selectCpanelWindows').show();
			$('#div-selectDatabase').show();
		}else {
			$('#div-selectCpanelLinux').hide();
			$('#div-selectCpanelWindows').hide();
			$('#div-selectDatabase').hide();
		}
		getTemplateAPIID();
	});
	
	$('#selectCpanelLinux').change(function(){
		getTemplateAPIID();
	});
	$('#selectCpanelWindows').change(function(){
		getTemplateAPIID();
	});
	$('#selectDatabase').change(function(){
		getTemplateAPIID();
	});
	
	
	if('{/literal}{$smarty.session.currentCloudSelectData.controlpanel}{literal}' != ''){
	    if('{/literal}{$smarty.session.currentCloudSelectData.type}{literal}' == 'vps'){
	        $('#selectCpanelLinux option[value=\'{/literal}{$smarty.session.currentCloudSelectData.controlpanel}{literal}\']').prop('selected', true);
			if('{/literal}{$smarty.session.currentCloudSelectData.tem}{literal}' != ''){	
				$('#selectOsTemplate option[value=\'{/literal}{$smarty.session.currentCloudSelectData.tem}{literal}\']').prop('selected', true);
			}
		}
	    if('{/literal}{$smarty.session.currentCloudSelectData.type}{literal}' == 'vm'){
	        if('{/literal}{$smarty.session.currentCloudSelectData.os}{literal}' == 'linux'){
                $('#selectCpanelLinux option[value=\'{/literal}{$smarty.session.currentCloudSelectData.controlpanel}{literal}\']').prop('selected', true);
				
			}else if('{/literal}{$smarty.session.currentCloudSelectData.os}{literal}' == 'windows'){
                $('#selectCpanelWindows option[value=\'{/literal}{$smarty.session.currentCloudSelectData.controlpanel}{literal}\']').prop('selected', true);
            }
        }
	}
	
	//if('{/literal}{$smarty.session.currentCloudSelectData.type}{literal}' == 'vm'){
	    if('{/literal}{$smarty.session.currentCloudSelectData.os}{literal}' == 'windows'){
            $('#selectOsTemplate option[value=\'2\']').prop('selected', true);
        }
        
        if('{/literal}{$smarty.session.currentCloudSelectData.controlpanel}{literal}' != ''){
             $('#selectCpanelWindows option[value=\'{/literal}{$smarty.session.currentCloudSelectData.controlpanel}{literal}\']').prop('selected', true);
        }
        if('{/literal}{$smarty.session.currentCloudSelectData.db}{literal}' != ''){
             $('#selectDatabase option[value=\'{/literal}{$smarty.session.currentCloudSelectData.db}{literal}\']').prop('selected', true);
        }

	//}
	

	function getTemplateAPIID(){
		var server 	= $('#selectOsTemplate').find(':selected').attr('data-server');
		var virtualizorApiId  		= $('#selectOsTemplate').find(':selected').attr('data-virtualizor_api_id');	
		if (virtualizorApiId === undefined) {
			virtualizorApiId	= 0;
		}
		var baseOS			=	$('#selectOsTemplate').val();
		if(baseOS == 24){
			$('.diskPromo').show();
		}
		else{
			$('.diskPromo').hide();
		}
		var controlPanel	=	'';
		var database		=	'';
		if (server == 'linux') {
			controlPanel	=	$('#selectCpanelLinux').val();
			database	=	3;
		}else if (server == 'windows') {
			controlPanel	=	$('#selectCpanelWindows').val();
			database		=	$('#selectDatabase').val();
		}
		
		var productName = '{/literal}{$product.name}{literal}';
		var product 	= 'virtualizor';
		var matches		= productName.match(/VMWare/ig);
		
		if(matches){
			productName = 'vmware';
		} 

		$.post('?cmd=serviceshandle&action=getCloudOsTemplateApiId', 
		{ 
			'virtualizorApiId' : virtualizorApiId
			, 'baseos': baseOS 
			, 'controlPanel': controlPanel 
			, 'database': database 
			, 'productId': '{/literal}{$product.id}{literal}'
			, 'productName': productName
		}
		
    		, function (data) {
    			
    			if($.parseJSON(data.data) === false){
    				console.log('Have no template.');
    				return false;
					resetostemplate();
    				return false;
    			}

    			var obj = $.parseJSON(data.data);
				
    			var id = $('label:contains("OS Template")').next().next().attr('id');
				var findID = $("#"+id).find('option:selected');
				
				findID.removeAttr('selected');
				$("#"+id+" option[value='" + obj.id + "']").attr("selected","selected");
		        simulateCart('#cart3');
		        
       	});
		
	}
	
	function resetostemplate(){
		
		$('#selectOsTemplate option[value=5]').prop('selected', true);
		$('#selectOsTemplate').change();
		$('#selectCpanelLinux option[value=0]').prop('selected', true);
		$('#selectCpanelLinux').change();
        return false;
	}

	$('label:contains("Domain Name")').next().val('{/literal}{$smarty.session.Cart.1.domain}{literal}');
	$('label:contains("Default Email")').next().val('{/literal}{$smarty.session.o365data.defaultEmail}@{$smarty.session.Cart.1.domain}{literal}');
	$('label:contains("Annual Subscription")').next().next().next().val('{/literal}{$smarty.session.o365data.quantity}{literal}');

function setConfigOS(){
   // $('.custom_field custom_field_720').parent('td').parent('tr').hide();
    //$('.custom_field custom_field_720').text('');
     
    var os = $('.custom_field_1197 option:selected').text();

    if(os.match(/windows.*/gi)){
        setWindows();
    }
    else{
          setLinux();
    }
   // $("select option:contains('Value a')").attr("disabled","disabled")
}

/*
 * disable control panel for linux
 */
function setWindows(){
    $(".custom_field_721 option").each(function() {
        var txtoption = $(this).text();
        if(txtoption.match(/parall.*/gi)) {
            $(this).attr("disabled", false);
        }
        else if(txtoption.match(/(cpanel|direct).*/gi)) {
            $(this).attr("disabled", "disabled");
        }
    });
    $(".custom_field_1206 option").each(function() {
        
            $(this).attr("disabled", false);
       
    });
    $(".custom_field_1208 option").each(function() {
        
            $(this).attr("disabled", false);
       
    });
    $(".custom_field_1209 option").each(function() {
        
            $(this).attr("disabled", false);
       
    });
}

/*
 * disable config for windows
 */
function setLinux(){
    $(".custom_field_721 option").each(function() {
        var txtoption = $(this).text();
        if(txtoption.match(/(cpanel|direct).*/gi)) {
            $(this).attr("disabled", false);
        }
        else if(txtoption.match(/parall.*/gi)) {
            $(this).attr("disabled", "disabled");
        }
    });
    $(".custom_field_1206 option").each(function() {
         var txtoption2 = $(this).text();
         if(txtoption2.match(/microsoft.*/gi)) {
            $(this).attr("disabled", "disabled");
         }
       
    });
    $(".custom_field_1208 option").each(function() {
         var txtoption2 = $(this).text();
         if(txtoption2.match(/kaspersky.*/gi)) {
            $(this).attr("disabled", "disabled");
         }
       
    });
    $(".custom_field_1209 option").each(function() {
         var txtoption2 = $(this).text();
         if(txtoption2.match(/iis.*/gi)) {
            $(this).attr("disabled", "disabled");
         }
       
    });
}
$(document).ready( function () {
    simulateCart('#cart3');
    $("[name='{/literal}{$namefreemonitor}{literal}']").prop('checked',true);
    $("[name='{/literal}{$namefreemonitor}{literal}']").attr('onclick','return false;');
    $("[name='{/literal}{$namefreemonitor}{literal}']").css('opacity','0.5');
    setConfigOS();
    $('.custom_field_1197').change(function(){
        $('.custom_field_721').prop("selectedIndex",0);
        setConfigOS();
    });
	setTimeout(function(){$("#slider1").change();}, 2000);
  	setTimeout(function(){$("#slider2").change();}, 3000);
   	setTimeout(function(){$("#slider3").change();}, 4000);
    $("#cloud-location option[value=\'{/literal}{$smarty.session.currentCloudSelectData.cLocation}{literal}\']").prop('selected', true);
	
	$('#selectOsTemplate').change();
	
});

function addToDomain(){
	$('#domain').val($('#forCloudDomain').val());
	$('#domain').change();
}

function changeRealCycle(){
    
    $("[name=\'cycle\'] option[value=\'"+$('#cloudCycle').val()+"\']").prop('selected', true);
    changeCycle('#cart3');
}

function updateSession(method,value){
   
    	$.post('?cmd=carthandle&action=updateSession', { 'method':method , 'value':value }
    	
    		, function (data) {
    		   
       	});
 }


{/literal}
</script>
{/if}