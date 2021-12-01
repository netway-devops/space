{literal}
    <script type="text/javascript">

        function new_product(pkg_name, number) {
            if ($("input[name='package[" + pkg_name + "][product]']:checked").val() == 'new') {
                $('#new_product_' + number).show();
            } else {
                $('#new_product_' + number).hide();
            }
        }

        function switch_t(el, id) {
            $('#free_b_' + id).hide();
            $('#once_b_' + id).hide();
            $('#recur_b_' + id).hide();
            $('#' + $(el).attr('id') + '_b_' + id).show();
        }

        setTimeout(function () {
            $('.check').unbind('click');
            $('.check').click(checkEl);
        }, 40);

        $(function () {
            $('.import-product-row .check').on('change', function () {
                $(this).closest('.import-product-row').find('input, select')
                    .not(this).prop('disabled', !this.checked)
            }).each(function () {
                $(this).trigger('change');
            });

            $('#new-product').bootboxform({
                size: 'large',
                title: "Configure product",
                btntitle: "Save"
            }).on('bootbox-form.shown', function (e, dialog) {
                $('.pay-switch', dialog).on('change', function () {
                    $('.once, .regular', dialog).hide();
                    $('.' + this.value.toLocaleLowerCase(), dialog).show();
                })
            });

            $('.new-product').on('click', function () {
                var row = $(this).closest('tr'),
                    field = row.find('.product-data'),
                    descr = row.find('.product-description');

                $('#new-product').trigger('show', [{
                    callback: function () {
                        var forms = $('input, select', this),
                            data = forms.serializeForm();
                        
                        field.val(JSON.stringify(data));
                        descr.text(
                            "New: " + forms.filter('[name=category]').find(':selected').text() + ' - ' + data.name
                        )
                    }
                }]);
            })
        })

    </script>
{/literal}
<form action="" method="post">

    <div class="container-fluid" style="margin-top: 10px">
        <div class="row">
            <div class="col-md-12">
                <ul>
                    <li>Select packages from App connection you wish to import accounts for</li>
                    <li>On next screen you will be able to select accounts you will be importing for selected packages
                    </li>
                    <li>If you choose to import package, please review product configuration once its imported</li>
                </ul>
            </div>
        </div>
    </div>

    <input type="hidden" name="import_type" value="1"/>
    <input type="hidden" value="{$server_id}" name="server_id"/>
    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">

        <tr>
            <th></th>
            <th width="25%">{$lang.packagename}</th>
            <th width="70%"></th>
        </tr>

        <tbody id="packages_list">
        {foreach name=rows from=$packages item=pkg key=pkg_id}
            <tr class="import-product-row">
                <td valign="top">
                    <input type="checkbox" class="check" value="{$pkg_id}"
                           name="selected[]" />
                </td>
                <td valign="top">
                    {$pkg.name}
                    <input type="hidden" name="package[{$pkg_id}][name]" disabled
                           value="{$pkg.name}"/>
                    {if $pkg.reseller}
                        (reseller)
                        <input type="hidden" name="package[{$pkg_id}][product_data][reseller]" disabled
                               value="1"/>
                        <input type="hidden" name="package[{$pkg_id}][name_accounts]" disabled
                               value="{$pkg.name} (reseller)"/>
                    {else}
                        <input type="hidden" disabled
                               name="package[{$pkg_id}][name_accounts]"
                               value="{$pkg.name}"/>
                    {/if}
                </td>
                <td>
                    {if $pkg.products}
                        <input type="radio" checked="checked" name="package[{$pkg_id}][product]"
                               value="old" disabled
                               onclick="new_product('{$pkg_id}',{$smarty.foreach.rows.iteration})"/>
                        {$lang.useexistingprod}:
                        <select name="package[{$pkg_id}][product_id]" disabled >
                            {foreach from=$pkg.products item=prod}
                                <option value="{$prod.id}">{$prod.name}</option>
                            {/foreach}
                        </select>
                        <br/>
                        <input type="radio" name="package[{$pkg_id}][product]" value="new" disabled
                               onclick="new_product('{$pkg_id}',{$smarty.foreach.rows.iteration})"/>
                        {$lang.createnewprod}: <a class="btn btn-default btn-xs new-product">Configure</a>
                        <br/>
                        <span class="product-description"></span>
                        <input type="hidden" name="package[{$pkg_id}][product_data]" disabled
                               value="null" class="product-data"/>
                    {else}
                        <a class="btn btn-default btn-xs new-product">Configure new product</a>
                        <span class="product-description">{$lang.thereisnoproductsinhb}</span>
                        <input type="hidden" name="package[{$pkg_id}][product]" value="new" disabled />
                        <input type="hidden" name="package[{$pkg_id}][product_data]" disabled
                               value="null" class="product-data"/>
                    {/if}
                </td>
            </tr>
        {/foreach}
        </tbody>
    </table>

    <div class="blu" style="padding: 10px 15px">
        <button id="continue" type="submit" name="continue" class="btn btn-primary">{$lang.Continue}</button>
    </div>

    {securitytoken}
