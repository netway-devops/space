<script type="text/javascript" src="{$template_dir}js/jqueryui/js/jquery-ui-1.8.23.custom.min.js?v={$hb_version}"></script>
<form action="?cmd=module&module={$moduleid}&do=invoices" method="post" id="csvexport">
    <div class="newhorizontalnav" id="newshelfnav">
        <div class="list-1">
            <ul>
                <li class="{if !$do || $do=='invoice-export'}active{/if}">
                    <a href="?cmd=module&module={$moduleid}"><span>Export Invoices</span></a>
                </li>
                <li class="{if $do=='transaction-export'}active{/if}">
                    <a href="?cmd=module&module={$moduleid}&do=transaction-export"><span>Export Transactions</span></a>
                </li>
                <li class="{if $do=='accounts-export'}active{/if}">
                    <a href="?cmd=module&module={$moduleid}&do=accounts-export"><span>Export Accounts</span></a>
                </li>
                <li class="{if $do=='account-addons-export'}active{/if}">
                    <a href="?cmd=module&module={$moduleid}&do=account-addons-export"><span>Export Account Addons</span></a>
                </li>
                <li class="{if $do=='clients-export'}active{/if} last">
                    <a href="?cmd=module&module={$moduleid}&do=clients-export"><span>Export Clients</span></a>
                </li>
                <li class="{if $do=='domains-export'}active{/if} last">
                    <a href="?cmd=module&module={$moduleid}&do=domains-export"><span>Export Domains</span></a>
                </li>
            </ul>

            <div id="smartres2" class="smartres" style="display:none"><ul id="smartres-results2" class="smartres-results" ></ul></div>
        </div>
        <div class="list-2">
            <div class="subm1 haveitems" style="">
                <ul>
                    <li ><a href="#" onclick="$('input[type=checkbox]:not(:checked)','.columns').click();return false;"><span>Enable all</span></a></li>
                    <li>
                        <a href="#" onclick="$('input[type=checkbox]:checked','.columns').click();return false;"><span>Disable all</span></a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    {literal}
        <style>
            #fieldstable {
                margin: 12px;
                width: 100%;
            }
            #fieldstable td {
                text-align: left;
                line-height: 10pt;
                /*width: 150px;*/
            }
            #fieldstable input, label {
                vertical-align: middle;
            }
            .columns{
                padding: 10px;
                background: white;
                font-size:0;
            }
            .columns label{
                cursor: pointer;
                display: inline-block;
            }
            .columns label.ui-sortable-helper{
                cursor: move;
            }
            .columns label input{
                display: none;
                vertical-align: top;
            }
            .columns label span{
                display: block;
                font-size: 12px;
                padding: 5px;
                line-height: 16px;
                background: rgb(232, 232, 232);
                border: 1px solid rgb(203, 203, 203);
                margin: 0 5px 5px 0; 
                min-width: 160px;
                overflow: hidden;
                text-overflow: ellipsis
            }
            .columns label :checked + span{
                background: none repeat scroll 0 0 #FFF0A5;
                border: 1px solid #FED22F;
            }
            #csvexport .w250{
                width: 250px
            }
        </style>
    {/literal}
    {if !$do || $do=='invoice-export'}
        <input type="hidden" name="do" value="invoices" />
        <div class="columns">
            {foreach from=$invoice item=field}
                <label class="field_invoice">
                    <input name="fields[]" checked="checked" type="checkbox" id="i_{$field}" value="{$field}" />
                    <span>{if $field != 'invoice_id'}Invoice:{/if} {if $lang[$field]}{$lang[$field]}{else}{$field|replace:'_':' '|capitalize}{/if}</span>
                </label>
            {/foreach}
            {foreach from=$invoiceitem item=field}
                <label class="field_item">
                    <input name="fields[]" checked="checked" type="checkbox" id="it_{$field}" value="{$field}" />
                    <span>Item: {if $lang[$field]}{$lang[$field]}{else}{$field|replace:'_':' '|capitalize}{/if}</span>
                </label>
            {/foreach}
            {foreach from=$clientfields item=field}
                <label class="field_client">
                    <input name="fields[]" type="checkbox" id="d_{$field}" value="client.{$field}" />
                    <span>Client: {if $lang[$field]}{$lang[$field]}{else}{$field|replace:'_':' '|capitalize}{/if}</span>
                </label>
            {/foreach}
        </div>
        <div class="lighterblue" style="padding:5px;">
            {literal}
                <script type="text/javascript">
                    $(document).ready().on('change', '#select_types', function () {
                        var val = $(this).val();
                        if (val === 'invoice') {
                            $('.field_item').hide().find('input').prop('disabled', true).prop('checked', false);
                        } else if (val === 'items') {
                            $('.field_item').show().find('input').prop('disabled', false).prop('checked', true);
                        }
                    });
                    $(".columns").sortable().disableSelection();
                </script>
            {/literal}
            <table border="0" cellpadding="3" cellspacing="0">
                <tr>
                    <td width="160" align="right">Client</td>
                    <td align="left">
                        <select name="client" load="clients" class="inp w250">
                            <option value="0">Any</option>
                            {foreach from=$clients item=client}
                                <option value="{$client.id}">#{$client.id} {$client.firstname} {$client.lastname}</option>
                            {/foreach}
                        </select>
                    </td>
                    <td width="160" align="right"> Invoice status</td>
                    <td align="left">
                        <select name="status" class="inp">
                            <option value="Any">Any</option>
                            <option value="Paid">Paid</option>
                            <option value="Unpaid">Unpaid</option>
                            <option value="Cancelled">Cancelled</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td width="160" align="right">Date from</td>
                    <td align="left">
                        <input name="date_from" class="haspicker inp" />
                    </td>
                    <td width="160" align="right"> Date to</td>
                    <td align="left">
                        <input name="date_to" class="haspicker inp" />
                    </td>
                </tr>
                <tr>
                    <td width="160" align="right">Export type</td>
                    <td align="left">
                        <select name="type" class="inp" id="select_types">
                            <option value="items" selected="selected">Invoice items with invoice info</option>
                            <option value="invoice">General invoice info, no items</option>
                        </select>
                    </td>
                    <td width="160" align="right">Delimiter</td>
                    <td align="left">
                        <select name="delim" class="inp" > 
                            <option value=",">, comma</option>
                            <option value=";">; semicolon</option>
                        </select>
                    </td>
                </tr>
            </table>
        </div>


    {elseif $do=='transaction-export'}
        <input type="hidden" name="do" value="transactions" />
        <div class="columns">
            {foreach from=$transaction item=field}
                <label class="field_invoice">
                    <input name="fields[]" checked="checked" type="checkbox" id="i_{$field}" value="{$field}" />
                    <span>{if $lang[$field]}{$lang[$field]}{else}{$field|replace:'_':' '|capitalize}{/if}</span>
                </label>
            {/foreach}
            {foreach from=$clientfields item=field}
                <label class="field_client">
                    <input name="fields[]" type="checkbox" id="d_{$field}" value="client.{$field}" />
                    <span>Client: {if $lang[$field]}{$lang[$field]}{else}{$field|replace:'_':' '|capitalize}{/if}</span>
                </label>
            {/foreach}
        </div>
        <div class="lighterblue" style="padding:5px;">

            <table border="0" cellpadding="3" cellspacing="0">
                <tr>
                    <td width="160" align="right">Gateway</td>
                    <td align="left">
                        <select name="gateway" class="inp">
                            <option value="0">Any</option>
                            {foreach from=$gateways item=gateway}
                                <option value="{$gateway.id}">{$gateway.modname}</option>
                            {/foreach}
                        </select>
                    </td>
                    <td width="160" align="right">Delimiter</td>
                    <td align="left">
                        <select name="delim" class="inp">
                            <option value=",">, comma</option>
                            <option value=";">; semicolon</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td width="160" align="right">Date from</td>
                    <td align="left">
                        <input name="date_from" class="haspicker inp" />
                    </td>
                    <td width="160" align="right"> Date to</td>
                    <td align="left">
                        <input name="date_to" class="haspicker inp" />
                    </td>
                </tr>
            </table>

        </div>

    {elseif $do=='accounts-export'}
        <input type="hidden" name="do" value="accounts" />
        <div class="columns">
            {foreach from=$account item=field}
                <label class="field_invoice">
                    <input name="fields[]" checked="checked" type="checkbox" id="i_{$field}" value="{$field}" />
                    <span>{if $lang[$field]}{$lang[$field]}{else}{$field|replace:'_':' '|capitalize}{/if}</span>
                </label>
            {/foreach}
            {foreach from=$clientfields item=field}
                <label class="field_client">
                    <input name="fields[]" type="checkbox" id="d_{$field}" value="client.{$field}" />
                    <span>Client: {if $lang[$field]}{$lang[$field]}{else}{$field|replace:'_':' '|capitalize}{/if}</span>
                </label>
            {/foreach}
        </div>
        <div class="lighterblue" style="padding:5px;">

            <table border="0" cellpadding="3" cellspacing="0">
                <tr>
                    <td width="160" align="right">Delimiter</td>
                    <td align="left">
                        <select name="delim" class="inp">
                            <option value=",">, comma</option>
                            <option value=";">; semicolon</option>
                        </select>
                    </td>
                    <td width="160" align="right"> </td>
                    <td align="left">

                    </td>
                </tr>

            </table>

        </div>
    {elseif $do=='account-addons-export'}
        <input type="hidden" name="do" value="account-addons" />
        <div class="columns">
            {foreach from=$addons item=field}
                <label class="field_invoice">
                    <input name="fields[]" checked="checked" type="checkbox" id="i_{$field}" value="{$field}" />
                    <span>{if $lang[$field]}{$lang[$field]}{else}{$field|replace:'_':' '|capitalize}{/if}</span>
                </label>
            {/foreach}
            {foreach from=$clientfields item=field}
                <label class="field_client">
                    <input name="fields[]" type="checkbox" id="d_{$field}" value="client.{$field}" />
                    <span>Client: {if $lang[$field]}{$lang[$field]}{else}{$field|replace:'_':' '|capitalize}{/if}</span>
                </label>
            {/foreach}
        </div>
        <div class="lighterblue" style="padding:5px;">
            <table border="0" cellpadding="3" cellspacing="0">
                <tr>
                    <td width="160" align="right">Delimiter</td>
                    <td align="left">
                        <select name="delim" class="inp">
                            <option value=",">, comma</option>
                            <option value=";">; semicolon</option>
                        </select>
                    </td>
                    <td width="160" align="right"> </td>
                    <td align="left">
                    </td>
                </tr>
            </table>
        </div>
    {elseif $do=='domains-export'}
        <input type="hidden" name="do" value="domains" />
        <div class="columns">
            {foreach from=$domains item=field}
                <label class="field_invoice">
                    <input name="fields[]" checked="checked" type="checkbox" id="i_{$field}" value="{$field}" />
                    <span>{if $lang[$field]}{$lang[$field]}{else}{$field|replace:'_':' '|capitalize}{/if}</span>
                </label>
            {/foreach}
            {foreach from=$clientfields item=field}
                <label class="field_client">
                    <input name="fields[]" type="checkbox" id="d_{$field}" value="client.{$field}" />
                    <span>Client: {if $lang[$field]}{$lang[$field]}{else}{$field|replace:'_':' '|capitalize}{/if}</span>
                </label>
            {/foreach}
        </div>
        <div class="lighterblue" style="padding:5px;">
            <table border="0" cellpadding="3" cellspacing="0">
                <tr>
                    <td width="160" align="right">Delimiter</td>
                    <td align="left">
                        <select name="delim" class="inp">
                            <option value=",">, comma</option>
                            <option value=";">; semicolon</option>
                        </select>
                    </td>
                    <td width="160" align="right"> </td>
                    <td align="left">

                    </td>
                </tr>

            </table>

        </div>

    {elseif $do=='clients-export'}
        <input type="hidden" name="do" value="clients" />
        <div class="columns">

            {foreach from=$clientfields item=field}
                <label class="field_client">
                    <input name="fields[]" checked="checked" type="checkbox" id="d_{$field}" value="client.{$field}" />
                    <span>{if $lang[$field]}{$lang[$field]}{else}{$field|replace:'_':' '|capitalize}{/if}</span>
                </label>
            {/foreach}
        </div>
        <div class="lighterblue" style="padding:5px;">

            <table border="0" cellpadding="3" cellspacing="0">
                <tr>
                    <td width="160" align="right">Delimiter</td>
                    <td align="left">
                        <select name="delim"  class="inp">
                            <option value=",">, comma</option>
                            <option value=";">; semicolon</option>
                        </select>
                    </td>
                    <td width="160" align="right"> </td>
                    <td align="left">

                    </td>
                </tr>
                <tr>
                    <td width="160" align="right">Registered from</td>
                    <td align="left">
                        <input name="date_from" class="haspicker inp" />
                    </td>
                    <td width="160" align="right">Registered to</td>
                    <td align="left">
                        <input name="date_to" class="haspicker inp" />
                    </td>
                </tr>
            </table>

        </div>


    {/if}

    <div class="blu">
        <input type="submit" value="Download CSV"  class="btn btn-primary"/>
    </div>
    {securitytoken}
</form>