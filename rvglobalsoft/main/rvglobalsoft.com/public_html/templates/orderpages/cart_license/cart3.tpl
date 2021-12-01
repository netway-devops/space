{php}
    $templatePath = $this->get_template_vars('template_path');
    include(dirname($templatePath) . '/orderpages/cart_license/cart3.tpl.php');
{/php}


<script type="text/javascript">
var currentIp   = '{$currentIp}';
var currentId   = '{$currentId}';
var productName = '{$productName}';
{literal}
function changeCycle(forms) {
    $(forms).append('<input type="hidden" name="ccycle" value="true"/>').submit();
    return true;
}
{/literal}
</script>


{if $productName != ''}
    <h2>You're going to order: {$productName} 
    {if $productName == 'cPanel'}
    <span style="float: right;"><img src="{$orderpage_dir}cart_license/images/logo-cpanel.gif" alt="cpanel" width="122" height="36" /></span>
    {/if}
    {if $productName == 'cPanel+RVSkin+RVsitebuilder'}
    <span style="float: right;"><img src="{$orderpage_dir}cart_license/images/logo-cpanel.gif" alt="cpanel" width="122" height="36" /></span>
    <span style="float: right;"><img src="{$orderpage_dir}cart_license/images/logo-rvskin.jpg" alt="RVSkin" width="46" height="36" /></span>
    <span style="float: right;"><img src="{$orderpage_dir}cart_license/images/logo-rvsb.gif" alt="RVSiteBuilder" width="89" height="36" /></span>
    {/if}
    {if $productName == 'ISPmanager'}
    <span style="float: right;"><img src="{$orderpage_dir}cart_license/images/logo-isp.gif" alt="isp" width="93" height="36" /></span>
    {/if}
    {if $productName == 'LiteSpeed'}
    <span style="float: right;"><img src="{$orderpage_dir}cart_license/images/logo-litepeed.gif" alt="LiteSpeed" width="101" height="36" /></span>
    {/if}
    {if $productName == 'Softaculous'}
    <span style="float: right;"><img src="{$orderpage_dir}cart_license/images/logo-soft.gif" alt="Softaculous" width="108" height="36" /></span>
    {/if}
    {if $productName == 'CloudLinux'}
    <span style="float: right;"><img src="{$orderpage_dir}cart_license/images/logo-cloudlinux.gif" alt="cloudlinux" width="77" height="36" /></span>
    {/if}
    {if $productName == 'RVSkin'}
    <span style="float: right;"><img src="{$orderpage_dir}cart_license/images/logo-rvskin.jpg" alt="RVSkin" width="46" height="36" /></span>
    {/if}
    {if $aProduct.slug == 'rvsitebuilder' || $aProduct.slug == 'rvsitebuilder7'}
    <span style="float: right;"><img src="{$orderpage_dir}cart_license/images/logo-rvsb.gif" alt="RVSiteBuilder" width="89" height="36" /></span>
    {/if}
    </h2>
{/if}

<div><p>&nbsp;</p></div>

<form action="" method="post" id="cart3">

{if $product.description!='' || $product.paytype=='Once' || $product.paytype=='Free'}
<div class="wbox">
    <!--<div class="wbox_header">
        <strong>{$product.name}</strong>
    </div>-->
    <div class="wbox_content" id="product_description">
    
        {$product.description}
    
        {if $product.paytype=='Free'}
            <br />
            <input type="hidden" name="cycle" value="Free" />
            {$lang.price} <strong>{$lang.free}</strong>
            
        {elseif $product.paytype=='Once'}
            <br />
            <input type="hidden" name="cycle" value="Once" />
            {$lang.price}  <strong>{$product.m|price:$currency}</strong> {$lang.once} / {$product.m_setup|price:$currency} {$lang.setupfee}
        {/if}
    </div>
</div>
{/if}



{if   $product.type=='Dedicated' || $product.type=='Server' || $product.hostname || $custom || ($product.paytype!='Once' && $product.paytype!='Free')}

