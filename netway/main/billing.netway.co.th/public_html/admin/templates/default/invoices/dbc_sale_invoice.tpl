{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . '/invoices/dbc_sale_invoice.tpl.php');
{/php}
{literal}
<style>
.show-dbc-product{
    font-size: 12px;
    margin-bottom: 20px;
    margin-top: 7px; 
}
.show-dbc-product th{
    padding: 10px;
    text-align: center;
}
.show-dbc-product th{
    background: #f0f0f0;
    border: none;
    border-top: 1px solid #eee;
    font-weight: 700;
    margin: 0;
}
.show-dbc-product td {
    padding: 5px 11px 2px 0px;
    text-align: center;
}
.show-dbc-product tr.line{
    border-bottom: 1px solid #eee;
}
input[type=text]{
    text-align:center;
}
</style>
{/literal}

<div class="ticketmsg ticketmain" style="width: 100%; display: block; float: left;" id="saleinvoicescetion">
    <div>
        <div><b>Sale Invoice</b><span {if $isConnected.is_connect != 1}style="display:none"{/if} id="connectedText"><font color="green"> Connected</font></span></div>
        <div style="background-color: #FFFFFF;">
            <input type="text" name="saleinvoiceid" id="saleinvoiceid" value="{$isConnected.sale_invoice_no}" {if $isConnected.is_connect == 1}disabled{/if}/>
           
            <button id="saleinvoiceconnectbutton" {if $isConnected.is_connect == 1}style="display:none"{/if} style="background: #2d7cb1;color: #fff;">Connect</button>
            <!--{if $isConnected.is_connect == 1}<button id="saleinvoiceconnecteditbutton">แก้ไข</button>{/if}-->
        </div>
        {if $isConnected.is_connect} 
        
        <div>
            <form action="" method="post" id= "importItem" >
            <table class="show-dbc-product text-center" width="100%" border="0" cellpadding="0" cellspacing="0" style="">
                <thead>
                  <tr>
                    <th>TYPE</th>
                    <th>NO.</th>
                    <th>DESCRIPTION</th>
                    <th>QUANTITY</th>
                    <th>UNIT OF MEASURE CODE</th>
                    <th>UNIT PRICE</th>
                    <th>DISCOUNT</th>
                  </tr>
                </thead>
                <tbody>
                     <input type="text" name="invoice_ID" value="{$isConnected.invoice_id}" id="invoice_ID" style="display:none"> 
                 {assign var="line" value="0"}   
                 {foreach from=$item key=catId item=aItem}
                 {assign var=line value=$line+1}
                 {if isset($aItem.dbc_no)}
               
                  <tr >
                    <td>
                        <select id ="lineType" name= "line_{$line}[lineType]">
                             <option value="0" title=""> </option>
                             <option value="1" title="G/L Account">G/L Account</option>
                             <option value="2" title="Item">Item</option>
                             <option value="3" title="Resource">Resource</option>
                             <option value="4" title="Fixed Asset">Fixed Asset</option>
                             <option value="5" title="Charge (Item)">Charge (Item)</option>   
                             <option value="6" title="Comment" >Comment</option>     
                        </select>
                   </td>
                    <td >
                        <input type="text" name="line_{$line}[no]"  value="{$aItem.dbc_no}" style="width: 111px;">
                    </td>
                    <td ><input type="text" name="line_{$line}[description1]" id ="description" value="{$aItem.product_name}" style="width: 205px;margin-right: -37px;"></td>
                    <td ><input type="text" name="line_{$line}[quantity]" id ="quantity" value="{$aItem.quantity}" style="width: 92px;margin-left: 39px;"></td>
                    <td ><input type="text" name="line_{$line}[unitCode]" id ="unitCode" value="{$aItem.code}"style="width: 114px;" disabled></td>
                    <td ><input type="text" name="line_{$line}[unitPrice]" id ="unitPrice" value="{$aItem.unit_price}" disabled ></td>
                    <td ><input type="text" name="line_{$line}[discount]" id ="discount" value="{$aItem.discount_price}"></td>
                </tr>
                <tr>
                 <td>
                      <select id ='lineComment1' name="line_{$line}[lineComment]"disabled>
                             <option value="0" title=""> </option>
                             <option value="1" title="G/L Account">G/L Account</option>
                             <option value="2" title="Item">Item</option>
                             <option value="3" title="Resource">Resource</option>
                             <option value="4" title="Fixed Asset">Fixed Asset</option>
                             <option value="5" title="Charge (Item)">Charge (Item)</option>   
                             <option value="6" title="Comment" selected >Comment</option>     
                        </select>
               </td>
                 <td><input type="text" name="line_{$line}[itemId]" value="{$aItem.dbc_item_id}"  style="display:none"></td>
                    <td><input type="text" name="line_{$line}[description2]" id ="description2" value="{$aItem.domain}"style="width: 205px;margin-right: -37px;"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td><td>
                </tr>
                <tr class="line" >
                 <td>
                    <select id ='lineComment2'disabled>
                         <option value="0" title=""></option>
                         <option value="1" title="G/L Account">G/L Account</option>
                         <option value="2" title="Item">Item</option>
                         <option value="3" title="Resource">Resource</option>
                         <option value="4" title="Fixed Asset">Fixed Asset</option>
                         <option value="5" title="Charge (Item)">Charge (Item)</option>   
                         <option value="6" title="Comment" selected>Comment</option>     
                    </select>
               </td>
               
                 <td></td>
                    <td><input type="text" name="line_{$line}[dueDate]"  value="( {$aItem.date_created} - {$aItem.next_due})"style="width: 205px;margin-right: -37px;"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td><td>
                </tr>
                
                {/if}
                 {/foreach}
               <tr>
                   <td colspan="7">
                    <button id="import"style="background: #2d7cb1;color: #fff;font-size: 15px;">Import</button>
                   </td>
               <tr>
              </tbody>
          </table>
          </form>
        </div>
        {/if}
    </div>
    
</div>

<script type="text/javascript">
{literal}
$(document).ready(function () {
	$('#saleinvoiceconnecteditbutton').click(function(){
		$(this).hide();
		$('#saleinvoiceconnectbutton').show();
        $('#saleinvoiceid').attr('disabled', false);
	});
	
    $('#saleinvoiceconnectbutton').click(function () {
        if($('#saleinvoiceid').val() == ''){
            alert('กรุณากรอก Sale Invoice Number');
            $('#saleinvoiceid').focus();
            return false;
        }else{
        	$('#saleinvoicescetion').addLoader()
            $.post('?cmd=invoicehandle&action=connect_sale_invoice_dbc'
                , {
                    invoiceId:  '{/literal}{$invoice.id}{literal}' ,
                    saleinvoiceid: $('#saleinvoiceid').val()
                  }
                , function(a){
                	var data = a.data
                    console.log(data.connected);
                    if(data.connected == 1){
                    	$('#saleinvoiceconnectbutton').hide();
                    	$('#saleinvoiceid').attr('disabled', true);
                    	$('#connectedText').show();
                    }else{
                    	$('#saleinvoiceid').focus();
                    	$('#saleinvoiceid').select();
                    }
                    alert(data.msg);
                    $('#preloader').remove();
                }
            );
        }
        
    });
    
    $('#import').click(function (e) {
         e.preventDefault();
             $.post('?cmd=invoicehandle&action=get_sale_invoice_items_dbc', $('#importItem').serialize(), 
             function(data){
                   var data = data.data
                   console.log(data);
              });
            
        });
    });    
{/literal}
</script>