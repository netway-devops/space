$(document).ready(function()
{
	$("#firstpane .onClick").click(function()
    {
		$(this).css({backgroundImage:"url(down.png)"}).next(".chlidren").slideToggle(300).siblings(".chlidren").slideUp("slow");
       	$(this).siblings().css({backgroundImage:"url(down.png)"});
	});
});