</form>

<div class="modal" bootbox id="new-product">
    <div class="form-group">
        <label>{$lang.Name}</label>
        <input type="text" name="name" class="form-control">
    </div>
    <div class="form-group">
        <label>{$lang.Category}</label>
        <select name="category" class="form-control">
            {foreach from=$prod_categories item=cat}
                <option value="{$cat.id}">{$cat.name}</option>
            {/foreach}
        </select>
    </div>
    <div class="checkbox">
        <label>
            <input type="checkbox"
                   name="tax"
                   value="1"/>
            {$lang.Tax}
        </label>
    </div>
    <div class="form-group">
        <label>{$lang.paymenttype}</label>
        <select name="paytype" class="form-control pay-switch" >
            <option value="free">{$lang.Free}</option>
            <option value="Once">{$lang.Once}</option>
            <option value="Regular">{$lang.Recurring}</option>
        </select>
    </div>
    <div class="once" style="display:none">
        <table class="table">
            <tr>
                <th>{$lang.setupfee}</th>
                <td><input type="text" value="0.00" size="10"
                           name="m_setup1"/>
                </td>
            </tr>
            <tr>
                <th>{$lang.Price}</th>
                <td><input type="text" value="0.00" size="10"
                           name="m1"/>
                </td>
            </tr>
        </table>
    </div>
    <div class="regular" style="display:none">
        <table class="table table-striped">
            <tr>
                <th width="80"/>
                <th width="80">{$lang.Monthly}</th>
                <th width="80">{$lang.Quarterly}</th>
                <th width="100">{$lang.SemiAnnually}</th>
                <th width="80">{$lang.Annually}</th>
                <th width="80">{$lang.Biennially}</th>
            </tr>
            <tr>
                <th>{$lang.setupfee}</th>
                <td>
                    <input type="text" value="0.00" size="10"
                           name="m_setup"/>
                </td>
                <td>
                    <input type="text" value="0.00" size="10"
                           name="q_setup"/>
                </td>
                <td>
                    <input type="text" value="0.00" size="10"
                           name="s_setup"/>
                </td>
                <td>
                    <input type="text" value="0.00" size="10"
                           name="a_setup"/>
                </td>
                <td>
                    <input type="text" value="0.00" size="10"
                           name="b_setup"/>
                </td>
            </tr>
            <tr>
                <th>{$lang.Price}</th>
                <td>
                    <input type="text" value="0.00" size="10"
                           name="m"/>
                </td>
                <td>
                    <input type="text" value="0.00" size="10"
                           name="q"/>
                </td>
                <td>
                    <input type="text" value="0.00" size="10"
                           name="s"/>
                </td>
                <td>
                    <input type="text" value="0.00" size="10"
                           name="a"/>
                </td>
                <td>
                    <input type="text" value="0.00" size="10"
                           name="b"/>
                </td>
            </tr>
        </table>
    </div>
</div>
