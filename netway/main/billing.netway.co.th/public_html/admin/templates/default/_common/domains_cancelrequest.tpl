{if $cancel_request}
    <div style="border: 1px solid #CCCCCC; background: #DDDDDD;" class="cancellation">
        <div>
            <strong style="margin-right: 15px;">Cancelation request was placed for this domain</strong>
            <input type="submit" name="del_cancreq" onclick="return confirm('{$lang.confirm_del_crequest}')" value="{$lang.DeleteRequest}" class="btn btn-warning btn-sm">
        </div>

        <table width="100%" cellspacing="2" style="padding: 5px 20px;">
            <tbody>
                <tr>
                    <td width="10%" valign="top"><strong>{$lang.who}:</strong></td>
                    <td valign="top">{$cancel_request.who|default:"-"}</td>
                </tr>
                <tr>
                    <td  width="10%" valign="top"><strong>{$lang.Type}:</strong></td>
                    <td width="30%" valign="top">{$cancel_request.type}</td>
                    <td width="10%" valign="top"><strong>{$lang.Reason}:</strong></td>
                    <td valign="top">{$cancel_request.reason}</td>
                </tr>
                <tr>
                    <td width="10%" valign="top"><strong>{$lang.Date}:</strong></td>
                    <td width="30%" valign="top">{$cancel_request.date|dateformat:$date_format}</td>
                    {if $cancel_request.process_at != '0000-00-00 00:00:00'}
                        <td width="10%" valign="top"><strong>{$lang.ProcessAt}:</strong></td>
                        <td valign="top">{$cancel_request.process_at|dateformat:$date_format}</td>
                    {/if}
                </tr>
                {if $cancel_request.process_at != '0000-00-00 00:00:00'}
                    <tr>
                        <td colspan="4">
                            <span class="label label-danger">Warning</span>
                            <span>{$lang.cancelation_warning}</span>
                        </td>
                    </tr>
                {/if}
            </tbody>
        </table>
    </div>
{/if}