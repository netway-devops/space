<div class="bordered-section article">
    <h2>{$lang.delete_account}</h2>

    {if $unpaid}
        <div class="brcrm">
            <p>{$lang.delete_account_unpaid}</p>
            {foreach from=$unpaid item=invoice name=unpaid}
                <a
                href="{$ca_url}clientarea/invoice/{$invoice.id}">{$invoice|@invoice}</a>{if !$smarty.foreach.unpaid.last},{/if}
            {/foreach}
        </div>
        <div class="p19">
            <p><strong>{$lang.delete_account_contact}</strong></p>
        </div>
    {else}
        <div class="brcrm">
            <p>
                {if $delay}
                    {$lang.delete_account_delay|sprintf:$delay}
                {else}
                    {$lang.delete_account_immediate}
                {/if}
            </p>
            <p>
                {$lang.delete_account_result}
            </p>
        </div>
        <div class="p19">
            <a href="{$ca_url}clientarea/" class="btn btn-success">{$lang.cancel}</a>
            <a href="{$ca_url}clientarea/{$action}/&confirm&security_token={$security_token}"
               class="btn btn-default">{$lang.yes_delete_account}</a>
        </div>
    {/if}

</div>