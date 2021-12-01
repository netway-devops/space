<script type="text/javascript">
    var gatewayid = "{php}echo$_REQUEST[gateway_id];{/php}"; 
    if(gatewayid==''){literal}{{/literal}
        gatewayid = "{$paygateid}";
    {literal}}{/literal}
</script>

<div id="editcreditcard" style="display:none;">
	{php}
$templatePath   = $this->get_template_vars('template_path');
include(dirname($templatePath) . '/orderpages/addcreditcard.tpl.php');
{/php}
	<div class="clear"></div>
	<a href="javascript:void(0);"onclick="saveCreditCard();" data-toggle="modal" class="custom-large-btn green-custom-btn btn" >{$lang.change}</a>&nbsp;
 	<a href="javascript:void(0);"onclick="$('#editcreditcard').hide();$('#displaycreditcard').show();" data-toggle="modal" class="custom-large-btn red-custom-btn btn bold" >{$lang.cancel}</a>&nbsp;
	<div class="clear"></div>
</div>

<script type="text/javascript">
   
    function saveCreditCard(){literal}{{/literal}
    
    data = {literal}{{/literal}
            cardtype: $('#field_credit_type').val(),
            cardnum: $('#field_credit_number').val(),
            expirymonth: $('#field_expirymonth').val(), 
            expiryyear: $('#field_expiryyear').val(),
            addcard: 'ok'
   {literal}}{/literal};
    
        $.ajax({literal}{{/literal}
                   type: 'POST',
                   url: '?/clientarea/ccard/',
                   data: data,
                   success: function(data) {literal}{{/literal}
                   
                   $.post("?cmd=cc_modify&action=updatecc&cardholder="+$('#field_credit_holder').val()+"&cardcvv="+$('#field_credit_cvv').val(), false, function(data){literal}{{/literal}
                        ajax_update('?cmd=cart&action=getgatewayhtml&gateway_id='+gatewayid, '', '#gatewayform',true)
                   {literal}}{/literal});
                   
                   {literal}}{/literal},
                   
                   error: function(xhr,error) {literal}{{/literal}
                        respError = $.parseJSON(xhr.responseText);
                        alert( "Whois API connection has error!! " + respError.message);
                   {literal}}{/literal}
         {literal}}{/literal});

    {literal}}{/literal}
</script>


{literal}<style type="text/css">
    #onestepcontainer #gatewayform .wbox {
        border:none;
    }
    #onestepcontainer #gatewayform .wbox_header {
        border:none;
        margin:0px;
        background:none;
        padding:0px;
        font-size:17px;
        letter-spacing: -1px;
        text-transform: lowercase;
    }
    #onestepcontainer #gatewayform .wbox_content {
        border-radius:4px 4px 4px 4px;
        border:1px solid #D2D2D2;
    }
    .credit_card {
        display:block;
        width:32px;
        height:32px;
        background-image: url('templates/orderpages/images/credit_cards.png');
        background-repeat:no-repeat;
        float:left;
        margin-right:10px;
    }
    .amex {
        background-position: -32px 0px;
    }
    .amex.offcard {
        background-position: -32px -32px !important;
    }
    .Visa {
        background-position: -64px 0px;
    }
    .Visa.offcard {
        background-position: -64px -32px !important;
    }
    .Discover {
        background-position: 0px 0px;
    }
    .Discover.offcard {
        background-position: 0px -32px !important;
    }
    .MasterCard {
        background-position: -96px 0px;
    }
    .MasterCard.offcard {
        background-position: -96px -32px !important;
    }

    .ccform label {
        margin-bottom:4px;
        clear:both;
        display:block;
    }
    .cfitm {
        padding:5px 10px 5px;
    }
    .citm {
        padding:5px;
        width: 280px;
    }


</style>

{/literal}
<div id="displaycreditcard">
<div class="wbox">
    <div class="wbox_header">
        <strong>{$lang.ccarddetails}</strong>
    </div>
    <div class="wbox_content ccform">
         <div class="left cfitm">
            <label for="field_credit_number">Card Holder Name</label>
            <b><span id="getcardholder"></span></b>
        </div>
        <div class="left cfitm">
            <label for="field_credit_number">{$lang.ccardnum}</label>
            <b>{$creditcard.cardnum}</b>
        </div>

        <div class="left cfitm" style="padding-bottom:3px">
            <label for="field_credit_number">{$lang.ccardexp}</label>
            <b>{$creditcard.expdate}</b>
        </div>
        <div class="left cfitm" style="display:none;">
            <label for="field_credit_number">CVV2</label>
            <input type="hidden" id="field_credit_number" class="styled" name="cc[cvv]" style="width:50px" value="999" autocomplete="off" />
        </div>
        <div class="left cfitm" id="card_types">
             <label for="field_credit_number">&nbsp;</label>
            <div class="credit_card {$creditcard.cardtype}"></div>
            <div class="clear"></div>
        </div>

		<div class="clear"></div>
		<a href="javascript:void(0);"onclick="$('#editcreditcard').show();$('#displaycreditcard').hide();" data-toggle="modal" class="custom-large-btn green-custom-btn btn" >{$lang.change}</a>&nbsp;
        <div class="clear"></div>
        <div class="clear"></div>
        <br><br>
         <div  >
              
                Your Credit Card Subscription will be in action in the next 1 - 24 hours. <br><br>
                You can take the license active faster than above by paying manually first.<br><br>
                “<b>Checkout</b> to complete Credit Card Subscription.Then go to <a href="https://rvglobalsoft.com/clientarea/invoices/" target="_blank" >invoice</a> page and click the “Pending” invoice to continue the payment. <br><br>
                Once your first invoice was paid, your credit card subscription will be started in the next invoice.
            
        </div>


    </div>
</div>
  
</div>            
<script type="text/javascript">
    getCreditCard();
    function getCreditCard() {literal}{{/literal}
        $.post("?cmd=cc_modify&action=getcc&id={$details.id}", false, function(data){literal}{{/literal}
            var aResponse = data.aResponse;
            $('#getcardholder').html(aResponse.cardholder);
        {literal}}{/literal});
    {literal}}{/literal}
    
</script>
