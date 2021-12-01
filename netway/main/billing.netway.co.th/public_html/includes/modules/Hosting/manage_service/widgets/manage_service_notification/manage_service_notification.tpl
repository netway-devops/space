<script src="{$system_url}includes/modules/Hosting/manage_service/public_html/js/external/jquery.ui/1.8.24/jquery-ui.min.js?v={$hb_version}"></script>
<script src="{$system_url}includes/modules/Hosting/manage_service/public_html/js/external/jquery.ibutton/lib/jquery.ibutton.js"></script>
<script src="{$system_url}includes/modules/Hosting/manage_service/public_html/js/manage.js"></script>
<script src="{$system_url}includes/modules/Hosting/manage_service/public_html/js/MN.js"></script>

<link href="{$system_url}includes/modules/Hosting/manage_service/public_html/js/external/jquery.ui/1.8.24/themes/base/jquery-ui.css?v={$hb_version}" rel="stylesheet" media="all" />
<link href="{$system_url}includes/modules/Hosting/manage_service/public_html/js/external/jquery.ibutton/css/jquery.ibutton.css?v={$hb_version}" rel="stylesheet" media="all" />
<link href="{$system_url}includes/modules/Hosting/manage_service/public_html/themes/manage.css?v={$hb_version}" rel="stylesheet" media="all" />

<script type="text/javascript">

    var system_url = "{$system_url}";

{literal}
     $(document).ready(function () {
         
         $.manage.validateTabNotification();
         $.manage.makeEvent();
         
     });
</script>
    
{/literal}



<div class="box">
    <div class="box-header well">
        <h2>Email</h2>
    </div>
    <div class="box-content">
        <div class="box-content">
            <ul class="dashboard-list">
                <li>
                    <div id="manage-service-user-media-display"></div>
                </li>
            </ul>
        </div>
    </div>
</div>

<div id="box-ping" style="display:none">
    <div class="box">
        <div class="box-header well">
            <h2>Server Up/Down</h2>
        </div>
        <div class="box-content">
            <div class="box-content">
                <ul class="dashboard-list">
                    <li>
                        <div style="float:left;">
                            <input type="checkbox" attrKey="action-key-ping" attrPeriod="manage-service-action-ping-esc-period" 
                                class="manage-service-switch-actions" id="manage-service-switch-action-ping" checked /> 
                        </div>
                        <div style="float:left;">
                             ถ้า down email จะแจ้งทันทีและแจ้งซ้ำทุกๆ 
                            <input  type="text" attrKey="action-key-ping" attrSwitch="manage-service-switch-action-ping" 
                                class="manage-service-actions-esc-period" name="manage-service-action-ping-esc-period" 
                                id="manage-service-action-ping-esc-period" 
                                value="600" size="6" maxlength="6" style="text-align: right; width:50px;">
                            seconds จนกว่าเครื่องจะ up
                        </div>
                        <div class="clr"></div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div id="box-cpu" style="display:none">
    <div class="box">
        <div class="box-header well">
            <h2>CPU</h2>
        </div>
        <div class="box-content">
            <div class="box-content">
                <ul class="dashboard-list">
                    <li>
                        <div style="float:left;">
                            <input type="checkbox" attrKey="action-cpu-processor-load-high" 
                             attrPeriod="manage-service-action-cpu-processor-load-esc-period" 
                             class="manage-service-switch-actions" id="manage-service-switch-cpu-processor-load" checked /> 
                        </div>
                        <div style="float:left;">
                             ถ้า <div id='cpu-processor-load-high-des2' style='display: inline;'></div> จะแจ้งทันทีและแจ้งซ้ำทุกๆ 
                            <input  type="text" attrKey="action-cpu-processor-load-high" attrSwitch="manage-service-switch-cpu-processor-load"
                             class="manage-service-actions-esc-period" name="manage-service-action-cpu-processor-load-esc-period" 
                             id="manage-service-action-cpu-processor-load-esc-period" value="600" size="6" maxlength="6" style="text-align: right; width:50px;">
                            seconds จนกว่าเครื่องจะเป็นปกติ
                        </div>
                        <div class="clr"></div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>


