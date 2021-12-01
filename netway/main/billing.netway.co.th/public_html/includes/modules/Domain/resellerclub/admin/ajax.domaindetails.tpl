{if $info}
    Order Status: {foreach from=$info.orderstatus item=s}<label class="label label-info">{$s}</label> {/foreach} <br>
    GDPR Status:
    {if $info.gdpr.eligible}
        {if $info.gdpr.enabled}

            <label class="label label-success">Enabled</label>
            {else}
            <label class="label label-danger">Disabled</label>
        {/if}
        {else}
        <label class="label label-default">Ineligible</label>
    {/if}<br>
        RAA Status:  {if $info.raaVerificationStatus == 'Verified'}
        <label class="label label-success">{$info.raaVerificationStatus}</label>
    {elseif $info.raaVerificationStatus == 'Pending'}
        <label class="label label-warning">{$info.raaVerificationStatus}</label>
    {elseif $info.raaVerificationStatus == 'Suspended'}
    <label class="label label-danger">{$info.raaVerificationStatus}</label>
    {elseif $info.raaVerificationStatus}
    <label class="label label-default">{$info.raaVerificationStatus}</label>
    {/if}<br>
{else}

{/if}