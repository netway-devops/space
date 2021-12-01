{foreach from=$c.items item=cit}
    <input name="custom[{$kk}][{$cit.id}]"
           data-variable="{$c.variable}"
           value="{if !$c.data[$cit.id]}{else}{$c.data[$cit.id]|dateformat:$date_format}{/if}"
           class="haspicker"  {if $fieldlogic}id="custom_field_{$c.id}"{/if}/>
    {$cit.name}
{/foreach}