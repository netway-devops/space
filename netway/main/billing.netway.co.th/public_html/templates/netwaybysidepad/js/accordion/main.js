$(document).ready(function(){

  $('#cssmenu > ul > li:has(ul), #cssmenu365 > ul > li:has(ul), #cssmenu-sm > ul > li:has(ul), #cssmenu-cs > ul > li:has(ul)').addClass("has-sub");

  $('#cssmenu > ul > li > a, #cssmenu365 > ul > li > a, #cssmenu-sm > ul > li > a, #cssmenu-cs > ul > li > a').click(function() {
    var checkElement = $(this).next();
    
    $('#cssmenu li, #cssmenu365 li, #cssmenu-sm li, #cssmenu-cs li').removeClass('active');
    $(this).closest('li').addClass('active');	
    
    
    if((checkElement.is('ul')) && (checkElement.is(':visible'))) {
      $(this).closest('li').removeClass('active');
      checkElement.slideUp('normal');
    }
    
    if((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
      $('#cssmenu ul ul:visible, #cssmenu365 ul ul:visible, #cssmenu-sm ul ul:visible, #cssmenu-cs ul ul:visible').slideUp('normal');
      checkElement.slideDown('normal');
    }
    
    if (checkElement.is('ul')) {
      return false;
    } else {
      return true;	
    }		
  });

});