{if $cf.config.showsteps}
    {once}
        <script type="text/javascript" src="{$system_url}includes/libs/configoptions/slider/pips/jquery-ui-slider-pips.js"></script>
        <link rel="stylesheet" href="{$system_url}includes/libs/configoptions/slider/pips/jquery-ui-slider-pips.css" />
    {/once}
{/if}
{foreach from=$cf.items item=cit}
    <tr class="field-upgrade-row field-slider">
        <td class="upgrade-name"><b>{$cf.name}</b></td>
        <td class="upgrade-from">
            <input name="fupgrade[{$cf.id}][new_config_id]" value="{$cit.id}" type="hidden"/>
            <b>{$cf.qty}</b>
            {if $cit.name}{$cit.name}{/if}
            {if $cit._price!=0} ({$cit._price|price:$currency:1:1:$currency.code})
            {elseif $cit.price>0} ({$cit.price|price:$currency:1:1})
            {/if}
        </td>
        <td class="upgrade-to">
            <div class="slider-group">
                <div id="custom_slider_{$cit.id}" class="slides left"
                     style="margin:6px 20px 0px 20px !important;float:left !important;width:370px;">
                    <div class="sl"></div>
                    <div class="sr"></div>
                </div>
                <input name="fupgrade[{$cf.id}][new_qty]" value="{$cf.qty}" type="text" id="custom_field_{$cf.copy_of}"/>
            </div>
            <script type="text/javascript">
                {literal}
                setTimeout(function () {
                    var s = $('#custom_slider_{/literal}{$cit.id}{literal}');
                    var sval = $('#custom_field_{/literal}{$cf.copy_of}{literal}');
                    if (typeof ($('#slider').slider) != 'function') {
                        s.hide();
                        return false;
                    }

                    var maxval = parseInt('{/literal}{$cf.config.maxvalue}{literal}') || 100,
                        minval = parseInt('{/literal}{if $cf.options & 32}{$cf.config.minvalue}{else}{$cf.qty}{/if}{literal}') || 0,
                        stepval = parseInt('{/literal}{$cf.config.step}{literal}') || 1,
                        initialval = parseInt('{/literal}{$cf.qty}{literal}') || 0,
                        size = 12 * (maxval.toString().length + 1),
                        showsteps = {/literal}{if $cf.config.showsteps} true {else} false {/if}{literal};

                    if ((maxval - minval) / stepval > 10) {
                        var pipstep = (maxval - minval) / 10;
                    }

                    if (minval < initialval)
                        minval += Math.abs(minval - initialval) % stepval;

                    s.width(s.parent().width() - size - (s.outerWidth(true) - s.width()) - (sval.outerWidth(true) - sval.width()) - 2).slider({
                        min: minval,
                        max: maxval,
                        value: sval.val() || initialval,
                        values: [],
                        step: stepval,
                        range: "min",
                        animate: true,
                        stop: function (e, ui) {
                            var x = Math.floor(s.slider("value"));
                            sval.val(x).trigger('change');
                        }
                    });

                    if (showsteps) {
                        s.slider("pips", {
                            rest: "label",
                            step: pipstep
                        }).slider("float");
                    }

                    sval.width(size).bind('change.slider', function () {
                        var self = $(this),
                            val = parseInt(self.val());

                        if (isNaN(val))
                            val = minval;

                        var base = minval > initialval ? minval : initialval,
                            r = (stepval + ((val - base) % stepval)) % stepval;

                        if (r != 0)
                            val -= r;

                        if (minval > val)
                            val = minval;
                        else if (val > maxval)
                            val = maxval;

                        self.val(val);
                        s.slider('value', val);
                    });
                }, 200);
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
        </td>
    </tr>
{/foreach}


