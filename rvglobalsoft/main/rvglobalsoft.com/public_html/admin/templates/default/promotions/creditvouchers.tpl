{if $section == 'submenu'}
    {if $action == 'default'}
        <div class="list-2">
            <div class="haveitems">
                <ul>
                    <li><a href="?cmd=creditvouchers&action=new_batch">Create new batch</a></li>
                </ul>
            </div>
        </div>
    {/if}
    {if $action !== 'default'}
        <ul class="breadcrumb" style="margin-bottom: 0">
            <li>
                <a href="?cmd=creditvouchers">List Vouchers</a>
            </li>
            {if  $action == 'new_batch'}
                <li>{$lang.addnewbatch}</li>
            {elseif $action == 'manage_batch' }
                <li class="active">#{$batch.id} {$batch.name}</li>
            {elseif $action == 'manage_batch' || $action == 'display_codes'}
                <li {if $action != 'display_codes'}class="active"{/if}>
                    <a href="?cmd=creditvouchers&action=manage_batch&id={$batch.id}">
                        #{$batch.id} {$batch.name}
                    </a>
                </li>
                <li class="active">{$lang.codes}</li>
            {/if}
        </ul>
    {/if}
{elseif $action=='default'}
    {if $batches}
        <form action="" method="post" id="testform">
            <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            <a href="?cmd=creditvouchers" id="currentlist" style="display:none" updater="#updater"></a>
            <table class="glike hover" width="100%" cellspacing="0" cellpadding="3" border="0">
                <tbody>
                    <tr>
                        <th><a href="?cmd=creditvouchers&orderby=name|ASC" class="sortorder">Batch name</a></th>
                        <th><a href="?cmd=creditvouchers&orderby=prefix|ASC" class="sortorder">Prefix / Voucher code</a></th>
                        <th><a href="?cmd=creditvouchers&orderby=created_at|ASC" class="sortorder">Created</a></th>
                        <th><a href="?cmd=creditvouchers&orderby=expires_at|ASC" class="sortorder">Expires</a></th>
                        <th><a href="?cmd=creditvouchers&orderby=active|ASC" class="sortorder">Active</a></th>
                        <th><a href="?cmd=creditvouchers&orderby=currency_id|ASC" class="sortorder">Currency</a>
                        </th>
                        <th><a href="?cmd=creditvouchers&orderby=value|ASC" class="sortorder">Value</a></th>
                        <th><a href="?cmd=creditvouchers&orderby=amount|ASC" class="sortorder">Amount</a></th>
                        <th><a href="?cmd=creditvouchers&orderby=used|ASC" class="sortorder">Used</a></th>
                        <th width="190"></th>
                    </tr>
                </tbody>
                <tbody id="updater">
                    {include file="promotions/ajax.creditvouchers.tpl"}
                </tbody>
                <tbody id="psummary">
                    <tr>
                        <th colspan="10">
                            {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span
                                    id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span
                                    id="sorterrecords">{$sorterrecords}</span>
                        </th>
                    </tr>
                </tbody>
            </table>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            {securitytoken}
        </form>
    {else}
        <div class="blank_state blank_news">
            <div class="blank_info">
                <h1>{$lang.creditvouchersheader}</h1>
                {$lang.creditvouchersdesc}
                <div class="clear"></div>
                <a class="new_add new_menu" href="?cmd=creditvouchers&action=new_batch" style="margin-top:10px">
                    <span>{$lang.addnewbatch}</span></a>
                <div class="clear"></div>
            </div>
        </div>
    {/if}
{elseif $action=='new_batch' || $action=='manage_batch'}
    <link href="{$template_dir}js/chosen/chosen.css" rel="stylesheet" media="all">
    <script type="text/javascript" src="{$template_dir}js/chosen/chosen.min.js?v={$hb_version}"></script>
    <form method="post">
        <input type="hidden" name="make" value="{if $action=='new_batch'}add{else}update{/if}"/>
        <div class="lighterblue2">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-6 col-md-8 col-xs-12">
                        <table border="0" cellpadding="6" cellspacing="0" width="100%">
                            <tbody>
                                {if $action=='manage_batch'}
                                    <tr>
                                        <td width="250" align="right"><strong>{$lang.batchname}</strong></td>
                                        <td><strong style="font-size: 16px;">{$batch.name}</strong></td>
                                    </tr>
                                    <tr>
                                        <td width="250" align="right">
                                            <label><strong>{$lang.datecreated}</strong></label></td>
                                        <td>{$batch.created_at|dateformat:$date_format}</td>
                                    </tr>
                                {else}
                                    <tr>
                                        <td width="250" align="right"><label
                                                    for="name"><strong>{$lang.batchname}</strong></label></td>
                                        <td>
                                            <div class="input-group">
                                                <input type="text" name="name" id="name" class="form-control"
                                                       size="50">
                                            </div>
                                        </td>
                                    </tr>
                                {/if}
                                <tr>
                                    <td width="250" align="right"><label
                                                for="size"><strong>{$lang.batchsize}</strong><a
                                                    class="vtip_description"
                                                    title="The number of generated codes"></a></label></td>
                                    <td>
                                        {if $action=='new_batch'}
                                            <div class="input-group">
                                                <input type="text" name="size" id="size" class="form-control"
                                                       size="4">
                                            </div>
                                        {else}
                                            <div class="creditVouchersSize">{$batch.amount}</div>
                                        {/if}
                                    </td>
                                </tr>
                                <tr>
                                    <td width="250" align="right"><label
                                                for="code_layout"><strong>{$lang.vouchercodelayout}</strong></label>
                                    </td>
                                    <td>
                                        {if $action=='new_batch'}
                                            <div class="input-group">
                                                <select name="code_layout" id="code_layout">
                                                    {foreach from=$code_layout key=key item=item}
                                                        <option value="{$key}" {if $batch.code_layout==$key || $key == 3}selected="selected"{/if}>{$item.name}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        {else}
                                            {$code_layout[$batch.code_layout].name}
                                        {/if}
                                    </td>
                                </tr>
                                <tr class="onchange_codelayout_hide">
                                    <td width="250" align="right"><label
                                                for="complexity"><strong>{$lang.codecomplexity}</strong></label>
                                    </td>
                                    <td>
                                        {if $action=='new_batch'}
                                            <select name="complexity" id="complexity">
                                                {foreach from=$complexity key=key item=item}
                                                    <option value="{$key}"
                                                            {if $key==2}selected="selected"{/if}>{$item.name}</option>
                                                {/foreach}
                                            </select>
                                        {elseif $action=='manage_batch' && $batch.code_layout == 4}
                                            <i>n/a</i>
                                        {else}
                                            {$complexity[$batch.complexity].name}
                                        {/if}
                                    </td>
                                </tr>
                                <tr class="onchange_codelayout_hide">
                                    <td width="250" align="right"><label
                                                for="prefix"><strong>{$lang.codeprefix}</strong><a
                                                    class="vtip_description"
                                                    title="Prefix for each generated code. It has to consist of 4 characters"></a></label>
                                    </td>
                                    <td>
                                        {if $action=='new_batch'}
                                            <div class="input-group">
                                                <input type="text" name="prefix" id="prefix" class="form-control"
                                                       size="4">
                                            </div>
                                        {elseif $action=='manage_batch' && $batch.code_layout == 4}
                                            <i>n/a</i>
                                        {else}
                                            {$batch.prefix}
                                        {/if}
                                    </td>
                                </tr>
                                <tr class="onchange_codelayout_show">
                                    <td width="250" align="right">
                                        <label for="voucher_code"><strong>Voucher code</strong></label>
                                    </td>
                                    <td>
                                        {if $action=='new_batch'}
                                            <div class="input-group">
                                                <input type="text" name="voucher_code" id="voucher_code" class="form-control">
                                            </div>
                                        {elseif $action=='manage_batch' && $batch.code_layout != 4}
                                            <i>n/a</i>
                                        {else}
                                            {$batch.prefix}
                                        {/if}
                                    </td>
                                </tr>
                                {if $action=='manage_batch'}
                                    <tr>
                                        <td width="250" align="right">
                                            <label><strong>{$lang.usedvouchers}</strong></label></td>
                                        <td>{$batch.used}</td>
                                    </tr>
                                    <tr>
                                        <td width="250" align="right" style="background-color: #eeeeee;">
                                            <label for="generate_codes">
                                                <strong>{$lang.generatenewcodes}</strong>
                                            </label>
                                        </td>
                                        <td style="background-color: #eeeeee; width: 260px; float: left">
                                            <div class="input-group">
                                                <input type="text" name="generate_codes" id="generate_codes"
                                                       value="{$batch.used_vouchers}" class="form-control">
                                                <span class="input-group-btn">
                                                    <a href="#"
                                                       onclick="generateCodes($(this),{$batch.id});return false;"
                                                       class="btn btn-default">Generate</a>
                                                </span>
                                            </div>
                                            <div class="creditVouchersLoaderImg">
                                                <img src="ajax-loading.gif">
                                            </div>
                                            {literal}
                                                <script>
                                                    function generateCodes(btn, batch_id) {
                                                        var count = $('#generate_codes').val();
                                                        if (!count || (parseInt(count) <= 0))
                                                            return;
                                                        if ($(btn).is('[disabled=disabled]'))
                                                            return;
                                                        $(btn).attr('disabled', true);
                                                        $('.creditVouchersLoaderImg').show();
                                                        $.ajax({
                                                            type: 'POST',
                                                            url: "?cmd=creditvouchers&action=generate_codes",
                                                            data: {
                                                                batch_id: batch_id,
                                                                count: count
                                                            },
                                                            success: function (data) {
                                                                var r = parse_response(data);
                                                                var sizeNow = $('.creditVouchersSize').html();
                                                                var sizeNew = parseInt(sizeNow) + parseInt(count);
                                                                $('.creditVouchersSize').html(sizeNew);
                                                                $('.creditVouchersLoaderImg').hide();
                                                                $(btn).attr('disabled', false);
                                                            }
                                                        });
                                                    }
                                                </script>
                                            {/literal}
                                        </td>
                                    </tr>
                                {/if}
                                <tr>
                                    <td width="250" align="right"><label
                                                for="value"><strong>{$lang.vouchervalue}</strong></label></td>
                                    <td>
                                        <div class="input-group">
                                            <input type="text" name="value" id="value" value="{$batch.value}"
                                                   class="form-control">
                                        </div>
                                    </td>
                                </tr>
                                {if count($currencies)>1}
                                    <tr>
                                        <td width="250" align="right"><label
                                                    for="currency_id"><strong>{$lang.currency}</strong></label></td>
                                        <td>
                                            <select name="currency_id" id="currency_id">
                                                {foreach from=$currencies item=curre}
                                                    <option value="{$curre.id}"
                                                            {if $batch.currency_id==$curre.id}selected="selected"{/if}>{if $curre.iso}{$curre.iso}{else}{$curre.code}{/if}</option>
                                                {/foreach}
                                            </select>
                                        </td>
                                    </tr>
                                {else}
                                    <input type="hidden" id="currency_id" value="{$batch.currency_id}"/>
                                {/if}
                                <tr>
                                    <td width="250" align="right"><strong>{$lang.expdate}</strong></td>
                                    <td>
                                        <div class="input-group">
                                            <input name="expires" class="config_val haspicker form-control"
                                                   {if $batch.expires_at}value="{$batch.expires_at|dateformat:$date_format}"{/if}/>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="250" align="right"><label
                                                for="one_per_account"><strong>{$lang.voucherperoneacc}</strong></label>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                            <input type="checkbox" name="one_per_account" id="one_per_account"
                                                   value="1" {if $batch.one_per_account}checked="checked"{/if}>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="250" align="right"><label
                                                for="only_new_clients"><strong>{$lang.vouchertonewacc}</strong></label>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                            <input type="checkbox" name="only_new_clients" id="only_new_clients"
                                                   value="1" {if $batch.only_new_clients}checked="checked"{/if}>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            {literal}
                <style>
                    .creditVouchersLoaderImg {
                        display: none;
                        margin: 0 auto;
                        text-align: center;
                    }
                </style>
                <script>
                    $(function () {
                        $('#code_layout').change(function () {
                            var sv = $(this).val() == 4;
                            console.log(sv);
                            $('.onchange_codelayout_hide').toggle(!sv);
                            $('.onchange_codelayout_show').toggle(sv);
                        }).trigger('change');
                    });
                </script>
            {/literal}
            {if $action=='manage_batch'}
                <div class="row">
                    <div class="col-md-12">
                        <a href="?cmd=creditvouchers&action=display_codes&id={$batch.id}"
                           class="btn btn-sm btn-default">Display codes</a>
                    </div>
                </div>
            {/if}
        </div>
        <div class="blu">
            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td>
                        {if $action=='new_batch'}
                            <button class="btn btn-primary btn-sm">Create batch</button>
                        {elseif $action=='manage_batch'}
                            <button class="btn btn-primary btn-sm">Save changes</button>
                        {/if}
                        <button class="btn btn-default btn-sm" onclick="location.reload();return false;">
                            Cancel
                        </button>
                    </td>
                </tr>
            </table>
        </div>
        {securitytoken}
    </form>
{elseif $action=='display_codes'}
    <form action="" method="post" id="testform">
        <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
        <div class="blu">
            <div class="left">
                <a href="?cmd=creditvouchers&action=generatecsv&id={$batch.id}" class="btn btn-sm btn-default">
                    Export to CSV
                </a>
            </div>
            <div class="right">
                <div class="pagination"></div>
            </div>
            <div class="clear"></div>
        </div>
        <a href="?cmd=creditvouchers&action=display_codes&id={$batch.id}" id="currentlist" style="display:none"
           updater="#updater"></a>
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <thead>
                <tr>
                    <th><a href="?cmd=creditvouchers&action=display_codes&id={$batch.id}&orderby=id|ASC"
                           class="sortorder">ID #</a></th>
                    <th><a href="?cmd=creditvouchers&action=display_codes&id={$batch.id}&orderby=code|ASC"
                           class="sortorder">Voucher code</a></th>
                    <th><a href="?cmd=creditvouchers&action=display_codes&id={$batch.id}&orderby=used_at|ASC"
                           class="sortorder">Used</a></th>
                    <th><a href="?cmd=creditvouchers&action=display_codes&id={$batch.id}&orderby=user_id|ASC"
                           class="sortorder">User</a></th>
                    <th><a href="?cmd=creditvouchers&action=display_codes&id={$batch.id}&orderby=used_at|ASC"
                           class="sortorder">Activation date</a></th>
                    <th width="70"></th>
                </tr>
            </thead>
            <tbody id="updater">
                {include file="promotions/ajax.creditvouchers.tpl"}
            </tbody>
            <tbody id="psummary">
                <tr>
                    <th colspan="7">
                        {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span
                                id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span
                                id="sorterrecords">{$sorterrecords}</span>
                    </th>
                </tr>
            </tbody>
        </table>
        {literal}
            <script>
                function deleteCode(btn, id) {
                    if ($(btn).is('[disabled=disabled]'))
                        return;
                    var row = $(btn).closest('tr');
                    $(btn).attr('disabled', true);
                    $.ajax({
                        type: 'POST',
                        url: "?cmd=creditvouchers&action=delete_code",
                        data: {
                            id: id
                        },
                        success: function (data) {
                            var r = parse_response(data);
                            $(row).remove();
                            $(btn).attr('disabled', false);
                        }
                    });
                }
            </script>
        {/literal}
        <div class="blu">
            <div class="left">
                <a href="?cmd=creditvouchers&action=generatecsv&id={$batch.id}" class="btn btn-sm btn-default">
                    Export to CSV
                </a>
            </div>
            <div class="right">
                <div class="pagination"></div>
            </div>
            <div class="clear"></div>
        </div>
        {securitytoken}
    </form>
{/if}

