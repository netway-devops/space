{foreach from=$c.items item=cit}
    <input type="hidden" name="custom[{$kk}][{$cit.id}]" value="0">
    <input type="checkbox" name="custom[{$kk}][{$cit.id}]"  value="1"  {if $c.data[$cit.id]}checked="checked"{/if} {if $fieldlogic}id="custom_field_{$c.id}"{/if}/> {$cit.name}
{/foreach}