{if $enabled}

    <div class="btn-group">
        <button type="button" class="btn btn-sm btn-default" >
            Slack VIP:
        </button>
        <button type="button" class="btn btn-sm {if $client_state}btn-success{else}btn-default{/if} dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <strong>{if $client_state}VIP{else}Regular{/if}</strong>  <span class="caret"></span>
        </button>
        <ul class="dropdown-menu">
            {if !$client_state}<li><a href="?cmd=slack&action=toggle&client_id={$client.client_id}&toggle=1&security_token={$security_token}">Set to: VIP</a></li>{else}
                <li><a href="?cmd=slack&action=toggle&client_id={$client.client_id}&toggle=0&security_token={$security_token}">Set to: Regular</a></li>
            {/if}
        </ul>
    </div>

{/if}