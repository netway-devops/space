<div class="form-group col-lg-12">
    <label>Source product</label>
    <select name="source" class="form-control" id="source">
        {foreach from=$categories item=category key=cid}
            <optgroup label="{$category.name}">
                {foreach from=$category.products item=product key=pid}
                    <option value="{$product.id}"
                            {if $cid == 0 && $pid == 0}selected{/if}>{$product.name}</option>
                {/foreach}
            </optgroup>
        {/foreach}
    </select>
</div>
<div class="form-group col-lg-12">
    <label>Target products</label>
    <select name="product[]" class="form-control" multiple id="products">
        {foreach from=$categories item=category key=cid}
            <optgroup label="{$category.name}">
                    <option value="-{$category.id}">{$category.name}: All products</option>
                {foreach from=$category.products item=product key=pid}
                    <option value="{$product.id}"
                            {if in_array($product.id, $submit.product) &&($cid != 0 && $pid != 0)}selected{/if}>{$product.name}</option>
                {/foreach}
            </optgroup>
        {/foreach}
    </select>
</div>
<div class="form-group col-lg-12">
    <label>Settings to copy</label>
    <select name="setting[]" class="form-control" multiple id="setting">
        {foreach from=$settings item=setting key=sid}
            <option value="{$sid}">{$setting}</option>
        {/foreach}
    </select>
</div>
<div class="col-sm-12">
    <div class="alert alert-warning">
        {$lang.copy_settings_warning}
    </div>
</div>
<div class="col-sm-12">
    <button class="btn btn-primary" name="make" value="bulk" type="submit">Submit changes</button>
</div>
{literal}
    <script type="text/javascript">

        $(function () {
            var setting = $('#setting'),
                products = $('#products'),
                source = $('#source');

            source.chosenedge({
                width: '100%'
            });
            products.chosenedge({
                width: '100%',
                enable_split_word_search: true,
                search_contains: true
            });
            setting.chosenedge({
                width: '100%'
            });

            $('button[value="bulk"]').on('click',function () {
                var stop = false,
                    message = '';
                if (isEmpty(products.val())){
                    message += "\nPlease select target products";
                    stop = true;
                }
                if (isEmpty(setting.val())){
                    message +="\nPlease select the settings to copy";
                    stop = true;
                }

                if (stop){
                    alert(message);
                    return false;
                }
            });
        });
    </script>
{/literal}

