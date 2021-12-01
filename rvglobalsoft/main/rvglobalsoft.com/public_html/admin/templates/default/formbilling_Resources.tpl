{literal}
    <style type="text/css">
        .formbilled_resource {
            list-style: none;
            padding: 0px;
            margin: 0px;
        }

        .formbilled_resource li {
            background: #ffffff
        }

        .formbilled_resource .pricingtableR label,
        .formbilled_resource tr td .inp,
        .formbilled_resource .scheme_container .inp {
            margin: 0;
            float: none;
        }

        .formbilled_resource .pricingtableR label._pricing,
        .formbilled_resource td {
            vertical-align: top;
            text-align: left;
            line-height: 30px;
            font-weight: normal;
        }

        .formbilled_resource td.fs11 {
            line-height: 20px;
        }

        .formbilled_resource .scheme_container {
            margin: 0;
            padding: 10px;
            background: #F0F0F3;
            border-radius: 5px;
            float: right;
            color: #767679;
        }

    </style>
{/literal}
<ul class="formbilled_resource">
    <li>
        <div class="scheme_container">
            Pricing scheme:
            <a class="vtip_description">
                <b>Volume scheme</b>
                <br>All units charge is calculated based on total count in period and related bracket.<br> ie.: <i>1-2:
                    $1, 3-4: $2, qtys are: 1,3; charge: 4*$2</i>
                <br><br>
                <b>Tiered scheme</b>
                <br/>Every unit charge is calculated with each measurement based on its own tier.<br/>i.e.: <i>1-2: $1,
                    3-4: $2, qtys are: 1,3; charge: 1*$1 + 3*$2</i>
                <br/><br/>
                <b>Stairstep scheme</b>
                <br/>Total cost is calculated based on price bracket, charge is for entire bracket not certain
                units<br/>i.e.: <i>1-5: $1, 6-10: $2, total qty: 7, charge: $2</i>
            </a> &nbsp;&nbsp;
            <select class="inp" name="items[{$k}][scheme]">
                <option {if $item.scheme=='tiered'}selected="selected"{/if} value="tiered">Tiered</option>
                <option {if $item.scheme=='volume'}selected="selected"{/if} value="volume">Volume</option>
                <option {if $item.scheme=='stairstep'}selected="selected"{/if} value="stairstep">Stairstep</option>
            </select>
        </div>
        <table border="0" cellpadding="1" class="left pricingtableR" cellspacing="0" id="{$k}_table">
            <tr>
                <td width="100" class="fs11">Starting QTY</td>
                <td width="100" class="fs11">Ending QTY</td>
                <td width="150" class="fs11">Unit price</td>
                <td></td>
            </tr>
            {if !$item.prices}
                <tr class="bracket">
                    <td class="resource-qty-start">
                        <input type="text" class="inp _qty _qty_start" size="3" disabled="disabled"
                               value="{$field.config.minvalue}" name="items[{$k}][prices][0][qty]"/>
                    </td>
                    <td class="resource-qty-end">
                        <input type="text" class="inp _qty _qty_end" size="3" disabled="disabled"
                               value="{$field.config.maxvalue}" name="items[{$k}][prices][0][qty_max]"/>
                    </td>
                    <td class="resource-cycles">
                        <div class="form-group">
                            {foreach from=$formbilling_cycles key=cycle item=cycle_name}
                                <label class="_pricing {$cycle}pricing">
                                    <input type="text" class="inp" size="3" value="0"
                                           name="items[{$k}][prices][0][{$cycle}]"/>
                                    <span> / {$cycle_name} </span>
                                </label>
                            {/foreach}
                        </div>
                    </td>
                    <td>
                        <a class="fs11 remove" href="#" onclick="return removeFormRow(this)">Remove</a>
                    </td>
                </tr>
            {/if}
            {foreach from=$item.prices item=p key=kx name=bracket}
                <tr class="bracket">
                    <td class="resource-qty-start">
                        <input type="text" class="inp _qty _qty_start" size="3"
                               {if $smarty.foreach.bracket.first}value="{$field.config.minvalue}" disabled="disabled"
                               {else}value="{$p.qty}"{/if} name="items[{$k}][prices][{$kx}][qty]"/>
                    </td>
                    <td class="resource-qty-end">
                        <input type="text" class="inp _qty _qty_end" size="3"
                               {if $smarty.foreach.bracket.last}value="{$field.config.maxvalue}" disabled="disabled"
                               {else}value="{$p.qty_max}"{/if} name="items[{$k}][prices][{$kx}][qty_max]"/>
                    </td>
                    <td class="resource-cycles">
                        <div class="form-group">
                            {foreach from=$formbilling_cycles item=cycle_name key=cycle}
                                <label class="_pricing {$cycle}pricing">
                                    <input type="text" class="inp" size="3" value="{$p.$cycle|price:$currency:false}"
                                           name="items[{$k}][prices][{$kx}][{$cycle}]"/>
                                    <span> / {$cycle_name} </span>
                                </label>
                            {/foreach}
                        </div>
                    </td>
                    <td>
                        <a class="fs11 remove" href="#" onclick="return removeFormRow(this)">Remove</a>
                    </td>
                </tr>
            {/foreach}
        </table>

        <div class="clear"></div>
        <div style="padding:15px 0px 10px;">
            <a onclick="return addFormBracket('{$k}');" class="prices menuitm " href="#">
                <span class="addsth">Add price bracket</span>
            </a>
        </div>
    </li>
