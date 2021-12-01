{if $action=='clientcontracts'}
    {literal}
        <script>
            $('#AdmNotes').remove();
            $('#clientfiles').remove();
            function loadContract(href, title) {
                $.ajax({
                    type: 'POST',
                    url: href,
                    success: function (data) {
                        bootbox.dialog({
                            message: data,
                            title: title,
                            backdrop: true,
                            buttons: {
                                close: {
                                    label: "Close",
                                    className: "btn-default",
                                },
                                success: {
                                    label: "Submit",
                                    className: "btn-success",
                                    callback: function () {
                                        var form = $('#form-contract');
                                        var form_url = form.attr('action');
                                        var form_method = form.attr('method') || 'POST';
                                        var form_data = new FormData($(form)[0]);

                                        $.ajax({
                                            type: form_method,
                                            url: form_url,
                                            data: form_data,
                                            cache: false,
                                            contentType: false,
                                            processData: false,
                                            success: function (data) {
                                                parse_response(data);
                                                $('.quitlist_contracts').parent().html("Loading");
                                                $('.nav_el_contracts').trigger('click');
                                            }
                                        });
                                        return true;
                                    }
                                },
                            }
                        });
                    }
                });
            }

            function removeContract(href) {
                if (!confirm('Are you sure?'))
                    return false;

                $.ajax({
                    type: 'POST',
                    url: href,
                    success: function (data) {
                        parse_response(data);
                        $('.quitlist_contracts').parent().html("Loading");
                        $('.nav_el_contracts').trigger('click');
                    }
                });
                return true;
            }

            function deleteAttachedFile(file_id) {
                $.ajax({
                    type: 'POST',
                    url: '?cmd=contracts&action=deletefile',
                    data: {file_id: file_id},
                    success: function (data) {
                        parse_response(data);
                        $('.attached-file-' + file_id).remove();
                    }
                });
                return true;
            }
        </script>
    {/literal}
    <div class="quitlist_contracts">
        <div class="clearfix" style="padding-bottom: 5px;">
            <div class="col-sm-12">
                <div class="row">
                    <div class="pull-right">
                        <a onclick="loadContract('?cmd=contracts&action=new_contract&client_id={$client_id}', 'New Contract'); return false;" href="#" class="btn btn-primary btn-xs" target="_blank"><i class="fa fa-plus"></i> New Contract</a>
                    </div>
                </div>
            </div>
        </div>
        {if $contracts}
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                <tbody>
                <tr>
                    <th><a href="?cmd=contracts&action=clientcontracts&id={$client_id}" class="sortorder" data-orderby="id">ID</a></th>
                    <th><a href="?cmd=contracts&action=clientcontracts&id={$client_id}" class="sortorder" data-orderby="number">Number</a></th>
                    <th><a href="?cmd=contracts&action=clientcontracts&id={$client_id}" class="sortorder" data-orderby="client_id">{$lang.Client}</a></th>
                    <th><a href="?cmd=contracts&action=clientcontracts&id={$client_id}" class="sortorder" data-orderby="template_id">Contract Template</a></th>
                    <th><a href="?cmd=contracts&action=clientcontracts&id={$client_id}" class="sortorder" data-orderby="created_at">{$lang.Date}</a></th>
                    <th><a href="?cmd=contracts&action=clientcontracts&id={$client_id}" class="sortorder" data-orderby="expires">Expires</a></th>
                    <th><a href="?cmd=contracts&action=clientcontracts&id={$client_id}" class="sortorder" data-orderby="accepted_at">Accepted date</a></th>
                    <th><a href="?cmd=contracts&action=clientcontracts&id={$client_id}" class="sortorder" data-orderby="accepted_by">Accepted by</a></th>
                    <th><a href="?cmd=contracts&action=clientcontracts&id={$client_id}" class="sortorder" data-orderby="status">{$lang.Status}</a></th>
                    <th width="70px"></th>
                </tr>
                </tbody>
                <tbody>
                {foreach from=$contracts item=ct}
                    <tr class="contractlist-{$ct.id}">
                        <td>{$ct.id}</td>
                        <td>{$ct.number} {if $ct.flags & 1}<label class="label label-sm label-success label-success-invert">Default</label>{/if}</td>
                        <td>{$ct.client_id|@client}</td>
                        <td><a href="?cmd=configuration&action=contracts" target="_blank">{$ct.template_name}</a></td>
                        <td>{$ct.created_at|dateformat:$date_format}</td>
                        <td>{if $ct.expires}{$ct.expires|dateformat:$date_format}{else}-{/if}</td>
                        <td>{if $ct.accepted_at}{$ct.accepted_at|dateformat:$date_format}{else}-{/if}</td>
                        <td>
                            {if $ct.accepted_by}
                                {if $ct.accepted_by < 0}
                                    Admin #{$ct.accepted_by|@abs}
                                {else}
                                    {$ct.accepted_by|@client}
                                {/if}
                            {else}-{/if}
                        </td>
                        <td><span class="{$ct.status}">{$lang[$ct.status]}</span></td>
                        <td width="70px">
                            <a class="editbtn" onclick="loadContract('?cmd=contracts&action=edit_contract&id={$ct.id}', 'Edit Contract'); return false;" href="#">Edit</a>
                            <a class="editbtn" style="color:red;" onclick="removeContract('?cmd=contracts&action=remove_contract&id={$ct.id}&make=remove'); return false;" href="#">Remove</a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="text-right" style="margin: 10px 0px;">
                <div style="display:inline-block">
                    <strong>{$lang.records_per_page}</strong>
                    <select name="contracts_per_page" id="contracts_per_page">
                        <option value="10" {if $contracts_per_page == 10}selected{/if}>10</option>
                        <option value="20" {if $contracts_per_page == 20}selected{/if}>20</option>
                        <option value="50" {if $contracts_per_page == 50}selected{/if}>50</option>
                        <option value="100" {if $contracts_per_page == 100}selected{/if}>100</option>
                        <option value="100000" {if $contracts_per_page == 100000}selected{/if}>All</option>
                    </select>
                </div>
                <div style="display:inline-block">
                    <center class="paginercontainer">
                        <strong>{$lang.Page} </strong>
                        {section name=foo loop=$totalpages}
                            <a href='?cmd=contracts&action=clientcontracts&id={$client_id}&page={$smarty.section.foo.iteration-1}' class="npaginer
                                   {if $smarty.section.foo.iteration-1==$currentpage}
                                       currentpage
                                   {/if}"
                            >{$smarty.section.foo.iteration}</a>
                        {/section}
                    </center>
                </div>
            </div>
        {else}
            <p style="text-align: center">{$lang.nothingtodisplay}</p>
        {/if}
        {if $contracts}
            <script>
                {literal}
                $(function () {
                    pagination();
                });

                function pagination() {
                    $('.paginercontainer', 'div.slide:visible').infinitepages();
                    FilterModal.bindsorter('{/literal}{$orderby.orderby}', '{$orderby.type}'{literal});
                    $('#contracts_per_page').on('change', function () {
                        var form_client = {contracts_per_page: $(this).val()},
                                url = "?cmd=contracts&action=clientcontracts&id={/literal}{$client_id}{literal}",
                                name = $(this).attr('name');
                        ajax_update(url, form_client, $('div.slide:visible'), true);
                    });
                }
                {/literal}
            </script>
        {/if}
    </div>
{elseif $action==='edit_contract' || $action==='new_contract'}
    <form action="?cmd=contracts&action={$action}" method="POST" id="form-contract" enctype="multipart/form-data">
        <div class="row">
            <div class="form-group col-md-6">
                <p><b>Contract Number</b></p>
                <input name="number" class="form-control" type="text"  value="{$contract.number}">
            </div>
            <div class="form-group col-md-6">
                <p><b>Use as default contract</b></p>
                <input id="flag_default" type="checkbox" name="flags[]" value="1" {if $contract.flags & 1}checked="checked"{/if}>
                <label for="flag_default">Yes</label>
            </div>
        </div>
        <div class="row">
            <div class="form-group col-md-12">
                <p><b>Contract Template</b></p>
                <select name="template_id" class="form-control">
                    {foreach from=$contract_templates item=tmpl}
                        <option value="{$tmpl.id}" {if $tmpl.id == $contract.template_id}selected="selected"{/if}>{$tmpl.name}</option>
                    {/foreach}
                </select>
                <a href="?cmd=configuration&action=contracts"><small>Show all templates</small></a>
            </div>
        </div>
        <div class="row">
            <div class="form-group col-md-6">
                <p><b>Status</b></p>
                <select name="status" class="form-control">
                    <option value="Draft" {if $contract.status === 'Draft'}selected="selected"{/if}>Draft</option>
                    <option value="Pending" {if $contract.status === 'Pending'}selected="selected"{/if}>Pending</option>
                    <option value="Active" {if $contract.status === 'Active'}selected="selected"{/if}>Active</option>
                    <option value="Expired" {if $contract.status === 'Expired'}selected="selected"{/if}>Expired</option>
                    <option value="Canceled" {if $contract.status === 'Canceled'}selected="selected"{/if}>Canceled</option>
                </select>
            </div>
            <div class="form-group col-md-6">
                <p><b>Expires date</b></p>
                <input name="expires" class="form-control haspicker" type="text" value="{if $contract.expires}{$contract.expires|dateformat:$date_format}{/if}">
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="form-group col-md-2">
                <p><b>Accepted ?</b></p>
                <input id="accepted_by" type="checkbox" name="accepted_by" value="{$contract_client.id}" {if $contract.accepted_by}checked="checked"{/if}>
                <label for="accepted_by">Yes</label>
            </div>
            <div class="form-group col-md-6">
                <p><b>Accepted date</b></p>
                <div class="input-group searchform" style="width: 100%;">
                    <div class="datepicker">
                        <input name="accepted_at" class="form-control haspicker" type="text" value="{$contract.accepted_at|dateformat:$date_format:false}">
                    </div>
                </div>

            </div>

            <div class="form-group col-md-4">
                <p><b>Accepted time</b></p>
                <input name="accepted_at_time" class="form-control" type="text" value="{$contract.accepted_at_time}">
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="form-group col-md-12">
                <p><b>Public note</b></p>
                <textarea class="form-control" name="public_notes" style="min-height: 70px;">{$contract.public_notes}</textarea>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="form-group col-md-12">
                <p><b>Attached files</b></p>
                {if !$files}
                    <em class="notfiles">This contract does not have any files added yet</em>
                {else}
                    <ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:10px" id="grab-sorter" >
                        {foreach from=$files item=f}
                            <li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;" class="attached-file-{$f.id}">
                                    <table width="100%" cellspacing="0" cellpadding="5" border="0">
                                        <tr>
                                            <td>
                                                <a class="dwbtn left" href="?cmd=root&action=download&type=downloads&id={$f.id}">download</a>
                                                <a href="?cmd=root&action=download&type=downloads&id={$f.id}">{$f.name}</a>
                                            </td>
                                            <td width="20">
                                                <a onclick="if (confirm('Are you sure you want to delete this file?'));deleteAttachedFile({$f.id});" class="delbtn" href="#">delete</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        {/foreach}
                    </ul>
                {/if}
                <div id="fileform" class="blu" style="display:none">
                    <table cellpadding="0" cellspacing="6" width="100%">
                        <tr>
                            <td align="right"><strong>{$lang.Name}</strong></td>
                            <td><input name="filename" /></td>
                            <td align="right"><strong>{$lang.file}</strong></td>
                            <td><input type="file" name="file" /></td>
                        </tr>
                    </table>
                </div>
                <a href="#" class="menuitm right" onclick="$('.notfiles').hide();$(this).hide();$('#fileform').show();return false;"><span>Upload file</span></a>
            </div>
        </div>
        {if $action==='edit_contract'}
            <hr>
            <div class="row">
                <div class="form-group col-md-12">
                    {include file='_common/noteseditor.tpl'}
                </div>
            </div>
            <input type="hidden" name="id" value="{$contract.id}">
        {/if}
        <input type="hidden" name="make" value="save">
        <input type="hidden" name="client_id" value="{$contract_client.id}">
        {securitytoken}
    </form>
    <script>
        $('.haspicker').datePicker();
    </script>
{/if}