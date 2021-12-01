{if $affiliate}
                <div class="unpaid-comm pull-right">
                <p>{$lang.unpaidcomisions}:</p>
                <p class="hightlighted-comm blue-c">{$affiliate.balance|price:$affiliate.currency_id} / {$affiliate.pending|price:$affiliate.currency_id}</p>
                </div>
                <label class="aff-label"><i class="icon-reff"></i> {$lang.reflink}:</label>
                <input type="text" class="aff-link" value="{$system_url}?affid={$affiliate.id}" />
{/if}