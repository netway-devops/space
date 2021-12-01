{if $step!=5 && $step!=0 && $step!=4}
    <div id="sidemenu">
        <div style="position:relative;">
            <div id="floater_box" style="position:absolute;">
                <div class="line-header clearfix first"><h3>{$lang.cartsum1}</h3></div>
                <div class="white-box">
                    <div id="cartSummary">
                        {include file='../orderpages/ajax.cart_bookshelf.tpl'}
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            appendLoader('flyingSidemenu');
        </script>
    </div>
{/if}