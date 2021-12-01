<tr>
    <td id="getvaluesloader">
        {if $test_connection_result}
            <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
                {$lang.test_configuration}:
                {if $lang[$test_connection_result.result]}{$lang[$test_connection_result.result]}
                {else}{$test_connection_result.result}
                {/if}
                {if $test_connection_result.error}: {$test_connection_result.error}
                {/if}
            </span>
        {/if}
    </td>
    <td id="onappconfig_">
        <input type="hidden" id="saved_module" value="{if $default}1{else}0{/if}"/>
        <div id="">
            <ul class="breadcrumb-nav" style="margin-top:10px;">
                <li><a href="#" class="active disabled" onclick="virtualizor.load_section('provisioning')">Start</a></li>
                <li><a href="#" class="disabled" onclick="virtualizor.load_section('resources')">Resources</a></li>                
                <li><a href="#" class="disabled" onclick="virtualizor.load_section('ostemplates')">OS Templates</a></li>
                <li><a href="#" class="disabled" onclick="virtualizor.load_section('network')">Network</a></li>
                <li><a href="#" class="disabled" onclick="virtualizor.load_section('finish');">Finish</a></li>
            </ul>
            <link rel="stylesheet" type="text/css" href="{$system_url}includes/modules/Hosting/virtualizor/templates/adminarea/config.css" />
            <script type="text/javascript" src="{$system_url}includes/modules/Hosting/virtualizor/templates/adminarea/config_script.js"></script>
            <div style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;margin-bottom:10px;background:#fff" id="onapptabcontainer">
                {include file="`$module_templates`config_provisioning.tpl"}
                {include file="`$module_templates`config_resources.tpl"}
                {include file="`$module_templates`config_ostemplates.tpl"}

                {include file="`$module_templates`config_network.tpl"}

                <div class="onapptab form" id="finish_tab">
                    <table border="0" cellspacing="0" width="100%" cellpadding="6">
                        <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from Virtualizor, please wait...</td></tr>
                        <tr>
                            <td valign="top" width="160" style="border-right:1px solid #E9E9E9">
                                <h4 class="finish">Finish</h4>
                                <span class="fs11" style="color:#C2C2C2">Save &amp; start selling</span>
                            </td>
                            <td valign="top">
                                Your package is ready to be purchased. <br/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <script type="text/javascript">
                {if $_isajax}setTimeout('virtualizor.append()', 50);
                {else}appendLoader('virtualizor.append');
                {/if}
            </script>
        </div>
    </td>
</tr>