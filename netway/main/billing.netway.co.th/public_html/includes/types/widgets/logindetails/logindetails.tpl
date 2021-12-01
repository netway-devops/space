{if $panellink || $service.username || $service.password || $rootpass || $forms}
    <div class="wbox">
        <div class="wbox_header">
            {$lang.logindetails} {if $panellink}{$panellink}{/if}
        </div>
        <div class="wbox_content">
            {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
        </div>
        <div class="wbox_content">
            <form action="" method="post" >
                <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker table table-striped">
                    {counter name=alt start=1 print=false assign=alter}
                    {if $panellink}
                    <tr {if $alter%2 == 0}class="even"{/if}{counter name=alt}>
                        <td width="160" align="right">URL</td>
                        <td><a href="{$panellink}" target="_blank">{$panellink}</a></td>
                    </tr>
                    {/if}
                    <tr {if $alter%2 == 0}class="even"{/if}{counter name=alt}>
                        <td width="160" align="right">{$lang.username}</td>
                        <td>{$service.username}</td>
                    </tr>
                    {if $service.password && !$widget_config.password}
                        <tr {if $alter%2 == 0}class="even"{/if}{counter name=alt}>
                            <td width="160" align="right">{$lang.password}</td>
                            <td><span style="display:none" id="showpassword">{$service.password}</span> <a href="#" onclick="$(this).hide();$('#showpassword').show();return false;" class="fs11">{$lang.revealpassword}</a></td>
                        </tr>
                    {/if}
                    {if $service.rootpassword && !$widget_config.rootpassword}
                        <tr {if $alter%2 == 0}class="even"{/if}{counter name=alt}>
                            <td width="160" align="right">{$lang.rootpassword}</td>
                            <td><span style="display:none" id="showpassword2">{$rootpass}</span> <a href="#" onclick="$(this).hide();$('#showpassword2').show();return false;" class="fs11">{$lang.revealpassword}</a></td>
                        </tr>
                    {/if}
                    {if $forms}
                        {foreach from=$forms item=cst key=kk}
                                <tr >
                                    <td align="right" width="160">{$cst.name}</td>
                                    <td>{include file=$cst.configtemplates.clientarea}</td>
                                </tr>
                        {/foreach}
                    {/if}
                </table>
            </form>

        </div>
    </div>
{/if}
{foreach from=$additional item=submodule key=k}
    <div class="wbox">
        <div class="wbox_header">
            {$lang.logindetails} {if $submodule.panellink}{$submodule.panellink}{/if}
        </div>
        <div class="wbox_content">
            <form action="" method="post" >
                <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker table table-striped">
                    {counter name=alt start=1 print=false assign=alter}
                    {if $submodule.panellink}
                        <tr {if $alter%2 == 0}class="even"{/if}{counter name=alt}>
                            <td width="160" align="right">URL</td>
                            <td><a href="{$submodule.panellink}" target="_blank">{$submodule.panellink}</a></td>
                        </tr>
                    {/if}
                    <tr {if $alter%2 == 0}class="even"{/if}{counter name=alt}>
                        <td width="160" align="right">{$lang.username}</td>
                        <td>{$submodule.username}</td>
                    </tr>
                    {if $submodule.password && !$widget_config.password}
                        <tr {if $alter%2 == 0}class="even"{/if}{counter name=alt}>
                            <td width="160" align="right">{$lang.password}</td>
                            <td><span style="display:none" id="showpassword_{$k}">{$submodule.password}</span> <a href="#" onclick="$(this).hide();$('#showpassword_{$k}').show();return false;" class="fs11">{$lang.revealpassword}</a></td>
                        </tr>
                    {/if}
                    {if $submodule.rootpassword && !$widget_config.rootpassword}
                        <tr {if $alter%2 == 0}class="even"{/if}{counter name=alt}>
                            <td width="160" align="right">{$lang.rootpassword}</td>
                            <td><span style="display:none" id="showpassword2_{$k}">{$submodule.rootpass}</span> <a href="#" onclick="$(this).hide();$('#showpassword2_{$k}').show();return false;" class="fs11">{$lang.revealpassword}</a></td>
                        </tr>
                    {/if}
                </table>
            </form>

        </div>
    </div>
{/foreach}
