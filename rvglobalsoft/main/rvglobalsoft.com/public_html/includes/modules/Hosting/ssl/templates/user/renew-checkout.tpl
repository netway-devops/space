{php}
//echo '<pre>';
//print_r($this->get_template_vars());
//echo '</pre>';
{/php}
<div class="wbox">
    <div class="wbox_header">
        <strong>Order Summary</strong>
    </div>
    <style>
        {literal}
        .table td, .table th{
            text-align: center;
        }
        .table td:first-child, .table th:first-child{
            text-align: left;
        }
        {/literal}
    </style>
    <div class="wbox_content">
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker table">
            <tr>
                <th width="55%" align="left">Description</th>
                <th width="20%"> Setup Fee</th>
                <th width="25%">Price</th>
            </tr>
            <tr class="srow">
                <td valign="top">
                    SSL - <span id="summarySSLName"></span>
                </td>
                <td>
                    -
                </td>
                <td>
                    $<span id="summarySSLPrice"></span> USD
                </td>
            </tr>
            {if $priceList.san_amount > 0}
                <tr class="srow">
                    <td vaign="top">
                        Addon Additional Domain Names x <span id="summarySANAmount"></span>
                    </td>
                    <td>
                        -
                    </td>
                    <td>
                        $<span id="summarySAN"></span> USD
                    </td>
                </tr>
            {/if}
            {if $priceList.server_amount > 0}
                <tr class="srow">
                    <td vaign="top">
                        Addon Additional Servers x <span id="summaryServAmount"></span>
                    </td>
                    <td>
                        -
                    </td>
                    <td>
                        $<span id="summaryServer"></span> USD
                    </td>
                </tr>
            {/if}
            <tr>
                <td colspan="3">
                    <a style="color: rgb(0, 153, 0);" href="{$ca_url}/clientarea/services/ssl/{$service.id}&action=renew" class="fs11">
                        [Edit Configuration]
                    </a> 
                    <a style="color: rgb(153, 0, 0);" href="{$ca_url}/clientarea/services/ssl/{$service.id}&action=renew" class="fs11">
                        [Remove]
                    </a> 
                </td>
            </tr>
            <tr>
                <td align="right" colspan="2">Subtotal:</td>
                <td>$<span class="summarySubtotal"></span> USD</td>
            </tr>
            <tr id="summaryDiscount" style="display:none;">
                <td align="right" colspan="2">Discount:</td>
                <td>- $<span id="summaryDiscount_Text"></span> USD</td>
            </tr>
            <tr id="summaryCredit" style="{if !$client_credit}display:none;{/if}">
                <td align="right" colspan="2">Credit:</td>
                <td>$<span id="summaryCredit_Text"></span> USD</td>
            </tr>
            <tr>
                <td align="right" colspan="2">Total Recurring:</td>
                <td> 
                    $<span class="summaryTotalRecurring"></span> USD <span id="summaryCycle"></span><br>
                </td>
            </tr>
            <tr>
                <td align="left" style="border:none">
                </td>
                <td align="right" style="border:none"><strong>Total Due Today:</strong>&nbsp;</td>
                <td style="border:none">
                    <span style="vertical-align: top; font-size: 20px;">$</span>
                    <span class="cart_total"><span class="summaryTotal"></span></span>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="wbox">
    <div class="wbox_header">
        <strong>Choose payment method</strong>
    </div>
    <div class="wbox_content">
        <center>
            {php} $count = 0;{/php}
            {foreach from=$paymentGateway key=moduleNum item=eachPayment}
                <input  type="radio" name="gateway" value="{$moduleNum}"{php}if($count == 0){echo 'checked'; $count = 1;}{/php}> {$eachPayment}
            {/foreach}
        </center>  
    </div>
