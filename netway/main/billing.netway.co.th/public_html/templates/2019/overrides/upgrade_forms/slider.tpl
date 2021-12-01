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
            <input name="fupgrade[{$cf.id}][new_qty]" value="{$cf.qty}" type="text"
                   style="display:none" id="custom_field_{$cf.copy_of}"/>
            <input name="fupgrade[{$cf.id}][new_config_id]" value="{$cit.id}" type="hidden"/>
            <b>{$cf.qty}</b>
            {if $cit.name}{$cit.name}{/if}
            {if $cit._price!=0} ({$cit._price|price:$currency:1:1:$currency.code})
            {elseif $cit.price>0} ({$cit.price|price:$currency:1:1})
            {/if}

        </td>
        <td class="upgrade-to">
            <div class="slider-group">
                <div id="custom_slider_{$cit.id}" class="slides left" style="margin:6px 20px 0px 20px !important;float:left !important;width:370px;">
                    <div class="sl"></div>
                    <div class="sr"></div>
                </div>
                <div id="custom_slider_{$cit.id}_value_indicator" style="font-weight:bold;font-size:14px;padding-top:3px;">{$cf.qty}</div>
            </div>
            <script type="text/javascript">
                {literal}
                setTimeout(function () {
                    var s = $('#custom_slider_{/literal}{$cit.id}{literal}');
                    var sval = $('#custom_field_{/literal}{$cf.copy_of}{literal}');
                    var svalind = $('#custom_slider_{/literal}{$cit.id}{literal}_value_indicator');
                    if (typeof($('#slider').slider) != 'function') {
                        s.hide();
                        sval.show();
                        svalind.hide();
                        return false;
                    }
                    var maxval = parseInt('{/literal}{$cf.config.maxvalue}{literal}') || 100;
                    var minval = parseInt('{/literal}{if $cf.options & 32}{$cf.config.minvalue}{else}{$cf.qty}{/if}{literal}') || 0;
                    var stepval = parseInt('{/literal}{$cf.config.step}{literal}') || 1;
                    var initialval = parseInt('{/literal}{$cf.qty}{literal}') || 0;
                    var showsteps = {/literal}{if $cf.config.showsteps} true {else} false {/if}{literal};

                    if ((maxval - minval) / stepval > 10) {
                        var pipstep = (maxval - minval) / 10;
                    }

                    if (minval < initialval)
                        minval += Math.abs(minval - initialval) % stepval;

                    s.width(s.parent().width() - 90).slider({
                        min: minval,
                        max: maxval,
                        value: sval.val() || initialval,
                        step: stepval,
                        range: "min",
                        animate: true,
                        stop: function (e, ui) {
                            var x = Math.floor(s.slider("value"));
                            svalind.html(x);
                            sval.val(x).trigger('change');
                        }
                    });

                    if (showsteps) {
                        s.slider("pips", {
                            rest: "label",
                            step: pipstep
                        }).slider("float");
                    }

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
        <td class="upgrade-price">
            <div class="custom_field_{$cf.id}_price w-100 text-right">
                {$price.config[$cf.id].total|price:$currency:1:1}
            </div>
        </td>
    </tr>
{/foreach}


