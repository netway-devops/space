<select name="extra_details[VmUuid]" >
    <option value=""> - none - </option>
    {foreach from=$list item=server}
        <option {if $current == $server.uuid}selected="selected"{/if} value="{$server.uuid}">#{$server.id} {$server.name}</option>
    {/foreach} 
</select>