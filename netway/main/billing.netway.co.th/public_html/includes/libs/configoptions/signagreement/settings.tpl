{if !$field.set_field}
    <div class="clear alert alert-info">
        <div class="row no-gutter">
            <div class="col-lg-11">
                <b>{$lang.Note}:</b> {$lang.save_to_set_contract}
            </div>
        </div>
    </div><br>
{elseif !$field.contracts}
    <div class="clear alert alert-warning">
        <div class="row no-gutter">
            <div class="col-lg-11">
                <b>{$lang.Note}:</b> {$lang.contract_template_not_found}
            </div>
        </div>
    </div><br>
    <div class="clear">
        <a class="btn btn-sm btn-info" target="_blank" href="?cmd=configuration&action=contracts">{$lang.Settings}</a>
    </div>
{else}
    <div class="clear form-inline">
        <div class="col-sm-12 form-group">
            <div class="col-sm-3" style="margin-top: 7px;">
                <label for="check-admin">
                    {$lang.contract_template}
                </label>
            </div>
            <div class="col-sm-8">
                <select class="chosen" name="config[contract]">
                    {foreach from=$field.contracts item=contract key=id}
                        <option value="{$id}" {if $field.config.contract == $id}selected{/if}>{$contract}</option>
                    {/foreach}
                </select>
            </div>
        </div>
    </div>
    <div class="clear">
        <a class="btn btn-sm btn-info" style="margin-top: 10px;" target="_blank" href="?cmd=configuration&action=contracts">{$lang.new_contract_template}</a>
    </div>
    <div class="clear"></div>
    <div class="height" style="min-height: 70px;"></div>
{literal}
    <script>
        $('.chosen').chosenedge({width: '100%'});
        $('.chosen-container').on('click', function () {
            var h = $('.chosen-drop', this).height(),
                div = $('.height'),
                data = div.data('height');
            if (data && data > h)
                return false;
            div.css('min-height', h+'px').data('height', h);
        });
    </script>
{/literal}
{/if}