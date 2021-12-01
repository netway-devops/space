<h1>{$lang.delete_account}</h1>

<section class="section-delete mt-5">
    {if $unpaid}
        <div class="message-box message-box-file card">
            <div class="card-header">{$lang.delete_account_unpaid}</div>
            <div class="card-body">
                <ul>
                    {foreach from=$unpaid item=invoice name=unpaid}
                        <li><a href="{$ca_url}clientarea/invoice/{$invoice.id}">{$invoice|@invoice}</a>{if !$smarty.foreach.unpaid.last},{/if}</li>
                    {/foreach}
                </ul>
            </div>
            <div class="card-footer">{$lang.delete_account_contact}</div>
        </div>
    {else}
        <div class="message-box message-box-file card">
            <div class="card-header">
                {if $delay}
                    {$lang.delete_account_delay|sprintf:$delay}
                {else}
                    {$lang.delete_account_immediate}
                {/if}
            </div>
            <div class="card-body">
                <p>{$lang.delete_account_result}</p>
                <a href="{$ca_url}clientarea/" class="btn btn-default">{$lang.cancel}</a>
                <a href="{$ca_url}clientarea/{$action}/&confirm&security_token={$security_token}" class="btn btn-danger">{$lang.yes_delete_account}</a>
            </div>
        </div>
    {/if}
</section>
