{if count($aDatas) > 1}
    {if $displayIdn==1}
        <li class="choices-header choices-Domains">Domains IDN</li>
    {elseif $displayIp==1}
        <li class="choices-header choices-Accounts">Account (Dedicate, VPS, Clound VPS)</li>
    {else}
        <li class="choices-header choices-Invoices">Custom search</li>
    {/if}
    {foreach from=$aDatas key=k item=aData}
        {if !$k}
            {continue}
        {/if}
        <li class="result">
            <a href="{$aData.cmdLink}">{$aData.itemPrefix} #{$aData.itemId} {$aData.itemName}
                <span class="second">{$aData.clientFirstName} {$aData.clientLastName}</span>
            </a>
        </li>
    {/foreach}
{/if}