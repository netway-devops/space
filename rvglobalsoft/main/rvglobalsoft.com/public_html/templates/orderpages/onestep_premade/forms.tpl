{*{if $cf.description!=''}<div class="cart-form-descr" >{$cf.description}</div>{/if}
subdomains-option
cpu-option
ram-option
disc-option
bandwidth-option
users-option
*}

{if $cf.items}
    <div class="server-detail {if $form_custom_counter % 2 == 0}server-detail-dark{else}server-detail-light{/if} {if $form_custom_counter == 0}first{/if}">

        {if $cf.type=='textarea'}
            <p class="openSansBold {if $cf.key}{$cf.key}{else}users-option{/if}"> {$cf.name}{if $cf.options &1}<span class="cart-form-star">*</span>{/if}</p>
            {foreach from=$cf.items item=cit}

                <textarea name="custom[{$cf.id}][{$cit.id}]" id="custom_field_{$cf.id}"  class="styled pinput_ custom_field_{$cf.id}" style="width:99%" >{$cart_contents[1][$cf.id][$cit.id].val}</textarea> 
            {/foreach}
        {elseif $cf.type=='input'}
            <p class="openSansBold {if $cf.key}{$cf.key}{else}users-option{/if}"> {$cf.name}{if $cf.options &1}<span class="cart-form-star">*</span>{/if}</p>
            {foreach from=$cf.items item=cit}
                <input name="custom[{$cf.id}][{$cit.id}]" id="custom_field_{$cf.id}"   value="{$cart_contents[1][$cf.id][$cit.id].val}"  class="styled pinput_ custom_field_{$cf.id}" style="width: 99%" type="text" />
            {/foreach}
        {elseif $cf.type=='qty' || $cf.type=='slider'}
            <div class="openSansBold right">
                {foreach from=$cf.items item=cit} 
                    <a href="#" class="addToServer" step="1"</a>
                    <a href="#" class="reduce" step="-1"></a>
                    <input type="hidden" name="custom[{$cf.id}][{$cit.id}]" onchange="simulateCart();" 
                           value="{if $cart_contents[1][$cf.id]}{foreach from=$cart_contents[1][$cf.id] item=cit}{$cit.qty}{/foreach}{else}0{/if}"
                           id="custom_field_{$cf.id}" class="custom_field_{$cf.id}"/>
                    <span class="s1"><span class="slider_value">{if $cart_contents[1][$cf.id]}{foreach from=$cart_contents[1][$cf.id] item=cit}{$cit.qty}{/foreach}{else}0{/if}</span> <span>{$cit.name}</span> {if $cit.price!=0}(+ {$cit.price|price:$currency}){/if}</span>
                {/foreach}
                {cartfieldlogic}
                {if $cf.config.conditionals}
                    <script type="text/javascript">
                    $('.custom_field_{$cf.id}').fieldLogic({literal}{{/literal}type: '{$cf.type}'{literal}}{/literal},[{foreach from=$cf.config.conditionals item=cd name=cond}{literal}{{/literal}
                         value: '{$cd.targetval}',
                         condition_type: '{$cd.condition}',
                         target: '.custom_field_{$cd.target}',
                         condition: '{if $cd.conditionval}{$cd.conditionval}{else}{$cd.val}{/if}',
                         action: '{$cd.action}'
                         {literal}}{/literal}{if !$smarty.foreach.cond.last},{/if}{/foreach}]);
                    </script>
                {/if}
            </div>
            <p class="openSansBold {if $cf.key}{$cf.key}{else}users-option{/if}"> {$cf.name}{if $cf.options &1}<span class="cart-form-star">*</span>{/if}</p>
        {else}
            <p class="openSansBold {if $cf.key}{$cf.key}{else}users-option{/if}"> {$cf.name}{if $cf.options &1}<span class="cart-form-star">*</span>{/if}</p>
            {assign value=$cart_contents var=contents}
            {include file=$cf.configtemplates.cart}
        {/if}
        {if $cf.description!=''}<div class="cart-form-descr clear" >{$cf.description}</div>{/if}
    </div>
{/if}