{if 'config:ShopingCartMode'|checkcondition}
    <div class="lang-box pull-right">
    <div class="btn-group">
        <a href="{$ca_url}cart/" class="btn dropdown-toggle cart-popover"{if $shoppingcart}data-placement="bottom" data-toggle="popover"  id="cartpop"{/if}>
            {$lang.cart}
            {if $shoppingcart}<span class="caret"></span>
            {/if}
        </a>
        {if $shoppingcart}
            <div style="display: none">
                <div class="wrapper">
                    <h3>Items in your cart</h3>
                    <ul class="nav nav-pills nav-stacked submenu-nav">
                        {foreach from=$shoppingcart item=order key=k}
                            {if $order.product}
                                <li>
                                    <a href="{$ca_url}cart&cart=edit&order={$k}">
                                        <span class="pull-right">{$order.total.total|price:$currency}</span>
                                        <div>
                                            {$order.product.category_name} - {$order.product.name}
                                            {if $order.product.domain}({$order.product.domain})
                                            {/if}
                                        </div>
                                    </a> 

                                </li>           
                            {elseif $order.domains }
                                {foreach from=$order.domains item=domenka key=kk}
                                    <li>
                                        <a href="{$ca_url}cart&cart=edit&order={$k}">
                                            <span class="pull-right">{$domenka.price|price:$currency}</span>
                                            <div>
                                                {if $domenka.action=='register'}{$lang.domainregister}
                                                {elseif $domenka.action=='transfer'}{$lang.domaintransfer}
                                                {elseif $domenka.action=='renew'}{$lang.domainrenewal}
                                                {/if}
                                                - {$domenka.name} - {$domenka.period} {$lang.years}
                                            </div>
                                        </a> 
                                    </li>           
                                {/foreach}
                            {/if}
                        {/foreach}
                    </ul>

                    {literal}
                        <script type="text/javascript">
                            $(function() {
                                $('#cartpop').popover({
                                    html: true,
                                    rigger: 'manual',
                                    template: '<div class="popover submenu dropdown-menu"><div class="arrow"></div><div class="popover-content" style="padding:0"></div></div>',
                                    content: function() {
                                        var data = $(this).next(),
                                                list = data.find('li a'),
                                                margin = 0;
                                        list.children('span:first-child').each(function() {
                                            var w = $('<span></span>').text($(this).text()).css({position: 'absolute', visibility: 'hidden', top: 0}).appendTo('body'),
                                                    width = w.width() + 10;
                                            w.remove();
                                            margin = margin > width ? margin : width;
                                        })
                                        list.children('div:last-child').css('margin-right', margin);
                                        return data.html();
                                    },
                                }).bind('shown', function() {
                                    var tip = $(this).data('popover').tip(),
                                            actualWidth = tip.outerWidth(),
                                            contener = $('section'),
                                            offset = tip.offset();

                                    if ((contener.offset().left + contener.width()) - 20 < offset.left + actualWidth) {
                                        var left = (contener.offset().left + contener.width()) - 20 - actualWidth;
                                        tip.find(".arrow").css('left', (actualWidth / 2) + offset.left - left)
                                        offset.left = left;
                                        tip.offset(offset)
                                    }
                                }).bind('mouseleave mouseenter', function(e) {
                                    var tip = $(this).data('popover').tip(),
                                            timeout = false,
                                            that = $(this),
                                            hide = function() {
                                        clearTimeout(timeout);
                                        timeout = setTimeout(function() {
                                            that.popover('hide');
                                        }, 200)
                                    }, show = function() {
                                        clearTimeout(timeout);
                                        timeout = false;
                                        if (!tip.is(':visible')) {
                                            that.popover('show');
                                        }
                                    }
                                    that.data('popover').tip().bind('mouseleave mouseenter', function(e) {
                                        if (e.type == 'mouseleave')
                                            hide();
                                        else
                                            show();
                                    });
                                    if (e.type == 'mouseleave')
                                        hide();
                                    else
                                        show();
                                });

                            });
                        </script>
                    {/literal}
                    <div class="submenu-services-bg"></div>
                </div>
            {/if}
        </div>
        <div class="header-separator"></div>
    </div>
</div>
        {/if}