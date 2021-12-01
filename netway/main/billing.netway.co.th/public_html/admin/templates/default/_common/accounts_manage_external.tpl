
{* Start Managed External Server (Zabbix) *}
{if $rvbandwidthtab && $rvmonitortab}
    <ul class="accor">
        <li><a href="#">Managed External Server</a>                              
            <div class="sor">
                {literal}
                <script type="text/javascript">
                    function rv_bind_managed_external_server() {
                        $('#rv-managed-external-server').TabbedMenu({elem:'.tab_content',picker:'li.tpicker',aclass:'active'});
                        $.zabbix.makeUiTrafficBandwidth();
                    }
                    appendLoader('rv_bind_managed_external_server');
                </script>
                {/literal}
                
                <ul class="tabs" id="rv-managed-external-server">
                    <li class="tpicker"><a href="#tab2">Bandwidth</a></li>
                    {if $isAppManageService}
                        <li class="tpicker"><a href="#tab2" onclick="$.manage.validateTabGraph();">Monitor</a></li>
                    {/if}
                    <li class="tpicker">
                        {if $rvServiceNotificationTab}
                            <a href="#tab2" onclick="$.manage.validateTabNotification();">Notification</a>
                        {else}
                            <a href="#tab2" onclick="$.zabbix.makeUiPing();$.zabbix.makeUiUserMedia();">Notification</a>
                        {/if}
                    </li>
                </ul>
                
                <div class="tab_content" style="display: none;">
                    {include file=$rvbandwidthtab}
                </div>
                
                {if $isAppManageService}
                    <div class="tab_content" style="display: none;">
                        {include file=$rvServiceMonitorTab}
                    </div>
                {/if}
                
                {if $rvServiceNotificationTab}
                    <div class="tab_content" style="display: none;">
                        {include file=$rvServiceNotificationTab}
                    </div>
                {else}
                    <div class="tab_content" style="display: none;">
                        {include file=$rvmonitortab} 
                    </div>
                {/if}                                               
                
        </li>
    </ul>
{/if}                                    
{* Stop Managed External Server (Zabbix) *}
