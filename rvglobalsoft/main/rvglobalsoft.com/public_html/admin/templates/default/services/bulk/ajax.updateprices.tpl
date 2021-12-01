{if !$showmodels}
    <div class="form-group col-lg-12">
        <label>Products</label>
        <select name="product[]" class="form-control" multiple id="products">
            {foreach from=$categories item=category}
                <optgroup label="{$category.name}">
                    {foreach from=$category.products item=product}
                        <option value="{$product.id}" {if in_array($product.id, $submit.product)}selected{/if}>{$product.name}</option>
                    {/foreach}
                </optgroup>
            {/foreach}
        </select>
    </div>
    <div class="form-group col-lg-6">
        <label>Type</label>
        <select name="action_type" class="form-control" id="bulk-price">
            <option value="up" {if $submit.action_type == 'up'}selected{/if}>Increase</option>
            <option value="down" {if $submit.action_type == 'down'}selected{/if}>Decrease</option>
            <option value="new" {if $submit.action_type == 'new'}selected{/if}>New prices</option>
        </select>
    </div>
    <div id="price-options" class="clearfix clear">
        {include file="services/bulk/ajax.updateprices.tpl" showmodels=1}
    </div>
    <div class="col-lg-12 ">
        <div class="form-group">
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="accountupdate" value="1"/>
                    Update recurring prices of related domains/accounts
                </label>
            </div>
        </div>
        <button class="btn btn-primary" name="make" value="bulk" type="submit">Update price</button>
    </div>
{literal}
    <script type="text/javascript">
        {/literal}
        lang['Register'] = '{$lang.Register}';
        lang['Transfer'] = '{$lang.Transfer}';
        lang['Renew'] = '{$lang.Renew}';
        lang['Redemption'] = '{$lang.Redemption}';
        lang['Years'] = '{$lang.Years}';
        var zero_value = '{0|price:$currency:false:false}';
        {literal}

        $(function () {
            var pricetype = $('#bulk-price'),
                products = $('#products'),
                priceoptions = $('#price-options');

            products.chosenedge({
                width: '100%',
                enable_split_word_search: true,
                search_contains: true
            }).on('change', function () {
                priceoptions.addLoader();
                var data = $('#serializeit').serializeForm();
                data.models = true;
                $.post(window.location.href, data, function (data) {
                    priceoptions.html(parse_response(data));
                    pricetype.trigger('change')
                })
            });

            pricetype.on('change', function () {
                $('.bulk-price').hide()
                    .filter($(this).val() === 'new' ? '.bulk-price-abs' : '.bulk-price-relative')
                    .show();
                $('[name=paytype]:checked', '#priceoptions').prev('.billopt').click();
            }).trigger('change');

            $('#serializeit').on('submit.bulk', function (e) {
                var prods = $('#products').val();
                if (!prods || prods.length == 0) {
                    alert('You have to select some products to update');
                    return false;
                }
                return true;
            })
        });


        function switch_t2(el, id) {
            $('#priceoptions .billopt').removeClass('checked');
            $(el).addClass('checked');
            $('input[name=paytype]').removeAttr('checked').prop('checked', false);
            $('input#' + id).attr('checked', 'checked').prop('checked', true);
            $('#bmcontainer').children().hide();
            $('#' + id + '_b').show();
            $('#hidepricingadd').click();
            return false;
        }

        function addopt() {
            var e = $('#' + $('#tbpricing select').val() + 'pricing');
            e.find('.inp').eq(0).val($('#newprice').val());
            e.find('.inp').eq(1).val($('#newsetup').val());
            e.find('.pricer_setup').html($('#newsetup').val());
            if ($('#newsetup').val() != zero_value)
                e.find('.pricer_setup').parent().parent().show();
            e.find('.pricer').html($('#newprice').val());
            e.show();
            $('#tbpricing select option:selected').hide();
            if ($('#tbpricing select option:visible').length < 1) {

            } else {
                $('#tbpricing select option:visible').eq(0).attr('selected', 'selected');
                $('#addpricing').show();
            }
            $('#tbpricing').hide();
            $('#newprice').val(zero_value);
            $('#newsetup').val(zero_value).hide();
            $('#newsetup1').show();
            return false;
        }

        $('#Regular_b .controls .editbtn').click(function () {
            var e = $(this).parent().parent().parent();
            e.find('.e1').hide();
            e.find('.e2').show();
            return false;
        });
        $('#Regular_b .controls .delbtn').click(function () {
            var e = $(this).parent().parent().parent();
            e.find('.e2').hide();
            e.find('.e1').show();
            e.find('input').val(zero_value);
            e.hide();
            var id = e.attr('id').substr(0, 1);
            if ($('#tbpricing select option:visible').length < 1) {
                $('#addpricing').show();
            }
            $('#tbpricing select option[value=' + id + ']').show();
            return false;
        });


        if ($('#bma_Regular').length)
            $('#bma_Regular').click();
        else
            $('#priceoptions a:first').click();
        $('#addpricingrow td:last-child:not(:first-child)').remove();
    </script>
{/literal}

