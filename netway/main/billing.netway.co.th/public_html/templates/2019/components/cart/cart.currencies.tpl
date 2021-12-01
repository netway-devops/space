{if count($currencies)>1}
    <div class="d-flex flex-row justify-content-end my-2">
        <form action="" method="post" id="currform" class="form-inline">
            <input name="action" type="hidden" value="changecurr">
            <span class="mr-3">{$lang.Currency}</span>
            <select name="currency" class="form-control" onchange="$('#currform').submit()">
                {foreach from=$currencies item=crx}
                    <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                {/foreach}
            </select>
        </form>
    </div>
{/if}