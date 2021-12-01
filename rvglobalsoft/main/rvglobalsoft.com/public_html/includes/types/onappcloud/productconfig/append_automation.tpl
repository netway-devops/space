<table border="0" cellpadding="6" cellspacing="0" width="100%" class="editor-container">
    <tr class="odd">
        <td align="right" width="200"><strong>Metered: Staff report</strong></td>
        <td><select name="config[MeteredUsageStaff]" class="inp">
                <option value="No" {if $configuration.MeteredUsageStaff=='No'}selected="selected"{/if}>Off</option>
                <option value="Daily" {if $configuration.MeteredUsageStaff=='Daily' || !$configuration.MeteredUsageStaff}selected="selected"{/if}>Daily</option>
                <option value="Weekly" {if $configuration.MeteredUsageStaff=='Weekly'}selected="selected"{/if}>On Mondays</option>
                <option value="Monthly" {if $configuration.MeteredUsageStaff=='Monthly'}selected="selected"{/if}>Every 1st day of month</option>
            </select>
        </td>
    </tr>
    <tr >
        <td align="right" width="200"><strong>Metered: Client report <a class="vtip_description" title="Note: Usage summary will be sent to customer with service invoice"></a></strong></td>
        <td><select name="config[MeteredUsageClient]" class="inp">
                <option value="No" {if $configuration.MeteredUsageClient=='No' ||  !$configuration.MeteredUsageClient}selected="selected"{/if}>Off</option>
                <option value="Yes" {if $configuration.MeteredUsageClient=='Yes'}selected="selected"{/if}>On</option>
            </select>
        </td>
    </tr>
</table>