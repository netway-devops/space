{if $action=='getadvanced'}

    <a href="?cmd=clientcredit&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=clientcredit" method="post" onsubmit="return filter(this)">
        {include file="_common/filters.tpl"}
        {securitytoken}
    </form>

    <script type="text/javascript">bindFreseter();</script>

{elseif $action=='default' ||  $action=='clientlog'}
    {if !$ajax}
        <div class="blu">
            <div class="left menubar">
                <a href="#" class="menuitm logaddentry"><strong>Add new entry</strong></a>
            </div>
            <div class="right"><div class="pagination"></div>
            </div>
            <div class="clear"></div>
        </div>
    {/if}
    {if $log}
        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>

                <a href="?cmd=clientcredit" id="currentlist" style="display:none" updater="#updater"></a>
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover" style="table-layout: fixed;">
                    <tbody>
                        <tr>
                            <th  width="130"><a href="?cmd=clientcredit&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                            <th  width="150"><a href="?cmd=clientcredit&orderby=lastname|ASC"  class="sortorder">Client</a></th>
                            <th><a href="?cmd=clientcredit&orderby=description|ASC"  class="sortorder">Description</a></th>
                            <th width="120">Increase</th>
                            <th width="120">Decrease</th>
                            <th width="150">Credit after</th>
                            <th width="130"><a href="?cmd=clientcredit&orderby=transaction_id|ASC"  class="sortorder">Trans. id</a></th>
                            <th width="90"><a href="?cmd=clientcredit&orderby=invoice_id|ASC"  class="sortorder">Invoice</a></th>
                            <th width="130"><a href="?cmd=clientcredit&orderby=admin_name|ASC"  class="sortorder">Staff</a></th>
                            <th width="100"></th>
                        </tr>
                    </tbody> 
                    <tbody id="updater"> 
                    {/if}
                    {foreach from=$log item=email}
                        <tr>
                            <td>{$email.date|dateformat:$date_format}</td>   
                            <td>
                               <a href="?cmd=clients&action=show&id={$email.client_id}" target="_blank">{$email.firstname} {$email.lastname}</a>
                            </td>
                            <td>{$email.description}</td>   
                            <td>{$email.in|price:$email.currency_id}</td>  
                            <td>{$email.out|price:$email.currency_id}</td>  
                            <td>{$email.balance|price:$email.currency_id}</td>  
                            <td>{if $email.transid}<a href="?cmd=transactions&action=edit&id={$email.transid}" target="_blank" title="{$email.transaction_id}">{$email.transaction_id|truncate:16}</a>{elseif $email.transaction_id}{$email.transaction_id|truncate:16}{else}-{/if}</td> 
                            <td>{if $email.invoice_id}<a href="?cmd=invoices&action=edit&id={$email.invoice_id}&list=all" target="_blank">{$email.invoice_id}</a>{else}-{/if}</td> 
                            <td>{if $email.admin_id}<a href="?cmd=editadmins&action=administrator&id={$email.admin_id}" target="_blank">{$email.admin_name}</a>{else}-{/if}</td> 
                            <td>
                                <a href="#" data-edit="{$email.data_edit|@json_encode|escape}" class="btn btn-default btn-xs logeditentry"><span>Edit</span></a>
                                <a href="?cmd=clientcredit&action=deletelogentry&id={$email.id}&security_token={$security_token}" class="btn btn-default btn-xs logdeleteentry" onclick="return confirm('Are you sure you want to remove this entry?');"><span style="color: red;">Delete</span></a>
                            </td>
                        </tr>
                    {/foreach}
                    {if $showall}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th colspan="10">
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                            </th>
                        </tr>
                    </tbody>
                </table>
                <div class="blu">
                    <div class="left">
                      
                    </div>
                    <div class="right"><div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                <input type="hidden" name="client_id" value="{$currentfilter.client_id}">
                {securitytoken}
            </form>
        {/if}
    {else} 
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="4"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}
    <div id="logaddentryform" class="modal-content" hidden bootbox data-title="">
        <form action="?cmd=clientcredit" method="post">
            <div class="form-group">
                <label class="control-label">{$lang.Date}</label>
                <div>
                    <input type="text" name="date" class="form-control haspicker" placeholder="eg. {"2014-05-15"|dateformat:$date_format}">
                </div>
            </div>
            <div class="clearfix"></div>
            <br>
            <div class="form-group">
                <label class="control-label">Client</label>
                <select name="client_id" class="form-control" id="client-search" data-required></select>
            </div>
            <div class="form-group">
                <label class="control-label">{$lang.Description}</label>
                <textarea name="description" class="form-control form_input_modal" placeholder="Short description about this entry"></textarea>
            </div>
            <div class="row">
                <div class="form-group col-md-4">
                    <label class="control-label">{$lang.increase}</label>
                    <input type="text" name="in" class="form-control form_input_modal"placeholder="{$lang.increase}"/>
                </div>
                <div class="form-group col-md-4">
                    <label class="control-label">{$lang.decrease}</label>
                    <input type="text" name="out" class="form-control form_input_modal"placeholder="{$lang.decrease}"/>
                </div>
                <div class="form-group col-md-4">
                    <label class="control-label">{$lang.creditafter}</label>
                    <input type="text" name="balance" class="form-control form_input_modal"placeholder="{$lang.creditafter}"/>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-md-6">
                    <label class="control-label">{$lang.related_transaction}</label>
                    <input type="text" name="transaction_id" class="form-control form_input_modal"placeholder="Related transaction"/>
                </div>
                <div class="form-group col-md-6">
                    <label class="control-label">{$lang.related_invoice}</label>
                    <input type="text" name="invoice_id" class="form-control form_input_modal"placeholder="Related Invoice"/>
                </div>
            </div>
            <div class="row client_credit_balance">
                <div class="form-group col-md-12">
                    <input type="checkbox" name="change_balance" value="1"/>
                    <label >Adjust client credit balance with Increase/Decrease of this entry</label>
                </div>
            </div>
            <input type="hidden" name="entry_id" id="log_entry_id" value="" />
            <input type="hidden" name="action" id="log_action" value=""/>
            <input type="hidden" name="make" value="addlogentry"/>
            {securitytoken}
        </form>
    </div>
{/if}
{literal}
    <script type="text/javascript">
        $(function () {
            $('#logaddentryform').bootboxform({
                formaction: '',
                callback: function (e, ele) {
                    var form = $('form', this);
                    var action = $(form).attr('action');

                    form.find('[data-required]').trigger('input');
                    console.log(form.find('.has-error'));
                    if(form.find('.has-error').length)
                        return false;

                    form.submit();
                    return true;
                }
            }).on('bootbox-form.shown', function (e, dialog) {
                dialog.find('input, select, textarea').on('input',function () {
                    $(this).closest('.form-group').toggleClass('has-error', this.value.length === 0)
                });
                dialog.find('select').chosenedge({width: '100%'});
                $('#client-search',dialog).chosensearch();
            });

            $('.logeditentry').on('click', function () {
                var data = $(this).data('edit'),
                    modal = $('#logaddentryform'),
                    modaldata = modal.data('bootboxform'),
                    text = 'Edit entry',
                    editBalance = $('.client_credit_balance');

                editBalance.hide();
                editBalance.find('input[name="change_balance"]').prop('checked',false);
                modaldata.title = text;
                modaldata.buttons.confirm.label = text;
                modal.on('bootbox-form.shown', function (e, dialog) {
                    Object.keys(data).map(function (value) {
                        var form = dialog.find('[name="' + value + '"]');
                        if (!form.length)
                            return;
                        form.val(data[value]);
                        if (value === 'client_id')
                            form.data('chosensearch').set(data[value], '#' + data[value]);
                    });
                    dialog.find('#log_entry_id').val(data.id);
                    dialog.find('#log_action').val('updatelogentry');
                }).trigger('show', [modaldata]);
                return false;
            });

            $('.logaddentry').on('click', function () {
                var modal = $('#logaddentryform'),
                    modaldata = modal.data('bootboxform'),
                    text = 'Add entry',
                    editBalance = $('.client_credit_balance');

                editBalance.show();
                modaldata.title = text;
                modaldata.buttons.confirm.label = text;
                modal.on('bootbox-form.shown', function (e, dialog) {
                    dialog.find('.form_input_modal').val('');
                    var clientId = $('input[name="client_id"]').val();
                    if (clientId !== '')
                        dialog.find('select[name="client_id"]').data('chosensearch').set(clientId, '#' + clientId);
                    dialog.find('#log_entry_id').val('');
                    dialog.find('#log_action').val('addlogentry');
                }).trigger('show', [modaldata]);
                return false;
            })
        });
    </script>
{/literal}