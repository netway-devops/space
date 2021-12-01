{include file='dedicated/cart_header.tpl'}

<form method="post" id="step2form" action="?cmd=cart" class="form-horizontal">
    <input type="hidden" name="action" value="addconfig"/>
    <input type="hidden" name="do" value="{$progress}"/>
    <div class="content">
        <div id="left">
            <h1>
                <span class="s1"></span>
                <span class="s2">
                    {if $progress==5}
                        {$lang.additional_services}
                    {/if}
                </span>
            </h1>
            <ul id="productS">
                {if $custom}
                    {include file='dedicated/cart_customfields.tpl'}
                {/if}
                {if $subproducts}
                    {foreach from=$subproducts item=a key=k}
                        <li id="paddo_{$a.id}" class="paddon_">
                            <div class="productsT" >
                                <span class="bL"></span>
                                <div class="cProductS">
                                    <p>
                                        <span></span>
                                        <span class="s1">{$a.category_name} - {$a.name}</span>
                                        <span class="s2 picked_option">
                                            {if !$cart_contents[4][$a.id]}
                                                {$lang.none}
                                            {else}
                                                {if $cart_contents[4][$a.id].recurring=='free'}
                                                    {$lang.free}
                                                {elseif $cart_contents[4][$a.id].recurring=='once'}
                                                    {$a.m|price:$currency} {$lang.once} {if $a.m_setup!=0}/ {$a.m_setup|price:$currency} {$lang.setupfee}
                                                    {/if}
                                                {else}
                                                    {foreach from=$a item=p_price key=p_cycle}
                                                        {if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}
                                                            {if  $cart_contents[4][$a.id].recurring==$p_cycle}
                                                                {assign var=p_setup value="`$p_cycle`_setup"}
                                                                {$p_price|price:$currency} {$lang.$p_cycle}
                                                                {if $a.$p_setup!=0} + {$a.$p_setup|price:$currency} {$lang.setupfee}
                                                                {/if}
                                                            {/if}
                                                        {/if}
                                                    {/foreach}
                                                {/if}
                                            {/if}
                                        </span>
                                    </p>
                                    <a href="#" onclick="return excol2('{$a.id}',this)">
                                        <span class="s10 {if $cart_contents[4][$a.id]}s11{/if}"></span>
                                        <span class="s2"><span class="ss1" {if $cart_contents[4][$a.id]}style="display:none"{/if}>{$lang.addtoorder}</span><span class="ss2" {if !$cart_contents[4][$a.id]}style="display:none"{else}{/if}>{$lang.modify}</span></span>
                                    </a>
                                </div>
                                <span class="bR"></span>
                            </div>
                            <div class="cPForm" style="display:none" id="excol2_{$a.id}">
                                <ul>
                                    <li ><input type="radio" name="subproduct_cycles[{$k}]" value="-1" class="pconfig2_" {if $cart_contents[4]}{if !$cart_contents[4][$a.id]}checked="checked"{/if}{else}checked="checked"{/if} />
                                        <span class="s1"><span>{$lang.none}</span></span>
                                    </li>


                                    {if $a.paytype=='Free'}

                                        <li ><input type="radio" name="subproduct_cycles[{$k}]" value="free" class="pconfig2_" {if $cart_contents[4] && $cart_contents[4][$a.id].recurring=='free'}checked="checked"{/if} />
                                            <span class="s1"><span>{$lang.free}</span></span>
                                        </li>
                                    {elseif $a.paytype=='Once'}
                                        <li ><input type="radio" name="subproduct_cycles[{$k}]" value="once" class="pconfig2_" {if $cart_contents[4] && $cart_contents[4][$a.id].recurring=='once'}checked="checked"{/if} />
                                            <span class="s1"><span>{$a.m|price:$currency} {$lang.once} {if $a.m_setup!=0}/ {$a.m_setup|price:$currency} {$lang.setupfee}{/if}</span></span></li>

                                    {else}
                                        {foreach from=$a item=p_price key=p_cycle}
                                            {if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}
                                                {if $p_price!=0}
                                                    <li >
                                                        <input type="radio" name="subproduct_cycles[{$k}]" value="{$p_cycle}" class="pconfig2_" {if $cart_contents[4] && $cart_contents[4][$a.id].recurring==$p_cycle}checked="checked"{/if}/>
                                                        {assign var=p_setup value="`$p_cycle`_setup"}
                                                        <span class="s1"><span>{$p_price|price:$currency} {$lang.$p_cycle}{if $a.$p_setup!=0} + {$a.$p_setup|price:$currency} {$lang.setupfee}{/if}</span></span>
                                                    </li>
                                                {/if}
                                            {/if}
                                        {/foreach}
                                    {/if}

                                </ul>
                            </div>
                        </li>
                    {/foreach}
                {/if}
                {if $addons}
                    {foreach from=$addons item=a key=k}
                        <li id="paddo_{$a.id}" class="paddon_">
                            <div class="productsT" >
                                <span class="bL"></span>
                                <div class="cProductS">
                                    <p>
                                        <span></span>
                                        <span class="s1">{$lang.addon}: {$a.name}</span>
                                        <span class="s2 picked_option">
                                        {if !$cart_contents[3][$a.id]}{$lang.none}{else}
                                            {if $cart_contents[3][$a.id].recurring=='free'}
                                                {$lang.free}
                                            {elseif $cart_contents[3][$a.id].recurring=='once'}
                                                {$a.m|price:$currency} {$lang.once} {if $a.m_setup!=0}/ {$a.m_setup|price:$currency} {$lang.setupfee}
                                                {/if}
                                            {else}
                                                {foreach from=$a item=p_price key=p_cycle}
                                                    {if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}
                                                        {if  $cart_contents[3][$a.id].recurring==$p_cycle}
                                                            {assign var=p_setup value="`$p_cycle`_setup"}
                                                            {$p_price|price:$currency} {$lang.$p_cycle}
                                                            {if $a.$p_setup!=0} + {$a.$p_setup|price:$currency} {$lang.setupfee}
                                                            {/if}
                                                        {/if}
                                                    {/if}
                                                {/foreach}
                                            {/if}
                                        {/if}
                                    </span>
                                </p>
                                <a href="#" onclick="return excol2('{$a.id}',this)">
                                    <span class="s10 {if $cart_contents[3][$a.id]}s11{/if}"></span>
                                    <span class="s2"><span class="ss1" {if $cart_contents[3][$a.id]}style="display:none"{/if}>{$lang.addtoorder}</span><span class="ss2" {if !$cart_contents[3][$a.id]}style="display:none"{else}{/if}>{$lang.modify}</span></span>
                                </a>
                            </div>
                            <span class="bR"></span>
                        </div>
                        <div class="cPForm" style="display:none" id="excol2_{$a.id}">
                            <ul>
                                <li ><input type="radio" name="addon_cycles[{$k}]" value="-1" class="pconfig2_" {if $cart_contents[3]}{if !$cart_contents[3][$a.id]}checked="checked"{/if}{else}checked="checked"{/if} />
                                    <span class="s1"><span>{$lang.none}</span></span>
                                </li>


                                {if $a.paytype=='Free'}

                                    <li ><input type="radio" name="addon_cycles[{$k}]" value="free" class="pconfig2_" {if $cart_contents[3] && $cart_contents[3][$a.id].recurring=='free'}checked="checked"{/if} />
                                        <span class="s1"><span>{$lang.free}</span></span>
                                    </li>
                                {elseif $a.paytype=='Once'}
                                    <li ><input type="radio" name="addon_cycles[{$k}]" value="once" class="pconfig2_" {if $cart_contents[3] && $cart_contents[3][$a.id].recurring=='once'}checked="checked"{/if} />
                                        <span class="s1"><span>{$a.m|price:$currency} {$lang.once} {if $a.m_setup!=0}/ {$a.m_setup|price:$currency} {$lang.setupfee}{/if}</span></span></li>

                                {else}
                                    {foreach from=$a item=p_price key=p_cycle}
                                        {if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}
                                            {if $p_price!=0}
                                                <li >
                                                    <input type="radio" name="addon_cycles[{$k}]" value="{$p_cycle}" class="pconfig2_" {if $cart_contents[3] && $cart_contents[3][$a.id].recurring==$p_cycle}checked="checked"{/if}/>
                                                    {assign var=p_setup value="`$p_cycle`_setup"}
                                                    <span class="s1"><span>{$p_price|price:$currency} {$lang.$p_cycle}{if $a.$p_setup!=0} + {$a.$p_setup|price:$currency} {$lang.setupfee}{/if}</span></span>
                                                </li>
                                            {/if}
                                        {/if}
                                    {/foreach}
                                {/if}
                            </ul>
                        </div>
                    </li>
                {/foreach}
            {/if}
        </ul>
    </div>
    {include file='dedicated/cart_sidemenu.tpl'}
</div></form>
{include file='dedicated/cart_footer.tpl'}