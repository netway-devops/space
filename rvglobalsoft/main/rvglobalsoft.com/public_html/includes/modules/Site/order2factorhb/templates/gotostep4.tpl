{literal} 
<script type="text/javascript">
    var url = '{/literal}{$system_url}{literal}';
    $(document).ready(function(){
        clearCart();
        gotoStep4();

    });
     function gotoStep4(){
            //var urlFree  = url+'index.php/cart/rv2factor/&step=0&action=add&id=58&cycle=Free';
            //var urlStep3 = url+'index.php/cart/&step=3&cycle=Free&action=addconfig&tagproductname=2-factor+Authentication+for+WHM+%28Free+1+account+for+30+days%29';
            //var urlStep4 = url+'index.php/cart/&step=4';
            var urlFree  = url+'cart/rv2factor/&step=0&action=add&id=58&cycle=Free';
            var urlStep3 = url+'cart/&step=3&cycle=Free&action=addconfig&tagproductname=2-factor+Authentication+for+WHM+%28Free+1+account+for+30+days%29';
            var urlStep4 = url+'cart/&step=4';
            $.post(urlFree,function(data){
                $.post(urlStep3,function(data){
                    window.location.assign(urlStep4);
                });
            });
        }
    function clearCart(){
        //var clearurl = url + "index.php/cart&cart=clear&order=0";
        var clearurl = url + "cart&cart=clear&order=0";
        $.post(clearurl,function(data){
            
        });
    }       
</script>
{/literal} 