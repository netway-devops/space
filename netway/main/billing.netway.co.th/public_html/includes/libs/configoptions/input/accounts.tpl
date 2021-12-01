{foreach from=$c.items item=cit}
    <input name="custom[{$kk}][{$cit.id}]"
           data-variable="{$c.variable}"
           value="{$c.data[$cit.id]|htmlspecialchars}"
           {if $fieldlogic}id="custom_field_{$c.id}"{/if} {if $cmd == 'orders' && $c.options & 1}required{/if}/> {$cit.name}
{/foreach}