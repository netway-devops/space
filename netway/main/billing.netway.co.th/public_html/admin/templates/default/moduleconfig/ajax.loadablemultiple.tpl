{if is_array($conf.default) && !empty($conf.default)}
    <select name="options[{$k}][]" class="form-control module-loadable module-loadable-multiple"
            multiple="multiple"
            {if $conf.reload}onchange="return getFieldValues('{if $product_id}{$product_id}{else}{$product.id}{/if}')"{/if}>
        {foreach from=$conf.default item=cs}
            {if $cs|is_array}
                <option {if $cs[0]|in_array:$default.$k} selected="selected" {/if} value="{$cs[0]}">{$cs[1]}</option>
            {else}
                <option {if $cs|in_array:$default.$k} selected="selected" {/if}>{$cs}</option>
            {/if}
        {/foreach}
    </select>
{else}
    {if $default.$k}
        {if is_array($default.$k)}
            <select class="form-control module-loadable module-loadable-multiple-val" name="options[{$k}][]" multiple>
                {foreach from=$default.$k item=item name=optvals}
                    <option value="{$item}" selected>{$item}</option>
                {/foreach}
            </select>
        {else}
            {$default.$k}
        {/if}
    {/if}
    <small><i>To check available values, press the 'Get values from server` button</i></small>
    <br>
{/if}
