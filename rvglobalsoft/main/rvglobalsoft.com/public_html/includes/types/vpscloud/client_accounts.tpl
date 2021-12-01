<style type="text/css">
{literal}

.page_tabs {
margin-bottom:-1px;
margin-top:0;
position:relative;
width:870px;
z-index:10;
margin:0px;
padding:0px;
overflow:hidden;
list-style:none;
}
.page_tabs li {

display:block;
float:left;
margin:20px 5px 0 0;
}
.page_tabs li a.active {
background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/nav-repeat-active.gif") repeat-x scroll 0 0 transparent;
color:#000000;
height:31px;
margin-bottom:-3px;
margin-top:0;
}
.page_tabs li a span {
display:block;
float:left;
}

.page_tabs li a.active .left-border {
background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/nav-left-active.gif") no-repeat scroll 0 0 transparent;
height:31px;
width:5px;
float:left;
display:block
}
.page_tabs li a.active .right-border {
background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/nav-right-active.gif") no-repeat scroll 0 0 transparent;
height:31px;
width:5px;
}
.page_tabs li a:hover {
text-decoration:underline;
}
.page_tabs li a {
background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/nav-repeat.gif") repeat-x scroll 0 0 transparent;
color:#4E4E4E;
display:block;
float:left;
font-size:100%;
height:25px;
margin-bottom:3px;
margin-top:3px;
overflow:hidden;
padding:0;
text-decoration:none;
}
.page_tabs li a .text {
padding:5px 5px 0;
}
.page_tabs li a .right-border {
background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/nav-right.gif") no-repeat scroll 0 0 transparent;
float:left;
height:26px;
width:5px;
}
.page_tabs li a .left-border {
background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/nav-left.gif") no-repeat scroll 0 0 transparent;
height:26px;
width:5px;
}	