<div id="box-memory" style="display:none">
    <div class="box">
        <div class="box-header well">
            <h2>Memory</h2>
        </div>
        <div class="box-content">
            <div class="box-content">
                <ul class="dashboard-list">
                    <li>
                        <div style="float:left;">
                            <input type="checkbox" attrKey="action-memory-lack-free-swap" attrPeriod="manage-service-action-memory-lack-free-swap-esc-period"
                             class="manage-service-switch-actions" id="manage-service-switch-memory-lack-free-swap" checked /> 
                        </div>
                        <div style="float:left;">
                             ถ้า <div id='memory-lack-free-swap-des2' style='display: inline;'></div> จะแจ้งทันทีและแจ้งซ้ำทุกๆ 
                            <input  type="text" attrKey="action-memory-lack-free-swap" attrSwitch="manage-service-switch-memory-lack-free-swap" 
                              class="manage-service-actions-esc-period" name="manage-service-action-memory-lack-free-swap-esc-period" 
                              id="manage-service-action-memory-lack-free-swap-esc-period" value="600" size="6" maxlength="6" style="text-align: right; width:50px;"> 
                            seconds จนกว่าเครื่องจะเป็นปกติ
                        </div>
                        
                        <br><br><div class="clr"></div>
                        
                        <div style="float:left;">
                            <input type="checkbox" 
                             attrKey="action-memory-lack-available-memory" 
                             attrPeriod="mn-action-memory-lack-available-memory-esc-period"
                             class="manage-service-switch-actions" 
                             id="mn-switch-memory-lack-available-memory" checked /> 
                        </div>
                        <div style="float:left;">
                             ถ้า <div id='memory-lack-available-memory-des2' style='display: inline;'></div> จะแจ้งทันทีและแจ้งซ้ำทุกๆ 
                            <input  type="text" 
                              attrKey="action-memory-lack-available-memory" 
                              attrSwitch="mn-switch-memory-lack-available-memory" 
                              class="manage-service-actions-esc-period" 
                              name="mn-action-memory-lack-available-memory-esc-period" 
                              id="mn-action-memory-lack-available-memory-esc-period" 
                              value="600" size="6" maxlength="6" style="text-align: right; width:50px;"> 
                            seconds จนกว่าเครื่องจะเป็นปกติ
                        </div>
                        
                        <div class="clr"></div>
                        
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>


<div id="box-disk" style="display:none">
    <div class="box">
        <div class="box-header well">
            <h2>Disk</h2>
        </div>
        <div class="box-content">
            <div class="box-content">
                <ul class="dashboard-list">
                    <li>
                        <div style="float:left;">
                            <input type="checkbox" attrKey="action-disk-io-overload" 
                             attrPeriod="mn-action-disk-io-overload-esc-period" 
                             class="manage-service-switch-actions" id="mn-switch-disk-io-overload" checked /> 
                        </div>
                        <div style="float:left;">
                             ถ้า <div id='disk-io-overload-des2' style='display: inline;'></div> จะแจ้งทันทีและแจ้งซ้ำทุกๆ 
                            <input  type="text" attrKey="action-disk-io-overload" 
                             attrSwitch="mn-switch-disk-io-overload"
                             class="manage-service-actions-esc-period" 
                             name="mn-action-disk-io-overload-esc-period" 
                             id="mn-action-disk-io-overload-esc-period" 
                             value="600" size="6" maxlength="6" style="text-align: right; width:50px;"> 
                            seconds จนกว่าเครื่องจะเป็นปกติ
                        </div>
                        <div class="clr"></div>
                        
                        <div id="box-free-disk-space" style="display:none">
                            {foreach from=$aActionFreeDiskSpace item=i key=k}
                                  <div style="float:left;">
                                    <input type="checkbox" attrKey="action-free-disk-space-volume-{$k}" 
                                        attrPeriod="mn-action-free-disk-space-volume-{$k}-esc-period" 
                                        class="manage-service-switch-actions" id="mn-switch-free-disk-space-volume-{$k}" checked /> 
                                  </div>
                                  <div style="float:left;">
                                        ถ้า free disk space is less than 3% on {$i|regex_replace:"/.*volume/":"volume "} จะแจ้งทันทีและแจ้งซ้ำทุกๆ
                                        <input  type="text" attrKey="action-free-disk-space-volume-{$k}" 
                                            attrSwitch="mn-switch-free-disk-space-volume-{$k}"
                                            class="manage-service-actions-esc-period" 
                                            name="mn-action-free-disk-space-volume-{$k}-esc-period" 
                                            id="mn-action-free-disk-space-volume-{$k}-esc-period" 
                                            value="600" size="6" maxlength="6" style="text-align: right; width:50px;"> 
                                            seconds จนกว่าเครื่องจะเป็นปกติ
                                 </div>
                                 <div class="clr"></div>
                                 
                            {/foreach}
                        </div>
                        
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>


