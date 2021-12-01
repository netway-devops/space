{if $ports}
    <div class="row">
        <div class="col-md-7">
            <select name="switch_port_id" id="switch_port_id" class="form-control">
                {foreach from=$ports item=port key=k}
                    <option value="{$port.id}">{$port.port_name} {if $port.account_id}( Assigned to #{$port.account_id}){/if}</option>
                {/foreach}
            </select>
        </div>
        <div class="col-md-2">

            <input type="hidden" value="{$server_id}" id="switch_server_id" name="switch_server_id" />
            <a href="#" onclick="return assignSwitchPort();" class="btn btn-success" onclick="return false;"><span class="addsth"><strong>Assign</strong></span></a>
        </div>
    </div>

{literal}
    <script>
    $('#switch_port_id').chosenedge({
        enable_split_word_search: true,
        search_contains: true,
        width: '100%'
    });
    </script>
{/literal}
{else}
    <p style="margin:5px">Unable to list ports, check if your item has correct port configuration, <a href="?cmd=dedimgr&do=itemeditor&item_id={$item_id}&subdo=update" target="_blank">you may need to use "Load Ports" button to update it</a></p>
{/if}