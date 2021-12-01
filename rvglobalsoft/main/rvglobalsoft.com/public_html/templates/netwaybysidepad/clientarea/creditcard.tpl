{*

Manage credit card on file, submit new credit card details

*}



<div class="text-block clear clearfix">
    <h5>{$lang.account}</h5>
   
    <div class="clear clearfix">
        <div class="account-box">
        
            {include file='clientarea/leftnavigation.tpl'}
            
            <div class="account-content">
            <div class="content-padding">
            {if $ccard.cardnum}
                <h6>{$lang.creditcardfile}</h6>
            {/if}
            <div class="pt15 clearfix ">
            
            {if $ccard.cardnum}
            <table width="100%" border="0"  cellspacing="0" class="table table-bordered">
                <tr><td align="right" width="160"><b>{$lang.cctype}</b></td><td>{$ccard.cardtype}</td></tr>
                <tr><td align="right" width="160"><b>Card Holder Name</b></td><td id="getcardholder"></td></tr>
                <tr class="even"><td align="right"><b>{$lang.ccnum}</b></td><td>{$ccard.cardnum}</td></tr>
                <tr><td align="right"><b>{$lang.ccexpiry}</b></td><td>{$ccard.expdate}</td></tr>
                <tr><td align="right"><b>CVV</b></td><td>***</td></tr>        
            </table>
            <script type="text/javascript">
                getCreditCard();
                function getCreditCard() {literal}{{/literal}
                    $.post("?cmd=cc_modify&action=getcc&id={$details.id}", false, function(data){literal}{{/literal}
                        var aResponse = data.aResponse;
                        $('#getcardholder').html(aResponse.cardholder);
                    {literal}}{/literal});
                {literal}}{/literal}
            </script>
            <form action="" method="post" style="margin-bottom:0px;">
                <a href="#newccdetails" data-toggle="modal" class="custom-large-btn green-custom-btn btn" >{$lang.changecc}</a>&nbsp;
                {if $allowremove} 
                <button class="custom-large-btn red-custom-btn btn bold" style="font-size:12px;" type="submit" name="removecard" onclick="return confirm('{$lang.removecc_confirm}')"  class="btn btn-danger">
                {$lang.removecc}
                 </button>
                {/if}
                {securitytoken}
             </form>
            
            
            </div>
            {else}
                <div class="center-wrapper">
                    <div class="center-box">
                        <p>{$lang.noccyet}</p>
                        <a href="#newccdetails"  data-toggle="modal" class="custom-large-btn green-custom-btn btn"> + {$lang.newcc} </a>
                    </div> 
                </div>
            {/if}  
                <div id="newccdetails" style="display:none" class="modal">
                    <form action="" id="save_cc_client" name="save_cc_client" method="post" style="margin-bottom:0px;">
        
                    <div class="modal-header">
                        <a href="#" class="close-modal" data-dismiss="modal">×</a>
                        <h3>{$lang.changeccdesc}</h3>
                    </div>
                    <div class="modal-body">
                        <table width="100%" cellpadding="2">
                        <tr><td width="150" >{$lang.cctype}</td><td>
                                <select name="cardtype">
                                    {foreach from=$supportedcc item=cc}
                                    <option>{$cc}</option>
                                    {/foreach}
                                </select>
                            </td></tr>
                            <!-- เวลา client เข้ามาแก้ไข credit card -->
                        <tr><td >Card Holder Name</td><td><span id="forcardname" style="color:red;"></span><input type="text" name="cardholder"id="cardholder" size="25" /></td></tr>
                        <tr><td >{$lang.ccnum}</td><td><input type="text" name="cardnum" value=""size="25" /></td></tr>
                        <tr><td >{$lang.ccexpiry}</td>
                            <td><input type="text" name="expirymonth" size="2" maxlength="2"  class="styled" style="width:30px;" /> /
                                <input type="text" name="expiryyear" size="2" maxlength="2"  class="styled" style="width:30px;"  /> (MM/YY)</td></tr>
                        <tr><td >CVV</td>
                            <td>
                            <span id="forcardcvv" style="color:red;"></span>
                            <input type="text" name="cardcvv"id="cardcvv" size="3" /></td></tr>
                    </table>
                    </div>

                    <div class="modal-footer">
                        <a href="#" class="btn" data-dismiss="modal">{$lang.close}</a>
                        <button type="submit" style="display:none;" name="addcard" id="addcard" class="custom-large-btn green-custom-btn btn">
                        {$lang.savechanges}
                        </button>
                        <button type="button" name="addcard33" id="addcard33" onclick="cc_modify($('#save_cc_client'));"class="custom-large-btn green-custom-btn btn">
                        {$lang.savechanges}
                        </button>
                    </div>
        
                {securitytoken}
            </form>
                    
            </div>                       
            </div>

        </div>
        
        
    </div>
 </div>
 
 
</div>
{literal}
<script type="text/javascript">

   
    function cc_modify(frm) {
        var cardname = $('#cardholder').val();
        var cardcvv = $('#cardcvv').val();
        $('#forcardcvv').html('');
        $('#forcardname').html('');
        if(cardname.trim() == ''){
            $('#forcardname').html('กรุณากรอก Card Holder Name');
            $('#cardname').val('').focus();
            return false;
        }
        if(cardcvv.trim() == ''){
            $('#forcardcvv').html('กรุณากรอก CVV');
            $('#cardcvv').val('').focus();
            return false;
        }
       
        $.post("?cmd=cc_modify&action=updatecc&cardholder="+$('#cardholder').val()+"&cardcvv="+$('#cardcvv').val(), false, function(data){
         
			//$('#addcard33').hide();$('#addcard').show();
			$('#addcard').trigger('click');
        	//frm.submit();
        });
    }
</script>
{/literal}