<div class="wbox">
    <div class="wbox_header">
        <strong>{$lang.config_options}</strong>
    </div>
    <div class="wbox_content">
        
        
        
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
        <colgroup class="firstcol"></colgroup>
        <colgroup class="alternatecol"></colgroup>
        
        {if $custom} 
            <input type="hidden" name="custom[-1]" value="dummy" />
            {foreach from=$custom item=cf} 
                {if $cf.items}
                <tr class="{$cf.key}" {if $cf.variable == 'public_ip'}id="pb_ip" style="display: none"{/if}>
                    <td class="{$cf.key} pb10"><label for="custom[{$cf.id}]" class="styled">{$cf.name} {if $cf.options & 1}*{/if}</label></td>
                    <td>
                        
                        {if $cf.description!=''}
                        <div class="fs11 descr" style="">{$cf.description}</div>
                        {/if}
                        {include file=$cf.configtemplates.cart}
                        
                    </td>
                </tr>
                {/if}
            {/foreach}
        {/if}
        
        <tr class="orderType ">
            <td class="pb10">Order Type: </td>
            <td>
                <span>Register</span>
            </td>
        </tr>
        
        {if $productName == 'CloudLinux'}
        <tr class="serverType ">
            <td class="pb10">For: </td>
            <td>
                <label><input type="radio" {if $productId == '116'} checked="checked" {else} onclick="document.location = '?cmd=cart&action=add&id=116';" {/if} /> cPanel</label>
                <label><input type="radio" {if $productId == '137'} checked="checked" {else} onclick="document.location = '?cmd=cart&action=add&id=137';" {/if} /> Other</label>
            </td>
        </tr>
        {/if}
        {if $productName != 'Virtualizor'}
        <tr class="serverType">
            <td class="pb10" {if $aProduct.slug == 'rvsitebuilder7'} style="display: none;" {/if}>Server Type: </td>
            <td {if $aProduct.slug == 'rvsitebuilder7'} style="display: none;" {/if}>
                <label><input type="radio" name="server_type[Dedicated]" title="Dedicated" value="" onclick="changeServerType($(this))" /> Dedicated</label>
                <label><input type="radio" name="server_type[VPS]" title="VPS" value="" onclick="changeServerType($(this))" /> VPS</label>
            </td>
        </tr>
        {/if}
        {if $productName == 'LiteSpeed'}
        <tr class="serverType ">
            <td class="pb10">Option: </td>
            <td>
                <select onchange="document.location = '?cmd=cart&action=add&id='+ this.options[this.selectedIndex].value +'';">
                    {if $productId == '138' || $productId == '139'}
                    <option value="138" {if $productId == '138'} selected="selected" {/if}>for VPS Lease</option>
                    <option value="139" {if $productId == '139'} selected="selected" {/if}>for Ultra VPS Lease</option>
                    {/if}
                    {if $productId == '140' || $productId == '141' || $productId == '142' || $productId == '143'}
                    <option value="140" {if $productId == '140'} selected="selected" {/if}>for 1-CPU Lease</option>
                    <option value="141" {if $productId == '141'} selected="selected" {/if}>for 2-CPU Lease</option>
                    <option value="142" {if $productId == '142'} selected="selected" {/if}>for 4-CPU Lease</option>
                    <option value="143" {if $productId == '143'} selected="selected" {/if}>for 8-CPU Lease</option>
                    {/if}
                </select>
            </td>
        </tr>
        {/if}
        
        {if $product.paytype!='Once' && $product.paytype!='Free'}

        <tr class="billingCycle">
            <td class="pb10"  width="175">{$lang.pickcycle}</td>
            <td class="pb10">
                
                <select name="cycle"   onchange="{if $custom}changeCycle('#cart3');{else}simulateCart('#cart3');{/if}" style="width:99%">
                  
                    {if $product.h!=0}<option value="h" {if $cycle=='h'} selected="selected"{/if}>{$product.h|price:$currency} {$lang.h}{if $product.h_setup!=0} + {$product.h_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Hourly} {$lang.freedomain}{/if}</option>{/if}
                    {if $product.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$product.d|price:$currency} {$lang.d}{if $product.d_setup!=0} + {$product.d_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Daily} {$lang.freedomain}{/if}</option>{/if}
                    {if $product.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$product.w|price:$currency} {$lang.w}{if $product.w_setup!=0} + {$product.w_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Weekly} {$lang.freedomain}{/if}</option>{/if}
                    {if $product.m!=0}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$product.m|price:$currency} {$lang.m}{if $product.m_setup!=0} + {$product.m_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Monthly} {$lang.freedomain}{/if}</option>{/if}
                    {if $product.q!=0}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$product.q|price:$currency} {$lang.q}{if $product.q_setup!=0} + {$product.q_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Quarterly} {$lang.freedomain}{/if}</option>{/if}
                    {if $product.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$product.s|price:$currency} {$lang.s}{if $product.s_setup!=0} + {$product.s_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.SemiAnnually}{$lang.freedomain}{/if}</option>{/if}
                    {if $product.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$product.a|price:$currency} {$lang.a}{if $product.a_setup!=0} + {$product.a_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Annually}{$lang.freedomain}{/if}</option>{/if}
                    {if $product.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$product.b|price:$currency} {$lang.b}{if $product.b_setup!=0} + {$product.b_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Biennially}{$lang.freedomain}{/if}</option>{/if}
                    {if $product.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$product.t|price:$currency} {$lang.t}{if $product.t_setup!=0} + {$product.t_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Triennially}{$lang.freedomain}{/if}</option>{/if}
                    {if $product.p4!=0}<option value="p4" {if $cycle=='p4'} selected="selected"{/if}>{$product.p4|price:$currency} {$lang.p4}{if $product.p4_setup!=0} + {$product.p4_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Triennially}{$lang.freedomain}{/if}</option>{/if}
                    {if $product.p5!=0}<option value="p5" {if $cycle=='p5'} selected="selected"{/if}>{$product.p5|price:$currency} {$lang.p5}{if $product.p5_setup!=0} + {$product.p5_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Triennially}{$lang.freedomain}{/if}</option>{/if}
                
                </select>
            </td>
        </tr>
        
        {/if}

        {if $product.hostname}
        <tr class="productHostname">
            <td class="pb10" width="175"><strong>{$lang.hostname}</strong> *</td>
            <td class="pb10"><input name="domain" value="{$item.domain}" class="styled" size="50" style="width:96%"/></td>  
        </tr>
        {/if}

        </table>
    
        <!-- <small>{$lang.field_marked_required}</small> -->
 
    </div>
 </div>
{/if}


