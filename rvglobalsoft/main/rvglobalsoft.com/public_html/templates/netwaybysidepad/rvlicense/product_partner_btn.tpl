{php}
    include_once $this->template_dir . 'rvlicense/product_partner_btn.tpl.php';
{/php}
<!-- {$aBtn|@debug_print_var} -->
<div class="top-btm-padding">

<span {if not $aBtn.sb7_noc} style="display:none;"{/if}>
<form method="POST" action="index.php?cmd=clientarea&rvaction=partner" style="display:inline-block;">
<input type="hidden" name="rvaction" value="partner"/>
<input type="hidden" name="rvcmd" value="rvsitebuilder_license"/>
<input type="hidden" name="product_id" value="{$aBtn.sb7_noc}"/>
<button class="clearstyle btn green-custom-btn l-btn">
<i class="icon-shopping-cart icon-white"></i>
Add RVSitebuilder NOC License</button>
 {securitytoken}</form>
 </span>
 

<span {if not $aBtn.sb_in} style="display:none;"{/if}>
<form method="POST" action="index.php?cmd=clientarea&rvaction=partner" style="display:inline-block;">
<input type="hidden" name="rvaction" value="partner"/>
<input type="hidden" name="rvcmd" value="rvsitebuilder_license"/>
<input type="hidden" name="product_id" value="{$aBtn.sb_in}"/>
<button class="clearstyle btn green-custom-btn l-btn">
<i class="icon-shopping-cart icon-white"></i>
Add RVSitebuilder internal</button>
 {securitytoken}</form>
 </span>
 
 
 
 <span {if not $aBtn.sb_ex} style="display:none;"{/if}>
<form method="POST" action="index.php?cmd=clientarea&rvaction=partner" style="display:inline-block;">
<input type="hidden" name="rvaction" value="partner"/>
<input type="hidden" name="rvcmd" value="rvsitebuilder_license"/>
<input type="hidden" name="product_id" value="{$aBtn.sb_ex}"/>
<button class="clearstyle btn green-custom-btn l-btn">
<i class="icon-shopping-cart icon-white"></i>
Add RVSitebuilder external</button>
 {securitytoken}</form>
 </span>
 
<span {if not $aBtn.sk_in} style="display:none;"{/if}>
<form method="POST" action="index.php?cmd=clientarea&rvaction=partner" style="display:inline-block;">
<input type="hidden" name="cmd" value="clientarea"/>
<input type="hidden" name="rvaction" value="partner"/>
<input type="hidden" name="rvcmd" value="rvskin_license"/>
<input type="hidden" name="product_id" value="{$aBtn.sk_in}"/>
<button class="clearstyle btn green-custom-btn l-btn">
<i class="icon-shopping-cart icon-white"></i>
Add RVSkin internal</button>
 {securitytoken}</form>
 </span>
 
 <span {if not $aBtn.sk_ex} style="display:none;"{/if}>
<form method="POST" action="index.php?cmd=clientarea&rvaction=partner" style="display:inline-block;">
<input type="hidden" name="rvaction" value="partner"/>
<input type="hidden" name="rvcmd" value="rvskin_license"/>
<input type="hidden" name="product_id" value="{$aBtn.sk_ex}"/>
<button class="clearstyle btn green-custom-btn l-btn">
<i class="icon-shopping-cart icon-white"></i>
Add RVSkin external</button>
 {securitytoken}</form>
 </span>

 <span>
	<form method="POST" action="index.php?cmd=clientarea&rvaction=partner" style="display:inline-block;">
		<input type="hidden" name="rvaction" value="partner"/>
		<input type="hidden" name="rvcmd" value="remote_issue"/>
		<button class="clearstyle btn green-custom-btn l-btn">
			<i class="icon-eye-open icon-white"></i>
			Remote API Access
		</button>
 		{securitytoken}
 	</form>
 </span>
    <a href="https://support.rvglobalsoft.com/hc/en-us/sections/360000002693-Partner-API" class="link" target="_blank"><i class="icon-info-sign"></i> API Setup</a><br /><br />
    {if isset($noc.client_id)}
        {* <div class="row-fluid padd" style=" background: #fef8d9;padding-bottom: 10px;"> 
            <div style="padding: 15px 100px 0px 10px;"> 
               <p style="color: #000;font-size: 18px;font-weight: bold;">&nbsp;<img src="{$template_dir}images/noc.png" alt="" style="height: auto;width: 27px;">&nbsp;&nbsp;Important Notice for RVsitebuilder NOC Partner </p>
               <p style="font-size: 16px;padding-left: 14px;color: #000;">RVsitebuilder price for NOC Partner is going to update on your account on <span style="color: #ff0000"> 7 July 2019.</span> I sent an email to you to inform the change of RVsitebuilder price for NOC partner since February.<br><br>
                   The email contained the information of the updated price and sample of what would change in your account. You may check in your inbox with email subject “ <span style="font-style: oblique;font-weight: bold;">Important: RVsitebuilder 7 New Price and Agreement for our NOC Partner </span>“ or contact me directly at <span style="color: #ff0000">sirishom@rvglobalsoft.com</span> 
                </p>
            </div>
        </div>    *}
{/if} 

</div>



