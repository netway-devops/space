{literal} 
<script type="text/javascript">
     var url = '{/literal}{$system_url}{literal}';
   
       
        var status = '{/literal}{$status}{literal}';
  
        clearCart();
        if(status == 'Active' || status =='Pending'){
            gotoListService(status);
        }
        else if(status == 'Terminated' || status == 'Suspended' || status == 'Expired'){
            addPaidServiceAndGoToStep4(status);
        }
        else if (status == 'Suspended'){
            showInvoice(status);
        }
   
    function clearCart(){
        //var clearurl = url + "index.php/cart&cart=clear&order=0";
        var clearurl = url + "cart&cart=clear&order=0";
        $.post(clearurl,function(data){
            
        });
    }
    function gotoListService(status){
        //var urlF  = url+'index.php/clientarea/services/rv2factor/&status='+status;
        var urlF  = url+'clientarea/services/rv2factor/&status='+status;
        window.location.assign(urlF);
    }
    function addPaidServiceAndGoToStep4(status){
        //var urlFree  = url+'index.php/cart/rv2factor/&step=0&action=add&id=59&cycle=m';
        //var urlStep3 = url+'index.php/cart/&step=3&status='+status;
        var urlFree  = url+'cart/rv2factor/&step=0&action=add&id=59&cycle=m';
        var urlStep3 = url+'cart/&step=3&status='+status;
        $.post(urlFree,function(data){
            window.location.assign(urlStep3);
        });
    }
    function showInvoice(status){
        //var urlF  = url+'index.php/clientarea/&status='+status;
        var urlF  = url+'clientarea/&status='+status;
        window.location.assign(urlF);
    }
</script>
{/literal} 