<div id="right">
<div style="position:relative;">
<div id="floater" style="position:absolute;">
    <div id="cart_sum">

		{include file='dedicated/ajax.cart_sidemenu.tpl'}
        
  </div></div>
</div>
</div>
<script type="text/javascript">{literal}
    function fixHeightsDelay() {
    setTimeout(function(){
     $('#right').height($('#cart_sum').height()+20);
    },450);
        }
function flyingSidemenu() {
    setTimeout(function(){
    $('#right').height($('#cart_sum').height()+20);
        $(window).scroll(function(){
            var t=$(window).scrollTop()-$('#right').offset().top;
            var maxi  =$('.content').height()-$('#floater').height()-15;
            if(t>maxi)
                t=maxi;
            if(t<0)
                t=0;

            $('#floater').animate({top:t+"px" },{queue: false, duration: 300});
        });
    },450);
}
$(function(){
    flyingSidemenu();

});

{/literal}
</script>