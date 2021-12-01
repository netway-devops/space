{cartfieldlogic}
{assign value="" var=cfitem_description}
<select name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}]"
        style="width:99%"
        class="pconfig_ form-control styled custom_field_{$cf.copy_of} cf_item_description_selector"
        data-copy_of="{$cf.copy_of}"
        id="custom_field_{$cf.copy_of}"
        onchange="$(document).trigger('hbcart.changeform', [this]);if(typeof (simulateCart)=='function') simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}')">
{foreach from=$cf.items item=cit}
    <option data-description="{$cit.description|escape}" data-val="{$cit.copy_of}" value="{$cit.id}" {cartformvalue}{if $cfvalue}selected="selected" {assign value="`$cit.description`" var=cfitem_description}{/if} >{$cit.name} {if $cit.price!=0}(
            {if $cit.fee!=0} {$cit.fee|price:$currency} {$lang[$cit.recurring]}{/if}
            {if $cit.setup!=0} {$cit.setup|price:$currency} {$lang.setupfee}{/if}
        ){/if}</option>
{/foreach}
</select>
<div class="mt-2 mb-3 text-secondary cf_item_description_value cf_{$cf.copy_of}_item_description_value">{$cfitem_description|escape}</div>
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