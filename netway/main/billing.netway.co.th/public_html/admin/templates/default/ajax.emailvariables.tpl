{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.emailvariables.tpl.php');
{/php}

{if $variables}
    <div class="well">
        <div class="fo"></div>

        <div class="form-group">
            <label for="availvars">{$lang.showmevars}</label>
            <br />
            <select name="availvars" id="availvars" class="inp">
                {*}<option value="0">{$lang.availvars}</option>{*}
                {foreach from=$variables item=var key=var_key}
                    {if ($to=='unsuspend' || $to=='suspend' || $to=='terminate' || $to=='welcome') && ($var_key=='domain' || $var_key=='invoice' || $var_key=='other')}
                    {else}
                        <optgroup label="{if $lang[$var_key]}{$lang[$var_key]}{else}{$var_key}{/if}">
                            {foreach from=$var item=var_desc key=var_name}
                                <option value="{ldelim}${if $var_key != 'other'}{$var_key}.{/if}{$var_name}{rdelim}">{if $lang[$var_desc]}{$lang[$var_desc]}{else}{$var_desc}{/if} </option>
                            {/foreach}
                        </optgroup>
                    {/if}
                {/foreach}
            </select>
            <input type="text" readonly class="inp" style="min-width:200px; " id="varpreview" onclick="this.select()"/>
        </div>


        {if !$inline && $email.for!='Admin'}
            <div id="chooselang" style="display:none">
                <span class="fs11">{$lang.chooselanguage}:</span> <select name="newtr">
                    {foreach from=$alanguages item=l}
                        <option >{$l|ucfirst}</option>
                    {/foreach}
                </select>
                <input type="button" value="{$lang.Add}" onclick="addTranslation()" />
            </div>
        {/if}

        <a  class="btn btn-primary" id="preview-form-act" href="#preview">{$lang.Preview}</a>
    </div>

    <div class="modal fade" id="preview-modal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Preview Setup</h4>
                </div>
                <div class="modal-body form-horizontal">
                    <div class="form-group type">
                        <label class="control-label col-sm-3" for="notification">Notification Type:</label>
                        <select name="notification" id="notification" class="form-control">
                            <option value="generic">Default Notification</option>
                            {foreach from=$notifications key=notify item=item}
                                <option value="{$notify}" data-params="{$item.params|@json_encode|escape}"
                                {if $lang[$notify] && stristr($lang[$notify], $email.tplname)}selected{/if}>{if $lang[$notify]}{$lang[$notify]}{else}{$notify}{/if}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="form-group optional client">
                    <label class="control-label col-sm-3" for="preview-client">Client:</label>
                    <select name="client" id="preview-client" class="form-control" >

                    </select>
                </div>
                <div class="form-group optional account service">
                    <label class="control-label col-sm-3" for="preview-account">Account:</label>
                    <select name="account" id="preview-account" class="form-control" data-type="Accounts" data-label="#$id $domain $firstname $lastname">

                    </select>
                </div>
                <div class="form-group optional domain">
                    <label class="control-label col-sm-3" for="preview-domain">Domain:</label>
                    <select name="domain" id="preview-domain" class="form-control" data-type="Domains" data-label="#$id $name">

                    </select>
                </div> 
                <div class="form-group optional order">
                    <label class="control-label col-sm-3" for="preview-order">Order:</label>
                    <select name="order" id="preview-order" class="form-control" data-type="Orders" data-label="#$id Order #$number">

                    </select>
                </div>
                <div class="form-group optional estimate">
                    <label class="control-label col-sm-3" for="preview-invoice">Estimate:</label>
                    <select name="estimate" id="preview-estimate" class="form-control" data-type="Estimates" data-label="#$id $subject [$status]">

                    </select>
                </div>
                <div class="form-group optional invoice">
                    <label class="control-label col-sm-3" for="preview-invoice">Invoice:</label>
                    <select name="invoice" id="preview-invoice" class="form-control" data-type="Invoices" data-label="#$id">

                    </select>
                </div>
                <div class="form-group optional transaction">
                    <label class="control-label col-sm-3" for="preview-transaction">Transaction:</label>
                    <select name="transaction" id="preview-transaction" class="form-control" data-type="Transactions" data-label="$trans_id $firstname $lastname">

                    </select>
                </div>
                <div class="form-group optional ticket">
                    <label class="control-label col-sm-3" for="preview-ticket">Ticket:</label>
                    <select name="ticket" id="preview-ticket" class="form-control" data-type="Tickets" data-label="#$ticket_number $subject">

                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Preview</button>
            </div>
        </div>
    </div>
</div>
{literal}
    <script type="text/javascript">
        $(function () {
            $('#preview-form-act').on('click', function () {
                $('#preview-modal').modal({
                    keyboard: false
                })
            })

            var modal = $('#preview-modal'),
                type = $('.form-group.type select', modal),
                groups = $('.form-group.optional', modal);

            groups.find('select').on('change update', function () {
                $(this).removeClass('error');
            }).hbsearchselect({
                width: '350px'
            });

            type.on('change update', function () {
                groups.hide();
                var params = $(':selected', this).data('params');
                if (params)
                    groups.filter('.' + params.join(', .')).show();
            }).trigger('update');

            type.width('350px').chosen();

            $('.btn-primary', modal).on('click', function () {
                var form = $('#previewform');

                var error = 0;
                $('#preview-modal .form-group:visible select').removeClass('error').each(function () {
                    var self = $(this);
                    if (!self.val()) {
                        error = 1;
                        self.addClass('error')
                        return false;
                    }
                })
                if (error)
                    return;

                form.html('');

                $('input[name^=subject], input[name^=security], select[name^=sendas], #preview-modal select', '#bodycont form').each(function () {
                    var self = $(this);
                    form.append($('<input>', {
                        name: self.attr('name'),
                        type: 'hidden',
                        value: self.val()
                    }));
                })

                $('textarea[id]').each(function () {
                    var self = $(this);
                    if (self.data('ace')) {
                        self.val(self.data('aceeditor').getSession().getValue());
                    }
                    form.append(self.clone().css('display', 'none'));

                })
                form.submit();
                return false;
            })

            $('#availvars').on('change update', function () {
                var self = $(this),
                    displ = self.next();

                displ.val(self.val());
            }).trigger('update');
        })
    </script>
    <style>
        .error + .chzn-container a{
            box-shadow: 0 0 7px 0px #ff2d2d;
            border-color: red;
        }
    </style>
{/literal}

{/if}