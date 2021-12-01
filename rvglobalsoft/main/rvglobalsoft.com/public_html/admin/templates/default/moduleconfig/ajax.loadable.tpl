    {if is_array($conf.default) && !empty($conf.default)}
        <select name="options[{$k}]" class="form-control module-loadable"
                {if $conf.reload}onchange="return getFieldValues('{if $product_id}{$product_id}{else}{$product.id}{/if}')"{/if}>
            {foreach from=$conf.default item=cs}
                {if $cs|is_array}
                    <option {if $default.$k== $cs[0]}selected="selected" {/if} value="{$cs[0]}">{$cs[1]}</option>
                {else}
                    <option {if $default.$k== $cs}selected="selected" {/if}>{$cs}</option>
                {/if}
            {/foreach}
        </select>
    {else}
        <input name="options[{$k}]" value="{if $default.$k}{$default.$k}{/if}" />
    {/if}
