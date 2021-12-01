{if $ccprocessed}

{else}
    {if $is3dsecure}
        <script type="text/javascript" src="{$common_template_dir}facebox/facebox.js"></script>
        <link media="all" type="text/css" rel="stylesheet" href="{$common_template_dir}facebox/facebox.css" />
    {literal}
        <script>
            function rebindform() {
                $('#preloader', '#ccpcontent').hide();
            }
            function redirectform() {
                window.location = '{/literal}{$system_url}?cmd=clientarea&action=invoices{literal}';
            }
            function ccsubmit(form) {
                $('#ccpcontent').addLoader();
                $(form).attr('target', 'faceboxiframe');
                $.facebox({iframe: '{/literal}{$system_url}?cmd=clientarea&action=emptyframe{literal}'});
                $(form).find('.items-hidden').find('input, select, textarea').attr('name', '');
                return true;
            }
        </script>
    {/literal}
    {else}
    {literal}
        <script>
            function ccsubmit(form) {
                $('#ccpcontent').addLoader();
                $(form).find('.items-hidden').find('input, select, textarea').attr('name', '');
                return true;
            }
        </script>
    {/literal}
    {/if}

    {literal}
        <script>
            function toggleCard(item) {
                var self = $(item),
                    scards = self.closest('.section-cards');

                scards.find('.items').hide();
                var items = $(item).closest('.item').find('.items');
                if ($(item).is(':checked')) {
                    scards.find('.items').addClass('items-hidden');
                    $(items).removeClass('items-hidden').show();
                } else {
                    scards.find('.items').removeClass('items-hidden');
                    $(items).addClass('items-hidden').hide();
                }
            }
            function switchcardform(val) {
                var oriname = $('.card-holder_original_name').val();
                var fname = $('.card-holder_firstname').val(),
                    lname = $('.card-holder_lastname').val(),
                    name = fname+" "+lname;
                if(val) {
                    $('#billing_existing').show();
                    $('#billing_override').hide();
                    $('.checkout').find('.credit-card-box-holder div').text(oriname);
                } else {
                    $('#billing_existing').hide();
                    $('#billing_override').show();
                    $('.checkout').find('.credit-card-box-holder div').text(name);
                }
            }
            $(document).ready(function(){


                $('.card-holder_details').on('keyup change', function () {
                    var fname = $('.card-holder_firstname').val(),
                        lname = $('.card-holder_lastname').val(),
                        name = fname+" "+lname;
                    $('.checkout').find('.credit-card-box-holder div').text(name);
                });

            });
        </script>
    {/literal}

    <section class="section-account-header">
        <h1>{$lang.credit_card_payment}</h1>
    </section>

    <h5 class="my-5">{$lang.credit_card_payment_descr}</h5>

    <section class="section-account">
        <form action='' method='post' onsubmit="return ccsubmit(this);" id="ccpcontent">
            <input type="hidden" name="invoice_id" value="{$invoice_id}" />
            <input type="hidden" name="payment_module" value="{$payment_module}" />
            <input type="hidden" name="client[client_id]" value="{$cadetails.id}" />

            <div class="section-cards">
                {if $allow_storage || $ccard}
                    <div class="card item">
                        <div class="card-body">
                            <div class="form-check">
                                <input type="radio" name="cc_details" value="existing" {if !$ccard}disabled="disabled"{else} checked="checked"  onclick="toggleCard(this);"{/if} />
                                <label class="form-check-label">
                                    {$lang.ccardexists}
                                    {if $ccard} ({$ccard.cardnum})
                                    {/if}
                                </label>
                            </div>
                            {if $ccard}
                                <div class="mt-3 items">
                                    <div class="checkout">
                                        <div class="credit-card">
                                            <div class="credit-card-box">
                                                <div class="flip">
                                                    <div class="front">
                                                        <div class="credit-card-box-chip"></div>
                                                        <div class="credit-card-box-logo {if $ccard.cardtype=='American Express'} amex {else}{$ccard.cardtype}{/if}"></div>
                                                        <div class="credit-card-box-number">{$ccard.cardnum}</div>
                                                        <div class="credit-card-box-holder">
                                                            <label>{$lang.ccholder}</label>
                                                            <div>{$login.firstname} {$login.lastname}</div>
                                                        </div>
                                                        <div class="credit-card-box-expiration-date">
                                                            <label>{$lang.ccexpiry}</label>
                                                            <div>{$ccard.expdate}</div>
                                                        </div>
                                                    </div>
                                                    <div class="back">
                                                        <div class="credit-card-box-strip"></div>
                                                        <div class="credit-card-box-logo">
                                                        </div>
                                                        <div class="credit-card-box-ccv">
                                                            <label>CCV</label>
                                                            <div></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="d-flex justify-content-center">
                                            <table style="max-width: 600px;">
                                                <tr>
                                                    <td >{$lang.ccarcvv}</td>
                                                    <td>
                                                        <input type="password"  class="form-control w-50 card-ccv_js" name="cvv" maxlength="5" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            {/if}
                        </div>
                    </div>
                {/if}
                <div class="card item">
                    <div class="card-body">
                        <div class="form-check">
                            <input type="radio" name="cc_details" value="new" {if !$ccard}checked="checked"{/if} onclick="toggleCard(this);"/>
                            <label class="form-check-label">
                                {$lang.ccardnew}
                            </label>
                        </div>
                        <div class="mt-3 items {if !$ccard}{else}items-hidden{/if}" {if !$ccard}{else}style="display:none"{/if} >
                            <div class="checkout">
                                <div class="credit-card">
                                    <div class="credit-card-box">
                                        <div class="flip">
                                            <div class="front">
                                                <div class="credit-card-box-chip"></div>
                                                <div class="credit-card-box-logo visa"></div>
                                                <div class="credit-card-box-number"></div>
                                                <div class="credit-card-box-holder">
                                                    <label>{$lang.ccholder}</label>
                                                    <div>{$login.firstname} {$login.lastname}</div>
                                                </div>
                                                <div class="credit-card-box-expiration-date">
                                                    <label>{$lang.ccexpiry}</label>
                                                    <div></div>
                                                </div>
                                            </div>
                                            <div class="back">
                                                <div class="credit-card-box-strip"></div>
                                                <div class="credit-card-box-logo">
                                                </div>
                                                <div class="credit-card-box-ccv">
                                                    <label>CCV</label>
                                                    <div></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-center">
                                    <table style="max-width: 600px;">
                                        <tr>
                                            <td width="150" >{$lang.cctype}</td>
                                            <td>
                                                {if !$allow_storage && !$ccard}
                                                    <input type="hidden" name="cc_details" value="new" />
                                                {/if}
                                                <select class="form-control card-type_js" name="cc[cardtype]">
                                                    {foreach from=$supportedcc item=cc}
                                                        <option>{$cc}</option>
                                                    {/foreach}
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >{$lang.ccnum}</td>
                                            <td><input type="num" class="form-control card-number_js" name="cc[cardnum]" maxlength="16" /></td>
                                        </tr>
                                        <tr>
                                            <td >{$lang.ccexpiry}</td>
                                            <td>
                                                <div class="d-flex flex-row align-items-center">
                                                    <select class="form-control w-50 card-expiration-month_js"  name="cc[expirymonth]" >
                                                        <option>MM</option>
                                                        <option value="01">01</option>
                                                        <option value="02">02</option>
                                                        <option value="03">03</option>
                                                        <option value="04">04</option>
                                                        <option value="05">05</option>
                                                        <option value="06">06</option>
                                                        <option value="07">07</option>
                                                        <option value="08">08</option>
                                                        <option value="09">09</option>
                                                        <option value="10">10</option>
                                                        <option value="11">11</option>
                                                        <option value="12">12</option>
                                                    </select>
                                                    <select class="form-control w-50 card-expiration-year_js" name="cc[expiryyear]">
                                                        <option>YYYY</option>
                                                        {section name=bar start=21 loop=29}
                                                            <option value="{$smarty.section.bar.index}">20{$smarty.section.bar.index}</option>
                                                        {/section}
                                                    </select>
                                                </div>
                                            </td>
                                        </tr>
                                        {if $allow_storage}
                                            <tr>
                                                <td>{$lang.autosave_cc}</td>
                                                <td align="left"><input type="checkbox" value="1" name="save_cc" {if !$ccard}checked="checked"{/if} /> {$lang.autosave_cc_desc}</td>
                                            </tr>
                                        {/if}
                                        <tr>
                                            <td >{$lang.ccarcvv}</td>
                                            <td>
                                                <input type="password"  class="form-control w-50 card-ccv_js" name="cvv" maxlength="5" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header d-flex flex-column flex-md-row justify-content-between">
                    <div class="mb-3 mb-md-0">
                        <strong>{$lang.billing_contact}  - <a href="{$ca_url}profiles/">{$lang.change}</a></strong>
                    </div>
                    <ul class="card-menu d-flex flex-row flex-wrap p-0 m-0 list-unstyled">
                        <li class="mr-2" >
                            <label><input type="radio" name="client[override_billing]" value="0" checked  onclick="switchcardform(true);"/>
                            {$lang.use_stored_billing}</label>
                        </li>
                        <li class="mr-2" >
                            <label><input type="radio" name="client[override_billing]" value="1" onclick="switchcardform(false);"  />
                            {$lang.override_stored_billing}</label>
                        </li>
                    </ul>
                </div>
                <div class="card-body">
                    <div id="billing_existing">
                        <table class="table">
                            <tbody>
                            <tr>
                                <td class="w-25">{$lang.firstname}</td>
                                <td>{$cadetails.firstname}</td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.lastname}</td>
                                <td>{$cadetails.lastname}</td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.company}</td>
                                <td>{$cadetails.companyname}</td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.email}</td>
                                <td>{$cadetails.email}</td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.address}</td>
                                <td>{$cadetails.address1}</td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.address2}</td>
                                <td>{$cadetails.address2}</td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.city}</td>
                                <td>{$cadetails.city}</td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.state}</td>
                                <td>{$cadetails.state}</td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.postcode}</td>
                                <td>{$cadetails.postcode}</td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.country}</td>
                                <td>{foreach from=$countries key=k item=v} {if $k==$cadetails.country}{$v}{break}{/if} {/foreach} </td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.phone}</td>
                                <td>{$cadetails.phonenumber}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div id="billing_override" style="display: none">
                        <table class="table">
                            <tbody>
                            <tr>
                                <td class="w-25">{$lang.firstname}</td>
                                <td><input name="client[firstname]" value="{$cadetails.firstname}" class="form-control card-holder_details card-holder_firstname"/>
                                    <input name="client[original_name]" value="{$cadetails.firstname} {$cadetails.lastname}" type="hidden" class="card-holder_original_name"/></td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.lastname}</td>
                                <td><input name="client[lastname]" value="{$cadetails.lastname}"  class="form-control card-holder_details card-holder_lastname"/></td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.company}</td>
                                <td><input name="client[companyname]" value="{$cadetails.companyname}"  class="form-control"/></td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.email}</td>
                                <td><input name="client[email]" value="{$cadetails.email}"  class="form-control"/></td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.address}</td>
                                <td><input name="client[address1]" value="{$cadetails.address1}"  class="form-control"/></td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.address2}</td>
                                <td><input name="client[address2]" value="{$cadetails.address2}"  class="form-control"/></td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.city}</td>
                                <td><input name="client[city]" value="{$cadetails.city}"  class="form-control"/></td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.state}</td>
                                <td><input name="client[state]" value="{$cadetails.state}"  class="form-control"/></td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.postcode}</td>
                                <td><input name="client[postcode]" value="{$cadetails.postcode}"  class="form-control"/></td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.country}</td>
                                <td>
                                    <select name="client[country]" class="form-control">
                                        {foreach from=$countries key=k item=v}
                                            <option value="{$k}" {if $k==$cadetails.country} selected="Selected"{/if}>{$v}</option>
                                        {/foreach}
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="w-25">{$lang.phone}</td>
                                <td><input name="client[phonenumber]" value="{$cadetails.phonenumber}"  class="form-control"/></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>



            {if $allow_partial}
                <hr>
                <div class="section-cards">
                    <div class="card item">
                        <div class="card-body">
                            <div class="form-check">
                                <input type="radio" name="custom_amount" value="0" checked="checked"  onclick="toggleCard(this);" />
                                <label class="form-check-label">
                                    {$lang.payfulldueamount|default:"Pay full due amount"}
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="card item">
                        <div class="card-body">
                            <div class="form-check">
                                <input type="radio" name="custom_amount" value="1" onclick="toggleCard(this);"/>
                                <label class="form-check-label">
                                    {$lang.specifyamounttopay|default:"Specify amount to pay (partial payment)"}
                                </label>
                            </div>
                            <div class="mt-3 items items-hidden" style="display:none" >
                                <div class="input-group">
                                    <input type="text" value="{$invoice_total}" size="4" name="custom_amount_value" class="form-control"/>
                                </div>
                                <div class="mt-2 small">
                                    <b>{$lang.mipartialpaymentvalue|default:"Minimum partial payment amount"}: </b>
                                    <span>{$partial_min|price}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            {/if}

            <div class="d-flex flex-row align-items-center justify-content-center my-5">
                {securitytoken}
                <input type="submit" value="{$lang.continue}" name="continue" class="btn btn-primary btn-lg w-25 mx-2"/>
            </div>
        </form>
    </section>
{/if}
