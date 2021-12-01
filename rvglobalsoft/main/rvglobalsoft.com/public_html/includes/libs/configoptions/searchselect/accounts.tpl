<select name="custom[{$kk}]"  {if $fieldlogic}id="custom_field_{$c.copy_of}"{/if} {if $cmd == 'orders' && $c.options & 1}required{/if}>
    <option value="0" {if $c.value=='0'}selected="selected"{/if}>-</option>
    {foreach from=$c.items item=itm}
        <option data-val="{$itm.copy_of}" value="{$itm.id}" {if $c.values[$itm.id]}selected="selected"{/if}>{$itm.name}
            {if $admindata.access.viewOrdersPrices}
                {if $itm.price}({$itm.price|price:$currency:true:$forcerecalc}){/if}
            {/if}
        </option>
    {/foreach}
</select>

{if $fieldlogic &&  $c.config.conditionals}
    {cartfieldlogic}
    <script type="text/javascript">
        $('#custom_field_{$c.copy_of}').fieldLogic({literal}{{/literal}type: '{$c.type}'{literal}}{/literal}, [{foreach from=$c.config.conditionals item=cd name=cond}{literal}{{/literal}
            value: '{$cd.targetval}',
            condition_type: '{$cd.condition}',
            target: '.custom_field_{$cd.target}',
            condition: '{if $cd.conditionval}{$cd.conditionval}{else}{$cd.val}{/if}',
            action: '{$cd.action}'
            {literal}}{/literal}{if !$smarty.foreach.cond.last},{/if}{/foreach}]);

    </script>
{/if}

