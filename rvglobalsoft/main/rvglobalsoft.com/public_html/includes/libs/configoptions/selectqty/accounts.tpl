<select style="width:160px" id="custom_field_select_{$kk}" {if $cmd == 'orders' && $c.options & 1}required{/if}>
    <option value="0" {if $c.value=='0'}selected="selected"{/if}>-</option>
    {foreach from=$c.items item=itm name=foo}
        <option data-val="{$itm.copy_of}" value="{$itm.id}"
                {if $c.values[$itm.id] || ($cmd == 'orders' && $make == 'getproduct' && $smarty.foreach.foo.first)}selected="selected"{/if}>{$itm.name}
            {if $admindata.access.viewOrdersPrices}
                {if $itm.price}({$itm.price|price:$currency:true:$forcerecalc}){/if}
            {/if}
        </option>
    {/foreach}
</select>
{if $c.values[$itm.id] || ($cmd == 'orders' && $make == 'getproduct')}
    {foreach from=$c.items item=itm name=foo2}
        {if $c.values[$itm.id] || ($cmd == 'orders' && $make == 'getproduct' && $smarty.foreach.foo2.first)}
            <input name="custom[{$kk}][{$itm.id}]" value="{if $c.qty}{$c.qty}{else}{$c.config.minvalue}{/if}" size="4" id="custom_field_{$kk}" />
        {/if}
    {/foreach}
{else}
    {foreach from=$c.items item=itm}
        <input name="custom[{$kk}][{$itm.id}]" value="{$c.qty}" size="4" id="custom_field_{$kk}"/>{break}
    {/foreach}
{/if}

{if $fieldlogic &&  $c.config.conditionals}
    {cartfieldlogic}
{/if}
<script type="text/javascript">
    (function(){literal}{{/literal}
        var cf = $('#custom_field_{$kk}'),
            cfs = $('#custom_field_select_{$kk}'),
            name =  cf.attr('name').replace(/\[\d+\]$/,'');

        cfs.change(function(){literal}{{/literal}
            var name =  cf.attr('name').replace(/\[\d+\]$/,'')
            cf.attr('name', name + '[' + cfs.val() + ']');
        {literal}});
        cf.attr('name', name + '[' + cfs.val() + ']');
    })();
    {/literal}

    {if $fieldlogic &&  $c.config.conditionals}
        $('#custom_field_{$kk}').fieldLogic({literal}{{/literal}type: '{$c.type}'{literal}}{/literal}, [{foreach from=$c.config.conditionals item=cd name=cond}{literal}{{/literal}
        value: '{$cd.targetval}',
        condition_type: '{$cd.condition}',
        target: '.custom_field_{$cd.target}',
        condition: '{if $cd.conditionval}{$cd.conditionval}{else}{$cd.val}{/if}',
        action: '{$cd.action}'
        {literal}}{/literal}{if !$smarty.foreach.cond.last},{/if}{/foreach}]);

    {/if}


</script>

