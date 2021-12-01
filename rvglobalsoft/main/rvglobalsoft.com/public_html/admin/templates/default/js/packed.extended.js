$(document).ready(function() { 
	forbidAccessBlock();
	
	// Hostbill smart search #smarts
	$('#smarts2').SmartSearch({
		target		: '#smartres2',
		submitel	: '#search_submiter2',
		url			: '?cmd=searchhandle&lightweight=1',
		results		: '#smartres-results2',
		container	: '#search_form_container2'
	});
	
	$('#smartres2').watch('display', function(){
		if ( $(this).is(':visible') ) {
			$('#smartres-results').append($('#smartres-results2').html());
			$('#smartres').fadeIn('fast', function() {
				$(document).click(function (event) {
					var $target = $(event.target);
					if( $target.is('a') || $target.parent().is('a') ) {
						if ($target.parent().is('a')) {
							$target	= $target.parent();
						}
						var w = window.open($target.attr('href'), "_blank");
					}
					$(document).unbind('click');
					$('#smartres').fadeOut('fast', function () { 
						$('#smartres-results').html('');
					});
					return false;
				});
			});
			$(this).hide();
		}
	});
	
	$('#smarts').keypress(function(event){
		$('#smarts2').val($('#smarts').val());
		if ( event.which == 13 ) {
			$('#search_submiter2').click();
		}
	});
	
	$('.ui-tooltips').tipTip({delay:100});

});

function forbidAccessBlock ()
{
	$('.isForbidAccess').block({ 
		message		: 'Disable', 
		css			: { 
			color: '#D1524C', textAlign: 'right',  width: '96%', border: '0px', 
			backgroundColor: 'rgba(255, 255, 255, 0)'
		},
		overlayCSS	: {
			backgroundColor: 'rgba(25, 25, 25, .7)'
		}
	}); 
}


function extendedQuerySmartsValue (query)
{
	return '%' + query + '%';
}


function editHideInvoice (edit)
{
    if (edit) {
        $('#invoice-details .invoice-edit.tdetails').hide();
        $('#invoice-details .invoice-edit.secondtd').show();
    } else {
        $('#invoice-details .invoice-edit.tdetails').show();
        $('#invoice-details .invoice-edit.secondtd').hide();
    }
}

function editInvoiceSave ()
{
    $('#invoice-actions a[href="#save"]').trigger('click');
    
}

function addInvoiceItemManual (invoiceId)
{
    $.post('?cmd=invoicehandle&action=addItemManual&invoiceId='+ invoiceId, $('#itemsform').serialize(), function (data) {
        $('#invoice-actions a[href="#save"]').trigger('click');
    });
}
