{include file="`$clouddir`header.cloud.tpl"}
<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{$lang.createnewserver}</h3>
    <div class="clear"></div>
</div>
<div class="content-bar nopadding" style="position:relative">
    {if $provisioning_type=='cloud'}<div class="resources_box">
        <strong><em>{$lang.availableresources}</em></strong>
<table cellspacing="0" cellpadding="0" width="100%" class="ttable">
    <tbody>

         <tr>
            <td width="70" align="right">Instances</td>
            <td ><b {if $CreateVM.limits.instances<1}style="color:red"{/if}>{$CreateVM.limits.instances}</b></td>
        </tr>
        <tr>
            <td width="70" align="right">{$lang.memory}</td>
            <td ><b {if $CreateVM.limits.mem<1}style="color:red"{/if}>{$CreateVM.limits.mem} MB</b></td>
        </tr>
         <tr>
            <td width="70" align="right">{$lang.storage}</td>
            <td ><b {if $CreateVM.limits.disk<1}style="color:red"{/if}>{$CreateVM.limits.disk} GB</b></td>
        </tr>
         <tr>
            <td width="70" align="right">{$lang.cpucores}</td>
            <td ><b {if $CreateVM.limits.cpu<1}style="color:red"{/if}>{$CreateVM.limits.cpu}</b></td>
        </tr>
         <tr>
            <td width="70" align="right">IPs</td>
            <td ><b {if $CreateVM.limits.ips<1}style="color:red"{/if}>{$CreateVM.limits.ips}</b></td>
        </tr>

    </tbody></table>
        <div style="text-align: right"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=resources" class="fs11">Increase limits</a></div>
    </div>
{/if}

<form method="post" action="">
    <input type="hidden" value="createmachine" name="make" />
   
    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">

        <tr>
            <td colspan="2"><span class="slabel">{$lang.name}</span><input type="text" size="30" required="required" name="CreateVM[hostname]"  class="styled" value="{$submit.CreateVM.hostname}"/></td>
        </tr>
       
        <tr>
            <td colspan="2"><span class="slabel">{$lang.ostemplate}</span><select style="min-width:250px;" required="required" name="CreateVM[template_id]" id="virtual_machine_template_id"  >
                   
                    {foreach from=$CreateVM.ostemplates item=templa}
                    <option value="{$templa[0]}" {if $submit.CreateVM.template_id==$templa[0]}selected="selected"{/if}>{$templa[1]} {if $templa[2] && $templa[2]>0}( {$templa[2]|price:$currency} ){/if}</option>
                   {/foreach}

                </select></td>

        </tr>

        <tr>
            <td colspan="2"><span class="slabel">Flavor</span><select style="min-width:250px;" required="required" name="CreateVM[flavor_id]" id="virtual_machine_flavor_id"  >

                    {foreach from=$flavors item=flavor}
                    <option value="{$flavor[0]}" {if $submit.CreateVM.flavor_id==$flavor[0]}selected="selected"{/if}>{$flavor[1]}</option>
                   {/foreach}

                </select></td>

        </tr>
        <tr>
            <td colspan="2"><span class="slabel">{$lang.password}</span><input type="text" size="30" name="CreateVM[initial_root_password]" class="styled" value="{$submit.CreateVM.initial_root_password}"/></td>
        </tr>

       

        <tr>
            <td align="center" style="border:none" colspan="2">

                <input type="submit" value="{$lang.CreateVM}" style="font-weight:bold" class=" blue" />
            </td>
        </tr>
    </table>


    



{securitytoken}
</form>
</div>
{include file="`$clouddir`footer.cloud.tpl"}