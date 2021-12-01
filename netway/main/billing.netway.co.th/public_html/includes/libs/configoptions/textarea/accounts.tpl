{foreach from=$c.items item=cit}{if $cit.name}{$cit.name}<br/>{/if}
    <textarea name="custom[{$kk}][{$cit.id}]" rows="3" cols="60" style="font-family: monospace"
              class="custom_field" {if $cmd == 'orders' && $c.options & 1}required{/if}
            data-variable="{$c.variable}"
    >{$c.data[$cit.id]|htmlspecialchars}</textarea>
{/foreach}