{if $subproducts}
<!--
<div class="wbox controlPanelProduct">
    <div class="wbox_header">
        <strong>Control Panel</strong>
    </div>
    <div class="wbox_content">
        
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
        <tbody>
            <tr class="cPanel">
                <td>
                    <label><input type="checkbox" name="controlpanel" value="cPanel" onclick="changeControlPanel($(this));" /> cPanel</label>
                </td>
                <td>
                    
                </td>
            </tr>
            <tr class="ISPmanager">
                <td>
                    <label><input type="checkbox" name="controlpanel" value="ISPmanager" onclick="changeControlPanel($(this));" /> ISPmanager</label>
                </td>
                <td>
                    
                </td>
            </tr>
        </tbody>
        </table>
        
    </div>
</div>
-->

<div class="wbox additionalProduct">
    <div class="wbox_header">
        <strong>Additional Products</strong>
    </div>
    <div class="wbox_content">
        
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
        <tbody>
            <tr class="CloudLinux">
                <td>
                    <label><input type="checkbox" name="additional" value="CloudLinux" onclick="changeAdditionalProduct($(this));" /> CloudLinux</label>
                </td>
                <td>
                    <select name="CloudLinux" onchange="changeAdditionalProduct($('input[value=CloudLinux]'));"></select>
                </td>
                <td>
                    
                </td>
            </tr>
            {if ! $isPartner}
            <tr class="RVSkin">
                <td>
                    <label><input type="checkbox" name="additional" value="RVSkin" onclick="changeAdditionalProduct($(this));" /> RVSkin</label>
                </td>
                <td>
                    
                </td>
                <td>
                    
                </td>
            </tr>
            <tr class="RVSiteBuilder">
                <td>
                    <label><input type="checkbox" name="additional" value="RVSiteBuilder" onclick="changeAdditionalProduct($(this));" /> RVSiteBuilder</label>
                </td>
                <td>
                    
                </td>
                <td>
                    
                </td>
            </tr>
            {/if}
            <!-- hidden
            <tr class="LiteSpeed">
                <td>
                    <label><input type="checkbox" name="additional" value="LiteSpeed" onclick="changeAdditionalProduct($(this));" /> LiteSpeed</label>
                </td>
                <td>
                    <select name="LiteSpeed" onchange="changeAdditionalProduct($('input[value=LiteSpeed]'));"></select>
                </td>
                <td>
                    
                </td>
            </tr>
            -->
            <tr class="Softaculous">
                <td>
                    <label><input type="checkbox" name="additional" value="Softaculous" onclick="changeAdditionalProduct($(this));" /> Softaculous</label>
                </td>
                <td>
                    
                </td>
                <td>
                    
                </td>
            </tr>
        </tbody>
        </table>
        
    </div>