<div id="box-raid" style="display:none">
    <div class="box">
        <div class="box-header well">
            <h2>Raid</h2>
        </div>
        <div class="box-content">
            <div class="box-content">
                <ul class="dashboard-list">
                    <li>
                    
                            {foreach from=$aActionRaidStatus item=i key=k}
                                  <div style="float:left;">
                                    <input type="checkbox" attrKey="action-raid-status-{$k}" 
                                        attrPeriod="mn-action-raid-status-{$k}-esc-period" 
                                        class="manage-service-switch-actions" id="mn-switch-raid-status-{$k}" checked /> 
                                  </div>
                                  <div style="float:left;">
                                        ถ้า {$i|regex_replace:"/.*:/":""} จะแจ้งทันทีและแจ้งซ้ำทุกๆ
                                        <input  type="text" attrKey="action-raid-status-{$k}" 
                                            attrSwitch="mn-switch-raid-status-{$k}"
                                            class="manage-service-actions-esc-period" 
                                            name="mn-action-raid-status-{$k}-esc-period" 
                                            id="mn-action-raid-status-{$k}-esc-period" 
                                            value="600" size="6" maxlength="6" style="text-align: right; width:50px;"> 
                                            seconds จนกว่าเครื่องจะเป็นปกติ
                                 </div>
                                 
                                 <div class="clr"></div>
                                 
                            {/foreach}
                        
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div id="box-apache" style="display:none">
    <div class="box">
        <div class="box-header well">
            <h2>Apache</h2>
        </div>
        <div class="box-content">
            <div class="box-content">
                <ul class="dashboard-list">
                    <li>
                        <div style="float:left;">
                            <input type="checkbox" attrKey="action-apache-down" 
                             attrPeriod="mn-action-apache-down-esc-period"
                             class="manage-service-switch-actions" id="mn-switch-apache-down" checked /> 
                        </div>
                        <div style="float:left;">
                             ถ้า <div id='apache-down-des2' style='display: inline;'></div> จะแจ้งทันทีและแจ้งซ้ำทุกๆ 
                            <input  type="text" attrKey="action-apache-down" 
                             attrSwitch="mn-switch-apache-down"
                             class="manage-service-actions-esc-period" 
                             name="mn-action-apache-down-esc-period" 
                             id="mn-action-apache-down-esc-period" 
                             value="600" size="6" maxlength="6" style="text-align: right; width:50px;"> 
                            seconds จนกว่าเครื่องจะเป็นปกติ
                        </div>
                        <div class="clr"></div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>


<div id="box-mysql" style="display:none">
    <div class="box">
        <div class="box-header well">
            <h2>MySQL</h2>
        </div>
        <div class="box-content">
            <div class="box-content">
                <ul class="dashboard-list">
                    <li>
                        <div style="float:left;">
                            <input type="checkbox" attrKey="action-mysql-thread-more-than-100" 
                             attrPeriod="mn-action-mysql-thread-more-than-100-esc-period" 
                             class="manage-service-switch-actions" id="mn-switch-mysql-thread-more-than-100" checked /> 
                        </div>
                        <div style="float:left;">
                             ถ้า <div id='mysql-thread-more-than-100-des2' style='display: inline;'></div> จะแจ้งทันทีและแจ้งซ้ำทุกๆ 
                            <input  type="text" attrKey="action-mysql-thread-more-than-100" 
                             attrSwitch="mn-switch-mysql-thread-more-than-100"
                             class="manage-service-actions-esc-period" 
                             name="mn-action-mysql-thread-more-than-100-esc-period" 
                             id="mn-action-mysql-thread-more-than-100-esc-period" 
                             value="600" size="6" maxlength="6" style="text-align: right; width:50px;"> 
                            seconds จนกว่าเครื่องจะเป็นปกติ
                        </div>
                        
                        <br><br>
                        
                        <div style="float:left;">
                            <input type="checkbox" attrKey="action-mysql-connection-utilization-more-than-95" 
                             attrPeriod="mn-action-mysql-connection-utilization-more-than-95-esc-period" 
                             class="manage-service-switch-actions" id="mn-switch-mysql-connection-utilization-more-than-95" checked /> 
                        </div>
                        <div style="float:left;">
                             ถ้า <div id='mysql-connection-utilization-more-than-95-des2' style='display: inline;'></div> จะแจ้งทันทีและแจ้งซ้ำทุกๆ 
                            <input  type="text" attrKey="action-mysql-connection-utilization-more-than-95" 
                             attrSwitch="mn-switch-mysql-connection-utilization-more-than-95"
                             class="manage-service-actions-esc-period" 
                             name="mn-action-mysql-connection-utilization-more-than-95-esc-period" 
                             id="mn-action-mysql-connection-utilization-more-than-95-esc-period" 
                             value="600" size="6" maxlength="6" style="text-align: right; width:50px;"> 
                            seconds จนกว่าเครื่องจะเป็นปกติ
                        </div>
                        
                        <br><br>
                        
                        <div style="float:left;">
                            <input type="checkbox" attrKey="action-mysql-down" 
                             attrPeriod="mn-action-mysql-down-esc-period" 
                             class="manage-service-switch-actions" id="mn-switch-mysql-down" checked /> 
                        </div>
                        <div style="float:left;">
                             ถ้า <div id='mysql-down-des2' style='display: inline;'></div> จะแจ้งทันทีและแจ้งซ้ำทุกๆ 
                            <input  type="text" attrKey="action-mysql-down" 
                             attrSwitch="mn-switch-mysql-down"
                             class="manage-service-actions-esc-period" 
                             name="mn-action-mysql-down-esc-period" 
                             id="mn-action-mysql-down-esc-period" 
                             value="600" size="6" maxlength="6" style="text-align: right; width:50px;"> 
                            seconds จนกว่าเครื่องจะเป็นปกติ
                        </div>
                        
                        <div class="clr"></div>
                        
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>


