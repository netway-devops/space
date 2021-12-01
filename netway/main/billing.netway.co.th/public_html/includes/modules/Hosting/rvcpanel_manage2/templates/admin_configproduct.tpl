<tr>
    <td style="padding-top: 15px;" align="right" valign="top"><strong>Map Pricing</strong></td>
    <td style="padding-top: 15px;" valign="top">
        <div class="left" id="subwiz_opt">
            <input type="hidden" name="frm_appcpanel" id="frm_appcpanel" value="yes" />
            <table border="0"  width="600" class="editor-container" cellpadding="0" cellspacing="0"  id="configoptionstable">
                <tr>
                    <th>Price</th>
                    <th>Group</th>
                    <th>Package</th>
                </tr>
{foreach from=$aPrice item=item_price key=item_key}
    {if $item_price gt 0.00}
                <tr>
                    <td>
        {if $item_key eq 't'} Triennially {else} {$lang.$item_key} {/if}
                    </td>
                    <td>
                        <select name="cpanel[{$item_key}][group]" class="inp left modulepicker" style="width: 200px;">
        {foreach from=$aGroup key=item_code item=item_name}
                            <option value="{$item_code}" {if $aPriceDef[$item_key].cpl_group eq $item_code}selected{/if}>{$item_name}</option>
        {/foreach}
                        </select>
                    </td>
                    <td>
                        <select name="cpanel[{$item_key}][package]" class="inp left modulepicker" style="width: 200px;">
        {foreach from=$aPackage key=item_code item=item_name}
                            <option value="{$item_code}" {if $aPriceDef[$item_key].cpl_package eq $item_code}selected{/if}>{$item_name}</option>
        {/foreach}
                        </select>
                     </td>
                </tr>
    {/if}
{/foreach}
<!--
                <tr>
                    <td align="right" colspan="3">
                        <label for="options_force_license">
                        <strong>Force license:</strong><br/>
                        <small >Should a new license be added if one already exists? (overwrites discounts)</small>                        </td>
                        </label>
                        <input type="checkbox" id="options_force_license" value="1" name="options[option3]" checked='checked'   />
                    </td>
                </tr>
-->
            </table>
        </div>
        <div class="clear"></div>
    </td>
</tr>