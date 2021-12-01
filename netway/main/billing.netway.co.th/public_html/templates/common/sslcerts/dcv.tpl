{if $dcv_methods}
    <div id="dcv">
        <div class="form-group" id="dcv-method">

            {if count($dcv_methods) > 1}
                <label><strong>{$lang.dcv_method}</strong></label>
                <div>
                    <select name="dcv">
                        {foreach from=$dcv_methods item=dcv}
                            <option value="{$dcv.type}" {if $customdata.dcv == $dcv.type}selected{/if}>{$lang[$dcv.lang]}</option>
                        {/foreach}
                    </select>
                </div>
            {else}
                {foreach from=$dcv_methods item=dcv}
                    <strong>{$lang[$dcv.lang]}</strong>
                    <input type="hidden" name="dcv" value="{$dcv.type}" />
                {/foreach}
            {/if}
        </div>
        {foreach from=$dcv_methods item=dcv}
            <div class="dcv dcv-{$dcv.type}">
                <p>{$lang[$dcv.descr_lang]}</p>
                {if $dcv.type == 'email'}
                    <div id="approver-list" data-init="{$approveremails|@json_encode|escape}" 
                         {if $customdata.approval_email}data-initval="{$customdata.approval_email|@json_encode|escape}"{/if}>	
                    </div>
                    {literal}
                        <script type="text/template" id="approver-tpl">
                            <div class="form-group" >
                            <label>{/literal}{$lang.approver_email_for}{literal}</label>
                            <div>
                            <select name="approval_email[%name%]">%options%</select>
                            </div>
                            </div>
                        </script>
                        <script>
                            $(function () {
                                $('select, input', '#dcv-method').on('change', function () {
                                    $('#dcv .dcv').hide().filter('.dcv-' + $(this).val()).show();
                                }).trigger('change');

                                var list = $('#approver-list'),
                                    tpl = $('#approver-tpl').html();

                                function render(emails, values) {
                                    var html = '';
                                    $.each(emails, function (name, options) {
                                        if (!options)
                                            return '';
                                        
                                        var opt = '';
                                        for (var i = 0, l = options.length; i < l; i++) {
                                            var op = options[i],
                                                selected = op == values[name] ? 'selected' : '';
                                            opt += '<option value="' + op + '" ' + selected + '>' + op + '</option>';
                                        }
                                        html += tpl.replace(/%name%/g, name)
                                            .replace('%options%', opt)
                                            .replace('%s', name);
                                    });
                                    return html;
                                }


                                $(document).on('change', '.custom-san', function () {
                                    list.addClass('loading');
                                    list.data('changed', true);
                                })

                                $(document).on('ajaxComplete ', function () {
                                    if (!list.data('changed'))
                                        return;

                                    list.data('changed', false);
                                    $.get(window.location.href + '&dcvemails', function (data) {
                                        if (!data || !data.emails || data.error)
                                            return;

                                        var values = {};
                                        $('select', list).map(function () {
                                            values[this.name.match(/\[(.*)\]/)[1]] = this.value;
                                        });

                                        list.html(render(data.emails, values));
                                        list.removeClass('loading');
                                    })
                                })
                                var listdata = list.data();
                                list.html(render(listdata.init, listdata.initval || {}));
                            })
                        </script>
                    {/literal}
                {/if}
            </div>
        {/foreach}
    </div>
{/if}