$(document).ready(function () {
	var noticAlert	= $('button[data-dismiss="alert"]');
	if (noticAlert.length) { 
		noticAlert.click(function() { $(this).parent().hide(); });
		noticAlert.parent().fadeOut(3000); 
	}
});

function bankinfoBlind ()
{
	
	$('.tdetail a').unbind('click').click(function () {
		return $('.secondtd').toggle(),
		$('.tdetails').toggle(),
		$('.a1').toggle(),
		$('.a2').toggle(),
		!1
	});
	
	
	$('.livemode', '#bodycont').unbind("mouseenter mouseleave").hover(function () {
		$(this).append('<a href="#" onclick="return false;" class="manuedit">Edit</a>')
	},
	function () {
		$(this).find('.manuedit').remove()
	}).click(function () {
		$('#tdetail a').click()
	});
	
}