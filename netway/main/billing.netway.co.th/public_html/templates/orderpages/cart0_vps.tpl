{if $custom_overrides.cart0_vps}
    {include file=$custom_overrides.cart0_vps}
{else}
    <h3>{$lang.browseprod}</h3>


    <div style="padding:10px 0px;text-align:center;">

        {foreach from=$categories item=i name=categories name=cats}
            {if $i.id == $current_cat} <strong>{$i.name}</strong> {if !$smarty.foreach.cats.last}|{/if}
            {else} <a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}|{/if}
            {/if}
        {/foreach}
    {if $logged=='1'} | {if $current_cat=='addons'}<strong>{else}<a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{/if}{$lang.prodaddons}{if $current_cat=='addons'}</strong>{else}</a>{/if}{/if}


    {foreach from=$categories item=i name=categories name=cats}
        {if $i.id == $current_cat && $i.description!=''}
            <div style="text-align:left;margin-top:10px;">{$i.description}</div>
        {/if}
    {/foreach}
    </div>




    {if $current_cat!='addons' && $current_cat!='transfer' && $current_cat!='register'}
        <br />
        <div class="vps_cart_products">
            {if $products}

                {if count($currencies)>1}
                    <form action="" method="post" id="currform"><p align="right">
                            <input name="action" type="hidden" value="changecurr">
                            {$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
                                {foreach from=$currencies item=crx}
                                    <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                                {/foreach}
                            </select>
                        </p></form>
                    {/if}

                {foreach from=$products item=i name=loop}
                    <form name="" action="" method="post">
                        <input name="action" type="hidden" value="add">
                        <input name="id" type="hidden" value="{$i.id}">

                        <div class="orderbox" style="width:48%;margin-right:10px;float:left;">
                            <div class="orderboxpadding">
                                <table width="100%">
                                    <tbody>
                                        <tr>
                                            <td colspan="2">
                                                <strong class="biggert">{$i.name}</strong>
                                            </td>
                                        </tr>
                                        <tr>

                                            <td colspan="2">
                                                <div class="descriptionbox">
                                                    {$i.description}
                                                </div>
                                            </td>
                                        </tr>
                                        <tr><td>
                                                {price product=$i}
                                                {if $i.paytype=='Free'}
                                                    <input type="hidden" name="cycle" value="Free" />
                                                    {$lang.price}: <strong > {$lang.Free}</strong>

                                                {elseif $i.paytype=='Once'}
                                                    <input type="hidden" name="cycle" value="Once" />
                                                    {$lang.price}: <span class="biggert"> @@line</span>
                                                {else}
                                                    <select name="cycle" >
                                                        <option value="@@cycle" @@selected>@@line</option>
                                                    </select>
                                                {/if}
                                                {/price}
                                            </td>
                                            <td align="right">
                                                <input type="submit" value="{if $i.out_of_stock}{$lang.out_of_stock_btn}{else}{$lang.ordernow}{/if}" style="font-weight:bold;" class="padded btn" {if $i.out_of_stock}disabled="disabled"{/if}>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </form>

                    {if $smarty.foreach.loop.iteration%2==0}<div class="clear"></div>{/if}

                {/foreach}
                <div class="clear"></div>
            {else}
                <center>{$lang.nothing}</center>
                {/if}
        </div>
        <div class="clear"></div>
    {/if}
    <script type="text/javascript">{literal}
        var max = 0;
        $('.descriptionbox').each(function() {
            var tmx = $(this).height();
            if (max < tmx)
                max = tmx;
        });
        $('.descriptionbox').each(function() {
            $(this).height(max);
        });
        {/literal}</script>
{/if}