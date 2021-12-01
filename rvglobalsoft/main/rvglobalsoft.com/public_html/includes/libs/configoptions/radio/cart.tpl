{cartfieldlogic}
{foreach from=$cf.items item=cit name=its}
<input name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}]"  
       value="{$cit.id}" {if $smarty.foreach.its.first}id="custom_field_{$cf.copy_of}"{/if} type="radio"  {cartformvalue} {if $cfvalue}checked="checked"{/if}
       onclick="$(document).trigger('hbcart.changeform', [this]);if(typeof (simulateCart)=='function') simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}')"
       class="pconfig_ styled custom_field_{$cf.copy_of}"/>
{$cit.name} {if $cit.price!=0}(
    {if $cit.fee!=0} {$cit.fee|price:$currency} {$lang[$cit.recurring]}{/if}
    {if $cit.setup!=0} {$cit.setup|price:$currency} {$lang.setupfee}{/if}
){/if}
<br/>
{/foreach}

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