.virtual-machine-details-content {
background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/content-repeat-wide.gif") repeat-y scroll 0 0 transparent;
padding:10px;
}
.virtual-machine-details-bottom {
background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/content-bottom-wide.gif") no-repeat scroll 0 0 transparent;
height:5px;
width:936px;
}
.virtual-machine-details {
float:left;
position:relative;
width:876px;

z-index:1;
}
td.right-aligned b{
    padding-right: 10px;
}
.virtual-machine-details .grey-bar {
background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/under-nav-bar-wide.gif") no-repeat scroll 0 0 transparent;
height:27px;
margin-top:-3px;
overflow:hidden;
}
.grey-bar dl.actions dt {
float:left;
}
.grey-bar dl.actions {
float:right;
margin:0 10px;
overflow:hidden;
}
.grey-bar dl.actions dd {
float:left;
font-size:95%;
margin-left:10px;
}
.grey-bar dl.actions dd a:hover { text-decoration:underline;}
.grey-bar dl.actions dd a.shutdown { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/shutdown-vm.png);}
.grey-bar dl.actions dd a.power-off { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/power-off-vm.png);}
.grey-bar dl.actions dd a.startup { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/startup-vm.png);}
.grey-bar dl.actions dd a.edit { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/edit-vm.png);}
.grey-bar dl.actions dd a.delete { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/delete-vm.png); }
.grey-bar dl.actions dd a.new-backup { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/backup.png); }
.grey-bar dl.actions dd a.reboot { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/reboot-vm.png);}
.grey-bar dl.actions dd a { padding:2px 0px 2px 20px; background-position:0px 1px; background-repeat:no-repeat; display:block; margin-top:5px; color:#005bb8; text-decoration:none;}

span.yes { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/tick.png);padding:2px 0px 2px 20px; background-position:0px 1px; background-repeat:no-repeat; margin-top:5px; color:#005bb8; text-decoration:none; }
span.no { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/cross.png);padding:2px 0px 2px 20px; background-position:0px 1px; background-repeat:no-repeat; margin-top:5px; color:#005bb8; text-decoration:none; }
a.bkpdelete {background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/delete-vm.png);padding:2px 0px 2px 20px; background-position:0px 1px; background-repeat:no-repeat; margin-top:5px; color:#005bb8; }
a.bkprestore {background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/restore-backup.png);padding:2px 0px 2px 20px; background-position:0px 1px; background-repeat:no-repeat; margin-top:5px; color:#C13700; }
a.linfo {margin-left:5px;background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/helpi.png);padding:2px 0px 2px 20px; background-position:0px 1px; background-repeat:no-repeat; margin-top:5px; color:#C13700; }

.power-status .yes {
background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/vm-on.png") no-repeat scroll 0 0 transparent;
display:block;
height:16px;
text-indent:-99999px;
width:16px;

}

.power-status .no {
background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/vm-off.png") no-repeat scroll 0 0 transparent;
display:block;
height:16px;
text-indent:-99999px;
width:16px;
}
.right-aligned {
text-align:right;
}
.ttable td {
	padding:3px 4px;
}
.ttable a.xmore {
	font-size: 10px;
        font-weight: bold;
}
table.data-table.backups-list thead {
    border:1px solid #DDDDDD;
}
table.data-table.backups-list thead {
    border-left:1px solid #005395;
    border-right:1px solid #005395;
}
table.data-table.backups-list thead {
    font-size:80%;
    font-weight:bold;
    text-transform:uppercase;
}
table.data-table.backups-list thead td {
    background:none repeat scroll 0 0 #777777;
    color:#FFFFFF;
    padding:8px 5px;
}
table.data-table tbody td {
    background:none repeat scroll 0 0 #FFFFFF;
    border-top:1px solid #DDDDDD;
}
table.data-table tbody tr:hover td {
    background-color: #FFF5BD;
}
table.data-table tbody tr td {
    border-color:-moz-use-text-color #DDDDDD #DDDDDD;
    border-right:1px solid #DDDDDD;
    border-style:none solid solid;
    border-width:0 1px 1px;
    font-size:90%;
    padding:8px;
}
div.step-part {
    background-color:#F5F5F5;
    padding: 10px;
}
h4 {margin:10px}
table.billingtable td {
padding: 6px;
}
table.billingtable td.title {
font-weight: bold;
}
{/literal}
</style>
<script type="text/javascript" src="{$system_url}templates/common/facebox/facebox.js"></script>
<link media="all" type="text/css" rel="stylesheet" href="{$system_url}templates/common/facebox/facebox.css" />



{if $service}
    {if $service.status!='Active'}

          <div class="wbox" id="billing_info" >
                <div class="wbox_header">
        {$lang.billing_info|capitalize}
                </div>
        <div class="wbox_content">
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">
            {include file='service_billing.tpl'}
        </table>
        </div></div>
    {else}
		{if $widget.appendtpl}
    {include file=$widget.appendtpl}
{/if}
         
            <ul class="page_tabs">
              <li ><a href="?cmd=clientarea&action=services&service={$service.id}"  class="{if !$vpsdo}active{/if}" ><span class="left-border"></span><span class="text">{$lang.overview}</span><span class="right-border"></span></a></li>
              <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=console" class="{if $vpsdo=='console'}active{/if}" ><span class="left-border"></span><span class="text">{$lang.Console}</span><span class="right-border"></span></a></li>
              <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=cpu" class="{if $vpsdo=='cpu'}active{/if}"><span class="left-border"></span><span class="text">{$lang.cpucharts}</span><span class="right-border"></span></a></li>
              <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=bandwidth" class="{if $vpsdo=='bandwidth'}active{/if}"><span class="left-border"></span><span class="text">{$lang.bwcharts}</span><span class="right-border"></span></a></li>
              <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=backups" class="{if $vpsdo=='backups'}active{/if}"><span class="left-border"></span><span class="text">{$lang.backups}</span><span class="right-border"></span></a></li>
		{if $vpsaddons.ip.available}<li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=manageips" class="{if $vpsdo=='manageips'}active{/if}"><span class="left-border"></span><span class="text">{$lang.manageips}</span><span class="right-border"></span></a></li>{/if}

			  {if $addons}{foreach from=$addons item=addon}
			{if $addon.templated}
			{foreach from=$addon.templated item=it}<li>
			<a href="?cmd=clientarea&amp;action=addonmodule&amp;id={$service.id}&amp;addon_id={$addon.id}&amp;call={$it}" onclick="return process('{$it}',{$service.id},'#_ocustom',{$addon.id})"><span class="left-border"></span><span class="text">{if $lang.$it}{$lang.$it}{else}{$it}{/if}</span><span class="right-border"></span></a>
			</li>{/foreach}{/if}
			  
			  {if $addon.methods}{foreach from=$addon.methods item=it}<li><a href="?cmd=clientarea&amp;action=addonmodule&amp;id={$service.id}&amp;addon_id={$addon.id}&amp;call={$it}"><span class="left-border"></span><span class="text">{if $lang.$it}{$lang.$it}{else}{$it}{/if}</span><span class="right-border"></span></a></li>{/foreach}{/if}
		{/foreach}
		{/if}
		<li style="float: right"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=billing" class="{if $vpsdo=='billing'}active{/if}"><span class="left-border"></span><span class="text">{$lang.billing_info}</span><span class="right-border"></span></a></li>
                {if $upgrades}<li style="float: right"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=upgrade" class="{if $vpsdo=='upgrade'}active{/if}"><span class="left-border"></span><span class="text"><strong>{$lang.Upgrade}</strong></span><span class="right-border"></span></a></li>{/if}
            </ul>
			
            <div class="virtual-machine-details wide">
              <div class="grey-bar">
                      <dl class="actions">
                      {if $service.status=='Active' && !$vpsdo}
                       <dt></dt>
					   {foreach from=$widgets item=widg}
                       <dd><a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}">{if $lang[$widg.name]}{$lang[$widg.name]}{elseif $widg.fullname}{$widg.fullname}{else}{$widg.name}{/if}</a></dd>
						{/foreach}
                       {if $vpsdetails.power_action_pending}
                       <dd><a href="?cmd=clientarea&action=services&service={$service.id}" ><img src="includes/types/vpscloud/images/arrow_refresh_small.gif" /></a></dd>
                       <dt></dt>
                        <dd style="display:block;margin-top:5px;padding:2px 0 2px 20px;">{$lang.vpsrunning}</dd>
                       {else}
                           {if $vpsdetails.running=='true'}
                            <dd><a onclick="return confirm('{$lang.sure_to_shutdown}?');" class="shutdown" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=shutdown">{$lang.Shutdown}</a></dd>
                            <dt></dt>
                            <dd><a onclick="return confirm('{$lang.sure_to_poweroff}?');" class="power-off" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=poweroff">{$lang.ForcePowerOff}</a></dd>
                            <dt></dt>
                            <dd><a onclick="return confirm('{$lang.sure_to_reboot}?');" class="reboot" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reboot">{$lang.GracefulReboot}</a></dd>
                            {else}

                            <dd><a class="startup" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=poweron">{$lang.Startup}</a></dd>
                            {/if}
                        {/if}
                    <dt></dt>
                    <dd><a  class="delete" href="?cmd=clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel">{$lang.DeleteVPS}</a></dd>
                    <dt></dt>
                    <dd><a class="reboot" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reinstall">{$lang.ReinstallVPS}</a></dd>
                    {elseif $vpsdo=='backups'}
                    {if $vpsaddons.rsync.available && $vpsaddons.rsync.service}
                    <dt></dt>
                    <dd><a class="new-backup" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=rsyncinfo">{$lang.rsyncbackups}</a></dd>
                    {/if}
                    {if $vpsaddons.r1soft.available && $vpsaddons.r1soft.service}
                    <dt></dt>
                    <dd><a class="new-backup" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=r1softinfo">{$lang.r1softbackups}</a></dd>
                    {/if}
                    <dt></dt>
                    <dd><a class="new-backup" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=createbackup" onclick="return confirm('{$lang.suretocreatebkp}')">{$lang.createsnapshot}</a></dd>
                    {elseif $vpsdo=='manageips' && $vpsaddons.ip.available}
                    <dt></dt>
                    <dd><a class="new-backup" href="?cmd=cart&amp;action=add&amp;cat_id=addons&amp;id={$vpsaddons.ip.id}&amp;account_id={$service.id}&amp;addon_cycles[{$vpsaddons.ip.id}]={$vpsaddons.ip.paytype}" >{$lang.ordernewip}</a></dd>
					{elseif $vpsdo=='billing'}
					  <dd><a  class="delete" href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel">{$lang.cancelrequest}</a></dd>
                    {/if}
                  </dl>
			  </div>
			  
			  
              <div class="virtual-machine-details-content">
			  
                <div class="top-background">
				 {if $vpsdo=='console'}
                                 <div style="margin: 10px">{$lang.vpsnetrootpassinfo} <strong>{$vpsdetails.password}</strong></div>
				 	{if $oldconsole}
					<div id="console">
