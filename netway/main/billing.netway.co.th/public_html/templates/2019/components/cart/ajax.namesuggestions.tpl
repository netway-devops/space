<div class="table-responsive table-borders table-radius mb-4">
    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled table" content="mb-4 ">
        <thead>
        <tr>
            <th class="w-50">{$lang.rnames}</th>
            <th colspan="2"></th>
        </tr>
        </thead>
        <tbody>
        {foreach from=$check item=ccme}
            {if $ccme.status =="suggested"}
                <tr>
                    <td class="first t1 input">
                        <input type="checkbox" name="tld[{$ccme.sld}{$ccme.tld}]" value="{$ccme.tld}"/>
                        <input type="hidden" name="sld[{$ccme.sld}{$ccme.tld}]" value="{$ccme.sld}"/>
                        <strong class="ml-3">{$ccme.sld}{$ccme.tld}</strong>
                    </td>
                    <td class="t3 status available" align="center">
                        <span class="badge badge-success badge-styled">{$lang.availorder}</span>
                    </td>
                    <td class="t4 last period" align="center">
                        {price tld=$ccme transfer=$transfer}
                            <select name="period[{$ccme.sld}{$ccme.tld}]" content="form-control">
                                <option value="@@cycle" @@selected>@@line</option>
                            </select>
                        {/price}
                    </td>
                </tr>
            {/if}
        {/foreach}
        </tbody>
    </table>
</div>