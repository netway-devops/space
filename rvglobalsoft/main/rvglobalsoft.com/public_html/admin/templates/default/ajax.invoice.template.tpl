{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . '/ajax.invoice.template.tpl.php');
{/php}

{if $action=='edittemplate'}
    {include file='configuration/edit_template.tpl'}
{elseif $action=='invoicetemplates'}
    <form action="" method="post" enctype="multipart/form-data">
        <input type="hidden" name="make" value="saveconfig"/>
        <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable">
            <tr class="bordme">
                <td width="205" align="right" valign="top"><strong>Document Logo</strong></td>

                <td colspan="3">
                    <input type="radio" value="0" {if $configuration.InvCompanyLogo==''}checked="checked"{/if}
                           name="InvCompanyLogoY" onclick="$('#logouploaders').slideUp();"/>
                    <strong>{$lang.InvCompanyLogo_descr1}</strong><br/>
                    <input type="radio" value="1" {if $configuration.InvCompanyLogo!=''}checked="checked"{/if}
                           name="InvCompanyLogoY" onclick="$('#logouploaders').slideDown();"/>
                    <strong>{$lang.InvCompanyLogo_descr}</strong>
                    <div class="clear"></div>
                    <div class="p6 left" id="logouploaders"
                         style="{if $configuration.InvCompanyLogo==''}display:none;{/if}padding:10px 5px;margin-top:10px;">
                        <table border="0" cellspacing="0" cellpadding="6">
                            <tr>
                                <td width="200" style="border:none" valign="top" align="center" class="fs11">
                                    {if $configuration.InvCompanyLogo!=''}
                                        {$lang.CurrentLogo}:
                                        <img src="../templates/{$configuration.InvCompanyLogo}"
                                             alt="{$configuration.BusinessName}"/>
                                    {else}
                                        No logo uploaded yet
                                    {/if}
                                </td>
                                <td style="border:none">
                                    {$lang.NewLogo}: <input name="file" id="InvCompanyLogo" type="file"/><br/>

                                </td>
                            </tr>

                        </table>
                    </div>
                    <div class="clear"></div>


                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="top"><strong>{$lang.InvoiceTemplate}</strong></td>
                <td colspan="3">
                    <table style="border:1px solid #CCCCCC; border-collapse: collapse" cellspacing="0" cellpadding="3">

                        {foreach from=$invtemplates item=tpl}
                            <tr>
                                <td style="border:1px solid #CCCCCC; background: #fff;">
                                    <input class="left" type="radio" name="InvoiceTemplate" value="{$tpl.id}"
                                           {if $configuration.InvoiceTemplate==$tpl.id}checked="checked"{/if}
                                           id="seo_{$tpl.id}"/>
                                    <label for="seo_{$tpl.id}" class="w150 left">{$tpl.name}</label>
                                    <div class="left">
                                        <a href="?cmd=configuration&action=invoicetemplates&make=preview&content_id={$tpl.id}&security_token={$security_token}"
                                           class="fs11">Preview</a>
                                        {if $tpl.parent_id=='0'}
                                            <a href="?cmd=configuration&action=invoicetemplates&make=customize&id={$tpl.id}&security_token={$security_token}"
                                               class="fs11 orspace">Customize</a>
                                        {else}
                                            <a href="?cmd=configuration&action=edittemplate&template_id={$tpl.id}"
                                               class="fs11 orspace">Edit</a>
                                            <a href="?cmd=configuration&action=invoicetemplates&make=delete&id={$tpl.id}&security_token={$security_token}"
                                               class="fs11 editbtn orspace"
                                               onclick="return confirm('Are you sure you wish to remove this template?')">Delete</a>
                                        {/if}
                                    </div>
                                    <div class="clear"></div>
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                </td>
            </tr>

            <tr class="bordme">
                <td width="205" align="right" valign="top"><strong>{$lang.EstimateTemplate}</strong></td>
                <td colspan="3">
                    <table style="border:1px solid #CCCCCC; border-collapse: collapse" cellspacing="0" cellpadding="3">

                        {foreach from=$estimatetemplates item=tpl}
                            <tr>
                                <td style="border:1px solid #CCCCCC; background: #fff;">
                                    <input class="left" type="radio" name="EstimateTemplate" value="{$tpl.id}"
                                           {if $configuration.EstimateTemplate==$tpl.id}checked="checked"{/if}
                                           id="seo_{$tpl.id}"/>
                                    <label for="seo_{$tpl.id}" class="w150 left">{$tpl.name}</label>
                                    <div class="left">
                                        <a href="?cmd=configuration&action=invoicetemplates&make=preview&content_id={$tpl.id}&security_token={$security_token}"
                                           class="fs11">Preview</a>
                                        {if $tpl.parent_id=='0'}
                                            <a href="?cmd=configuration&action=invoicetemplates&make=customize&id={$tpl.id}&security_token={$security_token}&type=estimate"
                                               class="fs11 orspace">Customize</a>
                                        {else}
                                            <a href="?cmd=configuration&action=edittemplate&template_id={$tpl.id}&type=estimate"
                                               class="fs11 orspace">Edit</a>
                                            <a href="?cmd=configuration&action=invoicetemplates&make=delete&id={$tpl.id}&security_token={$security_token}&type=estimate"
                                               class="fs11 editbtn orspace"
                                               onclick="return confirm('Are you sure you wish to remove this template?')">Delete</a>
                                        {/if}
                                    </div>
                                    <div class="clear"></div>
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                </td>
            </tr>

            {if $configuration.CnoteEnable=='on'}
                <tr class="bordme">
                    <td width="205" align="right" valign="top"><strong>{$lang.CreditNoteTemplate}</strong></td>
                    <td colspan="3">
                        <table style="border:1px solid #CCCCCC; border-collapse: collapse" cellspacing="0"
                               cellpadding="3">
                            {foreach from=$cnotetemplate item=tpl}
                                <tr>
                                    <td style="border:1px solid #CCCCCC; background: #fff;">
                                        <input class="left" type="radio" name="CNoteTemplate" value="{$tpl.id}"
                                               {if $configuration.CNoteTemplate==$tpl.id}checked="checked"{/if}
                                               id="seo_{$tpl.id}"/>
                                        <label for="seo_{$tpl.id}" class="w150 left">{$tpl.name}</label>
                                        <div class="left">
                                            <a href="?cmd=configuration&action=invoicetemplates&make=preview&content_id={$tpl.id}&security_token={$security_token}"
                                               class="fs11">Preview</a>
                                            {if $tpl.parent_id=='0'}
                                                <a href="?cmd=configuration&action=invoicetemplates&make=customize&id={$tpl.id}&security_token={$security_token}"
                                                   class="fs11 orspace">Customize</a
                                            {else}
                                                <a href="?cmd=configuration&action=edittemplate&template_id={$tpl.id}"
                                                   class="fs11 orspace">Edit</a>
                                                <a href="?cmd=configuration&action=invoicetemplates&make=delete&id={$tpl.id}&security_token={$security_token}"
                                                   class="fs11 editbtn orspace"
                                                   onclick="return confirm('Are you sure you wish to remove this template?')">Delete</a>
                                            {/if}
                                        </div>
                                        <div class="clear"></div>
                                    </td>
                                </tr>
                            {/foreach}
                        </table>
                    </td>
                </tr>
            {/if}


            {if $configuration.ReceiptEnable=='on'}
                <tr class="bordme">
                    <td width="205" align="right" valign="top"><strong>{$lang.CreditReceiptTemplate}</strong></td>
                    <td colspan="3">
                        <table style="border:1px solid #CCCCCC; border-collapse: collapse" cellspacing="0"
                               cellpadding="3">
                            {foreach from=$receipttemplate item=tpl}
                                <tr>
                                    <td style="border:1px solid #CCCCCC; background: #fff;">
                                        <input class="left" type="radio" name="ReceiptTemplate" value="{$tpl.id}"
                                               {if $configuration.ReceiptTemplate==$tpl.id}checked="checked"{/if}
                                               id="seo_{$tpl.id}"/>
                                        <label for="seo_{$tpl.id}" class="w150 left">{$tpl.name}</label>
                                        <div class="left">
                                            <a href="?cmd=configuration&action=invoicetemplates&make=preview&content_id={$tpl.id}&security_token={$security_token}"
                                               class="fs11">Preview</a>
                                            {if $tpl.parent_id=='0'}
                                                <a href="?cmd=configuration&action=invoicetemplates&make=customize&id={$tpl.id}&security_token={$security_token}"
                                                   class="fs11 orspace">Customize</a
                                            {else}
                                                <a href="?cmd=configuration&action=edittemplate&template_id={$tpl.id}"
                                                   class="fs11 orspace">Edit</a>
                                                <a href="?cmd=configuration&action=invoicetemplates&make=delete&id={$tpl.id}&security_token={$security_token}"
                                                   class="fs11 editbtn orspace"
                                                   onclick="return confirm('Are you sure you wish to remove this template?')">Delete</a>
                                            {/if}
                                        </div>
                                        <div class="clear"></div>
                                    </td>
                                </tr>
                            {/foreach}
                        </table>
                    </td>
                </tr>
            {/if}


            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <h3>Invoice details</h3>
                </td>
                <td colspan="3">

                </td>
            </tr>
            <tr class="bordme euinvoices"
            "="">
            <td align="right" width="205"><strong>Discount on invoice</strong></td>
            <td colspan="3">
                <input name="DiscountOnInvoice" type="radio" value="on"
                       {if $configuration.DiscountOnInvoice=='on'}checked="checked"{/if} class="inp">
                <strong>Yes, </strong>Show discount on invoice as negative invoice lines<br>
                <input name="DiscountOnInvoice" type="radio" value="coupon"
                       {if $configuration.DiscountOnInvoice=='coupon'}checked="checked"{/if} class="inp">
                <strong>Yes, </strong>Show discount on invoice as lines with coupon code<br>
                <input name="DiscountOnInvoice" type="radio" value="off"
                       {if $configuration.DiscountOnInvoice=='off'}checked="checked"{/if} class="inp">
                <strong>No, </strong>Just discount invoice amounts, without showing discount details
            </td>
            </tr>

            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Use 2nd currency: <a class="vtip_description"
                                            title="All invoice values will be displayed in 2 currencies, original (the one invoice was generated in), and second selected from list below. <br/>Works only on invoices generated after this option is enabled."></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="Invoice2ndcurrency" value="1"
                           {if $configuration.Invoice2ndcurrency}checked="checked"{/if}
                           onclick="$('#daybefore,#comment').toggle()"/>

                    <select class="inp" name="Invoice2ndcurrency_val">
                        {foreach from=$a_currencies item=v key=k}
                            <option value="{$k}"
                                    {if $configuration.Invoice2ndcurrency_val == $k}selected="selected"{/if}>{$v.iso}</option>
                        {/foreach}
                    </select>
            </tr>

            <tr class="bordme" id="daybefore" {if !$configuration.Invoice2ndcurrency}style="display:none"{/if}>
                <td width="205" align="right" valign="middle">
                    <b>'Day before' conversion: <a class="vtip_description"
                                                   title="If 2nd currency is enabled, HostBill will use conversion rate from day invoice was created (for EU invoices payment date is used). <br/> To use conversion rate from day before mentioned dates use this option (required in some EU countries)"></a></b><br/>
                </td>
                <td colspan="3"><input type="checkbox" name="InvoiceDayBefore" value="1"
                                       {if $configuration.InvoiceDayBefore}checked="checked"{/if} />

            </tr>

            <tr class="bordme" id="comment" {if !$configuration.Invoice2ndcurrency}style="display:none"{/if}>
                <td width="205" align="right" valign="middle">
                    <b>Conversion rate in note: <a class="vtip_description"
                                                   title="Place conversion rate used for 2nd currency in invoice notes"></a></b><br/>
                </td>
                <td colspan="3"><input type="checkbox" name="InvoiceConversionRate" value="1"
                                       {if $configuration.InvoiceConversionRate}checked="checked"{/if} />

            </tr>

            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Use 2nd language: <a class="vtip_description"
                                            title="When enabled all {literal}{$lang}{/literal} will be additionally translated with second language"></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="Invoice2ndlanguage" value="1"
                           {if $configuration.Invoice2ndlanguage}checked="checked"{/if} />
                    <select class="inp" name="Invoice2ndlanguage_val">
                        {foreach from=$a_languages item=v key=k}
                            <option value="{$v.name}"
                                    {if $configuration.Invoice2ndlanguage_val == $v.name}selected="selected"{/if}>{$v.name}</option>
                        {/foreach}
                    </select>
                </td>

            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Show account #ID: <a class="vtip_description"
                                            title="When enabled invoice lines will show account ID for related entries"></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="InvoiceShowAccountId" value="1"
                           {if $configuration.InvoiceShowAccountId}checked="checked"{/if} />

                </td>
            </tr>

            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Show account label: <a class="vtip_description"
                                              title="When enabled invoice lines will show account label entered by customer in client portal"></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="InvoiceShowAccountLabel" value="1"
                           {if $configuration.InvoiceShowAccountLabel}checked="checked"{/if} />

                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Period on recurring invoices: <a class="vtip_description"
                                                        title="Invoices issued for accounts gets period added to them by default. Invoices issued from Invoices->Recurring can also have period added when this feature is enabled"></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="RecurringAddPeriod" value="on"
                           {if $configuration.RecurringAddPeriod=='on'}checked="checked"{/if} />

                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Period on upgrade invoices: <a class="vtip_description"
                                                      title="Invoices issued for account upgrades does not have  period added to them by default. "></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="UpgradesAddPeriod" value="on"
                           {if $configuration.UpgradesAddPeriod=='on'}checked="checked"{/if} />

                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Period on domain transfer invoices: </b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="TransferOrderPeriod" value="on"
                           {if $configuration.TransferOrderPeriod=='on'}checked="checked"{/if} />

                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>{$lang.period_on_estimates}: <a class="vtip_description"
                                               title="{$lang.period_on_estimates_desc}"></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="PeriodOnEstimates" value="on"
                           {if $configuration.PeriodOnEstimates=='on'}checked="checked"{/if} />
                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>{$lang.SetupFeeSeparateLine}: <a class="vtip_description"
                                                       title="{$lang.SetupFeeSeparateLineDesc}"></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="SetupFeeSeparateLine" value="on"
                           {if $configuration.SetupFeeSeparateLine=='on'}checked="checked"{/if} />
                </td>
            </tr>

            {if $mbstring}
                <tr class="bordme">
                    <td width="205" align="right" valign="top"><strong>{$lang.PayToText}</strong></td>
                    <td colspan="3"><textarea style="width:50%" name="PayToText"
                                              class="inp">{$configuration.PayToText}</textarea></td>
                </tr>
                <tr class="bordme">
                    <td width="205" align="right" valign="top"><strong>{$lang.UseInvoiceFooter}</strong></td>
                    <td colspan="3"><textarea style="width:50%" name="InvoiceFooter" id="InvoiceFooter"
                                              class="inp">{$configuration.InvoiceFooter}</textarea></td>
                </tr>
            {/if}
        </table>

        <div style="text-align:center" class="nicerblu">
            <input type="submit" class="btn btn-primary" style="font-weight:bold" value="{$lang.savechanges}">
        </div>
        {securitytoken}
        {if $preview}
            <div class="text-center row" style="margin: 20px 0 0 0;">
                <div class="col-sm-12" style="border-color: #dfdfdf; border-style: solid; border-width: 1px 0; padding: 10px">
                    <h3><strong>Invoice preview</strong></h3>
                </div>
            </div>
            <div id="preview" style="padding: 30px; ">
                <div style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">{$preview}</div>
            </div>
        {/if}
    </form>
    {literal}
        <script>
            var bordme = $('.bordme td input, .bordme td select'),
                preview =  $('#preview'),
                send = {},
                keys = {};

            bordme.each(function (index, val) {
                keys[index] = $(val).attr('name');
            });
            bordme.on('change', function () {
                invoice_preview(this);
            });

            $(function () {
                invoice_preview($('.bordme'));
            });

            function invoice_preview(self) {
                var form = $(self).parents('form:first');
                send = form.serializeArray().reduce(function(obj, item) {
                    obj[item.name] = item.value;
                    return obj;
                }, {});

                preview.addLoader();
                $.post("?cmd=configuration&action=invoice_preview", {
                    config: send,
                    keys: keys
                }, function (result) {
                    preview.hideLoader();
                    preview.html(result);
                })
            }
        </script>
    {/literal}
{elseif $action=='estimatetemplates'}
    <form action="" method="post" enctype="multipart/form-data">
        <input type="hidden" name="make" value="saveconfig"/>
        <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable">

            <tr class="bordme">
                <td width="205" align="right" valign="top"><strong>{$lang.EstimateTemplate}</strong></td>
                <td colspan="3">
                    <table style="border:1px solid #CCCCCC; border-collapse: collapse" cellspacing="0" cellpadding="3">

                        {foreach from=$invtemplates item=tpl}
                            <tr>
                                <td style="border:1px solid #CCCCCC; background: #fff;">
                                    <input class="left" type="radio" name="InvoiceTemplate" value="{$tpl.id}"
                                           {if $configuration.EstimateTemplate==$tpl.id}checked="checked"{/if}
                                           id="seo_{$tpl.id}"/>
                                    <label for="seo_{$tpl.id}" class="w150 left">{$tpl.name}</label>
                                    <div class="left">
                                        <a href="?cmd=configuration&action=estimatetemplates&make=preview&content_id={$tpl.id}&security_token={$security_token}"
                                           class="fs11">Preview</a>
                                        {if $tpl.parent_id=='0'}
                                            <a href="?cmd=configuration&action=estimatetemplates&make=customize&id={$tpl.id}&security_token={$security_token}"
                                               class="fs11 orspace">Customize</a>
                                        {else}
                                            <a href="?cmd=configuration&action=edittemplate&template_id={$tpl.id}&type=estimate"
                                               class="fs11 orspace">Edit</a>
                                            <a href="?cmd=configuration&action=estimatetemplates&make=delete&id={$tpl.id}&security_token={$security_token}"
                                               class="fs11 editbtn orspace"
                                               onclick="return confirm('Are you sure you wish to remove this template?')">Delete</a>
                                        {/if}
                                    </div>
                                    <div class="clear"></div>
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                </td>
            </tr>


        </table>
        <div style="text-align:center" class="nicerblu">
            <input type="submit" class="submitme" style="font-weight:bold" value="{$lang.savechanges}">
        </div>
        {securitytoken}
    </form>
{elseif $action == 'invoice_preview'}
    {if $preview}
        <div style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
            {$preview}
        </div>
    {/if}
{/if}

