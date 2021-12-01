<div class="wbox">
        <div class="wbox_header">
            {$lang.billingcontact_widget}
        </div>
        <div class="wbox_content">

                <form action="" method="post">
                    <input type="hidden" name="make" value="submit" />
                    {$lang.billingcontact_guide}<br/><br/>

                    <table class="table">

                        <tr>
                            <td width="150"><strong>{$lang.new_contact}</strong></td>
                            <td>
                                <select name="contact_id" class="left">
                                    {foreach from=$contacts item=contact key=id}
                                        <option value="{$id}" {if $selected_contact == $id}selected="selected"{/if}>{$contact.firstname} {$contact.lastname}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>

                    </table>
                    <input type="submit" class="btn btn-primary" value="{$lang.savechanges}" onclick="return confirm('{$lang.manualrenew_confirm}');" />
                {securitytoken}</form>

        </div>
</div>

