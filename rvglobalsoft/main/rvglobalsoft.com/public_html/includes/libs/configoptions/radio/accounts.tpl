{foreach from=$c.items item=cit}
<input name="{if $cf_opt_name}{$cf_opt_name}{else}custom{/if}[{$kk}]"  value="{$cit.id}" type="radio" {if $c.values[$cit.id]}checked="checked"{/if}  {if $fieldlogic}class="custom_field_{$c.copy_of}"{/if}/> {$cit.name}
    {if $admindata.access.viewOrdersPrices}
        {if $cit.price}({$cit.price|price:$currency:true:$forcerecalc}){/if}<br/>
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
