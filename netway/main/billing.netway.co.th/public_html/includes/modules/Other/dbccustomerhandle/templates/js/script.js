$(function(){ 
   if($('#client_nav > div.left').length) {
       var modname = 'dbccustomerhandle'; //enter your modname here 
       var module = 'Customer'; //enter your nice module name here
       var client_id = $('#client_nav a:last').attr('href').split('=').pop(); //getting client id from current page
       var action = 'customtab'; // we will make ajax call into "modname(example)" module using action=customtab
       $('#client_nav > div.left #quickListCustomer').after('<a class="nav_el left" href="?cmd='+modname+'&action='+action+'&client_id='+client_id+'" onclick="return false">'+module+'</a>'); 
       $('#client_tab').append('<div class="slide" style="display: none;">Loading</div>'); 
   }
});