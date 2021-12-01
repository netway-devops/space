{literal}
    <style>
        .cart-offer, .offer-item-title {
            margin-bottom: 1rem;
        }

        .cart-offer.active {
            margin-bottom: 0px;
        }

        .cart-offer-items {
            width: calc(100% + 20px);
            max-height: 430px;
            overflow-y: auto;

            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            margin-left: -10px;
            margin-right: -10px;
        }

        .cart-offer-item {
            width: calc(50% - 40px);
            flex-grow: 1;
            margin: 10px;
            padding: 0;
        }

        .offer-item-body {
            padding: 1.4em;
        }
    </style>
    <script>
        $(function () {
            var root = $('#cart-offers'),
                loader_node = root.parent('.wbox_content');

            loader_node = loader_node.length ? loader_node : root;
            $(document).ajaxComplete(function( event, request, settings ) {
                if(settings.url.indexOf('do=removeitem') >= 0){
                    $.get(this.getAttribute('href'), function (data) {
                        root.html(data);
                    })
                }
            });
        })
    </script>
{/literal}
<div id="cart-offers" class="cart-offers">
    {include file="../../templates/common/tpl/ajax.cart_offer.tpl"}
</div>