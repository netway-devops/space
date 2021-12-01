<script src="{$system_url}includes/modules/Hosting/manage_service/public_html/js/external/jquery.ui/1.8.24/jquery-ui.min.js?v={$hb_version}"></script>
<script src="{$system_url}includes/modules/Hosting/manage_service/public_html/js/external/jquery.ibutton/lib/jquery.ibutton.js"></script>
<script src="{$system_url}includes/modules/Hosting/manage_service/public_html/js/manage.js"></script>
<script src="{$system_url}includes/modules/Hosting/manage_service/public_html/js/MN.js"></script>

<link href="{$system_url}includes/modules/Hosting/manage_service/public_html/js/external/jquery.ui/1.8.24/themes/base/jquery-ui.css?v={$hb_version}" rel="stylesheet" media="all" />
<link href="{$system_url}includes/modules/Hosting/manage_service/public_html/themes/manage.css?v={$hb_version}" rel="stylesheet" media="all" />

<script type="text/javascript">

    var system_url = "{$system_url}";
    var isAgentd = "{$isAgentd}";
    
    var isCpu = "{$isCpu}";
    var isMemory = "{$isMemory}";
    var isDisk = "{$isDisk}";
    var diskCount = "{$diskCount}";
    var isApahce = "{$isApahce}";
    var isMysql = "{$isMysql}";
    var mySqlCount = "{$mySqlCount}";
    var myIsamCount = "{$myIsamCount}";
    var myInnodbCount = "{$myInnodbCount}";
    var isNginx = "{$isNginx}";
    var isExim = "{$isExim}";
    var isNamed = "{$isNamed}";
    
{literal}   

    var aOnclick = {
        cpu: 0, 
        memory: 0, 
        disk: 0,
        apache: 0,
        mysql: 0,
        nginx: 0,
        exim: 0,
        named: 0
    };

    $(document).ready(function () {
        
        $.manage.makeEvent();
        
        $('#tabbedmenu2').TabbedMenu({elem:'.tab_content2',picker:'li.tpicker2',aclass:'active'});        
        $('#tabbedmenu3').TabbedMenu({elem:'.tab_content3',picker:'li.tpicker3',aclass:'active'});
        
        if (isAgentd == 'true') {
            // $.manage.init();
        } else {
            $.manage.raiseError('App "Manage Service" Require Zabbix Agentd. Please install zabbix agentd.');
        } 
        
    });
</script>
    
{/literal}

<ul class="tabs" id="tabbedmenu2">
    {if $isCpu} <li class="tpicker2 active"><a href="#tab1" onclick="$.manage.onclickTabCpu();">CPU</a></li> {/if}
    {if $isMemory} <li class="tpicker2"><a href="#tab2" onclick="$.manage.onclickTabMemory();">Memory</a></li> {/if}
    {if $isDisk} <li class="tpicker2"><a href="#tab2" onclick="$.manage.onclickTabDisk();">Disk</a></li> {/if}
    {if $isApahce} <li class="tpicker2"><a href="#tab2" onclick="$.manage.onclickTabApache();">Apache</a></li> {/if}
    {if $isMysql} <li class="tpicker2"><a href="#tab2" onclick="$.manage.onclickTabMysql();">MySQL</a></li> {/if}
    {*  
    {if $isMysql} <li class="tpicker2"><a href="#tab2" onclick="return false">MySQL Server</a></li> {/if}
    {if $isMysql} <li class="tpicker2"><a href="#tab2" onclick="return false">MyISAM database engine performance</a></li> {/if}
    {if $isMysql} <li class="tpicker2"><a href="#tab2" onclick="return false">InnoDB database engine performance</a></li> {/if} 
    *}
    {if $isNginx} <li class="tpicker2"><a href="#tab2" onclick="$.manage.onclickTabNginx();">Nginx</a></li> {/if}
    {if $isExim} <li class="tpicker2"><a href="#tab2" onclick="$.manage.onclickTabExim();">Exim</a></li> {/if}
    {if $isNamed} <li class="tpicker2"><a href="#tab2" onclick="$.manage.onclickTabNamed();">Named</a></li> {/if}
</ul>

