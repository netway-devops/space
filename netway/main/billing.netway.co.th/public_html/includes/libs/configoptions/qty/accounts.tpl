{foreach from=$c.items item=cit}
    <input name="custom[{$kk}][{$cit.id}]" data-variable="{$c.variable}" size="8" value="{$c.qty}"  {if $fieldlogic}class="custom_field_{$c.copy_of}"{/if} {if $cmd == 'orders' && $c.options & 1}required{/if}/>
    {if $cit.name || $cit.price}x {/if}{if $cit.name}{$cit.name}{/if}
    {if $admindata.access.viewOrdersPrices}
        {if $cit._price}({$cit._price|price:$currency:1:$forcerecalc:$currency.code})
        {elseif $cit.price}({$cit.price|price:$currency:true:$forcerecalc}){/if}
    {else} -
    {/if}
{/foreach}

{if $fieldlogic &&  $c.config.conditionals}
    {cartfieldlogic}
    <script type="text/javascript">
        $('.custom_field_{$c.copy_of}').fieldLogic({literal}{{/literal}type: '{$c.type}'{literal}}{/literal},[{foreach from=$c.config.conditionals item=cd name=cond}{literal}{{/literal}
            value: '{$cd.targetval}',
            condition_type: '{$cd.condition}',
            target: '.custom_field_{$cd.target}',
            condition: '{if $cd.conditionval}{$cd.conditionval}{else}{$cd.val}{/if}',
            action: '{$cd.action}'
            {literal}}{/literal}{if !$smarty.foreach.cond.last},{/if}{/foreach}]);
    </script>
{/if}