</ul>
{literal}
<script type="text/javascript">
    updatepricingform_calbacks['metered'] = function () {
        var w = $('input[name=paytype]:checked, input[name=bundle_paytype]:checked').val();

        switch (w) {
            case 'Once':
                $('.pricingtableR ._pricing', '#facebox').hide().filter('.mpricing').show().find('span').hide();
                break;
            case 'Regular':
            case 'SSLRegular':
                var elems = $('.pricingtableR ._pricing', '#facebox').hide();
                $('#Regular_b .cycle, #SSLRegular_b .cycle').each(function () {
                    var data = $(this).data();
                    elems.filter('.' + data.cycle + 'pricing').toggle(data.enabled);
                });
                break;

            case 'DomainRegular':
                $('.pricingtableR ._pricing', '#facebox').hide().filter('.apricing').show();
                break;
            case 'Metered':
            case 'Bandwidth':
                if ($('#metered_btype').length && $('#metered_btype').val() == 'PrePay') {
                    $('.pricingtableR ._pricing', '#facebox').hide().filter('.mpricing').show().find('span').hide();
                } else {
                    $('.pricingtableR ._pricing', '#facebox').hide().filter('.apricing, .spricing, .qpricing, .mpricing').show();
                }
                break;
            case 'Flavor':
                $('.pricingtableR ._pricing', '#facebox').hide().filter('.mpricing').show();
                break;
            default:
            case 'Free':
                $('.pricingtableR tr:not(.free_p)', '#facebox').hide();
                $('.pricingtableR tr.free_p', '#facebox').show();
                break;
        }
    };

    var last_bracket_index = 1;

    function addFormBracket(v) {
        var config = $('#' + v + '_table');
        if (!config.length)
            return false;

        last_bracket_index = Math.max(last_bracket_index+1,  config.find('.resource-cycles').length);

        var i = last_bracket_index;
        var last_qty = config.find('.bracket:last input'),
            last_qty_start = last_qty ? parseInt(last_qty.eq(0).val()) || 0 : 0,
            last_qty_end = last_qty ? parseInt(last_qty.eq(1).val()) || 100 : 100,
            new_qty = last_qty_end - Math.round(Math.max(0, last_qty_end - last_qty_start)/2);

        var html = config.find('.bracket:first')[0].outerHTML
            .replace(/(prices\]?\[)\d+/g, '$1' + i);

        config.append(html);

        last_qty.eq(1).val(new_qty);
        config.find('.bracket:last input._qty_start').val(new_qty);

        updatePricingForms();
        validateFormBracket();
        return false;
    }

    function removeFormRow(that) {
        $(that).parents('.bracket').remove();
        validateFormBracket();
    }

    function validateFormBracket() {
        var brackets = $('.pricingtableR .bracket'),
            inputs = brackets.find('input._qty'),
            first = parseInt($('#configMinvalue').val()) || 0,
            last = parseInt($('#configMaxvalue').val()) || 1,
            lasti = inputs.eq(inputs.length - 1);

        inputs.filter(':first,:last').prop('disabled', true).attr('disabled', 'disabled');
        inputs.filter(':disabled').not(':first,:last').prop('disabled', false).removeAttr('disabled');

        lasti.val(last);
        inputs.eq(0).val(first);

        var twin = false;
        inputs.not(':first,:last').each(function () {
            if (twin === false) {
                twin = $(this);
                return;
            }
            var pair = $(this).add(twin);
            pair.off('keyup').on('keyup', function () {
                pair.val(this.value)
            });
            twin = false;
        }).off('change').on('change', function () {
            var self = $(this),
                val = self.val(),
                adjusted = Math.min(Math.max(first,val), last);
            if(adjusted !== val){
                self.val(adjusted).trigger('keyup');
            }
        });


        brackets.find('.remove').toggle(brackets.length > 1);
    }

    $('#formbilling_Resources').bind('formbilling', function () {
        validateFormBracket()
    });

    $(function () {
        $('#configMaxvalue, #configMinvalue').unbind('change.resources').bind('change.resources', function () {
            validateFormBracket();
        });
        validateFormBracket();
        $("#formbilling_Resources a.vtip_description").vTip();
    });

</script>{/literal}
