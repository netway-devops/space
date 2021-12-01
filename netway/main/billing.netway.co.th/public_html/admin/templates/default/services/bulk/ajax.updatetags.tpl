<div class="form-group col-lg-12">
    <label>Products</label>
    <select name="product[]" class="form-control" multiple id="products">
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

<div class="col-lg-6 ">
    <div id="tagsBox" style="display: none;">{foreach from=$alltags item=tag}<span class="tag">{$tag}</span>{/foreach}
    </div>
    <div class="form-group">
        <label>Add tags</label>
        <div class="clearfix">
            <div id="tagsInput" class="tag-form" data-suggestions="{$alltags|@json_encode|escape}"></div>
            <div id="tags" style="display: none"></div>
        </div>
    </div>
</div>
<div class="col-lg-6 ">
    <div class="form-group">
        <label>Remove tags</label>
        <div class="clearfix">
            <div id="tagsInput2" class="tag-form" data-suggestions="{$alltags|@json_encode|escape}"></div>
            <div id="tags2" style="display: none">
            </div>
        </div>
    </div>
</div>
<div class="col-sm-12">
    <button class="btn btn-primary" name="make" value="bulk" type="submit">Update tags</button>
</div>
{literal}
    <script type="text/javascript">

        $(function () {
            $('.tag-form').hbtags()
                .on('tags.add', function (e, tag) {
                    var self = $(this);
                    self.next().append('<input type="hidden" name="tags' + (self.is('#tagsInput2') ? '_rem' : '') + '[]" value="' + tag + '" />');
                })
                .on('tags.rem', function (e, tag) {
                    $(this).next().find('#tags input[value="' + tag + '"]').remove();
                });

            $('#products').chosenedge({
                width: '100%',
                enable_split_word_search: true,
                search_contains: true
            });

            $('#serializeit').on('submit.bulk', function (e) {
                var prods = $('#products').val();
                if (!prods || prods.length == 0) {
                    alert('You have to select some products to update');
                    return false;
                }
                return true;
            })
        })

    </script>
{/literal}