
    <script type="text/javascript" src="{$template_dir}js/hbwidget.js?v={$hb_version}"></script>
    <div class="form-group col-lg-12">
        <label>Products</label>
        <select name="product[]" class="form-control" multiple id="products" data-cat="{$cat_id}">
            {foreach from=$categories item=category}
                <optgroup label="{$category.name}">
                    {foreach from=$category.products item=product}
                        <option value="{$product.id}"
                                {if in_array($product.id, $submit.product)}selected{/if}>{$product.name}</option>
                    {/foreach}
                </optgroup>
            {/foreach}
        </select>
    </div>
    <div id="widgeteditor_content" class="clearfix clear" style="padding:0 15px; margin-bottom: 15px">
        {include file="services/productwidgets/ajax.list.tpl"}
    </div>
    <div class="col-lg-12">
        <button class="btn btn-primary" type="submit" value="1" name="bulkupdate">Update client functions</button>
    </div>
{literal}
    <script type="text/javascript">
        HBWidget.product_id = [];

        $(function () {
            var products = $('#products'),
                bulkwidgets = $('#widgeteditor_content');

            products.chosenedge({
                width: '100%',
                enable_split_word_search: true,
                search_contains: true
            }).on('change', function () {
                bulkwidgets.addLoader();
                HBWidget.product_id = products.val();
                $.post('?cmd=productwidgets&action=loadproduct&bulk=1', {
                    product_id: products.val(),
                }, function (data) {
                    bulkwidgets.html(parse_response(data));
                })
            })

            function toggleWidgets(wid, widget_id) {
                $(this).closest('.product-widget').toggleClass('active disabled');
            }

            HBWidget.product_id = $('#products').val()

            HBWidget.enableWidget = toggleWidgets
            HBWidget.disableWidget = toggleWidgets
            HBWidget.editUrl = '?cmd=productwidgets&action=editwidget&bulk=1&cat_id=' + products.data('cat');

            $('.widgets').chosenedge({
                width: '100%',
                enable_split_word_search: true,
                search_contains: true
            });


            $('#serializeit').on('submit.bulk', function (e) {
                console.log(products, products.val())

                var form = $(this),
                    prods = products.val();

                if (!prods || prods.length == 0) {
                    alert('You have to select some products to update client functions');
                    return false;
                }

                var widgets = $('.product-widget').map(function () {
                    var self = $(this),
                        data = self.data(),
                        widon = self.is('.active');

                    if (!widon && (!data.ids || !data.ids.length))
                        return;

                    return {
                        toggle: widon,
                        widget: data.widget,
                        ids: data.ids
                    };
                }).get();

                form.append($('<input value="" name="widgets" type="hidden" />').val(JSON.stringify(widgets)))
                return true;
            })
        })

    </script>
{/literal}