<iframe width="100%" height="478px" src="?cmd=clientarea&action=services&vpsdo=console&service={$service.id}&showconsole=true" frameborder="0" border="0"> </iframe>
</div>
					{elseif $newconsole}
						{$newconsole}
				{else}
				<center><br><br><br><b>{$lang.consoleunavailable}</b><br><br><br><br></center>
						
					{/if}
				 {elseif $vpsdo=='manageips'}
                                    <div style="padding:10px">{$lang.yourmainip} <strong>{$service.vpsip}</strong></div>
                                    <div style="padding:10px">{$lang.vpsipnote}</div>
                                    <table class="data-table backups-list"  width="100%" cellspacing=0>
                                      <thead>
                                        <tr>
                                          <td>IP</td>
                                          <td>Netmask</td>
                                          <td>Gateway</td>
                                          <td></td>
                                        </tr>
                                      </thead>
                                      <tbody>
                                          {if $iplist}
                                            {foreach from=$iplist item=ip}
                                            <tr>
                                                <td>{$ip.ip}</td>
                                                <td>{$ip.netmask}</td>
                                                <td>{$ip.network}</td>
                                                <td><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=manageips&act=removeip&ipid={$ip.ipid}" onclick="return confirm('{$lang.suretodeleteip}')">{$lang.remove}</a></td>
                                            </tr>
                                            {/foreach}
                                          {else}
                                            <tr>
                                              <td style="text-align: center; font-size: 100%; width: 100%;" colspan="4">
                                                  {$lang.noips_avail}
                                              </td>
                                            </tr>
                                        {/if}
                                      </tbody>
                                    </table>
				 {elseif $vpsdo=='upgrade'}
                                        <div style="width: 320px;margin:auto">
                                        <div style="float: left;line-height:25px; font-weight: bold" >{$lang.upgradeyourvps}:</div>
                                        <div style="float:right;">
                                         {if $upgrades=='-1'}
                                       	  {$lang.upgrade_due_invoice}
                                         {else}
                                         
                                            <form action="" method="post">
                                              <input type="hidden" value="upgrade" name="make" />
                                              <div style="margin-bottom:10px;"><select name="upgrades" onchange="sss(this)">
                                              {foreach from=$upgrades item=up}
                                                    <option value="{$up.id}">{$up.catname}: {$up.name}</option>
                                              {/foreach}</select>
                                              </div>
                                               <div class="fs11" id="up_descriptions" style="margin: 10px 0;">
		  	{foreach from=$upgrades item=up key=k}
		  	<span {if $k!=0}style="display:none"{/if} class="up_desc">{$up.description}</span>
		  {/foreach}
		  </div>
          <div id="billing_options">
          	{foreach from=$upgrades item=i key=k}
		<div {if $k!=0}style="display:none"{/if} class="up_desc">
      {if $i.paytype=='Free'}
      		<input type="hidden" name="cycle[{$i.id}]" value="Free" />
    			 {$lang.price}: <strong> {$lang.Free}</strong>
      {elseif $i.paytype=='Once'}
     	 <input type="hidden" name="cycle[{$i.id}]" value="Once" />
    	 {$lang.price}: {$i.m|price:$currency} {$lang.once}
      {else}
	  {$lang.pickcycle}
      <select name="cycle[{$i.id}]">
           {if $i.d!=0}<option value="d" {if $i.cycle=='d'}selected="selected"{/if}>{$i.d|price:$currency} {$lang.d}</option>{/if}
           {if $i.w!=0}<option value="w" {if $i.cycle=='w'}selected="selected"{/if}>{$i.w|price:$currency} {$lang.w}</option>{/if}
           {if $i.m!=0}<option value="m" {if $i.cycle=='m'}selected="selected"{/if}>{$i.m|price:$currency} {$lang.m}</option>{/if}
           {if $i.q!=0}<option value="q" {if $i.cycle=='q'}selected="selected"{/if}>{$i.q|price:$currency} {$lang.q}</option>{/if}
           {if $i.s!=0}<option value="s" {if $i.cycle=='s'}selected="selected"{/if}>{$i.s|price:$currency} {$lang.s}</option>{/if}
           {if $i.a!=0}<option value="a" {if $i.cycle=='a'}selected="selected"{/if}>{$i.a|price:$currency} {$lang.a}</option>{/if}
           {if $i.b!=0}<option value="b" {if $i.cycle=='b'}selected="selected"{/if}>{$i.b|price:$currency} {$lang.b}</option>{/if}
           {if $i.t!=0}<option value="t" {if $i.cycle=='t'}selected="selected"{/if}>{$i.t|price:$currency} {$lang.t}</option>{/if}
      </select>
      {/if} 
                </div>
		 	 {/foreach}
          </div>	
          <center>
          
