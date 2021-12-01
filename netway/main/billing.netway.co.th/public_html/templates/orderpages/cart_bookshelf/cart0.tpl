{if count($currencies)>1}
    <form action="" method="post" id="currform">
        <p align="right" style="margin-right:25px">
            <input name="action" type="hidden" value="changecurr">
            {$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
                {foreach from=$currencies item=crx}
                    <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                {/foreach}
            </select>
        </p>
    </form>
{/if}
<!-- Servers -->
<div class="servers clearfix">
    {foreach from=$products item=i name=loop key=k}
        {if $smarty.foreach.loop.index > 3}{break}{/if}
        <div class="column left {if $smarty.foreach.loop.index == $opconfig.highlighted}best{/if}">
            <div class="iemask">
                <div class="iegrad">
                    <h3>{$i.name}</h3>
                    <div class="hr"></div>
                    <div class="price-box">
                        <span class="sign">{$currency.sign}</span><span class="price">{include file='common/price.tpl' product=$i hideall=true}</span><br />
                        {include file="common/cycle.tpl" product=$i}
                    </div>
                    
                    {if $opconfig.highlighted == $smarty.foreach.loop.index}
                        <div class="ribbon-top">
                            <div class="body">{$lang.best}!</div>
                            <div class="top"></div>
                            <div class="right"></div>
                        </div>
                    {/if}
                    <div class="order-now center">
                        <form method="post" action="" class="parentform">
                            <input type="hidden" name="action" value="add" />
                            <input type="hidden" name="id" value="{$i.id}" />
                            <a href="#" class="order-btn" onclick="$(this).parent().submit(); return false;">
                                {$lang.ordernow}
                            </a>
                        </form>
                    </div>
                    {specs var="awords" string=$i.description}
                    {foreach from=$awords item=prod name=lla key=k}
                        <ul class="specs">
                            {if $prod.specs} 
                                {foreach from=$prod.specs item=feat name=ll key=ka}
                                    <li>
                                        <strong>{$feat[1]}</strong>
                                        <span>{$feat[0]}</span>
                                    </li>
                                {/foreach}
                            {/if}

                        </ul>

                        {if $prod.features} 
                            <div class="additional-specs">
                                {$prod.features}
                            </div>
                        {/if}

                    {/foreach}
                    {assign var=awords value=false}
                </div>
            </div>
            <div class="order-now-shadow">
                <div class="left"></div>
                <div class="right"></div>
            </div>
        </div>
    {/foreach}  
</div>
    {include file='cart_bookshelf/cart.progress.tpl'}
    {include file='cart_bookshelf/cart.footer.tpl'}
