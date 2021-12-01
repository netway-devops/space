<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}metered/style.css" />
{*<script type="text/javascript" src="{$orderpage_dir}metered/jquery-1.6.2.js"></script>*}
<script type="text/javascript" src="{$template_dir}js/jquery-ui-1.8.2.custom.min.js"></script>
<script type="text/javascript" src="{$orderpage_dir}metered/jquery.ui.selectmenu.js"></script>
<link type="text/css" href="{$orderpage_dir}metered/jquery.ui.selectmenu.css" rel="stylesheet" />
<link type="text/css" href="{$orderpage_dir}metered/jquery.ui.theme.css" rel="stylesheet" />
<script src="{$orderpage_dir}metered/scripts_metered.js" type="text/javascript"></script>
<div class="zone-all">
    <h3 class="title-b">{$lang.browseprod}</h3>

    <ul class="menu-tabs">
        {foreach from=$categories item=i name=categories}
            {if $i.id == $current_cat} 
                <li class="first">
                    <a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a>
                </li>
            {/if}
        {/foreach}
        {foreach from=$categories item=i name=categories name=cats}
            {if $i.id != $current_cat}
                <li class="{if $smarty.foreach.cats.last && $logged!='1'}last{/if}"><a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a></li>
                {/if}
            {/foreach}
            {if $logged=='1' && $current_cat!='addons'}
            <li class="last"><a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{$lang.prodaddons}</a></li>
            {/if}
    </ul>
    <div class="con-inner-middle">		
        {* DISABLED CART DESCRIPTION 
        {foreach from=$categories item=i name=categories name=cats}
        {if $i.id == $current_cat && $i.description!=''}
        <div style="text-align:left;margin-top:10px;">{$i.description}</div>
        {/if}
        {/foreach}*}
        {if $current_cat!='addons' && $current_cat!='transfer' && $current_cat!='register'}
            <br />
            {if $products}				
                <table cellpadding="0" cellspacing="0" class="met">
                    <tr class="first-row-top">
                        <td colspan="4"><div><div></div></div></td>
                    </tr>								
                    <tr class="first-row">
                        <td class="col1" width="600">{$lang.service}</td>
                        <td width="115">{$lang.setupfee}</td>
                        <td width="94">{$lang.price}</td>
                        <td class="col4"  width="287">{$lang.Description}</td>
                    </tr>								
                    <tr class="first-row-bottom">
                        <td colspan="4"><div><div></div></div></td>
                    </tr>
                    <tr >
                        <td colspan="3">
                            <ul class="pr">
                                {foreach from=$products item=i key=k}
                                    <!-- -->
                                    <li id="id-{$i.id}" {if $opconfig.defaultselect == ($k+1) || ((!$opconfig.defaultselect || $opconfig.defaultselect < 1) && $k==0)}class="active"{/if}>
                                        <label>
                                            <div class="bel-top"><div></div></div>
                                            <div class="bel-middle">
                                                <table cellpadding="0" cellspacing="0" >
                                                    <colgroup>
                                                        <col width="5" />
                                                        <col width="361" />
                                                        <col width="61"/>
                                                        <col width="83"/>
                                                    </colgroup>						
                                                    <tr>
                                                        <td class="vmid"><div><input type="radio" name="box" {if $opconfig.defaultselect == ($k+1) || ((!$opconfig.defaultselect || $opconfig.defaultselect < 1) && $k==0)}checked="checked"{/if} value="{$i.id}" /></div></td>
                                                        <td>
                                                            <div class="pr-title">
                                                                {$i.name}
                                                            </div>
                                                            <div class="pr-desc">
                                                                {if $i.description!=''}
                                                                    <div class="pr-desc-top"><div></div></div>
                                                                    <div class="pr-desc-middle">												
                                                                        {$i.description}
                                                                        <div style="height:1px"></div>
                                                                    </div>
                                                                    <div class="pr-desc-bottom"><div></div></div>													
                                                                        {/if}
                                                            </div>
                                                        </td>
                                                        <td class="font-n" align="center" >
                                                            {price product=$i first=true}
                                                            {if $i.paytype=='Free'}<input type="hidden" name="cycle" value="Free" />
                                                            {elseif $i.paytype=='Once'}<input type="hidden" name="cycle" value="Once" />{/if}
                                                            @@setup @@setup!='-'@
                                                            {/price}

                                                        </td>
                                                        <td class="font-n" align="center" >
                                                            {price product=$i first=true}
                                                            {if $i.paytype=='Free'}{$lang.Free}{else}
                                                                @@price @@price!='-'@
                                                            {/if}
                                                            {/price}											
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>			
                                            <div class="bel-bottom"><div></div></div>
                                        </label>
                                    </li>
                                    <!-- -->								
                                {/foreach}
                            </ul>
                        </td>
                        <td colspan="3">
                            {foreach from=$products item=i key=k}
                                <div class="right hideable id-{$i.id}" {if $opconfig.defaultselect == ($k+1) || ((!$opconfig.defaultselect || $opconfig.defaultselect < 1) && $k==0)}style="display:block;"{else}style="display:none;"{/if}>
                                    <div class="desc">
                                        <div class="desc-title">
                                            {$i.name}
                                        </div>
                                        <div class="desc-cont" {if $i.description=='' ||  $i.description=='<ul></ul>'}style="visibility: hidden"{/if}>
                                            <div class="top">&nbsp;</div>
                                            <div class="middle">
                                                {$i.description}														
                                            </div>
                                            <div class="bottom">&nbsp;</div>
                                        </div>

                                    </div>
                                </div>						
                            {/foreach}
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            {foreach from=$products item=i key=k}

                                <div class="bil-opt hideable id-{$i.id}" {if $opconfig.defaultselect == ($k+1) || ((!$opconfig.defaultselect || $opconfig.defaultselect < 1) && $k==0)}style="display:block;"{else}style="display:none;"{/if}>
                                    <div class="bil-opt-top"><div></div></div>
                                    <div class="bil-opt-middle">
                                        <div class="bil-opt-title">
                                            {if  $i.paytype=='Free'}
                                                {$lang.price} {$lang.Free}
                                            {elseif $i.paytype=='Once'}
                                            {$lang.price} {if $i.m>0}{$i.m|price:$currency}{else}{$lang.Free}{/if}
                                        {else}
                                            {$lang.pselectbilling}:
                                        {/if}
                                    </div>
                                    {if  $i.paytype!='Free' &&  $i.paytype!='Once'}
                                        <div class="bil-opt-sel">
                                            <label for="cycle{$k.id}">
                                                {$lang.pickcycle}						
                                            </label>
                                            <div class="select-cont">
                                                <div>
                                                    {if  $i.paytype!='Free' &&  $i.paytype!='Once'}
                                                        {price product=$i}
                                                        <select name="cycle"  id="cycle_id-{$i.id}" 
                                                                onclick="setselectw('cycle_id-{$i.id}');" 
                                                                onchange="$('.maincycle').val($(this).val());">

                                                            <option value="@@cycle">@@line</option>
                                                        </select>
                                                        {/price}
                                                    {/if} 											
                                                </div>
                                            </div>

                                        </div>
                                    {/if}
                                    {if count($currencies)>1}
                                        <form action="" method="post" id="currform{$k}">
                                            <div class="bil-opt-sel">
                                                <input name="action" type="hidden" value="changecurr">
                                                <label for="cycleCurrency{$k.id}">
                                                    {$lang.Currency} 				
                                                </label>
                                                <div class="select-cont">
                                                    <div>
                                                        <select id="curr_id-{$i.id}" name="currency" class="styled span2" onchange="$('#currform{$k}').submit();
                                                        return false;">
                                                            {foreach from=$currencies item=crx}
                                                                <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                                                            {/foreach}
                                                        </select>		
                                                    </div>
                                                </div>
                                            </div>									
                                        </form>
                                    {/if}
                                </div>
                                <div class="bil-opt-bottom"><div></div></div>
                            </div>	
                        {/foreach}
                    </td>
                    <td style="vertical-align:middle">
                        {foreach from=$products item=i key=k}
                            <div class="hideable id-{$i.id}" {if $opconfig.defaultselect == ($k+1) || ((!$opconfig.defaultselect || $opconfig.defaultselect < 1) && $k==0)}style="display:block;"{else}style="display:none;"{/if}>
                                <form name="" action="" method="post">
                                    <input name="action" type="hidden" value="add">
                                    <input name="id" type="hidden" value="{$i.id}">
                                    {if $i.paytype=='Free'}<input type="hidden" name="cycle" value="Free" />
                                    {elseif $i.paytype=='Once'}<input type="hidden" name="cycle" value="Once" />
                                    {else}<input type="hidden" name="cycle" class="maincycle" value="" />
                                    {/if}												

                                    <div class="center" >
                                        <span class="button01" >
                                            <span>
                                                <input type="submit" value="{$lang.ordernow}" style="font-weight:bold;" class="padded btn"/>
                                            </span>
                                        </span>
                                    </div>
                                </form>
                            </div>						
                        {/foreach}
                    </td>
                </tr>								
            </table>
        {else}
            <center>{$lang.nothing}</center>
            {/if}


    {/if}

</div>