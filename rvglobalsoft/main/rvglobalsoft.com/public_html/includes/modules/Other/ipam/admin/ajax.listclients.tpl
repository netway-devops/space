<select name="edit[{$ip}][5]" style="width:80px;">
    <option value="0">None</option>
    {foreach from=$clients item=client}
    <option value="{$client.id}" {if $client.id==$selected}selected="selected"{/if}>#{$client.id} {$client.firstname} {$client.lastname}</option>
    {/foreach}
</select>