<div class="header-bar">
    <h3 class="vmdetails hasicon">{$widget.fullname}</h3>
</div>
<div class="content-bar" id="boot-order-form">
    <div class="notice">
        {$lang.cp_install_note}
    </div>
    <form action="" method="POST" class="form-horizontal">
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">
            <tr>
                <td colspan="2">
                    <div class="control-group">
                        <label class="control-label">{$lang.cp_select}</label>
                        <div class="controls">
                            <select required="required" name="install">
                                {foreach from=$install_opts item=opt}
                                    <option value="{$opt.id}">{$opt.name}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="text-center">
                    <button type="submit" class="btn btn-info">{$lang.cp_install}</button>
                    <a class="btn btn-default"
                       href="{$service_url}&vpsdo=vmdetails&vpsid={$vpsid}">{$lang.cancel}</a>
                </td>
            </tr>
        </table>
        {securitytoken}
    </form>
</div>

