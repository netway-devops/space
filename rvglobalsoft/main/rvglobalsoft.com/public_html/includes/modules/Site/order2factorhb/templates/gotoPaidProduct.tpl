{literal} 
<script type="text/javascript">
     var url = '{/literal}{$system_url}{literal}';
   
       
    var querystring = '{/literal}{$querystring}{literal}';
  
    clearCart();
    addPaidServiceAndGoToStep4(querystring);
   
    function clearCart(){
        //var clearurl = url + "index.php/cart&cart=clear&order=0";
        var clearurl = url + "cart&cart=clear&order=0";
        $.post(clearurl,function(data){
            
        });
    }

    function addPaidServiceAndGoToStep4(querystring){
        //var urlStep3 = url+'index.php/cart/&step=3&'+querystring;
        //var urlStep4 = url+'index.php/cart/&step=4';
        var urlStep3 = url+'cart/&step=3&'+querystring;
        var urlStep4 = url+'cart/&step=4';
        $.post(urlStep3,function(data){
            window.location.assign(urlStep4);
        });
    }
  
</script>
{/literal} 