</div>
<div class="wbox">
    <div class="wbox_header">
        <strong>Client Information</strong>
    </div>
    <div class="wbox_content">
        <!--<table class="table table-striped" width="100%" cellspacing="0" cellpadding="0">-->
        <table width="100%" cellspacing="0" cellpadding="0">
            <tr height="30" class="even">
                <td class="" style="font-weight:bold; height:2.7em;"> 
                    <img src="{$system_url}templates/netwaybysidepad/images/info-arrow.gif" alt="" width="6" height="7" style="margin-right:3px;"> Email Address                            
                </td>
                <td style="color:#05478f;">
                    {$clientDetail.email}
                </td>
                <td class="" style="font-weight:bold; height:2.7em;"> 
                    <img src="{$system_url}templates/netwaybysidepad/images/info-arrow.gif" alt="" width="6" height="7" style="margin-right:3px;"> First Name                            
                </td>
                <td style="color:#05478f;">
                    {$clientDetail.firstname}
                </td>
            </tr>
            <tr height="30">
                <td class="" style="font-weight:bold; height:2.7em;"> 
                    <img src="{$system_url}templates/netwaybysidepad/images/info-arrow.gif" alt="" width="6" height="7" style="margin-right:3px;"> Last Name                            
                </td>
                <td style="color:#05478f;">
                    {$clientDetail.lastname}
                </td>
                <td class="" style="font-weight:bold; height:2.7em;"> 
                    <img src="{$system_url}templates/netwaybysidepad/images/info-arrow.gif" alt="" width="6" height="7" style="margin-right:3px;"> Organization                            
                </td>
                <td style="color:#05478f;">
                    {$clientDetail.companyname}
                </td>
            </tr>
            <tr height="30" class="even">
                <td class="" style="font-weight:bold; height:2.7em;"> 
                    <img src="{$system_url}templates/netwaybysidepad/images/info-arrow.gif" alt="" width="6" height="7" style="margin-right:3px;"> Address 1                            
                </td>
                <td style="color:#05478f;">
                    {$clientDetail.address1}
                </td>
                <td class="" style="font-weight:bold; height:2.7em;"> 
                    <img src="{$system_url}templates/netwaybysidepad/images/info-arrow.gif" alt="" width="6" height="7" style="margin-right:3px;"> Address 2                            
                </td>
                <td style="color:#05478f;">
                    {$clientDetail.address2}
                </td>
            </tr>
            <tr height="30">
                <td class="" style="font-weight:bold; height:2.7em;"> 
                    <img src="{$system_url}templates/netwaybysidepad/images/info-arrow.gif" alt="" width="6" height="7" style="margin-right:3px;"> City                            
                </td>
                <td style="color:#05478f;">
                    {$clientDetail.city}
                </td>
                <td class="" style="font-weight:bold; height:2.7em;"> 
                    <img src="{$system_url}templates/netwaybysidepad/images/info-arrow.gif" alt="" width="6" height="7" style="margin-right:3px;"> State                            
                </td>
                <td style="color:#05478f;">
                    {$clientDetail.state}
                </td>
            </tr>
            <tr height="30" class="even">
                <td class="" style="font-weight:bold; height:2.7em;"> 
                    <img src="{$system_url}templates/netwaybysidepad/images/info-arrow.gif" alt="" width="6" height="7" style="margin-right:3px;"> Postal Code                            
                </td>
                <td style="color:#05478f;">
                    {$clientDetail.postcode}
                </td>
                <td class="" style="font-weight:bold; height:2.7em;"> 
                    <img src="{$system_url}templates/netwaybysidepad/images/info-arrow.gif" alt="" width="6" height="7" style="margin-right:3px;"> Country                            
                </td>
                <td style="color:#05478f;">
                    {$clientDetail.countryname}                                                   
                </td>
            </tr>
            <tr height="30">
                <td class="" style="font-weight:bold; height:2.7em;"> 
                    <img src="{$system_url}templates/netwaybysidepad/images/info-arrow.gif" alt="" width="6" height="7" style="margin-right:3px;"> Phone                            
                </td>
                <td style="color:#05478f;">
                    {$clientDetail.phonenumber}
                </td>
                <td class="" style="font-weight:bold; height:2.7em;"> 
                    <img src="{$system_url}templates/netwaybysidepad/images/info-arrow.gif" alt="" width="6" height="7" style="margin-right:3px;"> Tax ID
                </td>
                <td style="color:#05478f;">
                    {if $clientDetail.taxexempt}{$clientDetail.taxexempt}{/if}
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="wbox">
    <div class="wbox_header">
        <strong>Notes:</strong>
    </div>
    <div class="wbox_content">
        <table border="0" cellpadding="0" cellspacing="6" width="100%">
            <tr>
                <td>
                    <textarea id="c_notes" placeholder="Insert your message here." style="width:98%" rows="3" name="notes"></textarea>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="orderbox" id="checkout">
    <div class="orderboxpadding">
        <center>
            <input type="checkbox" id="tos"> I have read and accepted <a href="{$system_url}{$ca_url}?page/terms-of-service/" target="_blank">Terms of Service</a><a id="er" style="color:red;display:none;">&nbsp;&nbsp;&nbsp;**</a>
            <br /><br />
            <input type="button" value="Checkout" id="CheckOut" class="padded btn  btn-primary" onclick="">
            <input type="button" value="Clear Cart" id="ClearCart" class="padded btn" />
            <input type="hidden" name="orderSummary" id="orderSummary" value="" />
            <input type="hidden" name="productPriceJSON" value='{$priceListJSON}' />
        </center>
    </div>
</div>