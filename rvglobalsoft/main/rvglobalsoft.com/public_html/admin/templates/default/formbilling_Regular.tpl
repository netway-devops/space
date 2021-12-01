<table width="100%" class="pricingtable table table-striped"
       {if !$item.pricing_enabled}style="display:none"{/if}>
    <thead>
    <tr>
        <th class="form-price-label" style="width: 1%">Cycle</th>
        <th class="form-price-price">{$lang.price}</th>
        <th class="form-price-setup">{$lang.setupfee}</th>
        <th class="form-price-upgrade">
            {$lang.upgradefee}
            <span class="vtip_description">
                    <span>{$lang.upgradefee_formtip}</span>
                </span>
        </th>
    </tr>
    </thead>
    <tbody class="pricingtable-cycles">
    <tr class="freepricing form-price">
        <td colspan="4">
            {$lang.freenopricing}
        </td>
    </tr>
    <tr class="oncepricing form-price">
        <td class="form-price-label">
            {$lang.Once}
        </td>
        <td class="form-price-price">
            <input type="text" value="{$item.m|price:$currency:false}"
                   size="4" name="items[{$k}][m1]" class="inp"/> &nbsp;&nbsp;
        </td>
        <td class="form-price-setup">
            <input type="text" value="{$item.m_setup|price:$currency:false}"
                   size="4" name="items[{$k}][m_setup1]" class="inp"/>
        </td>
        <td class="form-price-upgrade">
            {assign var=cyclesetup value="`$cycle`_upgrade"}
            <input type="text" value="{$item[$cyclesetup]|price:$currency:false}"
                   size="4" name="items[{$k}][{$cycle}_setup]" class="inp"/>
        </td>
    </tr>
    {foreach from=$formbilling_cycles key=cycle item=cycle_name}
        <tr class="{$cycle}pricing form-price">

            <td class="form-price-label text-nowrap">
                {$cycle_name}
            </td>

            <td class="form-price-price">
                <input type="text" value="{$item[$cycle]|price:$currency:false}"
                       size="4" name="items[{$k}][{$cycle}]" class="inp"/>

            </td>
            <td class="form-price-setup">
                {assign var=cyclesetup value="`$cycle`_setup"}
                <input type="text" value="{$item[$cyclesetup]|price:$currency:false}"
                       size="4" name="items[{$k}][{$cycle}_setup]" class="inp"/>
            </td>
            <td class="form-price-upgrade">
                {assign var=cycleupgrade value="`$cycle`_upgrade"}
                <input type="text" value="{$item[$cycleupgrade]|price:$currency:false}"
                       size="4" name="items[{$k}][{$cycle}_upgrade]" class="inp"/>
            </td>
        </tr>
    {/foreach}
    </tbody>
</table>
{literal}
    <script type="text/javascript">
        updatepricingform_calbacks['regular'] = function () {
            var root = $('#facebox'),
                formcycles = $('.pricingtable .form-price', root),
                cyclemap = {'Annually': 'a', 'Semi-Annually': 's', 'Quarterly': 'q', 'Monthly': 'm'},
                billingModel = $('input[name=paytype]:checked').val()
                    || $('#pricing_overide:visible input[name=bundle_paytype]:checked').val()
                    || $('input[name=dynamic_paytype]:checked').val();

            root.find('.vtip_description').vTip();
            var cyclename, cycle, filter;

            switch (billingModel) {
                case 'Once':
                    formcycles.not('.oncepricing').remove();
                    break;
                case 'Regular':
                case 'SSLRegular':
                    filter = [];

                    $('#Regular_b .cycle, #SSLRegular_b .cycle').each(function () {
                        var data = $(this).data();
                        if (data.enabled) {
                            filter.push('.' + data.cycle + 'pricing');
                        }
                    });

                    formcycles.not(filter.join(',')).remove();
                    break;

                case 'DomainRegular':
                    formcycles.not('.apricing').remove();

                    break;
                case 'Metered':
                case 'Bandwidth':
                case 'Power':
                    cyclename = $('select[name="config[MeteredCycle]"]').val();
                    cycle = cyclemap[cyclename] || 'm';

                    if ($('#metered_btype').length && $('#metered_btype').val() == 'PrePay') {
                        formcycles.not('.mpricing').remove();
                        $('.form-price-setup', root).remove();
                    } else {
                        formcycles.not('.' + cycle + 'pricing').remove();
                    }
                    break;
                case 'BundleRegular':
                    filter = [];
                    $('#pricing_dynamo .like-table-row').each(function () {
                        var id = $(this).attr('rel') || $(this).attr('id');
                        if (id) {
                            filter.push('.' + id);
                        }
                    });
                    formcycles.not(filter.join(',')).remove();
                    break;
                case 'Flavor':
                    cyclename = $('select[name="config[FlavorCycle]"]').val();
                    cycle = cyclemap[cyclename] || 'm';

                    formcycles.not('.' + cycle + 'pricing, .hpricing').remove();
                    break;
                default:
                case 'Free':
                    formcycles.not('.freepricing').remove();

                    break;

            }

        };

    </script>
{/literal}