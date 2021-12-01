{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.taxnumber.tpl.php');
{/php}

{if $view == 'taxnumber'}
<div id="manageTaxnumber" class="searchbox">
	<div class="editline text-align:right" id="tax_number_line">
		<span id="taxNumber" class="line_descr" style="display:inline">Next SOD number : <strong>{$nwSODNumber}</strong></span>
		{if isset($admindata.access.specialEdittaxnumber)}<a class="editbtn" style="display:none;" href="#" >{$lang.Edit}</a>{/if}
		<div style="display:none" class="editor-line">
		    <input type="number" maxlength="3" value="{$nwSODNumber}" style="font-size:14px;font-weight:bold;" />
		    <a class="savebtn" href="#" >{$lang.savechanges}</a>
		</div>
	</div>
</div>
<script language="JavaScript">
{literal}
$(document).ready(function () {
    $('#manageTaxnumber .editline').unbind('mouseenter mouseleave').hover(function () {
        $(this).hasClass('editable1') || $(this).find('.editbtn').show();
    },
    function () {
        $(this).find('.editbtn').hide();
    }).find('.editbtn').unbind('click').click(function () {
        var a = $(this).parent();
        a.find('input').height(a.find('.line_descr').height());
        a.addClass('editable1').children().hide();
        a.find('.editor-line').show().find('input').focus();
        return false;
    });
    $('#tax_number_line .savebtn').unbind('click').click(function () {
        var b = $(this).parent().parent();
		var v = parseInt(b.find('input').val());
		//var pad = '000';
		//var vf = (pad+v).slice(-pad.length);
        b.find('#taxNumber strong').html(v);
		b.find('#taxNumber').show();
        b.removeClass('editable1').find('.editor-line').hide();
        $.post('?cmd=configurationhandle&action=update', {
            nwConfig   : {$nwSODNumber: v}
        },
        function (a) {
            parse_response(a)
        });
        return false;
    });
});
{/literal}
</script>
{/if}


{if $view == 'invoicenumber'}
<div id="manageInvoiceNumber">
    <div class="{if $invoice.invoice_number != ''}editline{/if}" id="invoice_number_line" style="display:block;float:left">
        <span id="invoiceNumber" class="line_descr" style="display:inline">Sale Order: 
		    <strong>
		    	{if $invoice.invoice_number == ''}
				    -
					&nbsp;
					{if isset($admindata.access.specialEdittaxnumber)}
                    <a class="menuitm " id="choice" onclick="return false;" href="#">
                    <span class="morbtn"><strong>เลือกประเภท</strong></span> 
                    </a>

                    <ul id="choiceTax" class="contextMenu" style="top: 191.5px;left: 530.859px;">
                        <li>
                           <a id="addInvoiceNumber" class="menuitm" href="{$admin_url}?cmd=invoicehandle&action=addtaxinvoice&id={$invoice.id}" style="color: #2d2d2d;font-size: 12px;">
                                ประเภท SO
                           </a>
                        </li>
                        <li>
                            <a id="upInvoiceNumber" class="menuitm" href="{$admin_url}?cmd=invoicehandle&action=updatetaxinvoice&invoiceNumber=HRxxxx-xxxx&invoiceId={$invoice.id}" style="color: #2d2d2d;font-size: 12px;">
                                ประเภท HR
                            </a>
                        </li>
                    </ul>
					<!--<a id="addInvoiceNumber" class="menuitm" href="{$admin_url}?cmd=invoicehandle&action=addtaxinvoice&id={$invoice.id}"><span class="addsth"><strong>ออกใบกำกับภาษีทันที</strong></span></a>-->
					{/if}
                    
				{else}
				    {$invoice.invoice_number}
				{/if}
			</strong>
		</span>
        {if isset($admindata.access.specialEdittaxnumber)}<a class="editbtn" style="display:none;" href="#" >{$lang.Edit}</a>{/if}
        <div style="display:none" class="editor-line">
            ใบกำกับภาษี: <input type="text" value="{$invoice.invoice_number}" style="font-size:14px;font-weight:bold;" />
            <a class="savebtn" href="#" >{$lang.savechanges}</a>
        </div>
    </div>
    {if $invoice.invoice_number != ''}
        {if isset($admindata.access.specialEdittaxnumber) && $showCreateSODButton == true}
    <div style="display:block;float:left">
        &nbsp;
        <a class="menuitm " id="createSalesOrder" href="{$admin_url}?cmd=invoicehandle&action=createSalesOrder&id={$invoice.id}"><span class="addsth"><strong>สร้าง Sale Order</strong></span></a>
    </div>
      	{/if}
    {/if}


    <div class="{if $invoice.sim_number != ''}editline{/if}" id="sim_number_line" style="display:block;float:left">
        <span id="simNumber" class="line_descr" style="display:inline"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ใบกำกับภาษี: 
		    <strong>
		    	{if $invoice.sim_number == ''}
				    -
					&nbsp;
					{if isset($admindata.access.specialEdittaxnumber)}
                    <a class="menuitm " id="addSimNumber" href="{$admin_url}?cmd=invoicehandle&action=addsiminvoice&id={$invoice.id}"><span class="addsth"><strong>ออกใบกำกับภาษีทันที</strong></span></a>
					{/if}
                    
				{else}
				    {$invoice.sim_number}
				{/if}
			</strong>
		</span>
        {if isset($admindata.access.specialEdittaxnumber)}<a class="editbtn" style="display:none;" href="#" >{$lang.Edit}</a>{/if}
        <div style="display:none" class="editor-line">
            ใบกำกับภาษี: <input type="text" value="{$invoice.sim_number}" style="font-size:14px;font-weight:bold;" />
            <a class="savebtn" href="#" >{$lang.savechanges}</a>
        </div>
    </div>

</div>

<script language="JavaScript">
{literal}
$(document).ready(function () {
    $('#manageInvoiceNumber .editline').unbind('mouseenter mouseleave').hover(function () {
        $(this).hasClass('editable1') || $(this).find('.editbtn').show();
    },
    function () {
        $(this).find('.editbtn').hide();
    }).find('.editbtn').unbind('click').click(function () {
        var a = $(this).parent();
        a.find('input').height(a.find('.line_descr').height());
        a.addClass('editable1').children().hide();
        a.find('.editor-line').show().find('input').focus();
        return false;
    });
    $('#invoice_number_line .savebtn').unbind('click').click(function () {
        var b = $(this).parent().parent();
        var v = b.find('input').val();
        b.find('#invoiceNumber strong').html(v);
        b.find('#invoiceNumber').show();
        b.removeClass('editable1').find('.editor-line').hide();
        $.post('?cmd=invoicehandle&action=updatetaxinvoice', {
            invoiceNumber   : v,
			invoiceId       : {/literal}{$invoice.id}{literal}
        },
        function (a) {
            parse_response(a)
        });
        return false;
    });

    $('#choice').focus(function() {
        $(this).addClass("activated");
        $('#choiceTax').css("display", "block");
    });

	$('#addInvoiceNumber').unbind('click').click(function () {
		$.get($(this).attr('href'), function(a) {
			//var codes = eval("(" + a.substr(a.indexOf("<!-- ") + 4, a.indexOf("-->") - 4) + ")");
			parse_response(a)
		});
		setTimeout(function(){
			location.reload();
		},1000);
		return false;
	});
    $('#upInvoiceNumber, #upInvoiceNumberSIM, #upInvoiceNumberRE').unbind('click').click(function () {
		$.get($(this).attr('href'), function(a) {
			//var codes = eval("(" + a.substr(a.indexOf("<!-- ") + 4, a.indexOf("-->") - 4) + ")");
			parse_response(a)
		});
		setTimeout(function(){
			location.reload();
		},1000);
		return false;
	});

    $('#createSalesOrder').unbind('click').click(function () {
		$.get($(this).attr('href'), function(data) {
			parse_response_json(data);
		});
		setTimeout(function(){
			location.reload();
		},1000);
		return false;
	});

	$('#addSimNumber').unbind('click').click(function () {
		$.get($(this).attr('href'), function(data) {
			parse_response_json(data);
		});
		setTimeout(function(){
			location.reload();
		},1000);
		return false;
	});
    $('#sim_number_line .savebtn').unbind('click').click(function () {
        var b = $(this).parent().parent();
        var v = b.find('input').val();
        b.find('#simNumber strong').html(v);
        b.find('#simNumber').show();
        b.removeClass('editable1').find('.editor-line').hide();
        $.post('?cmd=invoicehandle&action=updatesiminvoice', {
            simNumber       : v,
			invoiceId       : {/literal}{$invoice.id}{literal}
        },
        function (data) {
            parse_response_json(data)
        });
        return false;
    });

});
{/literal}
</script>
{/if}

