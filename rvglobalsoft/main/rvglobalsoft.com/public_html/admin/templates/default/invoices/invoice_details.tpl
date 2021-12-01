{if $invoice.status == 'Recurring' || $status == 'Recurring'}
    {assign value=true var=is_recurring}
{/if}

<strong class="clientmsg">{$lang.Client}:
    <a href="?cmd=clients&action=show&id={$invoice.client_id}">{$invoice.client.lastname} {$invoice.client.firstname}</a>
    {if $admindata.access.loginAsClient}
    <a class="menuitm"  href="{$system_url}?action=adminlogin&id={$invoice.client_id}" target="_blank"><span ><strong>Login as client</strong></span></a>
    {/if}
</strong>

{if $invoice.status!='Draft' && !$invoice.readonly}
    <div class="right replybtn tdetail {if ! isset($admindata.access.editInvoices)}isForbidAccess{/if} ">
        <strong>
            <a href="#">
                <span class="a1" onclick="editHideInvoice(1);" >{$lang.editdetails}</span>
                <span class="a2" onclick="editHideInvoice(0);" >{$lang.hidedetails}</span>
            </a>
        </strong>
    </div>
{/if}

{if $invoice.status == 'Creditnote' && !$invoice.client_id}
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
    <div class="right">{$lang.Paid}: {$invoice.datepaid|date_format:'%d %b %Y'}&nbsp;&nbsp;&nbsp;</div>
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
                            <td width="200" align="left"><span class="{if !$block_invoice}livemode{/if}">{$invoice.recurring.start_from|dateformat:'%d %b %Y'}</span></td>
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
                            <td colspan="2" class="fs11"><a href="?cmd=invoices&list=all&filter[recurring_id]={$invoice.recurring_id}" target="_blank">{$lang.find_relatedinv}</a></td>
                        </tr>
                    </table>
                </div>

                <div class="left">
                    <table border="0" width="250" cellspacing="3" cellpadding="0">
                        <tr>
                            <td width="100" align="right" class="light">{$lang.next_invoice}: </td>
                            <td width="200" align="left"><span class="{if !$block_invoice}livemode{/if}">{$invoice.recurring.next_invoice|dateformat:'%d %b %Y'}</span></td>
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
                        <td rowspan="6">
                            <div>
                                <span><label style="width:130px; display:block; float:left; clear: left;">Billing Address:</label> {$invoiceAddress}</span><br />
                                <span><label style="width:130px; display:block; float:left; clear: left;">Mailing Address:</label> {$mailingAddress}</span><br />
                                <span><label style="width:130px; display:block; float:left; clear: left;">Client Address:</label> {$clientAddress}</span><br />
                            </div>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>

                    <tr>
                        {if !$is_recurring} 
                            <td width="100" align="right" class="light">{$lang.invoicedate}:</td>
                            <td width="200" align="left"><span class="{if !$block_invoice}livemode{/if}">
                                    {if $proforma && $invoice.paid_id!='' && $invoice.status!='Creditnote'}
                                        {$invoice.datepaid|date_format:'%d %b %Y'}
                                    {else}
                                        {$invoice.date|date_format:'%d %b %Y'}
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
                                {if $invoice.is_netway}
                                <br /><b>pay to Netway</b>
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
                        {if !$is_recurring && $invoice.status!='Creditnote'} 
                            <td width="100" align="right"  class="light">{$lang.duedate}:</td>
                            <td width="200" align="left">
                                <span class="{if !$block_invoice}livemode{/if}">{$invoice.duedate|date_format:'%d %b %Y'}</span>
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
                        {if !$is_recurring && $invoice.status!='Creditnote'}  
                            <td width="100" align="right"  class="light">Pay Before:</td>
                            <td width="200" align="left">
                                <span class="{if !$block_invoice}livemode{/if}">{$invoice.paybefore|date_format:'%d %b %Y'}</span>
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

                        {if $invoice.status!='Creditnote'  && $invoice.status!='Receiptpaid' && $invoice.status!='Receiptunpaid'}
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



            <div>
                <div class="ticketmsg ticketmain" style="width: 250px; display: block; float: left;">
                    <div>
                        <div><b>ตั้งค่า</b></div>
                        <div style="background-color: #FFFFFF; padding: 5px;">

                            {if $invoice.status == 'Paid' && ! $invoice.is_netway}
                            <input type="checkbox" name="is_netway" id="is_netway" value="1" onclick="{literal} if (confirm('ยืนยันว่าเป็นการจ่ายให้ Netway?')) { 
                                $.post('?cmd=invoicehandle&action=setPayToNetway&invoiceId={/literal}{$invoice.id}{literal}', function (data) {
                                    document.location = '?cmd=invoices&action=edit&id={/literal}{$invoice.id}{literal}';
                                }); 
                                } else { return false; } {/literal}" />
                                ตั้งว่าจ่ายให้ Netway
                            {/if}

                        </div>
                    </div>
                </div>
            </div>

            <div class="clear"></div>
        </div>
    {/if}

    {if !$invoice.readonly}
        <div class="secondtd invoice-edit {$invoice.status}" style="display: none;" >
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
                                           readonly="readonly"
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
                                    <select name="invoice[recurring][frequency]" onchange="if($(this).val() == 'em')$('#recurring_start_date').val('{$curdate|dateformat:"Y-m-t"|dateformat:$date_format}').trigger('change');">
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
                                    <td colspan="2" class="fs11"><a href="?cmd=invoices&list=all&filter[recurring_id]={$invoice.recurring_id}" target="_blank">{$lang.find_relatedinv}</a></td>
                                </tr>
                            {/if}
                        </table>
                    </div>
                    {if $invoice.status!='Draft'}
                        <div class="left">
                            <table border="0" width="250" cellspacing="3" cellpadding="0">
                                <tr>
                                    <td width="100" align="right" class="light">{$lang.next_invoice}:</td>
                                    <td width="200" align="left"><input type="text" name="invoice[recurring][next_invoice]" value="{$invoice.recurring.next_invoice|dateformat:$date_format}" class="haspicker" id="recurring_next_invoice" readonly="readonly" /></td>
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
                                    {if $proforma && $invoice.paid_id!='' && $invoice.status!='Creditnote'}

                                        <input type="text" name="invoice[datepaid]" value="{$invoice.datepaid|dateformat:$date_format}" placeholder="{$invoice.datepaid|dateformat:'%d %b %Y'}" {if $block_invoice}disabled{else}class="haspicker"{/if} readonly="readonly" />
                                    {else}
                                        <input type="text" name="invoice[date]" value="{$invoice.date|dateformat:$date_format}" placeholder="{$invoice.date|dateformat:'%d %b %Y'}" {if $block_invoice}disabled{else}class="haspicker"{/if} readonly="readonly" />
                                    {/if}
                                </td>
                            {/if}

                            <td width="100" align="right" class="light">{$lang.Gateway}:</td>
                            <td width="200" align="left" >
                                <select name="invoice[payment_module]"  onclick="new_gateway(this)">
                                    <option value="0" >{$lang.none}</option>
                                    {foreach from=$gateways key=gatewayid item=paymethod}
                                        <option value="{$gatewayid}"{if $invoice.payment_module == $gatewayid} selected="selected"{/if} >{$paymethod}</option>
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
                            {if !$is_recurring  && $invoice.status!='Creditnote'}   
                                <td width="100" align="right"  class="light">{$lang.duedate}:</td>
                                <td width="200" align="left">
                                    <input type="text" name="invoice[duedate]" value="{$invoice.duedate|dateformat:$date_format}" {if $block_invoice}disabled{else}class="haspicker"{/if}/>
                                </td>
                            {/if}

                            <td width="100" align="right" class="light">{$lang.taxlevel1}:</td>
                            <td width="200" align="left"><input type="text" name="invoice[taxrate]" size="7" value="{$invoice.taxrate}" {if $block_invoice}disabled{/if}/> %</td>

                            {if !$is_recurring}
                                <td width="100" align="right" class="light">{if "config:Invoice2ndcurrency:1"|checkcondition }1st currency rate{else}Currency rate{/if}:</td>
                                <td width="200">
                                    <input type="text" name="invoice[rate]" size="7" value="{$invoice.rate}" {if $block_invoice}disabled{/if}/>
                                </td>
                            {/if}

                        </tr>
                        <tr>
                            {if !$is_recurring  && $invoice.status!='Creditnote'}   
                                <td width="100" align="right"  class="light">Pay Before:</td>
                                <td width="200" align="left">
                                    <input type="text" name="invoice[paybefore]" value="{$invoice.paybefore|dateformat:$date_format}" {if $block_invoice}disabled{else}class="haspicker"{/if}/>
                                </td>
                            {/if}

                            <td width="100" align="right" class="light">{$lang.taxlevel2}:</td>
                            <td width="200" align="left" ><input type="text" name="invoice[taxrate2]" size="7" value="{$invoice.taxrate2}" {if $block_invoice}disabled{/if}/> %</td>

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

                            {if $invoice.status!='Creditnote' && $invoice.status!='Receiptpaid' && $invoice.status!='Receiptunpaid'}
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
                
                <div align="center">
                    <a href="#save" onclick="editInvoiceSave();" class="btn btn-success btn-sm" data-confirm="yes">{$lang.savechanges}</a>
                </div>
                
                <input type="submit" value="{$lang.savechanges}" id="savedetailsform" style="display:none"/>
                {securitytoken}
            </form>
        </div>
    {/if}
</div>
