{if $keys}
    <form action="{$widget_url}&do=download" method="POST" target="_blank"  style="margin: 0">
        <h3 class="summarize">Public Key</h3>
        <input type="hidden" name="name" value="generated.pub" />
        <textarea readonly="readonly" name="key" style="width: 100%;;box-sizing: border-box; cursor: pointer">{$keys.public}</textarea>
        <div class="btn-group-cloud">
            <button class="btn btn-info" >Download Public Key</button>
        </div>
        {securitytoken}
    </form>
    <div class="mseparator"></div>
    <form action="{$widget_url}&do=download" method="POST" target="_blank" style="margin: 0">
        <h3 class="summarize">Private Key</h3>
        <input type="hidden" name="name" value="generated.key" />
        <textarea readonly="readonly" name="key" style="width: 100%;;box-sizing: border-box; cursor: pointer">{$keys.private}</textarea>

        <div class="btn-group-cloud">
            <button class="btn btn-info" >Download Private Key</button>
        </div>
        {securitytoken}
    </form>
    <div class="btn-group-cloud-alt">
        <a href="{$widget_url}" class="btn btn-default"><i class="icon icon-chevron-left"></i> Go Back</a>
    </div>
    <script type="text/javascript">
        {literal}
            $(function () {
                $("textarea").on('click focus',function () {
                    $(this).select();
                });
            })
        {/literal}
    </script>
{else}
    <table cellspacing="0" width="100%" class="data-table">
        <thead>
            <tr>
                <td>{$lang.name}</td>
                <td>{$lang.fingerprint}</td>
                <td></td>
            </tr>
        </thead>
        <tbody>
            {foreach from=$list item=key}
                <tr>
                    <td>{$key.name}</td>
                    <td>{$key.fingerprint|escape}</td>
                    <td>
                        <a href="{$widget_url}&do=delete&key={$key.id}&security_token={$security_token}" 
                           onclick="return confirm('Are you sure you want to remove this key?')" class="small_control small_delete fs11">{$lang.delete}</a>
                    </td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="3">{$lang.nothing}</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
    <div class="btn-group-cloud">
        {if $can_generate}
            <a class="btn btn-info" href="{$widget_url}#generate" id="genKeys">Generate new key</a>
        {/if}
        <a class="btn btn-info" href="{$widget_url}#register" id="regKeys">Register existing key</a>
    </div>
    <div class="clear"></div>

    <div class="modal hide fade" id="genKeysModal">
        <form action="{$widget_url}&do=generate" method="POST" style="margin: 0">
            <div class="modal-header">
                <button type="button" class="close hide-modal" aria-hidden="true">×</button>
                <h2 id="myModalLabel">Generate new SSH key pair</h2>
            </div>

            <div class="modal-body">
                <div class="control-group">
                    <label><strong>{$lang.name}</strong></label>
                    <input name="name" type="text" />
                </div>
                <p class="description fs11" >
                    Your private key will be available to download only once, make sure to save it somewhere safe.
                </p>
                <p class="description fs11" >
                    Public key will be automaticaly registared.
                </p>
            </div> 
            <div class="modal-footer">
                <span class="pull-right">
                    <button type="submit" class="default btn btn-flat-primary btn-primary">Generate</button>
                    <button type="button" class="default btn hide-modal">{$lang.cancel}</button>
                </span>
            </div>
            {securitytoken}
        </form>
    </div>

    <div class="modal hide fade" id="regKeysModal">
        <form action="{$widget_url}&do=register" method="POST" style="margin: 0">
            <div class="modal-header">
                <button type="button" class="close hide-modal" aria-hidden="true">×</button>
                <h2 id="myModalLabel">{$lang.registerexistingpublickey}</h2>
            </div>

            <div class="modal-body">
                <p class="description fs11" id="descDomainFwder">
                    {$lang.youmusthaveprivatekeythepairandpass}
                </p>
                <div class="control-group">
                    <label><strong>{$lang.name}</strong></label>
                    <input name="name" type="text" />
                </div>
                <div class="control-group">
                    <label><strong>{$lang.publickey}</strong></label>
                    <textarea name="pubkey" style="width: 100%; height: 200px; box-sizing: border-box;"></textarea>
                </div>
            </div> 
            <div class="modal-footer">
                <span class="pull-right">
                    <button type="submit" class="default btn btn-flat-primary btn-primary">{$lang.addkey}</button>
                    <button type="button" class="default btn hide-modal">{$lang.cancel}</button>
                </span>
            </div>
            {securitytoken}
        </form>
    </div>
    <script type="text/javascript">
        {literal}             $(function () {
                    $('#regKeys, #genKeys').click(function (e) {
                        e.preventDefault();
                    var self = $(this),
                        edit = $('#' + self.attr('id') + 'Modal').clone(true);

                    edit.find('.hide-modal').click(function () {
                    edit.modal('hide');                     });
                        edit.on('hidden', function () {
                        edit.remove();
                    });
                        edit.find(".vtip_description").data('tooltip', '');

            edit.on('shown', function () {
                edit.find(".vtip_description").tooltip();
                    });
                    edit.modal({
                        show: true,
                    })
                })
            })
        {/literal}
    </script>
{/if}