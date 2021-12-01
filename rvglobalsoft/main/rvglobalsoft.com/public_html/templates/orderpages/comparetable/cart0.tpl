<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}comparetable/style.css" />
<div class="left">
<h3 class="title-b">{$lang.browseprod}</h3>
<div class="menu-prod">
    {foreach from=$categories item=i name=categories name=cats}
        <span {if $i.id == $current_cat}class="active"{/if}><a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a></span>{if $smarty.foreach.cats.last && !$logged}{else} |{/if}
    {/foreach}
{if $logged=='1'} <span ><a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{$lang.prodaddons}</a></span>{/if}
</div>
</div>
{if count($currencies)>1}
    <form action="" method="post" id="currform">
        <p align="right" style="margin-right:15px">
            <input name="action" type="hidden" value="changecurr">
            {$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
                {foreach from=$currencies item=crx}
                    <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                {/foreach}
            </select>
        </p>
    </form>
{/if}
<div class="box-radial" style="clear:both">
<table class="product-table" style="width: 100%" cellpadding="0" cellspacing="0" >
    <thead>
        <tr>
            <td class="empty-td">

            </td>
            {foreach from=$products item=i name=loop key=k}
                {if $smarty.foreach.loop.index > 2}{break}
                {/if}
                <td class="{if $k == $opconfig.selected}active{/if} product-container" rel="{$i.id}">
                    <h2>{$i.name}</h2>
                    <h2 class="price">
                        <strong>
                            {if $i.paytype=='Free'}
                                {$lang.Free}
                            {elseif $i.paytype=='Once'}
                            {$i.m|price:$currency:true:false:false}
                        {else}
                            <!--
                            {if $i.d!=0}
                                -->{$i.d|price:$currency:true:false:false}<!--
                            {elseif $i.w!=0}
                                -->{$i.w|price:$currency:true:false:false}<!--
                            {elseif $i.m!=0}
                                -->{$i.m|price:$currency:true:false:false}<!--
                            {elseif $i.q!=0}
                                -->{$i.q|price:$currency:true:false:false}<!--	
                            {elseif $i.s!=0}
                                -->{$i.s|price:$currency:true:false:false}<!--	
                            {elseif $i.a!=0}
                                -->{$i.a|price:$currency:true:false:false}<!--	
                            {elseif $i.b!=0}
                                -->{$i.b|price:$currency:true:false:false}<!--	
                            {elseif $i.t!=0}
                                -->{$i.t|price:$currency:true:false:false}<!--	
                            {elseif $i.p4!=0}
                                -->{$i.p4|price:$currency:true:false:false}<!--
                            {elseif $i.p5!=0}
                                -->{$i.p4|price:$currency:true:false:false}<!--
                            {/if}
                            -->
                        {/if}
                    </strong>
                    {if $i.paytype=='Free'}
                    {elseif $i.paytype=='Once'}{$lang.once}
                    {else}
                        {if $i.d!=0}{$lang.d} 
                        {elseif $i.w!=0}{$lang.w} 
                        {elseif $i.m!=0}{$lang.m}
                        {elseif $i.q!=0}{$lang.q}
                        {elseif $i.s!=0}{$lang.s}
                        {elseif $i.a!=0}{$lang.a}
                        {elseif $i.b!=0}{$lang.b}
                        {elseif $i.t!=0}{$lang.t}
                        {elseif $i.p4!=0}{$lang.p4}
                        {elseif $i.p5!=0}{$lang.p5}
                        {/if}
                    {/if}
                </h2>
            </td>
        {/foreach}
        </tr>
        <tr class="grove-border">
            <td class="first">
            </td>
            {foreach from=$products item=i name=loop key=k}
                {if $smarty.foreach.loop.index > 2}{break}
                {/if}
                <td class="{if $k == $opconfig.selected}active{/if}"></td>
            {/foreach}
            </tr>
        </thead>
        <tbody>
        {productspec products=$products features=features parsed=$products limit=3}
        {foreach from=$features item=values key=feature name=loop}

            <tr class="{if $smarty.foreach.loop.index %2 != 0}odd{/if}{if $smarty.foreach.loop.first} first{/if}">
                <td class="feature-name">
                    {$feature}
                </td>
                {foreach from=$values item=value key=id}
                    <td class="feature-value{if $value === false} empty{/if}{if $id == $opconfig.selected} active{/if}">
                    <span class="centrate">
                    {if $value !== false}<i class="feature-available"></i>{$value}
                    {else}<i class="feature-notavailable"></i>{if $lang.notincluded}{$lang.notincluded}{else}{$lang.notincluded}{/if}
                    {/if}
                    </span>
                    </td>
                {/foreach}
            </tr>
            {/foreach}
    </tbody>
    <tfoot>
        <tr>
            <td class="empty-td"></td>
        {foreach from=$products item=i name=loop key=k}
            {if $smarty.foreach.loop.index > 2}{break}
                {/if}
            <td class="{if $k == $opconfig.selected}active{/if}">
                <form name="form" action="" method="post">
                    <input name="action" type="hidden" value="add" />
                    <input name="id" type="hidden" value="{$i.id}" />
                    <div class="product-actions">
                        <a href="#" class="btn" onclick="$(this).parent().parent('form').submit();return false;">{$lang.ordernow}</a>
                    </div>
                </form>
            </td>
        {/foreach}
        </tr>
    </tfoot>
</table>
        {literal}
        <script type="text/javascript">
            var prlen = $('.product-container').length;
            var colwid = [0, 0, 0];
            $('.centrate').each(function(i){
                var column = i % prlen;
                if(colwid[column] < $(this).width()){
                    colwid[column] = $(this).width();
                }
            });
            for(i=0; i<colwid.length; i++){
                var off = 2 + i;
                $('td:nth-child('+off+') .centrate').width(colwid[i]).addClass('block');
            }
        </script>
        {/literal}
</div>
<div class="cart-customizations">
{if $opconfig.customheader}
    <h1>{$opconfig.customheader}</h1>
{/if}
{if $opconfig.firstblock || $opconfig.secondblock || $opconfig.thirdblock}
    <table class="blocks">
        <tr>
        {if $opconfig.firstblock }
            <td class="first">
                <img src="{$orderpage_dir}/comparetable/firstimg.png" alt="First image" class="left"/>
            {$opconfig.firstblock }
            </td>
        {/if}
        {if $opconfig.secondblock }
            <td class="second">
                <img src="{$orderpage_dir}/comparetable/secondimg.png" alt="Second image" class="left"/>
            {$opconfig.secondblock }
            </td>
        {/if}
        {if $opconfig.thirdblock }
            <td class="third">
                <img src="{$orderpage_dir}/comparetable/thirdimg.png" alt="Third image" class="left"/>
            {$opconfig.thirdblock }
            </td>
        {/if}
        </tr>
    </table>
{/if}
{if $opconfig.footer}
    <div class="cart-foot"><div>{$opconfig.footer}</div></div>
{/if}
</div>
