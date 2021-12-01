{cartfieldlogic}
{if $cf.config.showsteps}
    {once}
        <script type="text/javascript" src="{$system_url}includes/libs/configoptions/slider/pips/jquery-ui-slider-pips.js"></script>
        <link rel="stylesheet" href="{$system_url}includes/libs/configoptions/slider/pips/jquery-ui-slider-pips.css" />
    {/once}
{/if}
{foreach from=$cf.items item=cit}
    <div class="custom_field_{$cf.copy_of}">
        <div class="slider-group">
            <input name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]"
                    {cartformvalue} value="{if $cfvalue.qty}{$cfvalue.qty}{else}{$cf.config.initialval}{/if}"
                   type="text" style="display:none" id="custom_field_{$cf.copy_of}"
                   onchange="$(document).trigger('hbcart.changeform', [this]);if (typeof(simulateCart)=='function')simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}');"
                   variable="{$cf.variable}" class="custom_field_{$cf.copy_of}"/>
            <div id="custom_slider_{$cit.id}" class="slides left"
                 style="margin:6px 20px 0px 20px !important;float:left !important;width:370px;">
                <div class="sl"></div>
                <div class="sr"></div>
            </div>
            <div id="custom_slider_{$cit.id}_value_indicator" class="slider-value-indicator" style="font-weight:bold;font-size:14px;padding-top:3px;">
                {if $cfvalue.qty}{$cfvalue.qty}{else}{$cf.config.initialval}{/if}{$cit.name}
            </div>
        </div>
        <script type="text/javascript">

            {if $cf.config.conditionals}
            $('#custom_field_{$cf.copy_of}').fieldLogic({literal}{{/literal}
                type: '{$cf.type}'
                {literal}}{/literal}, [{$cf.config.conditionals|@array_values|@json_encode}]);
            {/if}

            var _size = parseInt('{$cf.config.maxvalue}') || 100;
            window.SliderInputSize = Math.max(window.SliderInputSize, _size);

            setTimeout(function () {literal}{{/literal}
                var _s = '#custom_slider_{$cit.id}';
                var s = $(_s);
                var sval = $('#custom_field_{$cf.copy_of}');
                var svalind = $('#custom_slider_{$cit.id}_value_indicator');
                if (typeof ($('#slider').slider) != 'function'){literal} {
                    s.hide();
                    return false;
                }

                function getKeyByValue(object, value) {
                    return Object.keys(object).find(key => object[key] === value);
                }

                {/literal}

                var initialval = parseInt('{$cf.config.initialval}') || 0,
                    steps = {$cf.steps|@json_encode},
                    size = 12 * (window.SliderInputSize.toString().length + 1),
                    showsteps = {if $cf.config.showsteps} true {else} false {/if};

                var initialkey = getKeyByValue(steps, parseInt('{if $cfvalue.qty}{$cfvalue.qty}{else}{$cf.config.initialval}{/if}'));

                {literal}

                s.width(s.parent().width() - size - (s.outerWidth(true) - s.width()) - (sval.outerWidth(true) - sval.width()))
                .slider({
                    min: 0,
                    max: steps.length - 1,
                    step: 1,
                    animate: true,
                    range: "min",
                    value: initialkey,
                    values: [initialkey],
                    stop: function(e, ui) {
                        var x = steps[ui.value];
                        sval.val(x).trigger('change');
                        svalind.html(x);
                    },
                    create: function (e, ui) {
                        svalind.html(steps[ui.value]);
                    }
                });

                if (showsteps) {
                    s.slider('pips', {labels: steps, rest: 'label'})
                    .slider('float', {labels: steps, rest: 'label'});
                }

            }, 200);{/literal}
        </script>
    </div>
{/foreach}