<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}sslcertificates/style.css" />

{include file='sslcertificates/cprogress.tpl'}

<div class="blue-pad">
    <h4>{$lang.step} 1</h4>
    <h3>{$lang.chooseyourcertificate}</h3>
</div>

{if $products}
    <div class="left products">
        <ul>
            {foreach from=$products item=i name=floop}
                <li class="nitem {if $smarty.foreach.floop.first}selected{/if}{if $smarty.foreach.floop.last} last{/if}">
                    <input type="hidden" name="id" value="{$i.id}" {if $smarty.foreach.floop.first}checked="checked"{/if}/> 
                    <a href="#">{$i.name}</a>
                    <div class="tail"></div>
                </li>
            {/foreach}
        </ul>
    </div>
    <div class="left products-view white-box">
        {foreach from=$products item=i name=floop}
            <div class="product {if $smarty.foreach.floop.first}selected{/if}">
                <form id="mform" class="form-horizontal" action="" method="post">
                    <input type="hidden" name="do" value="0" />
                    <input type="hidden" name="action" value="add" />
                    <input type="hidden" name="cycle" value="" id="product_cycle" />
                    <input type="hidden" name="id" value="{$i.id}" />
                    <h3>{$i.name}</h3>
                    {if $i.description && $i.description != ''}
                    <div class="strike-line"></div>
                    <div class="product-description">
                        {$i.description}
                    </div>
                    {/if}
                    <div class="strike-line"></div>
                    <button type="submit" class="btn btn-custom right">{$lang.continuetostep} 2 &raquo;</button>
                    <div class="product-prices">
                        {if $i.paytype=='Free'}
                            {$lang.free}
                        {else}
                        {if $i.p5!=0}
                            <input type="radio" name="cycle" value="p5"/>
                            <strong>5 {$lang.years}</strong> - {$i.p5|price:$currency} {if $i.p5_setup!=0} + {$i.p5_setup|price:$currency} {$lang.setupfee}{/if}<br />
                        {/if}
                        {if $i.p4!=0}
                            <input type="radio" name="cycle" value="p4"/>
                            <strong>4 {$lang.years}</strong> - {$i.p4|price:$currency} {if $i.p4_setup!=0} + {$i.p4_setup|price:$currency} {$lang.setupfee}{/if}<br />
                        {/if}
                        {if $i.t!=0}
                            <input type="radio" name="cycle" value="t"/>
                            <strong>3 {$lang.years}</strong> - {$i.t|price:$currency} {if $i.t_setup!=0} + {$i.t_setup|price:$currency} {$lang.setupfee}{/if}<br />
                        {/if} 
                        {if $i.b!=0}
                            <input type="radio" name="cycle" value="b"/>
                            <strong>2 {$lang.years}</strong> - {$i.b|price:$currency} {if $i.b_setup!=0} + {$i.b_setup|price:$currency} {$lang.setupfee}{/if}<br />
                        {/if}
                        {if $i.a!=0}
                            <input type="radio" name="cycle" value="a"/>
                            <strong>1 {$lang.years}</strong> - {$i.a|price:$currency} {if $i.a_setup!=0} + {$i.a_setup|price:$currency} {$lang.setupfee}{/if}
                        {/if}
                        {/if}
                    </div>
                    
                </form>
            </div>
        {/foreach}
    </div>
{else}
    <center>{$lang.nothing}</center>
{/if}
<div class="clear"></div>
<script type="text/javascript">
step1();
</script>