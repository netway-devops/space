

{literal}
    <style>
        .table-import{
            margin-bottom: 15px;
        }

        #import-items tr td {
            padding: 10px;
            border-bottom: 1px solid #ddd
        }

        #import-items tr + tr.placeholder {
            display: none;
        }

        #import-items .placeholder td {
            padding: 12px 15px;
            color: #ccc;
            border: 2px dashed #ddd;
        }

        #import-items code {
            padding: 2px 4px;
            font-size: 90%;
            color: #35779E;
            background-color: #F2F4F9;
            border-radius: 4px;
        }
    </style>

    <script>
        $(function () {

            $(".chosen").chosenedge({
                width: "100%",
                disable_search_threshold: 5,
                allow_single_deselect: true,
                display_disabled_options: false
            });

            $('.client-search').chosensearch();
        })
    </script>
{/literal}

<form action="" method="post" >
    <input type="hidden" value="{$server_id}" name="server_id" />

    <div class="lighterblue" style="padding:10px;">
        <b> Note:</b> Importing accounts is resource &amp; time consuming process.
        To avoid timeouts, consider importing few accounts at a time, rather than all at once.
    </div>

    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table table-striped table-import">
        <tr>
            <th width="20"><input type="checkbox" id="checkall" /></th>
            <th>ID / {$lang.Username}</th>
            <th>{$lang.Email}</th>
            <th>{$lang.Status}</th>
            <th>{$lang.Domain}</th>
            <th>Remote Package</th>
            <th>{$lang.productassigned}</th>
            <th>Client assigned</th>
        </tr>

        {if $accounts.not_in_hb}
            {if $import_type == '2' || $import_type == '3'}
                {foreach from=$accounts.not_in_hb item=acc}
                    <tr>
                        <td>
                            <input type="checkbox" class="check" value="{$acc.id}" name="selected[]" />
                            <input type="hidden" name="product_id[{$acc.id}]" value="{$acc.product_id}" />
                        </td>
                        <td>{$acc.username}</td>
                        <td>{$acc.email}</td>
                        <td {if $acc.status == 'Suspended'}style="color: red"{/if}>
                            <span class="{$acc.status}">{$acc.status}</span>
                        </td>
                        <td>{$acc.domain}</td>
                        <td>{if $acc.product_name}{$acc.product_name}{else}-{/if}</td>
                        <td>
                            <select name="product_id[{$acc.id}]" class="chosen form-control">
                                {foreach from=$pnames item=category }
                                    {if $category.products}
                                        <optgroup label="&nbsp;{$category.name}">
                                            {foreach from=$category.products item=product}
                                                <option value="{$product.id}">{$product.name}</option>
                                            {/foreach}
                                        </optgroup>
                                    {/if}
                                {/foreach}
                            </select>
                        </td>
                        <td>
                            <select name="client_id[{$acc.id}]" class="form-control client-search">
                                {if $acc.email}
                                    <option value="0">Import client from remote app</option>
                                {/if}
                            </select>
                        </td>
                    </tr>
                {/foreach}
            {else}
                {foreach from=$accounts.not_in_hb item=acc}
                    <tr>
                        <td>
                            <input type="checkbox" class="check" value="{$acc.id}" name="selected[]" />
                            <input type="hidden" name="product_id[{$acc.id}]" value="{$acc.product_id}" />
                        </td>
                        <td>{$acc.username}</td>
                        <td>{$acc.email}</td>
                        <td {if $acc.status == 'Suspended'}style="color: red"{/if}>{$acc.status}</td>
                        <td>{$acc.domain}</td>
                        <td>{$acc.package}</td>
                        <td>{$acc.product_name}</td>
                        <td><em>Attempt to match by email or create new</em></td>

                    </tr>
                {/foreach}
            {/if}
        {else}
            <tr><td colspan="8">{$lang.noaccountstoimport}</td></tr>
        {/if}

        {if $accounts.in_hb}
            <tbody class="lighterblue_td">
                <tr><th colspan="8" style="text-align: center">{$lang.accalreadyinhb}</th></tr>
                {foreach from=$accounts.in_hb item=acc2}
                    <tr>
                        <td><input type="checkbox" disabled="disabled" /></td>
                        <td>{$acc2.username}</td>
                        <td>{$acc2.email}</td>
                        <td>{$acc2.status}</td>
                        <td>{$acc2.domain}</td>
                        <td>{$acc2.package}</td>
                        <td>{$acc2.product_name}</td>
                        <td></td>
                    </tr>
                {/foreach}
            </tbody>
        {/if}

    </table>

    <script type="text/javascript">
        {literal}
        setTimeout(function() {
            $('.check').unbind('click');
            $('.check').click(checkEl);
        }, 40);
        {/literal}
    </script>


    <div class="blu" style="padding: 10px 15px">
        <button type="submit" name="submit" value="1" class="btn btn-primary">Import selected</button>
    </div>
    {securitytoken}
</form>
