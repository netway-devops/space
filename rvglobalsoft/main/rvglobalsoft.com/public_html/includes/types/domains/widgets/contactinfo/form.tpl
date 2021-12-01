<tbody id="{$type}_contact"  {if $info.action}style="display:none"{/if}>
    {foreach from=$info item=field key=name name=contactloop}
        {if !$field|@is_array}{continue}
        {/if}
        <tr {if $smarty.foreach.contactloop.index % 2 == 0}class="even"{/if}>
            <td align="right" width="160">
                {if $lang[$field.name]}{$lang[$field.name]}
                {else}{$field.name|capitalize}
                {/if}
            </td>
            <td>
                {if $field.type == 'select'}
                    <select class="styled"
                            name="updateContactInfo[{$type}][{$name}]" >
                        {foreach from=$field.items key=key item=value}
                            <option value="{$key}" {if $field.value == $key}selected{/if}>{$value}</option>
                        {/foreach}
                    </select>
                {else}
                    <input type="text" class="styled" size="30" 
                           value="{$field.value}" 
                           name="updateContactInfo[{$type}][{$name}]" />
                {/if}
            </td>
        </tr>
    {/foreach}
    {if $type == 'registrant' && $ContactInfo.extended}

        <tr  class="even">
            <td colspan="2" align="center">
                <strong>{$lang.extendedinfo}:</strong>
            </td>
        </tr>
        {foreach from=$ContactInfo.extended item=attribute name=fextended}
            <tr {if $smarty.foreach.fextended.iteration%2==0}class="even"{/if}>
                <td>{$attribute.description}:</td>
                {if $attribute.input}
                    <td>
                        <input type="text" class="styled" size="20" 
                               value="{if $attribute.value}{$attribute.value}{else}{$attribute.default}{/if}"
                               name="updateContactInfo[registrant][extended][{$attribute.name}]" />
                    </td>
                {else}
                    <td>
                        <select name="updateContactInfo[registrant][extended][{$attribute.name}]">
                            {foreach from=$attribute.option item=value}
                                <option value="{$value.value}" {if $value.value == $attribute.default} selected="selected"{/if} >{$value.title}</option>
                            {/foreach}
                        </select>
                    </td>
                {/if}
            </tr>
        {/foreach}
    {/if}
</tbody>