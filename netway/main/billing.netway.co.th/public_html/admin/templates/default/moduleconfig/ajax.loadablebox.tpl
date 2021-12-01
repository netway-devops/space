
    {if is_array($conf.default)}
        <input name="options[{$k}]" value="1" type="checkbox" {if $conf.default[0]}checked="checked"{/if} />
    {else}
        <input type="checkbox" value="1" name="options[{$k}]" {if $default.$k=='1'}checked='checked'{/if} />
    {/if}
