{if $connections}
    {foreach from=$connections item=connect}
        <div class="row">
            <div class="col-sm-8">
                <label>{$connect.name}:</label>
                {if $connect.data.balance}
                    <label style="margin-left: 5px;">{$connect.data.balance} EUR</label>
                {/if}
                {if $connect.data.error}
                    <label style="margin-left: 5px;">Error: {$connect.data.error}</label>
                {/if}
            </div>
            {if $connect.data.time}
                <div class="col-sm-4">
                    <label>Updated at:</label>
                    <label style="margin-left: 5px;">{$connect.data.time}</label>
                </div>
            {/if}
        </div>
    {/foreach}
{else}
    <div id="joker_balance" class="row">
        <div class="col-sm-12">
            <label>You must configure the connection in <a href="?cmd=joker_money_balance" target="_blank">Joker Money Balance</a></label>
        </div>
    </div>
{/if}