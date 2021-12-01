{*

Credit Card processing screen.
Logged in customer can provide credit card details, or use current credit card on file to pay for invoice

*}{if $ccprocessed}

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
                    return true;
                }
            </script>
        {/literal}
    {else}
        {literal}
            <script>
                function ccsubmit() {
                    $('#ccpcontent').addLoader();
                    return true;
                }
            </script>
        {/literal}
    {/if}
    <article>
        <h2><i class="icon-cc"></i> {$lang.myccard}</h2>
        <p>{$lang.account_descr}</p>

        <form action='' method='post' onsubmit="ccsubmit(this)" class="form-inline">
            <input type="hidden" name="invoice_id" value="{$invoice_id}" />
            <input type="hidden" name="payment_module" value="{$payment_module}" />
            <input type="hidden" name="client[client_id]" value="{$cadetails.id}" />

            <div class="table-box m15 overflow-h">
                <div class="table-header">
                </div>

                <table class="table table-header-fix table-striped p-td">
                    <tr>
                        <th colspan="2">{$lang.ccarddetails}</th>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="radio" name="cc_details" value="existing" {if !$ccard}disabled="disabled"{else}checked="checked"  onclick="$('#newcard').hide();"{/if} /> 
                            {$lang.ccardexists}
                            {if $ccard} ({$ccard.cardnum})
                            {/if}
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="radio" name="cc_details" value="new" {if !$ccard}checked="checked"{/if} onclick="$('#newcard').show();"/> 
                            {$lang.ccardnew}
                        </td>
                    </tr>
                    <tbody id="newcard" {if $ccard}style="display:none"{/if}>
                        <tr>
                            <td width="160" >{$lang.ccardtype}</td>
                            <td>
                                <select name="cc[cardtype]">
                                    {foreach from=$supportedcc item=cc}
                                        <option>{$cc}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td> {$lang.ccardnum}</td>
                            <td><input type="text" name="cc[cardnum]" size="25" maxlenght="16"  class="styled"  autocomplete="off"/></td>
                        </tr>
                        <tr>
                            <td>{$lang.ccardexp}</td>
                            <td>
                                <input type="text" name="cc[expirymonth]" size="2" maxlength="2" class="styled span1" />/
                                <input type="text" name="cc[expiryyear]" size="2" maxlength="2"  class="styled span1"/> (MM/YY)
                            </td>
                        </tr>
                        <tr>
                            <td>{$lang.autosave_cc}</td>
                            <td align="left"><input type="checkbox" value="1" name="save_cc" {if !$ccard}checked="checked"{/if} /> {$lang.autosave_cc_desc}</td>
                        </tr>
                    </tbody>
                    <tr>
                        <td width="160">{$lang.ccarcvv}</td>
                        <td align="left"><input type="text" name="cvv" size="4"  class="styled" autocomplete="off" style="width:60px"/> <a href="#newccdetails" data-toggle="modal">?</a></td>
                    </tr>

                    <tr>
                        <td colspan="2" align="center"><input type="submit" value="{$lang.continue}" name="continue"  class="btn btn-info" style="font-weight:bold"/></td>
                    </tr>
                </table>
            </div>

            <div class="table-box m15 overflow-h">
                <div class="table-header">
                </div>

                <table class="table table-header-fix table-striped p-td">
                    <tr>
                        <th colspan="2">{$lang.yourinfo}</th>
                    </tr>
                    <tr>
                        <td>{$lang.firstname}</td>
                        <td><input name="client[firstname]" value="{$cadetails.firstname}" class="styled"/></td>
                    </tr>

                    <tr>
                        <td>{$lang.lastname}</td>
                        <td><input name="client[lastname]" value="{$cadetails.lastname}"  class="styled"/></td>
                    </tr>

                    <tr>
                        <td>{$lang.company}</td>
                        <td><input name="client[companyname]" value="{$cadetails.companyname}"  class="styled"/></td>
                    </tr>

                    <tr>
                        <td>{$lang.email}</td>
                        <td><input name="client[email]" value="{$cadetails.email}"  class="styled"/></td>
                    </tr>

                    <tr>
                        <td>{$lang.address}</td>
                        <td><input name="client[address1]" value="{$cadetails.address1}"  class="styled"/></td>
                    </tr>

                    <tr>
                        <td>{$lang.address2}</td>
                        <td><input name="client[address2]" value="{$cadetails.address2}"  class="styled"/></td>
                    </tr>

                    <tr>
                        <td>{$lang.city}</td>
                        <td><input name="client[city]" value="{$cadetails.city}"  class="styled"/></td>
                    </tr>

                    <tr>
                        <td>{$lang.state}</td>
                        <td><input name="client[state]" value="{$cadetails.state}"  class="styled"/></td>
                    </tr>

                    <tr>
                        <td>{$lang.postcode}</td>
                        <td><input name="client[postcode]" value="{$cadetails.postcode}"  class="styled"/></td>
                    </tr>

                    <tr>
                        <td>{$lang.country}</td>
                        <td>
                            <select name="client[country]">
                                {foreach from=$countries key=k item=v}
                                    <option value="{$k}" {if $k==$cadetails.country} selected="Selected"{/if}>{$v}</option>

                                {/foreach}
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td>{$lang.phone}</td>
                        <td><input name="client[phonenumber]" value="{$cadetails.phonenumber}"  class="styled"/></td>
                    </tr>
                </table>
            </div>
            {securitytoken}
        </form>
        <div id="newccdetails" style="display:none" class="modal">
            <form action="" method="post" style="margin-bottom:0px;">

                <div class="modal-header">
                    <a class="close-modal" data-dismiss="modal">×</a>
                    <h3>CVV Info</h3>
                </div>
                <div class="modal-body">
                    <img src="{$template_dir}img/cvv.gif" alt="WHat is CVV code?"/>
                </div>
                <div class="modal-footer">
                    <a href="#" class="btn" data-dismiss="modal">{$lang.close}</a>
                </div>

                {securitytoken}
            </form>

        </div>
    </article>

    {/if}
