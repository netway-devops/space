{foreach from=$c.items item=cit}
    {assign var="itm" value=$cit}
{/foreach}
{foreach from=$c.data item=cit key=id}
    <ul>
        {foreach from=$cit|json_decode:1 item=key_id}
            <li style="cursor: pointer;">
                <a href="#ssh_keys" onclick="show('{$key_id}')"><span>{if isset($c.ssh[$key_id])}{$c.ssh[$key_id].name}{else}{$key_id}{/if}</span></a>
                <input type="hidden" name="custom[{$kk}][{$itm.id}][]" value='{$key_id}' class="custom_field">
            </li>
        {/foreach}
    </ul>
{/foreach}
{literal}
<script>

    function show(key_id) {
        var keys = {/literal}{$c.ssh|@json_encode}{literal};
        bootbox.alert({
            title: "Key: "+ keys[key_id]['name'],
            message: "<textarea style='cursor:pointer; min-height: 100px; min-width: 100%;' disabled>"+ atob(keys[key_id]['key'])+"</textarea>",
            size: 'large',
        });
    }
</script>
{/literal}
