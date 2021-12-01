{foreach from=$emails item=email name=foo}
    <tr>
        <td>{$email.email}</td>
        <td>
            <a href="{$ca_url}clientarea/emails/{$email.id}/" class="roll-link">
                <span data-title="{$email.subject}">{$email.subject}</span>
            </a>
        </td>
        <td>{$email.date|dateformat:$date_format}</td>

    </tr>
{foreachelse}
    <tr><td colspan="100%" class="text-center">{$lang.nothing}</td></tr>
{/foreach}