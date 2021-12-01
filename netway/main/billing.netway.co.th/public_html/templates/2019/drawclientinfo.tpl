<div class="table-responsive">
    <table class="table stackable" width="100%" cellspacing="0" cellpadding="0">
        {foreach from=$fields item=field name=floop key=k}
            {if $smarty.foreach.floop.index%2==0}
                <tr>
            {/if}
            <td class="noncrucial">
                <b>
                    {if $field.options & 1}{if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                    {else}{$field.name}{/if}
                </b>
            </td>
            <td data-label="{if $field.options & 1}{if $lang[$k]}{$lang[$k]}:{else}{$field.name}:{/if}{else}{$field.name}:{/if}">
                {if $k=='country'}
                    {foreach from=$countries key=k item=v}{if $k==$client.country}{$v}{/if}{/foreach}
                {else}
                    {if $field.field_type=='Input' || $field.field_type=='Encrypted' || $field.field_type=='Phonenumber'}{$client[$k]}
                    {elseif $field.field_type=='Password'}
                    {elseif $field.field_type=='Select'}
                        {foreach from=$field.default_value item=fa}
                            {if $client[$k]==$fa}{$fa}{/if}
                        {/foreach}
                    {elseif $field.field_type=='Check'}
                        {foreach from=$field.default_value item=fa}
                            {if in_array($fa,$client[$k])}{$fa}<br/>{/if}
                        {/foreach}
                    {elseif $field.field_type=='Contact'}
                        {foreach from=$field.default_value item=fa key=id}
                            {if $client[$k] == $id}{$fa}{/if}
                        {/foreach}
                    {/if}
                {/if}
            </td>
            {if $smarty.foreach.floop.index%2==1 }
                </tr>
            {/if}
        {/foreach}
    </table>
</div>