</div>

<div class="wbox subProducts">
    <div class="wbox_header">
        <strong>{$lang.additional_services}</strong>
    </div>
    <div class="wbox_content">
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
            <colgroup class="firstcol"></colgroup>
            <colgroup class="alternatecol"></colgroup>
            <colgroup class="firstcol"></colgroup>

            {foreach from=$subproducts item=a key=k}
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
                    <select name="subproducts_cycles[{$k}]"   onchange="if($('input[name=\'subproducts[{$k}]\']').is(':checked'))simulateCart('#cart3');">
     {if $a.h!=0}<option value="h" {if $cycle=='h'} selected="selected"{/if}>{$a.h|price:$currency} {$lang.h}{if $a.h_setup!=0} + {$a.h_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$a.d|price:$currency} {$lang.d}{if $a.d_setup!=0} + {$a.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$a.w|price:$currency} {$lang.w}{if $a.w_setup!=0} + {$a.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.m!=0}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$a.m|price:$currency} {$lang.m}{if $a.m_setup!=0} + {$a.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.q!=0}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$a.q|price:$currency} {$lang.q}{if $a.q_setup!=0} + {$a.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$a.s|price:$currency} {$lang.s}{if $a.s_setup!=0} + {$a.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$a.a|price:$currency} {$lang.a}{if $a.a_setup!=0} + {$a.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$a.b|price:$currency} {$lang.b}{if $a.b_setup!=0} + {$a.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$a.t|price:$currency} {$lang.t}{if $a.t_setup!=0} + {$a.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.p4!=0}<option value="p4" {if $cycle=='p4'} selected="selected"{/if}>{$a.p4|price:$currency} {$lang.p4}{if $a.p4_setup!=0} + {$a.p4_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.p5!=0}<option value="p5" {if $cycle=='p5'} selected="selected"{/if}>{$a.p5|price:$currency} {$lang.p5}{if $a.p5_setup!=0} + {$a.p5_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                    </select>
                    {/if}
                </td>
            </tr>
            {/foreach}
        </table>
    </div></div>
{/if}

{if $addons}
<div class="wbox productAddons">
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
            <tr><td width="20"><input name="addon[{$k}]" type="checkbox" value="1" {if $selected_addons.$k}checked="checked"{/if}  onchange="simulateCart('#cart3');"/></td>
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
     {if $a.h!=0}<option value="h" {if $cycle=='h'} selected="selected"{/if}>{$a.h|price:$currency} {$lang.h}{if $a.h_setup!=0} + {$a.h_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$a.d|price:$currency} {$lang.d}{if $a.d_setup!=0} + {$a.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$a.w|price:$currency} {$lang.w}{if $a.w_setup!=0} + {$a.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.m!=0}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$a.m|price:$currency} {$lang.m}{if $a.m_setup!=0} + {$a.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.q!=0}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$a.q|price:$currency} {$lang.q}{if $a.q_setup!=0} + {$a.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$a.s|price:$currency} {$lang.s}{if $a.s_setup!=0} + {$a.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$a.a|price:$currency} {$lang.a}{if $a.a_setup!=0} + {$a.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$a.b|price:$currency} {$lang.b}{if $a.b_setup!=0} + {$a.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$a.t|price:$currency} {$lang.t}{if $a.t_setup!=0} + {$a.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.p4!=0}<option value="p4" {if $cycle=='p4'} selected="selected"{/if}>{$a.p4|price:$currency} {$lang.p4}{if $a.p4_setup!=0} + {$a.p4_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        {if $a.p5!=0}<option value="p5" {if $cycle=='p5'} selected="selected"{/if}>{$a.p5|price:$currency} {$lang.p5}{if $a.p5_setup!=0} + {$a.p5_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                    </select>
                    {/if}
                </td>
            </tr>
            {/foreach}
        </table>
    </div></div>
{/if}





<input name='action' value='addconfig' type='hidden' /><br />

<div class="orderbox continueProcess"><div class="orderboxpadding"><center><input type="submit" value="{$lang.continue}" style="font-weight:bold;font-size:12px;"  class="padded btn  btn-primary"/></center></div></div>

</form>