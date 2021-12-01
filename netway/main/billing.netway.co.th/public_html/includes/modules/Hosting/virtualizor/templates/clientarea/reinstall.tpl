<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">Rebuild</h3>

    <div class="clear"></div>
</div>
<div class="content-bar">
    <div class="notice">
        <h3>{$lang.ReinstallVPS}</h3>
        {$lang.choose_template1} <font color="#cc0000">{$lang.choose_template2}</font>
    </div>
    {if $ostemplates}
        <script type="text/javascript">
            {literal}
            var ostemplates = [];
            var distributions = {
                linux: [],
                windows: []
            };{/literal}


            {foreach from=$distributions.linux item=i key=k}distributions.linux[{$k}] = "{$i}";
            {/foreach}
            {foreach from=$distributions.windows item=i key=k}distributions.windows[{$k}] = "{$i}";
            {/foreach}

            {foreach from=$ostemplates item=i name=tpls}ostemplates[{$smarty.foreach.tpls.index}] ={literal} {
                {/literal}id: "{$i[0]}",
                name: "{$i[1]} {if $i[2] && $i[2]>0}( {$i[2]|price:$currency} ){/if}",
                distro: "{$i.distro}",
                family: "{$i.family}"{literal}}{/literal};
            {/foreach}
        </script>
        <form action="" method="post">
            <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">
                <tr>
                    <td colspan="2">
                        <div class="control-group">
                            <label class="control-label">{$lang.os}</label>
                            <div class="controls">
                                <select required="required" name="CreateVM[operating_system]"
                                        id="virtual_machine_operating_system" onchange="filtertemplates('family')"
                                        style="min-width:250px;">
                                    <option value="linux" selected="selected">Linux</option>
                                    <option value="windows">Windows</option>
                                </select>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="control-group">
                            <label class="control-label">{$lang.distribution}</label>
                            <div class="controls">
                                <select required="required" name="CreateVM[operating_system_distro]"
                                        id="virtual_machine_operating_system_distro"
                                        onchange="filtertemplates('distro')"
                                        style="min-width:250px;">
                                    {foreach from=$distributions.linux item=d}
                                        <option value="{$d}">{$d|ucfirst}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </td>

                </tr>
                <tr>
                    <td colspan="2">
                        <div class="control-group">
                            <label class="control-label">{$lang.ostemplate}</label>
                            <div class="controls">
                                <select style="min-width:250px;" required="required" name="os"
                                        id="virtual_machine_template_id"
                                        onchange="swapcheck($(this).val())">
                                    {foreach from=$ostemplates item=templa}
                                        {if $templa.family=='linux' && $templa.distro==$distributions.linux[0]}
                                            <option value="{$templa[0]}">{$templa[1]} {if $templa[2] && $templa[2]>0}( {$templa[2]|price:$currency} ){/if}</option>
                                        {/if}
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="text-center">
                        <input type="submit"
                               value="{$lang.ReinstallVPS}"
                               name="changeos" class="btn btn-info"/>
                        <a class="btn btn-default"
                           href="{$service_url}&vpsdo=vmdetails&vpsid={$vpsid}">{$lang.cancel}</a>
                    </td>
                </tr>

            </table>
            {securitytoken}
        </form>
    {else}
        <div style="color: red; text-align: center; width:850px">
            <strong>{$lang.ostemplates_error}</strong>
        </div>
    {/if}
</div>