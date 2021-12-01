{if $custom_overrides.cart_sidemenu}
    {include file=$custom_overrides.cart_sidemenu}
{else}
    {if $step!=5 && $step!=0 && $step!=4 && !$has_own_ajax}
        <div id="sidemenu" class="default-cart">
            <div style="position:relative;">
                <div id="floater" style="position:absolute;">
                    <div class="wbox">
                        <div class="wbox_header">{$lang.cartsum1}</div>
                        <div class="wbox_content" id="cartSummary">
                            {include file='../orderpages/ajax.cart.summary.tpl'}
                        </div>
                    </div>
                </div>
            </div>
            {literal}
                <script type="text/javascript">
                    function flyingSidemenu() {
                        $('#sidemenu').height($('#floater').height());
                        $(window).scroll(function () {
                            var t = $(window).scrollTop() - $('#sidemenu').offset().top;
                            var maxi = $('#contener').height() - $('#floater').height() - 15;
                            if (t > maxi)
                                t = maxi;
                            if (t < 0)
                                t = 0;

                            $('#floater').animate({top: t + "px"}, {queue: false, duration: 300});
                        });
                    }
                    appendLoader('flyingSidemenu');

                </script>
            {/literal}
        </div>
    {/if}
{/if}