<input type="submit" value="{$lang.continue}" style="font-weight:bold"/>
		
          </center>
		  </div>

                                              <script type="text/javascript">
                                              {literal}
                                              function sss(el) {
                                                    	$('.up_desc').hide();
														var index=$(el).eq(0).attr('selectedIndex');
														$('#up_descriptions .up_desc').eq(index).show();
														$('#billing_options .up_desc').eq(index).show();

                                              }
                                              {/literal}
                                              </script>
                                              </form>
                                              
                                        {/if}      
                                        </div>
                                        <div class="clear"></div></div>
				 {elseif $vpsdo=='billing'}
                                     <table cellpadding="0" cellspacing="0" class="billingtable">
                                        <tr>
                                              <td class="title" width="160" align="right">{$lang.registrationdate}</td>
                                              <td>{$service.date_created|dateformat:$date_format}</td>
                                              <td width="40%" class="title" align="right">{$lang.service}</td>
                                              <td>{$service.catname} - {$service.name} </td>
                                            </tr>
                                            <tr>
                                              <td class="title" align="right">{$lang.firstpayment_amount}</td>
                                              <td>{$service.firstpayment|price:$currency}</td>
                                              <td class="title" align="right">{$lang.reccuring_amount}</td>
                                              <td>{$service.total|price:$currency}</td>

                                            </tr>
                                          {if $service.billingcycle!='Free' && $service.billingcycle!='Once'}
                                            <tr >
                                              <td class="title" align="right">{$lang.bcycle}</td>
                                              <td>{$lang[$service.billingcycle]}</td>
                                              <td class="title" align="right">{$lang.nextdue}</td>
                                              <td>{$service.next_due|dateformat:$date_format}</td>
                                            </tr>
                                          {/if}
                                    </table>
				 {elseif $vpsdo=='cpu'}
                                    {$lang.cpuchartinfo}
                                    {if $cloudtype=='2'}
                                        <h3><br />{$lang.hourlyusage}</h3>
                                        <script type="text/javascript" src="includes/types/vpscloud/assets/jquery.fusioncharts.js"></script>
                                        <div id="my_chart"  style=""></div>
                                        <script type="text/javascript">
                                                {literal}
                                        $('#my_chart').insertFusionCharts({
                                                swfPath: "templates/default/js/fusioncharts/",
                                                type: "MSLine2D",
                                                data: "{/literal}{$chart_url}{literal}",
                                                dataFormat: "URIData",
                                                width: "850",
                                                height: "300"
                                        });
                                        {/literal}
                                        </script>
                                    {elseif $cloudtype=='1'}
                                        <h3><br />{$lang.hourusage}</h3>
                                        <img style="width:850px" src="?cmd=clientarea&action=services&vpsdo=cpugraph&service={$service.id}&graphperiod=hourly" class="periodval" />
                                        <h3><br />{$lang.dayusage}</h3>
                                         <img style="width:850px" src="?cmd=clientarea&action=services&vpsdo=cpugraph&service={$service.id}&graphperiod=daily" class="periodval" />
                                        <h3><br />{$lang.weekusage}</h3>
                                         <img style="width:850px" src="?cmd=clientarea&action=services&vpsdo=cpugraph&service={$service.id}&graphperiod=weekly" class="periodval" />
                                        <h3><br />{$lang.monthusage}</h3>
                                         <img style="width:850px" src="?cmd=clientarea&action=services&vpsdo=cpugraph&service={$service.id}&graphperiod=monthly" class="periodval" />
                                        <h3><br />{$lang.yearusage}</h3>
                                         <img style="width:850px" src="?cmd=clientarea&action=services&vpsdo=cpugraph&service={$service.id}&graphperiod=yearly" class="periodval" />
                                     {/if}
				 {elseif $vpsdo=='bandwidth'}
                                    {$lang.bwchartinfo}
                                    {if $cloudtype=='2'}
                                        <h3><br />{$lang.hourlyusage}</h3>
                                        <script type="text/javascript" src="includes/types/vpscloud/assets/jquery.fusioncharts.js"></script>
                                        <div id="my_chart"  style=""></div>
                                        <script type="text/javascript">
                                                {literal}
                                        $('#my_chart').insertFusionCharts({
                                                swfPath: "templates/default/js/fusioncharts/",
                                                type: "MSLine2D",
                                                data: "{/literal}{$chart_url}{literal}",
                                                dataFormat: "URIData",
                                                width: "850",
                                                height: "300"
                                        });
                                        {/literal}
                                        </script>
                                    {elseif $cloudtype=='1'}
                                        <h3><br />{$lang.hourusage}</h3>
                                        <img style="width:850px" src="?cmd=clientarea&action=services&vpsdo=bandwidthgraph&service={$service.id}&graphperiod=hourly" class="periodval" />
                                        <h3><br />{$lang.dayusage}</h3>
                                         <img style="width:850px" src="?cmd=clientarea&action=services&vpsdo=bandwidthgraph&service={$service.id}&graphperiod=daily" class="periodval" />
                                        <h3><br />{$lang.weekusage}</h3>
                                         <img style="width:850px" src="?cmd=clientarea&action=services&vpsdo=bandwidthgraph&service={$service.id}&graphperiod=weekly" class="periodval" />
                                        <h3><br />{$lang.monthusage}</h3>
                                         <img style="width:850px" src="?cmd=clientarea&action=services&vpsdo=bandwidthgraph&service={$service.id}&graphperiod=monthly" class="periodval" />
                                        <h3><br />{$lang.yearusage}</h3>
                                         <img style="width:850px" src="?cmd=clientarea&action=services&vpsdo=bandwidthgraph&service={$service.id}&graphperiod=yearly" class="periodval" />
                                     {/if}
				 {elseif $vpsdo=='backups'}
                                    <div style="padding:10px">{$lang.backups_desc}</div>
                                    <table class="data-table backups-list"  width="100%" cellspacing=0>
                                      <thead>
                                        <tr>
                                          <td>{$lang.name}</td>
                                          <td>{$lang.status}</td>
                                          <td>{$lang.date}</td>
                                          <td>{$lang.size}</td>
                                          <td></td>
                                          <td></td>
                                        </tr>
                                      </thead>
                                      <tbody>
                                          {if $backups}
                                            {foreach from=$backups item=bkp}
                                            <tr>
                                                <td><strong>{$bkp.name}</strong></td>
                                                <td><strong>{if $bkp.available}{$lang.Available}{else}{$lang.Pending}{/if}</strong></td>
                                                <td>{$bkp.date}</td>
                                                <td>{if $bkp.size}{$bkp.size}{else}{$lang.notbuiltyet}{/if}</td>
                                                <td>{if $bkp.available}<a class="bkprestore" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=restorebackup&backup={$bkp.id}" onclick="return confirm('{$lang.suretorestorebkp}')">{$lang.restore}</a>{/if}</td>
                                                <td>{if $bkp.type != 'autobackup'}<a class="bkpdelete" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=deletebackup&backup={$bkp.id}" onclick="return confirm('{$lang.suretodeletebkp}')">{$lang.delete}</a>{/if}</td>
                                            </tr>
                                            {/foreach}
                                          {else}
                                            <tr>
                                              <td style="text-align: center; font-size: 100%; width: 100%;" colspan="6">
                                                  {$lang.nobackups_avail}
                                              </td>
                                            </tr>
                                        {/if}
                                      </tbody>
                                    </table>
				 {elseif $vpsdo=='rsyncinfo'}
                                 {if $rsync}
                                    <div style="float: right; font-size: 14px; font-weight: bold; padding: 10px;line-height: 23px">
                                    Username : {$rsync.username}<br />
                                    Password : {$rsync.password}<br />
                                    Quota : {$rsync.quota} <br />
                                    </div>
                                     <div>
                                         <h2 style="padding:10px">RSync Instructions<br/><br/></h2>
                                            <h4>Step 1. Log in as root to your server</h4>
                                     </div><div class="clear"></div>
                                        <div>
                                        <div class="step-part">
                                        Use:
                                        <ul>
                                        <li>shell access method (SSH, telnet, etc.)</li>
                                        <li>control panel (Cpanel, Plesk, etc.)</li>
                                        </ul>

                                        If you do not have root access, log in to the account you will be using to perform backups.<br><br>

                                        Note: rsync requires read access to the files it is to back up. So, it is often executed as a root user. However, it may also work when executed from individual user accounts.
                                        </div>
                                        <h4>Step 2. Create an RSA encryption key</h4>
                                        <div class="step-part">


                                        Create an RSA encryption key for use with the SSH transport. To check if a key already exists, run:<br>

                                        <pre>
                                        # cat ~/.ssh/id_rsa.pub
                                        </pre>

                                        If the file already exists, you may skip to step 3. Otherwise, create a key with the ssh-keygen utility:<br>

                                        <pre>
                                        # ssh-keygen -t rsa -N '' (Note: these are two single quotes)
                                        </pre>
                                        </div>
                                        <h4>Step 3. Copy your RSA encryption key to the VPS.NET backup system</h4>
                                        <div class="step-part">
                                        You may copy the key through the shell.<br>

                                        <pre>
                                        # scp ~/.ssh/id_rsa.pub {$rsync.username}@rsync1.cloudkeeper.net:keys/{$rsync.hostname}/
                                        # ssh ${$rsync.username}@rsync1.cloudkeeper.net mergekeys
                                        </pre>
                                        </div>
                                        <h4>Step 4. Make sure rsync is installed</h4>
                                        <div class="step-part">

                                        Run: <br>

                                        <pre>
                                        # yum install rsync (for CentOS) OR
                                        # apt-get install rsync (for Debian or Ubuntu)
                                        </pre>

                                        You may now test rsync by copying a small directory, such as /etc: <br>

                                        <pre>
                                        # rsync -avz -e ssh /etc {$rsync.username}@rsync1.cloudkeeper.net:{$rsync.hostname}/
                                        </pre>
                                        </div>
                                        <h4>Step 5. Add rsync as a daily cronjob</h4>
                                        <div class="step-part">

                                        1. Log in as root.<br>

                                        2. Execute the following command (variations listed below):<br>

                                        <pre>
                                        # echo 15 20 * * * root rsync -avz --exclude=/proc -e ssh / {$rsync.username}@rsync1.cloudkeeper.net:{$rsync.hostname}/>> /etc/crontab
                                        </pre>
                                        (note: don't forget both brackets...that's >>)<br><br>

                                        Bak up home directories:

                                        <pre>
                                        rsync -avz -e ssh /home {$rsync.username}@rsync1.cloudkeeper.net:{$rsync.hostname}/
                                        </pre>

                                        Back up specific users:
                                        <pre>
                                        rsync -avz -e ssh ~bob ~bill ~sarah {$rsync.username}@rsync1.cloudkeeper.net:{$rsync.hostname}/
                                        </pre>
                                        </div>
                                        </div>
                                    {else}
                                        You don't have valid license of RSync. Please contact administrator.
                                    {/if}
				 {elseif $vpsdo=='r1softinfo'}
                                    {if $rsoft_license}
                                    <div>
                                        <div style="padding:20px"><strong>Your license key:</strong> {$rsoft_license}</div>
                                                        <table class="data-table backups-list"  width="100%" cellspacing=0>
                                                          <thead>
                                                            <tr>
                                                              <td>Agent / Server</td>

                                                              <td>32-bit</td>
                                                              <td>64-bit</td>
                                                            </tr>
                                                          </thead>
                                                          <tbody>
                                                            <tr>
                                                              <td>Linux CDP Agent</td>

                                                              <td><a href="http://download.r1soft.com/d/linux-agent/1.70.2-x86/%20" rel="external">Download</a></td>
                                                              <td><a href="http://download.r1soft.com/d/linux-agent/1.70.2-x86_64/" rel="external">Download</a></td>
                                                            </tr>
                                                            <tr>
                                                              <td>Windows CDP Agent</td>
                                                              <td><a href="http://download.r1soft.com/d/windows-agent/2.20.3-win32/windows-agent-win32-2.20.3.exe" rel="external">Download</a></td>
                                                              <td><a href="http://download.r1soft.com/d/windows-agent/2.20.3-win64/windows-agent-win64-2.20.3.exe" rel="external">Download</a></td>

                                                            </tr>
                                                            <tr>
                                                              <td>Linux CDP Server</td>
                                                              <td><a href="http://download.r1soft.com/d/server/2.20.3-linux32/CDP-Server-Stand-Alone/installer/CDP-Server-Stand-Alone-linux32-2.20.3.run" rel="external">Download</a></td>
                                                              <td><a href="http://download.r1soft.com/d/server/2.20.3-linux64/CDP-Server-Stand-Alone/installer/CDP-Server-Stand-Alone-linux64-2.20.3.run" rel="external">Download</a></td>
                                                            </tr>
                                                          </tbody>

                                                        </table>
                                                      </div>
                                    {else}
                                        You don't have valid license of R1Soft. Please contact administrator.
                                    {/if}
				 {elseif $vpsdo=='reinstall'}
                                    <h3><br />{$lang.ReinstallVPS}<br/></h3>
                                    {$lang.choose_template1} <font color="#cc0000">{$lang.choose_template2}</font><br /><br />{$lang.choose_template3}
                                    
                                    <p><strong>{$lang.makeitoff}</strong></p>
                                    
                                    {if $ostemplates}
                                    <div style="padding:10px; text-align: center; width:850px">
                                        <form action="" method="post">
                                            <select name="os">
                                            {foreach from=$ostemplates item=templt}
                                                <option value="{$templt[0]}">{$templt[1]} {if $templt[2] && $templt[2]>0} ({$templt[2]|price:$currency}){/if}</option>
                                            {/foreach}
                                            </select>
                                            <input type="submit" value="{$lang.ReinstallVPS}" name="changeos" />
                                        </form>
                                        </div>
                                    {else}
                                        <div style="color: red; text-align: center; width:850px"><strong>{$lang.ostemplates_error}</strong></div>
                                    {/if}
				 {else}
				 <table cellpadding="4" width="100%" class="ttable">
                      <tbody><tr>
                        <td class="right-aligned" width="25%">
                          <b>{$lang.hostname}</b>
                        </td>
                        <td class="courier-font"  width="25%">{$service.domain}</td>
                        <td class="right-aligned" width="25%">
                           <b>{$lang.ostemplate}</b>
                        </td>
                        <td class="courier-font"  width="25%">  {$service.os} </td>
                      </tr>
					  <tr>
                        <td class="right-aligned">
                          <b>{$lang.status}</b>
                        </td>
                        <td class="power-status">{if $vpsdetails.running=='true'}<span class="yes">Yes</span>{else}<span class="no">No</span>{/if}</td>
                        <td class="right-aligned" valign="top">
                          <b>{$lang.ipadd}</b>
                        </td>
                        <td>{$service.vpsip} <br /> <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=manageips" class="xmore">{$lang.dotmore}</a></td>
                      </tr>
					  
                      <tr>
                        <td class="right-aligned">
                          <b>{$lang.inirootpass}</b>
                        </td>
                        <td>{$vpsdetails.password}</td>
                        <td class="right-aligned">
                           <b>{$lang.monthly_bandwidth_used}</b>
                        </td>
                        <td>  {$vpsdetails.bandwidth_used} {$vpsdetails.bandwidth_s}</td>
                      </tr>

                      <tr>
                        <td class="right-aligned" valign="top">
                          <b>{$lang.backups}</b>
                        </td>
                        <td valign="top" style="line-height:20px">
                           {if $vpsaddons.snapshot.available}Snapshot {if $vpsaddons.snapshot.active}<span class="yes">&nbsp;</span>{else}<span class="no">&nbsp;</span> <a href="?cmd=cart&amp;action=add&amp;cat_id=addons&amp;id={$vpsaddons.snapshot.id}&amp;account_id={$service.id}&amp;addon_cycles[{$vpsaddons.snapshot.id}]={$vpsaddons.snapshot.paytype}"  class="xmore">{$lang.order}!</a>{/if}<br />  {/if}
                           {if $vpsaddons.r1soft.available}R1Soft {if $vpsaddons.r1soft.active}<span class="yes">&nbsp;</span>{else}<span class="no">&nbsp;</span> <a href="?cmd=cart&amp;action=add&amp;cat_id=addons&amp;id={$vpsaddons.r1soft.id}&amp;account_id={$service.id}&amp;addon_cycles[{$vpsaddons.r1soft.id}]={$vpsaddons.r1soft.paytype}" class="xmore">{$lang.order}!</a>{/if}<br />  {/if}
                           {if $vpsaddons.rsync.available}RSync {if $vpsaddons.rsync.active}<span class="yes">&nbsp;</span>{else}<span class="no">&nbsp;</span> <a href="?cmd=cart&amp;action=add&amp;cat_id=addons&amp;id={$vpsaddons.rsync.id}&amp;account_id={$service.id}&amp;addon_cycles[{$vpsaddons.rsync.id}]={$vpsaddons.rsync.paytype}" class="xmore">{$lang.order}!</a>{/if}<br />  {/if}
                        </td>
                        <td class="right-aligned" valign="top">
                           <b>{$lang.Licenses}</b>
                        </td>
                        <td valign="top" style="line-height:20px">
                            {if $vpsaddons.cpanel.active || $vpsaddons.ispmanager.active}
                                {if $vpsaddons.cpanel.active}CPanel <a class="linfo" onclick="{literal}$.facebox({ ajax: '?cmd=clientarea&action=services&service={/literal}{$service.id}{literal}&vpsdo=cpanelinfo' }); return false;{/literal}" href=""></a><br />{/if}
                                {if $vpsaddons.ispmanager.active}ISPManager <a class="linfo" onclick="{literal}$.facebox({ ajax: '?cmd=clientarea&action=services&service={/literal}{$service.id}{literal}&vpsdo=ispminfo' }); return false;{/literal}" href=""></a><br />{/if}
                            {elseif $vpsaddons.cpanel.available || $vpsaddons.ispmanager.available}
                                <form method="post" action="" >
                                    <a href=""  class="xmore" id="licenselink" onclick="$(this).hide(); $('#licenseslist').show(); return false;">{$lang.order}!</a>
                                    <div style="display: none" id="licenseslist">
                                        {if $vpsaddons.cpanel.available}<input type="radio" value="cpanel" name="licenseorder" /> CPanel<br />{/if}
                                        {if $vpsaddons.ispmanager.available}<input type="radio" value="ispmanager" name="licenseorder" /> ISPManager<br />{/if}
                                        <input type="submit" value="{$lang.cancel}" onclick="$('#licenseslist').hide();$('#licenselink').show(); return false;" /><input type="submit" value="{$lang.order}" name="orderlicense" style="font-weight: bold"/>
                                    </div>
                                </form>
                            {/if}
                        </td>
                      </tr>
					  
                   
					  
                      
					  
                      {if isset($service.extra.showlocation.value) && $service.extra.showlocation.value == '1'}
					 <tr>
					   <td class="right-aligned">
                          <b>Cloud</b>
                        </td>
                        <td> {$service.node} </td>
						<td></td><td></td>
                    </tr>
					{/if}
                    
                    </tbody></table>
				 
				 {/if}
				
				
                 
                  
				  
                </div>
              </div>
              <div class="virtual-machine-details-bottom"></div>
            </div>
			
			<div class="clear"></div>
    {/if}
         
{/if}