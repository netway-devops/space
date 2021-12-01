<div class="wbox">
    <div class="wbox_header">
        {$lang.changeowner_widget}
    </div>
    <div class="wbox_content">
        {if $unpaidinvoice}
            {$lang.changeowner_invoiceinfo}
            <br>
            {$lang.manualrenew_unpaidinvoice}
            <a href="{$ca_url}clientarea/invoice/{$unpaidinvoice.id}/">{$unpaidinvoice|@invoice}</a>
        {else}
            {if $transfer && $transfer.status == 'Pending'}
                {$lang.changeowner_pending|sprintf:$transfer.new_client_email:$transfer.date_request}<br/><br/>
                <form action="" method="post">
                    <input type="hidden" name="make" value="cancel"/>
                    <input type="submit" class="btn btn-danger" value="{$lang.changeowner_cancelbtn}" onclick="return confirm('Are you sure?');"/>
                    {securitytoken}
                </form>
            {else}
                <form action="" method="post">
                    <input type="hidden" name="make" value="submit"/>
                    {$lang.changeowner_guide}<br/><br/>
                    <table class="table">
                        <tr>
                            <td width="250"><strong>{$lang.new_owner_email}</strong></td>
                            <td>
                                <input type="email" name="newemail" class="inp" value="" required/>
                            </td>
                        </tr>
                    </table>
                    <input type="submit" class="btn btn-primary" value="{$lang.changeowner_widget}" onclick="return confirm('{$lang.manualrenew_confirm}');"/>
                    {securitytoken}
                </form>
            {/if}
        {/if}
    </div>
</div>

