<link href="{$template_dir}hbchat/media/settings.css?v={$hb_version}" rel="stylesheet" media="all" />
<script type="text/javascript" src="../includes/modules/Other/autoupgrade/templates/autoupgrade.js"></script>

<div class="row" style="margin-top:30px" >
    <div class="col-md-12">
        <div class="box box-primary  " >
            <div class="box-header" >
                <h3 class="box-title">Auto Update</h3>

            </div>
            <div class="box-body">
                <div class="row" id="form-log" style="display: none">
                    <div class="col-md-12" id="autoupgrade_log">
                        <h3>Update in progress...</h3>
                    </div>
                </div>
                <div class="row" id="form-info">
                    <div class="col-md-8 ">

                        {if $warning}

                            <div class="chatbg_1" style="padding:50px;text-align:center">
                                <h1 style="color:red;font-size:32px">Your PHP version is {$phpversion}, HostBill requires PHP 5.3 or higher</h1>
                                <h2>Update is not possible, manual update will result in errors, please update your PHP version first</h2>
                            </div>

                        {else}

                            {if $upgraded}
                                <div style="margin:24px;">
                                    {if $upgrade_result}
                                        <h2 style="color:green">{if $action=='performpatch'}Patch{else}Update{/if}: Success</h2>
                                    {else}
                                        <h2 style="color:blue">{if $action=='performpatch'}Patch{else}Update{/if}: failed</h2>
                                        <strong style="color:red">{$upgrade_errors}</strong>
                                    {/if}
                                </div>
                            {/if}
                            <table cellspacing="0" cellpadding="0" border="0" width="100%" style="margin-bottom:10px;">
                                <tbody>
                                <tr>
                                    <td valign="top" width="200">
                                        <table border="0" cellspacing="0" cellpadding="4"  class="introduce">
                                            <tr>
                                                <td width="1" style="border-left:none;"></td>
                                                <td width="160">Your version:</td>
                                                <td width="200" {if $current_version!=$latest_version}style="border-right:none;"{/if}>Latest version:</td>
                                                {if $current_version==$latest_version}
                                                    <td  width="160" style="border-right:none;">Plugin updates:</td>

                                                {/if}
                                            </tr>
                                            <tr>
                                                <td width="1" style="border-left:none;"></td>
                                                <td width="160"><b {if $current_version!=$latest_version}style='color:red'{/if}>{$current_version}</b></td>
                                                <td {if $current_version!=$latest_version}style="border-right:none;"{/if}><b>{$latest_version}</b></td>
                                                {if $current_version==$latest_version}
                                                    <td style="border-right:none;"><b>{if $plugin_updates}Yes{else}No{/if}</b></td>
                                                {/if}
                                            </tr>
                                            <tr>
                                                <td width="1" style="border-left:none;"></td>
                                                <td></td>
                                                <td  style="border-right:none;" {if $current_version!=$latest_version}colspan="3"{/if}>
                                                    <em class="fs11">Last checked: {if $latest_version_check}{$latest_version_check|dateformat:$date_format}{/if} <a href="?cmd=autoupgrade&action=checkversion" class="editbtn">check now</a></em>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>
                                </tr>

                                </tbody></table>

                            {if $current_version!=$latest_version}
                                <div style="padding-bottom:20px">

                                    <div style="padding:20px">

                                        <a  href="?cmd=autoupgrade&action=checkversion&security_token={$security_token}"  class="btn btn-default">
                                            <strong>Check for new versions</strong>
                                        </a>
                                        <a  href="?cmd=autoupgrade&action=performupgrade&security_token={$security_token}" onclick="return HBAutoupgrade.initVersionUpgrade();" class="btn btn-success">
                                            <strong>Update Now</strong>
                                        </a>

                                        <span class="orspace" style="padding-top:7px"><a href="http://hostbillapp.com/changelog/" target="_blank">Get more info about this release</a></span>
                                        <div class="clear"></div>
                                    </div>
                                </div>


                            {elseif $plugin_updates}
                                <div style="padding:20px">
                                    <a  href="?cmd=autoupgrade&action=checkversion&security_token={$security_token}"  class="btn btn-default">
                                        <strong>Check for new versions</strong>
                                    </a>
                                    <a  href="?cmd=autoupgrade&action=performpluginup&security_token={$security_token}" onclick="return HBAutoupgrade.initPluginsUpgrade();" class="btn btn-success">
                                        <strong>Update plugins Now</strong>
                                    </a>

                                    <div class="clear"></div>
                                    <div id="patchinfo" style="margin-top:10px">
                                        <strong>New plugin versions found:</strong><br/>
                                        {foreach from=$plugin_updates item=p}
                                            <strong>{$p.name}</strong> ({$p.filename}) - local version: {$p.local}, new version: {$p.remote} <br/>
                                        {/foreach}
                                    </div>

                                </div>
                                {else}
                                <div style="padding:20px">
                                    <a  href="?cmd=autoupgrade&action=checkversion&security_token={$security_token}"  class="btn btn-default">
                                        <strong>Check for new versions</strong>
                                    </a>

                                </div>
                            {/if}

                            <div style="margin-top:20px">
                                <form action="" method="post" >
                                    <input type="hidden" name="make" value="send" />
                                    <b>List of files/folders to exclude:</b> <a class="vtip_description" title="Provide list of files/folders you wish to prevent
                                                                     from being overwritten by upgrade. <br/><b>Use relative paths</b>, one per line, like:<br/>
                                                                     templates/orderpages/*  <em>will prevent any file from templates/orderpages from being overwritten</em><br/>
                                                                     includes/core/class.events.php <em>Will prevent one file from being overwritten</em>"></a>

                                    <textarea style="height:100px;margin-bottom:15px;" name="exclusions" class="form-control">{$exclusions}</textarea>
                                    <label>Plugins to exclude from auto-upgrade <a class="vtip_description" title="Optionally you can also disable entire plugins from being overwritten/detected for changes"></a></label>
                                    <select multiple class=" form-control" name="pluginexcluded[]" id="pluginexcluded">
                                        {foreach from=$updateableplugins item=i}
                                            <option value="{$i.filename}" {if $excludedplugins[$i.filename]}selected="selected"{/if}>{$i.name}</option>
                                        {/foreach}
                                    </select>
                                    <button type="submit" name="submit"  class="btn-primary btn" style="margin-top:15px"><i class="fa fa-save"></i> Save list</button>
                                    {securitytoken}
                                </form>
                            </div>



                        {/if}

                    </div>
                    <div class="col-md-4" style="">
                        <b>Before performing update make sure to <span style="color:red">create backup</span> of your HostBill files and database (using control-panel or manual backup)</b>
                        <br/>  You may also consider enabling <a href="?cmd=configuration">Maintenance Mode</a>
                        <br/> <br/>
                        <h3>Auto-update FAQ</h3>
                        <b>Q:</b> Do I need to download anything?<br/>
                        <b>A:</b> No, this tool will download, extract & apply update automatically.<br/><br/>

                        <b>Q:</b> Will update overwrite my custom clientarea templates?<br/>
                        <b>A:</b> No, as long as you keep your custom templates in separate folder under /templates, <br>
                        if you've modified some files its safe to make custom folder under /templates and keep your entire look there.<br/><br/>

                        <b>Q:</b> Auto-update fails, what can be wrong?<br/>
                        <b>A:</b> Please check common issues in : <a href="https://hostbill.atlassian.net/wiki/display/DOCS/Auto-Upgrade+plugin" target="_blank"><strong>Documentation</strong></a>

                        <br/>
                        <br/>
                        For up-to-date FAQ visit <a href="https://hostbill.atlassian.net/wiki/display/DOCS/Auto-Upgrade+plugin" target="_blank"><strong>Documentation</strong></a>


                    </div>
                </div>
            </div>

        </div>
    </div>



</div>