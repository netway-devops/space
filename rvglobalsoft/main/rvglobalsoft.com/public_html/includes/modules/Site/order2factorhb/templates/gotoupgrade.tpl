{literal} 
<script type="text/javascript">
    

        var url = '{/literal}{$system_url}{literal}';

        gotoStep3();

        

        function gotoStep3(){
            //var urlFree  = url+'index.php/cart/rv2factor/&step=0&action=add&id=59&cycle=m';
            //var urlStep3 = url+'index.php/cart/&step=3';
            var urlFree  = url+'cart/rv2factor/&step=0&action=add&id=59&cycle=m';
            var urlStep3 = url+'cart/&step=3';
            $.post(urlFree,function(data){
                window.location.assign(urlStep3);
            });
        }
    
</script>
{/literal} 