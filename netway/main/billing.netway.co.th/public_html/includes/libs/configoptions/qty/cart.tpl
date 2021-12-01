{cartfieldlogic}
{foreach from=$cf.items item=cit}
    <input name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]" 
           id="custom_field_{$cf.copy_of}"  {cartformvalue} value="{$cfvalue.qty}"
           class="styled custom_field custom_field_{$cf.copy_of}" type="text" size="2"
           onchange="$(document).trigger('hbcart.changeform', [this]);if(typeof(simulateCart) == 'function')simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}');"/> {if $cit.name || $cit.price}x{/if} {if $cit.name!='None'}{$cit.name}{/if}
    {if $cit.price!=0}(
    {if $cit._fee!=0} {$cit._fee|price:$currency}{elseif $cit.fee!=0} {$cit.fee|price:$currency} {$lang[$cit.recurring]}{/if}
    {if $cit._setup!=0} {$cit._setup|price:$currency} {$lang.setupfee}{elseif $cit.setup!=0} {$cit.setup|price:$currency} {$lang.setupfee}{/if}
){/if}<br/>{/foreach}

{if $cf.config.conditionals}
    <script type="text/javascript">
    $('.custom_field_{$cf.copy_of}').fieldLogic({literal}{{/literal}type: '{$cf.type}'{literal}}{/literal},[{foreach from=$cf.config.conditionals item=cd name=cond}{literal}{{/literal}
         value: '{$cd.targetval}',
         condition_type: '{$cd.condition}',
         target: '.custom_field_{$cd.target}',
         condition: '{if $cd.conditionval}{$cd.conditionval}{else}{$cd.val}{/if}',
         action: '{$cd.action}'
         {literal}}{/literal}{if !$smarty.foreach.cond.last},{/if}{/foreach}]);
    </script>
{/if}
