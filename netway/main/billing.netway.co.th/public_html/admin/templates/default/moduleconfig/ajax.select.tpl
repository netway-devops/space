    <div>
        <select id="conf_opt_{$k}" name="options[{$k}]" {if $conf.reload}onchange="return getFieldValues({if $product_id}{$product_id}{else}{$product.id}{/if})"{elseif $conf.onchange}onchange="{$conf.onchange}"{/if}>
            {foreach from=$conf.default item=cs}
                {if $cs|is_array}
                    <option {if $default.$k== $cs[0]}selected="selected" {/if} value="{$cs[0]}">{$cs[1]}</option>
                {else}
                    <option {if $default.$k== $cs}selected="selected" {/if}>{$cs}</option>
                {/if}
            {/foreach}
        </select>
        {if $conf.onchange}
            <script type="text/javascript">{literal}function lm{/literal}{$k}{literal}() {$('#conf_opt_{/literal}{$k}{literal}').change(); } {/literal}lm{$k}();appendLoader('lm{$k}');</script>
        {/if}
    </div>