<div id="box-nginx" style="display:none">
    <div class="box">
        <div class="box-header well">
            <h2>Nginx</h2>
        </div>
        <div class="box-content">
            <div class="box-content">
                <ul class="dashboard-list">
                    <li>
                        <div style="float:left;">
                            <input type="checkbox" attrKey="action-nginx-down" 
                             attrPeriod="mn-action-nginx-down-esc-period" 
                             class="manage-service-switch-actions" id="mn-switch-nginx-down" checked /> 
                        </div>
                        <div style="float:left;">
                             ถ้า <div id='nginx-down-des2' style='display: inline;'></div> จะแจ้งทันทีและแจ้งซ้ำทุกๆ 
                            <input  type="text" attrKey="action-nginx-down" 
                             attrSwitch="mn-switch-nginx-down"
                             class="manage-service-actions-esc-period" 
                             name="mn-action-nginx-down-esc-period" 
                             id="mn-action-nginx-down-esc-period" 
                             value="600" size="6" maxlength="6" style="text-align: right; width:50px;"> 
                            seconds จนกว่าเครื่องจะเป็นปกติ
                        </div>
                        
                        <div class="clr"></div>
                        
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div id="box-exim" style="display:none">
    <div class="box">
        <div class="box-header well">
            <h2>Exim</h2>
        </div>
        <div class="box-content">
            <div class="box-content">
                <ul class="dashboard-list">
                    <li>
                        <div style="float:left;">
                            <input type="checkbox" attrKey="action-exim-queue-more-than-1000" 
                             attrPeriod="mn-action-exim-queue-more-than-1000-esc-period" 
                             class="manage-service-switch-actions" id="mn-switch-exim-queue-more-than-1000" checked /> 
                        </div>
                        <div style="float:left;">
                             ถ้า <div id='exim-queue-more-than-1000-des2' style='display: inline;'></div> จะแจ้งทันทีและแจ้งซ้ำทุกๆ 
                            <input  type="text" attrKey="action-exim-queue-more-than-1000" 
                             attrSwitch="mn-switch-exim-queue-more-than-1000"
                             class="manage-service-actions-esc-period" 
                             name="mn-action-exim-queue-more-than-1000-esc-period" 
                             id="mn-action-exim-queue-more-than-1000-esc-period" 
                             value="600" size="6" maxlength="6" style="text-align: right; width:50px;"> 
                            seconds จนกว่าเครื่องจะเป็นปกติ
                        </div>
                        
                        <div class="clr"></div>
                        
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>


<div id="box-named" style="display:none">
    <div class="box">
        <div class="box-header well">
            <h2>Named</h2>
        </div>
        <div class="box-content">
            <div class="box-content">
                <ul class="dashboard-list">
                    <li>
                        <div style="float:left;">
                            <input type="checkbox" attrKey="action-named-down" 
                             attrPeriod="mn-action-named-down-esc-period" 
                             class="manage-service-switch-actions" id="mn-switch-named-down" checked /> 
                        </div>
                        <div style="float:left;">
                             ถ้า <div id='named-down-des2' style='display: inline;'></div> จะแจ้งทันทีและแจ้งซ้ำทุกๆ 
                            <input  type="text" attrKey="action-named-down" 
                             attrSwitch="mn-switch-named-down"
                             class="manage-service-actions-esc-period" 
                             name="mn-action-named-down-esc-period" 
                             id="mn-action-named-down-esc-period" 
                             value="600" size="6" maxlength="6" style="text-align: right;"> 
                            seconds จนกว่าเครื่องจะเป็นปกติ
                        </div>
                        
                        <div class="clr"></div>
                        
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>


<!-- START HIDDEN  -->
<input type="hidden" id = "account-id"  name="account-id" value="{$accountId}">
<input type="hidden" id = "server-id"  name="server-id" value="{$serverId}">
<input type="hidden" id = "client-id"  name="client-id" value="{$clientId}">
<!-- END HIDDEN -->