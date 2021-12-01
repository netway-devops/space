{if $invoice.status == 'Recurring' || $status == 'Recurring'}
    {assign value=true var=is_recurring}
{/if}

<strong class="clientmsg">{$lang.Client}:
    {$invoice.client|@profilelink:true|@login_as_client:$system_url:$invoice.client_id}
</strong>

{if $invoice.status!='Draft' && !$invoice.readonly}
    <div class="right replybtn tdetail">
        <strong>
            <a href="#" id="tab-detail">
                <span class="a1">{$lang.editdetails}</span>
                <span class="a2">{$lang.hidedetails}</span>
            </a>
        </strong>
    </div>
{/if}

{if ($invoice.status == 'Creditnote' || $invoice.status == 'CreditnoteDraft') && !$invoice.client_id}
    <form action="?cmd=invoices&action=changething" method="post" id="detailsform">
        <input type="hidden" name="make" value="editdetails" />
        <input type="hidden" name="id" value="{$invoice.id}" />
        <input type="hidden" name="list" value="creditnote" />
        <div id="clientloader">
            <p>Choose client profile that you want to assign to this document.</p>
            <select style="width: 180px" name="invoice[client_id]" load="clients" default="{$invoice.client_id}">
                <option value="0">{$lang.selectcustomer}</option>
            </select>
            <button type="submit" class="menuitm btn btn-primary">Continue</button>
        </div>
        {securitytoken}
    </form>
    <hr>
{/if}

{if $invoice.status == 'Paid'}
    <div class="right">{$lang.Paid}: {$invoice.datepaid|dateformat:$date_format}&nbsp;&nbsp;&nbsp;</div>
{/if}