{* <div class="tab_container"> *}
    {if $isCpu}
        <div class="tab_content2" style="display: block;">
            
            <p>
                <div id="cpu-load-display-value-slider"></div>
                <br>
            </p>
            <div id="cpu-load-slider" style="margin-left:5px;"></div>
            <br>
            <div id="cpu-load-display-graph" class="display-graph">
                <div class="dvLoading"></div>
            </div>
            
            <br><br>
            
            <p>
                <div id="cpu-jump-display-value-slider"></div>
                <br>
            </p>
            <div id="cpu-jump-slider" style="margin-left:5px;"></div>
            <br>
            <div id="cpu-jump-display-graph" class="display-graph">
                <div class="dvLoading"></div>
            </div>
            
        </div>
    {/if}
    {if $isMemory}      
        <div class="tab_content2" style="display: block;">
        
            <p>
                <div id="memory-usage-display-value-slider"></div>
                <br>
            </p>
            <div id="memory-usage-slider" style="margin-left:5px;"></div>
            <br>
            <div id="memory-usage-display-graph" class="display-graph">
                <div class="dvLoading"></div>
            </div>
            
            <br><br>
            
            <p>
                <div id="swap-usage-display-value-slider"></div>
                <br>
            </p>
            <div id="swap-usage-slider" style="margin-left:5px;"></div>
            <br>
            <div id="swap-usage-display-graph" class="display-graph">
                <div class="dvLoading"></div>
            </div>
            
        </div>
    {/if}
    {if $isDisk}  
        <div class="tab_content2" style="display: block;">
            
            {foreach from=$aGraphFreeDiskSpace item=i key=k}
                <p>
                    <div id="free-disk-space-display-value-slider-{$k}"></div>
                    <br>
                </p>
                <div id="free-disk-space-slider-{$k}" attrGraphId="{$i}" attrKey="{$k}" attrTargetDisplayGraph="free-disk-space-display-graph-{$k}" attrTargetDisplaySlide="free-disk-space-display-value-slider-{$k}" style="margin-left:5px;"></div>
                <br>
                <div id="free-disk-space-display-graph-{$k}" class="display-graph">
                    <div class="dvLoading"></div>
                </div>
                
                <br><br>
            {/foreach}
            
        </div>
    {/if}
    {if $isApahce}
        <div class="tab_content2" style="display: block;">
        
            <p>
                <div id="apache-stat-display-value-slider"></div>
                <br>
            </p>
            <div id="apache-stat-slider" style="margin-left:5px;"></div>
            <br>
            <div id="apache-stat-display-graph" class="display-graph">
                <div class="dvLoading"></div>
            </div>
            
        </div>
    {/if}
    {if $isMysql}
        <div class="tab_content2" style="display: block;">
    
            <br>&nbsp;
    
             <ul class="tabs" id="tabbedmenu3">
                <li class="tpicker3 active"><a href="#tab1" onclick="return false">MySQL Server</a></li>
                <li class="tpicker3"><a href="#tab2" onclick="return false">MyISAM database engine performance</a></li>
                <li class="tpicker3"><a href="#tab2" onclick="return false">InnoDB database engine performance</a></li>
            </ul>
        
            <div class="tab_content3" style="display: block;">        
                {foreach from=$aGraphMysql item=i key=k}
                    <p>
                        <div id="mysql-display-value-slider-{$k}"></div>
                        <br>
                    </p>
                    <div id="mysql-slider-{$k}" attrType="mysql" attrGraphId="{$i}" attrKey="{$k}" attrTargetDisplayGraph="mysql-display-graph-{$k}" attrTargetDisplaySlide="mysql-display-value-slider-{$k}" style="margin-left:5px;"></div>
                    <br>
                    <div id="mysql-display-graph-{$k}" class="display-graph">
                        <div class="dvLoading"></div>
                    </div>
                    
                    <br><br>
                {/foreach}       
            </div>
            
            <div class="tab_content3" style="display: block;">
                {foreach from=$aGraphMyIsam item=i key=k}
                    <p>
                        <div id="myisam-display-value-slider-{$k}"></div>
                        <br>
                    </p>
                    <div id="myisam-slider-{$k}" attrType="myisam" attrGraphId="{$i}" attrKey="{$k}" attrTargetDisplayGraph="myisam-display-graph-{$k}" attrTargetDisplaySlide="myisam-display-value-slider-{$k}" style="margin-left:5px;"></div>
                    <br>
                    <div id="myisam-display-graph-{$k}" class="display-graph">
                        <div class="dvLoading"></div>
                    </div>
                    
                    <br><br>
                {/foreach}
            </div>
            
            
            <div class="tab_content3" style="display: block;">
                {foreach from=$aGraphInnodb item=i key=k}
                    <p>
                        <div id="innodb-display-value-slider-{$k}"></div>
                        <br>
                    </p>
                    <div id="innodb-slider-{$k}" attrType="innodb" attrGraphId="{$i}" attrKey="{$k}" attrTargetDisplayGraph="innodb-display-graph-{$k}" attrTargetDisplaySlide="innodb-display-value-slider-{$k}" style="margin-left:5px;"></div>
                    <br>
                    <div id="innodb-display-graph-{$k}" class="display-graph">
                        <div class="dvLoading"></div>
                    </div>
                    
                    <br><br>
                {/foreach}
            </div>
            
        </div>
    {/if}
    {*
    {if $isMysql}
        <div class="tab_content2" style="display: block;">
        
            {foreach from=$aGraphMysql item=i key=k}
                <p>
                    <div id="mysql-display-value-slider-{$k}"></div>
                    <br>
                </p>
                <div id="mysql-slider-{$k}" attrType="mysql" attrGraphId="{$i}" attrKey="{$k}" attrTargetDisplayGraph="mysql-display-graph-{$k}" attrTargetDisplaySlide="mysql-display-value-slider-{$k}" style="margin-left:5px;"></div>
                <br>
                <div id="mysql-display-graph-{$k}" class="display-graph">
                    <div class="dvLoading"></div>
                </div>
                
                <br><br>
            {/foreach}
                      
        </div>
    {/if}
    {if $isMysql}
        <div class="tab_content2" style="display: block;">
            
            {foreach from=$aGraphMyIsam item=i key=k}
                <p>
                    <div id="myisam-display-value-slider-{$k}"></div>
                    <br>
                </p>
                <div id="myisam-slider-{$k}" attrType="myisam" attrGraphId="{$i}" attrKey="{$k}" attrTargetDisplayGraph="myisam-display-graph-{$k}" attrTargetDisplaySlide="myisam-display-value-slider-{$k}" style="margin-left:5px;"></div>
                <br>
                <div id="myisam-display-graph-{$k}" class="display-graph">
                    <div class="dvLoading"></div>
                </div>
                
                <br><br>
            {/foreach}
            
        </div>
    {/if}
    {if $isMysql}
        <div class="tab_content2" style="display: block;">
            
            {foreach from=$aGraphInnodb item=i key=k}
                <p>
                    <div id="innodb-display-value-slider-{$k}"></div>
                    <br>
                </p>
                <div id="innodb-slider-{$k}" attrType="innodb" attrGraphId="{$i}" attrKey="{$k}" attrTargetDisplayGraph="innodb-display-graph-{$k}" attrTargetDisplaySlide="innodb-display-value-slider-{$k}" style="margin-left:5px;"></div>
                <br>
                <div id="innodb-display-graph-{$k}" class="display-graph">
                    <div class="dvLoading"></div>
                </div>
                
                <br><br>
            {/foreach}
            
        </div>
    {/if}
    *}
    {if $isNginx}
        <div class="tab_content2" style="display: block;">
            
            <p>
                <div id="nginx-connect-display-value-slider"></div>
                <br>
            </p>
            <div id="nginx-connect-slider" style="margin-left:5px;"></div>
            <br>
            <div id="nginx-connect-display-graph" class="display-graph">
                <div class="dvLoading"></div>
            </div>
            
            <br><br>
            
            <p>
                <div id="nginx-thread-display-value-slider"></div>
                <br>
            </p>
            <div id="nginx-thread-slider" style="margin-left:5px;"></div>
            <br>
            <div id="nginx-thread-display-graph" class="display-graph">
                <div class="dvLoading"></div>
            </div>
            
        </div>
    {/if}
    {if $isExim}
        <div class="tab_content2" style="display: block;">
        
            <p>
                <div id="exim-statistic-display-value-slider"></div>
                <br>
            </p>
            <div id="exim-statistic-slider" style="margin-left:5px;"></div>
            <br>
            <div id="exim-statistic-display-graph" class="display-graph">
                <div class="dvLoading"></div>
            </div>
            
            <br><br>
        
            <p>
                <div id="exim-traffic-display-value-slider"></div>
                <br>
            </p>
            <div id="exim-traffic-slider" style="margin-left:5px;"></div>
            <br>
            <div id="exim-traffic-display-graph" class="display-graph">
                <div class="dvLoading"></div>
            </div>
            
        </div>
    {/if}
    {if $isNamed}
        <div class="tab_content2" style="display: block;">
            
            <p>
                <div id="named-session-display-value-slider"></div>
                <br>
            </p>
            <div id="named-session-slider" style="margin-left:5px;"></div>
            <br>
            <div id="named-session-display-graph" class="display-graph">
                <div class="dvLoading"></div>
            </div>
            
            <br><br>
            
        </div>
    {/if}
              
{* </div> *}






<!-- START HIDDEN  -->
<input type="hidden" id = "account-id"  name="account-id" value="{$accountId}">
<input type="hidden" id = "server-id"  name="server-id" value="{$serverId}">
<input type="hidden" id = "client-id"  name="client-id" value="{$clientId}">

<input type="hidden" id = "tabs-once-mn-graph"  name="tabs-once-mn-graph" value="0">
<input type="hidden" id = "tabs-once-mn-notification"  name="tabs-once-mn-notification" value="0">

<!-- END HIDDEN -->