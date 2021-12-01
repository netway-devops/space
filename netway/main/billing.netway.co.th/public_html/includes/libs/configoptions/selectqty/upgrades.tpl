<tr class="field-upgrade-row field-select">
    <td class="upgrade-name"><b>{$cf.name}</b>
    </td>
    <td class="upgrade-from">

        {foreach from=$cf.items item=cit}
            {if isset($cf.data[$cit.id])}{$cit.name} {if $cit.price!=0}(
                {if $cit.fee!=0} {$cit.fee|price:$currency:1:1} {$lang[$service.billingcycle]}{/if}
                {if $cit.setup!=0} {$cit.setup|price:$currency:1:1} {$lang.setupfee}{/if}
                ){/if}{break}{/if}
        {/foreach}
    </td>
    <td class="upgrade-to">
        <div class="selectqty-box">
            <select name="fupgrade[{$cf.id}][new_config_id]" id="custom_field_select_{$cf.copy_of}">
                {foreach from=$cf.items item=cit} {if $cit.options & 1}{continue}{/if}
                    <option value="{$cit.id}"
                            {if isset($cf.data[$cit.id])}selected="selected"{/if}>{$cit.name} {if $cit.price!=0}(
                            {if $cit.fee!=0} {$cit.fee|price:$currency:1:1} {$lang[$service.billingcycle]}{/if}
                            {if $cit.setup!=0} {$cit.setup|price:$currency:1:1} {$lang.setupfee}{/if}
                            ){/if}</option>
                {/foreach}
            </select>
            <input name="fupgrade[{$cf.id}][new_qty]" value="{$cf.qty}" type="text" id="custom_field_{$cf.copy_of}"/>
            <script type="text/javascript">
                (function () {literal}{{/literal}

                    var cf = $('#custom_field_{$cf.copy_of}'),
                        cfs = $('#custom_field_select_{$cf.copy_of}'),
                        maxval = parseInt('{$cf.config.maxvalue}') || 100,
                        minval = parseInt('{if $cf.options & 32}{$cf.config.minvalue}{else}{$cf.qty}{/if}') || 1,
                        size = 12 * (maxval.toString().length + 2);

                    cf.width(size);
                    cfs.css('margin-right', '10px')
                        .css('float', 'left')
                        .width(cfs.parent().width() - size - (cfs.outerWidth(true) - cfs.width()) - (cf.outerWidth(true) - cf.width()));
                    {literal}
                    cf.on('change', function(){
                        var self = $(this);
                        self.val(Math.max(Math.min(self.val(), maxval), minval))
                    })
                })();
                {/literal}
            </script>
            {cartfieldlogic}
            {if $cf.config.conditionals}
                <script type="text/javascript">
                    $('#custom_field_{$cf.copy_of}').fieldLogic({literal}{{/literal}
                        type: '{$cf.type}'
                        {literal}}{/literal}, {$cf.config.conditionals|@array_values|@json_encode});
                </script>
            {/if}
        </div>
    </td>
</tr>