<div class="clear"></div>
<div id="invoice-details">
    {if $invoice.status!='Draft'}
        <div class="tdetails invoice-edit active {if $invoice.readonly}read-only{/if}">
            {if $is_recurring}
                <div class="left">
                    <table border="0" width="300" cellspacing="3" cellpadding="0">
                        <tr>
                            <td width="100" align="right" class="light">{$lang.start_date}:</td>
                            <td width="200" align="left"><span class="{if !$block_invoice}livemode{/if}">{$invoice.recurring.start_from|dateformat:$date_format}</span></td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">Due Days:</td>
                            <td width="200" align="left">
                                <span class="{if !$block_invoice}livemode{/if}">{if $invoice.recurring.duedays}{$invoice.recurring.duedays}{else}Default - {$automation.duedays}{/if} day(s)</span>
                            </td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">Pay Before Days:</td>
                            <td width="200" align="left">
                                <span class="{if !$block_invoice}livemode{/if}">{if $invoice.recurring.paybefore}{$invoice.recurring.paybefore}{else}Default - {$automation.paybefore}{/if} day(s)</span>
                            </td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.frequency}:</td>
                            <td width="200" align="left"><span class="{if !$block_invoice}livemode{/if}">{$lang[$invoice.recurring.frequency]}</span></td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.occurrences}:</td>
                            <td width="200" align="left"><span class="{if !$block_invoice}livemode{/if}">{if  $invoice.recurring.occurrences}{$invoice.recurring.occurrences}{else}{$lang.infinite}{/if}</span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="fs11"><a href="?cmd=invoices&list=all&filter[recurring_id]={$invoice.recurring_id}&resetfilter=1" target="_blank">{$lang.find_relatedinv}</a></td>
                        </tr>
                    </table>
                </div>

                <div class="left">
                    <table border="0" width="250" cellspacing="3" cellpadding="0">
                        <tr>
                            <td width="100" align="right" class="light">{$lang.next_invoice}: </td>
                            <td width="200" align="left"><span class="{if !$block_invoice}livemode{/if}">{$invoice.recurring.next_invoice|dateformat:$date_format}</span></td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.remaining|ucfirst}:</td>
                            <td width="200" align="left">{if $invoice.recurring.invoices_left && $invoice.recurring.occurrences}{$invoice.recurring.invoices_left}{else}&#8734;{/if}</td>
                        </tr>
                    </table>
                </div>

            {/if}

            <div class="left">
                <table border="0" cellspacing="3" cellpadding="0">
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td width="300" rowspan="6">
                            <div>
                                {if $isErrorInvoiceClientId}
                                <div class="imp_msg">
                                    <strong>Invoice client error</strong> <a href="?cmd=invoices&action=edit&id={$invoice.id}&fixerror=clientId">Fix this error</a> คลิกเพื่อแก้ไขปัญหา
                                </div>
                                {/if}
                            </div>
                        </td>
                    </tr>
                    <tr>
                        {if !$is_recurring}
                            <td width="100" align="right" class="light">{$lang.invoicedate}:</td>
                            <td width="200" align="left"><span class="{if !$block_invoice}livemode{/if}">
                                    {if $proforma && $invoice.paid_id!='' && $invoice.status!='Creditnote' && $invoice.status!='CreditnoteDraft'}
                                        {$invoice.datepaid|dateformat:$date_format}
                                    {else}
                                        {$invoice.date|dateformat:$date_format}
                                    {/if}
                                </span>
                            </td>
                        {/if}

                        <td width="100" align="right" class="light">{$lang.Gateway}:</td>
                        <td width="200" align="left">
                            <span class="livemode">
                                {if $invoice.credit>0 && !$invoice.gateway}
                                    {$lang.paidbybalance}
                                {else}
                                    {$invoice.gateway|default:"`$lang.none`"}
                                    {if $invoice.credit>0}<span class="fs11">+ {$lang.paidbybalance}</span>{/if}
                                {/if}
                            </span>
                            {if $invoice.status=='Unpaid' && $balance>0}
                                {if $cc }
                                    <form action="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}"  style="display:inline" method="post"
                                          onsubmit="return confirm('{$lang.chargefromcc1|addslashes} {$balance|price:$currency} {$lang.chargefromcc2|addslashes}');">
                                        <input type="submit" value="{$lang.chargecc}" name="chargeCC" class="btn btn-sm btn-primary" />{securitytoken}
                                    </form>
                                {elseif $ach}
                                    <form action="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}"  style="display:inline" method="post"
                                          onsubmit="return confirm('Are you sure you wish to charge {$balance|price:$currency} from client Bank Account?');">
                                        <input type="submit" value="Charge ACH" name="chargeACH" />{securitytoken}
                                    </form>
                                {/if}

                            {/if}
                        </td>
                        <td width="100" align="right" class="light">{$lang.currency}:</td>
                        <td width="200">
                            <span class="{if !$block_invoice}livemode{/if}">{$currency.iso}</span>
                        </td>
                    </tr>
                    <tr>
                        {if !$is_recurring && $invoice.status!='Creditnote' && $invoice.status!='CreditnoteDraft'}
                            <td width="100" align="right"  class="light">{$lang.duedate}:</td>
                            <td width="200" align="left">
                                <span class="{if !$block_invoice}livemode{/if}">{$invoice.duedate|dateformat:$date_format}</span>
                            </td>
                        {/if}

                        <td width="100" align="right" class="light">{$lang.taxlevel1}:</td>
                        <td width="200" align="left"><span class="{if !$block_invoice}livemode{/if}">{$invoice.taxrate} %</span></td>

                        {if !$is_recurring}
                            <td width="100" align="right" class="light">{if "config:Invoice2ndcurrency:1"|checkcondition }1st currency rate{else}Currency rate{/if}:</td>
                            <td width="200">
                                <span class="{if !$block_invoice}livemode{/if}">{$invoice.rate}</span>
                            </td>
                        {/if}
                    </tr>
                    <tr>
                        {if !$is_recurring && $invoice.status!='Creditnote' && $invoice.status!='CreditnoteDraft'}
                            <td width="100" align="right"  class="light">Pay Before:</td>
                            <td width="200" align="left">
                                <span class="{if !$block_invoice}livemode{/if}">{$invoice.paybefore|dateformat:$date_format}</span>
                            </td>
                        {/if}

                        <td width="100" align="right" class="light">{$lang.taxlevel2}:</td>
                        <td width="200" align="left"><span class="{if !$block_invoice}livemode{/if}">{$invoice.taxrate2} %</span></td>

                        {if !$is_recurring && "config:Invoice2ndcurrency:1"|checkcondition }
                            <td width="100" align="right" class="light">2nd currency rate:</td>
                            <td width="200">
                                <span class="{if !$block_invoice}livemode{/if}">{$invoice.rate2}</span>
                            </td>
                        {/if}
                    </tr>
                    <tr>
                        {if !$is_recurring}
                            <td width="100" align="right"  class="light">{$lang.Amount}:</td>
                            <td width="200" align="left">
                                <strong class="invoice-total">{$invoice.grandtotal|price:$currency}</strong>
                            </td>
                        {/if}

                        {if $invoice.status!='Creditnote' && $invoice.status!='CreditnoteDraft' && $invoice.status!='Receiptpaid' && $invoice.status!='Receiptunpaid'}
                            <td width="100" align="right" class="light">{$lang.Credit}:</td>
                            <td width="200" align="left"><span class="{if !$block_invoice}livemode{/if}">{$invoice.credit|price:$currency}</span></td>
                            {/if}

                    </tr>
                    <tr>

                        {if !$is_recurring}
                            <td width="100" align="right" class="light">{$lang.balance}</td>
                            <td width="200" align="left" class="invoice-balance">{$balance|price:$currency}</td>
                        {/if}
                        {if $invoice.status=='Unpaid' && $clientcredit>0 && $balance>0 }
                            <td width="100" align="right" class="light">{$lang.clientcreditavailable}:</td>
                            <td width="200" align="left" colspan="2">
                                {$clientcredit|price:$currency}
                                <a class="editbtn" id="add-credit-btn" href="#">{$lang.clientcreditaddtoinvoice}</a>
                            </td>
                        {/if}
                    </tr>
                </table>
            </div>
            <div class="clear"></div>
        </div>
        {if $isShowBalanceNotification}
        <div style="background-color: rgb(255, 232, 232); color: red; border: 1px solid red; overflow: hidden; height: auto;">
            <p align="center">
                Invoice balance มีค่าติดลบ จะเป็นการให้ credit กับลูกค้าสำหรับ invoice หน้า กรุณาตรวจสอบความถูกต้อง (ถ้าถูกต้องแล้วไม่เป็นไร ข้อความเตือนนี้จะไม่แสดงอีกในวันถัดไป)
                <br />
                <a href="?cmd=clients&action=show&id={$invoice.client_id}" target="_blank">คลิกเพื่อดู Credit log</a>
            </p>
        </div>
        {/if}
    {/if}
    {if !$invoice.readonly}
        <div class="secondtd invoice-edit {$invoice.status}" >
            <form action="" method="post" id="detailsform">
                <input type="hidden" name="make" value="editdetails" />
                <input type="hidden" id="client_id" name="invoice[client_id]" value="{$invoice.client_id}" />

                {if $is_recurring}
                    <div class="left">
                        <input type="hidden" id="is_recurring" name="invoice[recurring][recurr]" value="1" />
                        <table border="0" width="300" cellspacing="3" cellpadding="0" >
                            <tr>
                                <td width="100" align="right" class="light">{$lang.start_date}:</td>
                                <td width="200" align="left">
                                    <input  value="{if $invoice.status != 'Draft'}{$invoice.recurring.start_from|dateformat:$date_format}{/if}"
                                            type="hidden" id="old_recurring_start_date" />
                                    <input name="invoice[recurring][start_from]"
                                           value="{$invoice.recurring.start_from|dateformat:$date_format}"
                                           class="haspicker" id="recurring_start_date" />
                                </td>
                            </tr>
                            <tr>
                                <td width="100" align="right" class="light">Due Days:</td>
                                <td width="200" align="left">
                                    <span class="input-mask {if !$invoice.recurring.duedays}active{/if}">
                                        Default - {$automation.duedays} day(s)
                                    </span>
                                    <input name="invoice[recurring][duedays]" size="4"
                                           value="{$invoice.recurring.duedays}"  />
                                    <span>day(s)</span>
                                </td>
                            </tr>
                            <tr>
                                <td width="100" align="right" class="light">Pay Before Days:</td>
                                <td width="200" align="left">
                                    <span class="input-mask {if !$invoice.recurring.paybefore}active{/if}">
                                        Default - {$automation.paybefore} day(s)
                                    </span>

                                    <input name="invoice[recurring][paybefore]" size="4"
                                           value="{$invoice.recurring.paybefore}" />
                                    <span>day(s)</span>
                                </td>
                            </tr>
                            <tr>
                                <td width="100" align="right" class="light">{$lang.frequency}:</td>
                                <td width="200" align="left">
                                    <select name="invoice[recurring][frequency]" onchange="if($(this).val() == 'em')$('#recurring_start_date').val('{$curdate|dateformat:"Y-m-t"|dateformat:$date_format}').trigger('change'); $('a[href=NewLine]').data('cycle', $(this).val());">
                                        <option value="1w" {if $invoice.recurring.frequency=='1w'}selected="selected"{/if}>{$lang.1w}</option>
                                        <option value="2w" {if $invoice.recurring.frequency=='2w'}selected="selected"{/if}>{$lang.2w}</option>
                                        <option value="4w" {if $invoice.recurring.frequency=='4w'}selected="selected"{/if}>{$lang.4w}</option>
                                        <option value="1m" {if $invoice.recurring.frequency=='1m'}selected="selected"{/if}>{$lang.1m}</option>
                                        <option value="em" {if $invoice.recurring.frequency=='em'}selected="selected"{/if}>Monthly - on last day of month</option>
                                        <option value="2m" {if $invoice.recurring.frequency=='2m'}selected="selected"{/if}>{$lang.2m}</option>
                                        <option value="3m" {if $invoice.recurring.frequency=='3m'}selected="selected"{/if}>{$lang.3m}</option>
                                        <option value="6m" {if $invoice.recurring.frequency=='6m'}selected="selected"{/if}>{$lang.6m}</option>
                                        <option value="1y" {if $invoice.recurring.frequency=='1y'}selected="selected"{/if}>{$lang.1y}</option>
                                        <option value="2y" {if $invoice.recurring.frequency=='2y'}selected="selected"{/if}>{$lang.2y}</option>
                                    </select>
                                    <script>{literal}$(function () {
                                            $('a[href=NewLine]').data('cycle', $('select[name="invoice[recurring][frequency]"]').val());
                                        });{/literal}</script>
                                </td>
                            </tr>
                            <tr>
                                <td width="100" align="right" class="light">{$lang.occurrences}:</td>
                                <td width="200" align="left" class="light" valign="middle">
                                    <input name="invoice[recurring][occurrences]"
                                           value="{if  $invoice.recurring.occurrences}{$invoice.recurring.occurrences}{else}0{/if}"
                                           size="2" id="recurring_occurrences"
                                           {if !$invoice.recurring.occurrences}disabled="disabled"{/if} /> #
                                    <input type="checkbox" name="invoice[recurring][infinite]"
                                           {if !$invoice.recurring.occurrences}checked="checked"{/if}
                                           id="inp_recurring_occurrences"
                                           value="1"/>
                                    <label for="inp_recurring_occurrences"> {$lang.infinite}</label>
                                </td>
                            </tr>
                            {if $invoice.status!='Draft'}
                                <tr>
                                    <td colspan="2" class="fs11"><a href="?cmd=invoices&list=all&filter[recurring_id]={$invoice.recurring_id}&resetfilter=1" target="_blank">{$lang.find_relatedinv}</a></td>
                                </tr>
                            {/if}
                        </table>
                    </div>
                    {if $invoice.status!='Draft'}
                        <div class="left">
                            <table border="0" width="250" cellspacing="3" cellpadding="0">
                                <tr>
                                    <td width="100" align="right" class="light">{$lang.next_invoice}:</td>
                                    <td width="200" align="left"><input type="text" name="invoice[recurring][next_invoice]" value="{$invoice.recurring.next_invoice|dateformat:$date_format}" class="haspicker" id="recurring_next_invoice" /></td>
                                </tr>
                                <tr>
                                    <td width="100" align="right" class="light">{$lang.remaining|ucfirst}:</td>
                                    <td width="200" align="left">{if $invoice.recurring.invoices_left && $invoice.recurring.occurrences}{$invoice.recurring.invoices_left}{else}&#8734;{/if}</td>
                                </tr>
                            </table>
                        </div>
                    {/if}
                {/if}
                <div class="left">
                    <table border="0" width="700" cellspacing="3" cellpadding="0" style="table-layout: fixed;">
                        <tr>
                            {if !$is_recurring}
                                <td width="100" align="right" class="light">{$lang.invoicedate}:</td>
                                <td width="200" align="left">
                                    {if $proforma && $invoice.paid_id!='' && $invoice.status!='Creditnote' && $invoice.status!='CreditnoteDraft'}
                                        <input type="text" name="invoice[datepaid]" value="{$invoice.datepaid|dateformat:$date_format}" placeholder="{$invoice.datepaid|dateformat:$date_format}" {if $block_invoice}disabled{else}class="haspicker"{/if}/>
                                    {else}
                                        <input type="text" name="invoice[date]" value="{$invoice.date|dateformat:$date_format}" placeholder="{$invoice.date|dateformat:$date_format}" {if $block_invoice}disabled{else}class="haspicker"{/if}/>
                                    {/if}
                                </td>
                            {/if}

                            <td width="100" align="right" class="light">{$lang.Gateway}:</td>
                            <td width="200" align="left" >
                                <select name="invoice[payment_module]"  onclick="new_gateway(this)">
                                    <!--<option value="0" >{$lang.none}</option>-->
                                    {if $invoice.payment_module == '0'}
                                        {assign var= 'default_payment' value='4'} <!-- set default payment select bank transfer -->
                                    {/if}
                                    {foreach from=$gateways key=gatewayid item=paymethod}
                                    
                                        <option value="{$gatewayid}"{if $invoice.payment_module == $gatewayid} selected="selected"{elseif $default_payment==$gatewayid}selected="selected"{/if} >{$paymethod}</option>
                                    {/foreach}
                                    <option value="new" style="font-weight: bold">{$lang.newgateway}</option>
                                </select>
                            </td>

                            <td width="100" align="right" class="light">{$lang.currency}:</td>
                            <td width="200">
                                <select name="invoice[currency_id]" {if $block_invoice}disabled{/if}>
                                    {foreach from=$currencies item=curr}
                                        <option value="{$curr.id}"{if $invoice.currency_id == $curr.id}selected="selected"{/if} >{$curr.iso}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            {if !$is_recurring  && $invoice.status!='Creditnote' && $invoice.status!='CreditnoteDraft'}
                                <td width="100" align="right"  class="light">{$lang.duedate}:</td>
                                <td width="200" align="left">
                                    <input type="text" name="invoice[duedate]" value="{$invoice.duedate|dateformat:$date_format}" {if $block_invoice}disabled{else}class="haspicker"{/if}/>
                                </td>
                            {/if}

                            <td width="100" align="right" class="light">{$lang.taxlevel1}:</td>
                            <td width="200" align="left">
                                <input type="text" name="invoice[taxrate]" size="7"
                                       value="{$invoice.taxrate}" disabled /> %</td>

                            {if !$is_recurring}
                                <td width="100" align="right" class="light">{if "config:Invoice2ndcurrency:1"|checkcondition }1st currency rate{else}Currency rate{/if}:</td>
                                <td width="200">
                                    <input type="text" name="invoice[rate]" size="7" value="{$invoice.rate}" {if $block_invoice}disabled{/if}/>
                                </td>
                            {/if}

                        </tr>
                        <tr>
                            {if !$is_recurring  && $invoice.status!='Creditnote' && $invoice.status!='CreditnoteDraft'}
                                <td width="100" align="right"  class="light">Pay Before:</td>
                                <td width="200" align="left">
                                    <input type="text" name="invoice[paybefore]" value="{$invoice.paybefore|dateformat:$date_format}" {if $block_invoice}disabled{else}class="haspicker"{/if}/>
                                </td>
                            {/if}

                            <td width="100" align="right" class="light">{$lang.taxlevel2}:</td>
                            <td width="200" align="left" >
                                <input type="text" name="invoice[taxrate2]" size="7"
                                       value="{$invoice.taxrate2}" {if $block_invoice}disabled{/if}/> %</td>

                            {if !$is_recurring && "config:Invoice2ndcurrency:1"|checkcondition }
                                <td width="100" align="right" class="light">2nd currency rate:</td>
                                <td width="200">
                                    <input type="text" name="invoice[rate2]" size="7" value="{$invoice.rate2}" {if $block_invoice}disabled{/if}/>
                                </td>
                            {/if}

                        </tr>
                        <tr>
                            {if !$is_recurring}
                                <td width="100" align="right"  class="light">{$lang.Amount}:</td>
                                <td width="200" align="left" >
                                    <strong class="invoice-total">{$invoice.grandtotal|price:$currency}</strong>
                                </td>
                            {/if}

                            {if $invoice.status!='Creditnote' && $invoice.status!='CreditnoteDraft' && $invoice.status!='Receiptpaid' && $invoice.status!='Receiptunpaid'}
                                <td width="100" align="right" class="light">{$lang.Credit}:</td>
                                <td width="200" align="left" colspan="2">
                                    <input type="text" name="invoice[credit]" size="7" value="{$invoice.credit}" {if $block_invoice}disabled{/if}/>
                                </td>
                            {/if}

                        </tr>
                        <tr>
                            {if !$is_recurring}
                                <td width="100" align="right" class="light">{$lang.balance}</td>
                                <td width="200" align="left" class="invoice-balance">{$balance|price:$currency}</td>
                            {/if}

                        </tr>
                        {if !$block_invoice}
                            {if !$is_recurring && $invoice.status!='Draft' && $allowclientedits}
                                <tr>
                                    <td  align="left" colspan="2">
                                        <a href="#" class="editbtn" id="updateclietndetails">{$lang.setcurrentclient}</a>
                                    </td>
                                </tr>
                            {/if}
                        {/if}
                    </table>
                </div>
                <div class="clear"></div>
                <input type="submit" value="{$lang.savechanges}" id="savedetailsform" style="display:none"/>
                {securitytoken}
            </form>
        </div>
    {/if}
</div>
