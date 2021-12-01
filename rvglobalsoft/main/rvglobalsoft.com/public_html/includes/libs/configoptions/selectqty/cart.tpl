{cartfieldlogic}
<div class="selectqty-box">
    <select class="pconfig_ styled custom_field_{$cf.copy_of}"  id="custom_field_select_{$cf.copy_of}" >
        {foreach from=$cf.items item=cit}
            <option data-val="{$cit.copy_of}" value="{$cit.id}" {cartformvalue} {if $cfvalue}selected="selected"{/if}>{$cit.name} {if $cit.price!=0}(
                    {if $cit.fee!=0} {$cit.fee|price:$currency} {$lang[$cit.recurring]}{/if}
                    {if $cit.setup!=0} {$cit.setup|price:$currency} {$lang.setupfee}{/if}
                    ){/if}</option>
        {/foreach}
    </select>
    {if $cfvalues}
        {foreach from=$cf.items item=cit}
            {if $cfvalues[$cit.id]}
                <input class="pconfig_ styled custom_field_{$cf.copy_of}" type="text" name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]" value="{if $cfvalues[$cit.id].qty}{$cfvalues[$cit.id].qty}{else}{$cf.config.minvalue}{/if}" id="custom_field_{$cf.copy_of}"/>
            {/if}
        {/foreach}
    {else}
        {foreach from=$cf.items item=cit}
            <input class="pconfig_ styled custom_field_{$cf.copy_of}" type="text" name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]" value="{$cf.config.minvalue}" id="custom_field_{$cf.copy_of}" />
            {break}
        {/foreach}
    {/if}
</div>
<script type="text/javascript">
    (function(){literal}{{/literal}
        var cf = $('#custom_field_{$cf.copy_of}'),
            cfs = $('#custom_field_select_{$cf.copy_of}'),
            name =  cf.attr('name').replace(/\[\d+\]$/,''),
            maxval = parseInt('{$cf.config.maxvalue}') || 100,
            size = 12 * (maxval.toString().length + 2);

        cfs.add(cf).change(function(){literal}{{/literal}
            cf.attr('name', name + '[' + cfs.val() + ']');
            $(document).trigger('hbcart.changeform', [cfs]);
            if(typeof (simulateCart)=='function')
                simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}');
            {literal}});
        cf.width(size).attr('name', name + '[' + cfs.val() + ']');
        cfs.css('margin-right', '10px')
            .css('float', 'left')
            .width(cfs.parent().width() - size - (cfs.outerWidth(true) - cfs.width()) - (cf.outerWidth(true) - cf.width()));
    })();
    {/literal}
    {if $cf.config.conditionals}
    $('.custom_field_{$cf.copy_of}').fieldLogic({literal}{{/literal}type: '{$cf.type}'{literal}}{/literal},[{foreach from=$cf.config.conditionals item=cd name=cond}{literal}{{/literal}
        value: '{$cd.targetval}',
        condition_type: '{$cd.condition}',
        target: '.custom_field_{$cd.target}',
        condition: '{if $cd.conditionval}{$cd.conditionval}{else}{$cd.val}{/if}',
        action: '{$cd.action}'
        {literal}}{/literal}{if !$smarty.foreach.cond.last},{/if}{/foreach}]);
    {/if}
</script>

