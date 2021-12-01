<table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <h1>
                {$lang.createinvoice}
            </h1>
        </td>
        <td>
            <h1>

                <span class="{$invoice.status}" id="invoice_status">
                    {if $invoice.metadata.invoicetype=='recurringinvoice'}Recurring{/if}
                    {if $lang[$invoice.status]}
                        {$lang[$invoice.status]}
                    {else}{$invoice.status}
                    {/if}
                </span>
            </h1>
        </td>
</table>

<input type="hidden" id="invoice_id" name="invoice_id" value="{$invoice.id}" />
<input type="hidden" id="currency_id" name="inv_currency_id" value="{$invoice.currency_id}" />
<input type="hidden" id="old_client_id" name="old_client_id" value="{$invoice.client_id}" />

<div id="client_nav">
    <!--navigation-->
    <a class="nav_el nav_sel left" href="#">Draft details</a>
    {if $invoice.client_id} 
        {include file="_common/quicklists.tpl" _client=$invoice.client_id}
    {/if}
    <div class="clear"></div>
</div>

<div class="ticketmsg ticketmain" id="client_tab">
    <div  class="slide" style="display:block">
        {if !$invoice.client_id}
            {assign value=0 var=draftstep}
        {elseif !$invoice.metadata.invoicetype}
            {assign value=1 var=draftstep}
        {else}
            {assign value=2 var=draftstep}
        {/if}
        <ul class="hbnav breadcrumb draft-steps">
            <li class="step {if $draftstep==0}active{/if}">
                <a><span>Select Client</span></a>
            </li>
            <li class="step {if $draftstep==1}active{/if}">
                <a><span>Invoice type</span></a>
            </li>
            <li class="step {if $draftstep==2}active{/if}">
                <a><span>Details</span></a>
            </li>

        </ul>
        <div class="draft-steps-box">

            <div class="draft-step" {if $draftstep==0}style="display:block"{/if}>
                <div id="clientloader">
                    <p>Choose client profile that you want to assign to this invoice.</p>

                    <select style="width: 180px" name="invoice[client_id]" load="clients" default="{$invoice.client_id}">
                        <option value="0">{$lang.selectcustomer}</option>
                    </select>
                    <a  class="menuitm">Continue</a>


                </div>
            </div>
            <div class="draft-step" {if $draftstep==1}style="display:block"{/if}>
                <ul class="invoice-type">
                    <li>
                        <input type="radio" value="standardinvoice" id="standardinvoice" name="invoice[invoicetype]"
                               {if $invoice.metadata.invoicetype=='standardinvoice'}checked{/if}/>
                        <label for="standardinvoice">
                            <h3>{$lang.standardinvoice}</h3>
                            <span>Create new invoice for client that can be issued instantly.</span>
                        </label>
                    </li>
                    <li>
                        <input type="radio" value="recurringinvoice" id="recurringinvoice"  name="invoice[invoicetype]" 
                               {if $invoice.metadata.invoicetype=='recurringinvoice'}checked{/if}/>
                        <label for="recurringinvoice">
                            <h3>{$lang.recurringinvoice}</h3>
                            <span>Create billing template that will be used to automatically generate invoices over time.</span>
                        </label>
                    </li>
                    {if "config:CnoteEnable:on"|checkcondition}
                        <li>
                            <label for="recurringinvoice" onclick="window.location.replace('?cmd=invoices&action=createcreditnote&invoice_id={$invoice.id}');return false;">
                                <h3>{$lang.creditnote}</h3>
                                <span>Issue credit note, document indicating "money out"/"owed to customer"</span>
                            </label>
                        </li>
                    {/if}
                </ul>
            </div>
            <div class="draft-step" {if $draftstep==2}style="display:block"{/if}>
                <div id="detcont">
                    {if $invoice.metadata.invoicetype=='recurringinvoice'}
                        {include file='invoices/invoice_details.tpl' status=Recurring}
                    {else}
                        {include file='invoices/invoice_details.tpl'}
                    {/if}
                </div>
            </div>
        </div>
    </div>
    {include file="_common/quicklists.tpl" _placeholder=true}
</div>


