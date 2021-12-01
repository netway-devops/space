{if $servers}
{literal}
    <script type="text/javascript">

        $(function () {
            var warn = $('.import-warn'),
                btn = $('#import-continue');

            $('.chosenedge').chosenedge({
                width: '100%',
                enable_split_word_search: true,
                search_contains: true,
            }).on('change', function () {
                btn.prop('disabled', true)
                $.post('?cmd=importaccounts&action=verifySupport', {id: this.value}, function (data) {
                    var type = data && data.support || '0';

                    warn.hide();
                    if (type === '0') {
                        $('#warn-no-support').show()
                        return;
                    }

                    btn.prop('disabled', false)
                    if (type === '2' || type === '3') {
                        $('#warn-product').show();
                    }
                })
                return false;
            }).trigger('change')
        })

    </script>
{/literal}
    <form action="" method="post">
        <div class="container-fluid" style="margin-top: 10px">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <label>{$lang.pleasechooseserv}</label>
                        <select name="server_id" id="server_id" class="form-control chosenedge">
                            {foreach from=$servers item=group}
                                <optgroup label="{$group.name}">
                                    {foreach from=$group.servers item=srvr}
                                        <option value="{$srvr.id}" data-type="{$group.import}">
                                            {$srvr.name}
                                            {if $srvr.ip} - {$srvr.ip}{elseif $srvr.host} - {$srvr.host}{/if}
                                        </option>
                                    {/foreach}
                                </optgroup>
                            {/foreach}
                        </select>
                    </div>
                    <div id="warnings">
                        <div id="warn-no-support" class="import-warn alert alert-danger" style="display: none">
                            {$lang.import_notsupported}
                        </div>
                        {if $no_products}
                            <div id="warn-product" class="import-warn alert alert-danger" style="display: none">
                                {$lang.import_type2}
                                <p>{$lang.no_products_error}</p>
                            </div>
                        {else}
                            <div id="warn-product" class="import-warn alert alert-warning" style="display: none">
                                {$lang.import_type2}
                            </div>
                        {/if}

                    </div>
                </div>
            </div>
        </div>
        <div class="blu" style="padding: 10px 15px">
            <button id="import-continue" type="submit" value="1" class="btn btn-primary" type="submit">
                Continue
            </button>
            {securitytoken}
        </div>
    </form>
{else}
    {$lang.firstaddserver}
    <a href="?cmd=servers&action=add">{$lang.clickhere}</a>
    {$lang.toadd}
{/if}
