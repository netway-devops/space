<div class="cart-switch clearfix">
    <span><b>{$lang.bestselling}</b></span>
    <span class="active"><b>{$lang.allservers}</b></span>
    <div></div>
</div>
<h2>{$lang.configure} <strong>{$lang.dedicatedserver}</strong></h2>
<div class="switch-content">
    <div class="server-list">
        <table cellpadding="0" cellspacing="0" class="server-table table-striped">
            <thead>
                <tr>
                    <th>
                        <strong>{$lang.server}</strong>
                    </th>
                    {foreach from=$products item=i name=ploop key=k}
                        {specs var="awords_top" string=$i.description}
                        {if $awords_top[0].specs} 
                            {foreach from=$awords_top[0].specs item=feat name=feat key=ka}
                                {if $smarty.foreach.feat.index > 2}{break}
                                {/if}
                                <th>
                                    <strong>{$feat[0]}</strong>
                                </th>
                            {/foreach}
                        {/if}

                        {break}
                    {/foreach}
                    <th>
                        <strong>{$lang.startingat}</strong>
                    </th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                {foreach from=$products item=i name=ploop key=k}
                    <tr {if $smarty.foreach.ploop.iteration%2==0}class="odd"{/if}>
                        <td>
                            <span>{$i.name}</span>
                        </td>
                        {specs var="awords" string=$i.description}
                        <td>{$awords[$k].specs[0][1]}</td>
                        <td>{$awords[$k].specs[1][1]}</td>
                        <td>{$awords[$k].specs[2][1]}</td>
                        <td>
                            {if $i.paytype=='Free'}{$lang.Free}
                            {elseif $i.paytype=='Once'}{$i.m|price:$currency}
                            {else}<!--
                                {if $i.d!=0}
                                    -->{$i.d|price:$currency}<!--
                                {elseif $i.w!=0}
                                    -->{$i.w|price:$currency}<!--
                                {elseif $i.m!=0}
                                    -->{$i.m|price:$currency}<!--
                                {elseif $i.q!=0}
                                    -->{$i.q|price:$currency}<!--
                                {elseif $i.s!=0}
                                    -->{$i.s|price:$currency}<!--
                                {elseif $i.a!=0}
                                    -->{$i.a|price:$currency}<!--
                                {elseif $i.b!=0}
                                    -->{$i.b|price:$currency}<!--
                                {elseif $i.t!=0}
                                    -->{$i.t|price:$currency}<!--
                                {elseif $i.p4!=0}
                                    -->{$i.p4|price:$currency:false}<!--
                                {elseif $i.p5!=0}
                                    -->{$i.p5|price:$currency:false}<!--
                                {/if}
                                -->
                            {/if}
                            {if $i.paytype=='Free'}
                            {elseif $i.paytype=='Once'}/{$lang.once}
                            {else}/
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
                        </td>
                        <td>
                            <a class="btn btn-success btn-order" rel="{$i.id}" href="{$ca_url}cart&amp;action=add&amp;id={$i.id}&amp;cat_id={$current_cat}">{$lang.order}</a>
                        </td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
    <div class="server-blocks">
        <ul id="imgsrc" style="display:none" rel="{$orderpage_dir}dedicated_new/img/">{$opconfig.server_img}</ul>
        {foreach from=$products item=i name=ploop key=k}
            {if $smarty.foreach.ploop.index > 3}{break}{/if}
            <div {if $smarty.foreach.ploop.first}class="first-block"{elseif $smarty.foreach.ploop.last || $smarty.foreach.ploop.index == 3}class="last-block"{/if}>
                <div>
                    <img class="left" src="{$orderpage_dir}dedicated_new/img/default.png" alt="cpu" />
                    <h4>
                        <span>{$i.name}</span>
                    </h4>
                    <ul class="clear">
                        {specs var="awords" string=$i.description}
                        {foreach from=$awords[$k].specs item=feat name=feat key=ka}
                            <li {if $smarty.foreach.feat.last}class="last-child"{/if}><strong>{$feat[0]}:</strong> <span>{$feat[1]}</span></li>
                        {/foreach}
                    </ul>
                    
                </div>
                <div class="separator"></div>
                <div class="last">
                    <a class="btn btn-success btn-order" href="{$ca_url}cart&amp;action=add&amp;id={$i.id}&amp;cat_id={$current_cat}">{$lang.configure}</a>
                    <span class="product-price">{include file="common/price.tpl" product=$i hidecode=true decimal=0}</span>
                    {include file="common/cycle.tpl" product=$i wrap=true}
                    <div class="clear"></div>
                </div>
            </div>
        {/foreach}
    </div>
</div>