{else}
    {if $supported_billingmodels}
        <div class="form-group bulk-price bulk-price-relative col-lg-6">
            <label>Amount</label>
            <div class="row">
                <div class="col-xs-6 col-sm-8 col-md-9">
                    <input type="text" class="form-control" name="amount" value="{$submit.amount|price:$currency:false:false}"/>
                </div>
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <select name="type" class="form-control">
                        <option value="1" {if $submit.type == '1'}selected{/if}>Fixed</option>
                        <option value="2" {if $submit.type == '2'}selected{/if}>Percent</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="form-group bulk-price bulk-price-relative col-lg-6">
            <label>Apply to</label>

            {if in_array('DomainRegular', $supported_billingmodels) }
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="include[]" value="register"
                               {if !$submit.include || in_array('register', $submit.include)}checked{/if} />
                        Register price
                    </label>
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="include[]" value="transfer"
                               {if !$submit.include || in_array('transfer', $submit.include)}checked{/if}/>
                        Transfer price
                    </label>
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="include[]" value="renew"
                               {if !$submit.include || in_array('renew', $submit.include)}checked{/if}/>
                        Renew price
                    </label>
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="include[]" value="redemption"
                               {if !$submit.include || in_array('redemption', $submit.include)}checked{/if}/>
                        Redemption price
                    </label>
                </div>
            {else}
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="include[]" value="recurring"
                               {if !$submit.include || in_array('recurring', $submit.include)}checked{/if}/>
                        Recurring price
                    </label>
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="include[]" value="setup"
                               {if !$submit.include || in_array('setup', $submit.include)}checked{/if}/>
                        Setup fee
                    </label>
                </div>
            {/if}
        </div>
        <div class="form-group bulk-price bulk-price-abs col-lg-12">
            <div id="priceoptions">
                {foreach from=$supported_billingmodels item=bm name=boptloop}
                    {if $bm == 'Metered'}{continue}{/if}
                    <a href="#" class="billopt {if $smarty.foreach.boptloop.first && $bm == 'Free'}bfirst{/if}"
                       onclick='return switch_t2(this, "{$bm}");' id="bma_{$bm}">
                        {if $lang[$bm]}{$lang[$bm]}
                        {elseif $bm == "DomainRegular"}{$lang.Regular}
                        {else}{$bm}
                        {/if}
                    </a>
                    <input type="radio" value="{$bm}" name="paytype" {if $product.paytype==$bm}checked="checked"{/if}
                           id="{$bm}" style="display:none"/>
                {/foreach}
                <div id="bmcontainer">
                    {foreach from=$supported_billingmodels item=bm name=boptloop}
                        {if $bm == 'Metered'}{continue}{/if}
                        {if $bm == 'Bundle'}
                            <table>
                                <tbody>
                                    {include file="productbilling_`$bm`.tpl" product=$billing_product[$bm]}
                                </tbody>
                            </table>
                        {else}
                            {include file="productbilling_`$bm`.tpl" product=$billing_product[$bm]}
                        {/if}

                    {/foreach}
                </div>
            </div>
        </div>
    {else}
        <div class="form-group col-lg-12">
            <div class="alert alert-info">
                Select at least one product to display billing options
            </div>
        </div>
    {/if}
{/if}