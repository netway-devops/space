$(function(){ 
   if($('#client_nav > div.left').length) {
       var modname = 'authorizationhandle'; //enter your modname here 
       var module = 'Authorization'; //enter your nice module name here
       var client_id = $('#client_nav a:last').attr('href').split('=').pop(); //getting client id from current page
       var action = 'customtab'; // we will make ajax call into "modname(example)" module using action=customtab
       
       var accountId = $('#client_nav a:contains(\'Account Log\')').attr('href').split('=').pop(); //getting client id from current page
       if (accountId == '') {
           return;
       }
       $('#client_nav > div.left a:last').after('<a class="nav_el left" href="?cmd='+modname+'&action='+action+'&client_id='+client_id+'&accountId='+ accountId +'" onclick="return false">'+module+'</a>'); 
       $('#client_tab').append('<div class="slide" style="display: none;">Loading</div>');
       
       $('#client_tab').append('<div class="slide" style="display: none;">Loading</div>'); /* --- bug fix --- */
   }
});