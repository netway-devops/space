{if $emails}
    {foreach from=$emails item=email name=foo}
        <tr>
            <td><a href="{$ca_url}clientarea/emails/{$email.id}/">{$email.subject}</a></td>
            <td>{$email.date|dateformat:$date_format}</td>
        </tr>
    {/foreach}
{else}
    <tr><td colspan="2">{$lang.nothing}</td></tr>
{/if}