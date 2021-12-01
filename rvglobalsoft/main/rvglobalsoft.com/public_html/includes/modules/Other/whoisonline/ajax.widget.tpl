{literal}
    <style>
        .isclient-link {
            display: flex;
            flex-direction: column;
            text-decoration: none;
            text-underline: none;
            padding: 5px;
            margin: 5px 0;
            background: #fdfdfd;
        }
        .isclient-link:hover {
            background: #f1f1f1;
        }
        .isclient-link a {
            color: #4bb1cf;
            font-style: italic;
            word-break: break-all;
        }
    </style>
{/literal}
{if !$clients_online}
    No registered clients are online now
{else}
    <div style="margin:10px 0;display: flex;flex-direction: row;align-items: center;">
        <img src="/includes/modules/Other/whoisonline/user_new.png" alt="Active users">
        <div style="display: flex;flex-direction: column;margin-left: 15px;">
            <h5>Active clients</h5>
            <div><h4 style="color: #F0C000;display: inline-block;margin: 0;">{$clients_online|@count}</h4> <h5 style="margin: 0;display: inline-block;color: #777;">Active</h5></div>
        </div>
    </div>

    <div class="row">
        {foreach from=$clients_online item="client"}
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 ">
                <div class="isclient isclient-link isclient-{$client.group_id}">
                    {$client|@profilelink:true}
                    <span>IP: <a href="https://geoiptool.com/en/?IP={$client.ip}" target="_blank">{$client.ip}</a></span>
                </div>
            </div>
        {/foreach}
    </div>
{/if}