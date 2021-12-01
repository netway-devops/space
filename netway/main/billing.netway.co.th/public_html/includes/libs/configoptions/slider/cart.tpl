{cartfieldlogic}
{if $cf.config.showsteps}
    {once}
        <script type="text/javascript" src="{$system_url}includes/libs/configoptions/slider/pips/jquery-ui-slider-pips.js"></script>
        <link rel="stylesheet" href="{$system_url}includes/libs/configoptions/slider/pips/jquery-ui-slider-pips.css" />
    {/once}
{/if}
{foreach from=$cf.items item=cit}
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
    $('.custom_field_{$cf.copy_of}').fieldLogic({literal}{{/literal}type: '{$cf.type}'{literal}}{/literal},[{foreach from=$cf.config.conditionals item=cd name=cond}{literal}{{/literal}
         value: '{$cd.targetval}',
         condition_type: '{$cd.condition}',
         target: '.custom_field_{$cd.target}',
         condition: '{if $cd.conditionval}{$cd.conditionval}{else}{$cd.val}{/if}',
         action: '{$cd.action}'
         {literal}}{/literal}{if !$smarty.foreach.cond.last},{/if}{/foreach}]);
{/if}
    setTimeout(function() {literal}{{/literal}
        var s = $('#custom_slider_{$cit.id}');
        var sval = $('#custom_field_{$cf.copy_of}');
        var svalind = $('#custom_slider_{$cit.id}_value_indicator');
        var unit = '{$cit.name}';
        if (typeof($('#slider').slider) != 'function'){literal} {
            s.hide();
            sval.show();
            svalind.hide();
            return false;
        }{/literal}

        var maxval = parseInt('{$cf.config.maxvalue}') || 100;
        var minval = parseInt('{$cf.config.minvalue}') || 0;
        var stepval = parseInt('{$cf.config.step}') || 1;
        var initialval = parseInt('{$cf.config.initialval}') || 0;
        var showsteps = {if $cf.config.showsteps} true {else} false {/if};

        {literal}

        if ((maxval - minval) / stepval > 10) {
            var pipstep = (maxval - minval) / 10;
        }

        var size = 12 * (maxval.toString().length + unit.length + 1);

        s.width(s.parent().width() - (s.outerWidth(true) - s.width())).slider({
            min: minval,
            max: maxval,
            value: sval.val() || initialval,
            step: stepval,
            range: "min",
            values: [],
            animate: true,
            stop: function(e, ui) {
                var x = Math.floor(s.slider("value"));
                sval.val(x).trigger('change');
                svalind.html(x + unit);
            }
        })

        if (showsteps) {
            s.slider("pips", {
                rest: "label",
                step: pipstep
            }).slider("float", {
                rest: 'label'
            });
        }
    }, 200);{/literal}
</script>
{/foreach}