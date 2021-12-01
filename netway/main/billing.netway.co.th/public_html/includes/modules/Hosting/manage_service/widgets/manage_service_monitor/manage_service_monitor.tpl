<script src="{$system_url}includes/modules/Hosting/manage_service/public_html/js/external/jquery.ui/1.8.24/jquery-ui.min.js?v={$hb_version}"></script>
<script src="{$system_url}includes/modules/Hosting/manage_service/public_html/js/external/jquery.ibutton/lib/jquery.ibutton.js"></script>
<script src="{$system_url}includes/modules/Hosting/manage_service/public_html/js/manage.js"></script>
<script src="{$system_url}includes/modules/Hosting/manage_service/public_html/js/MN.js"></script>

<link href="{$system_url}includes/modules/Hosting/manage_service/public_html/js/external/jquery.ui/1.8.24/themes/base/jquery-ui.css?v={$hb_version}" rel="stylesheet" media="all" />
<link href="{$system_url}includes/modules/Hosting/manage_service/public_html/js/external/jquery.ibutton/css/jquery.ibutton.css?v={$hb_version}" rel="stylesheet" media="all" />
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
         
         
         if (isAgentd == 'true') {
             
            $("#tabs-monitor-all").tabs();
            $("#tabs-containner-mysql").tabs().css({ 'width' : '95%'});
            
            // $.manage.validateTabGraph();
            $.manage.onclickTabCpu();
            
            $('#tabs-monitor-all').bind('tabsshow', function(event, ui) {

                if (ui.panel.id == 'tabs-monitor-cpu') {
                    $.manage.onclickTabCpu();
                } else if (ui.panel.id == 'tabs-monitor-memory') {
                    $.manage.onclickTabMemory();
                } else if (ui.panel.id == 'tabs-monitor-disk') {
                    $.manage.onclickTabDisk();
                } else if (ui.panel.id == 'tabs-monitor-apache') {
                    $.manage.onclickTabApache();
                } else if (ui.panel.id == 'tabs-monitor-mysql') {
                    $.manage.onclickTabMysql();
                } else if (ui.panel.id == 'tabs-monitor-nginx') {
                    $.manage.onclickTabNginx();
                } else if (ui.panel.id == 'tabs-monitor-exim') {
                    $.manage.onclickTabExim();
                } else if (ui.panel.id == 'tabs-monitor-named') {
                    $.manage.onclickTabNamed();
                }
                
            });
            
         } else {
            $.manage.raiseError('App "Manage Service" Require Zabbix Agentd. Please install zabbix agentd.');
         } 
                 
     });
</script>
    
{/literal}

<br clear="all" />


<div id="tabs-monitor-all">
    
  <ul>
    {if $isCpu} <li><a href="#tabs-monitor-cpu">CPU</a></li> {/if}
    {if $isMemory} <li><a href="#tabs-monitor-memory">Memory</a></li> {/if}
    {if $isDisk} <li><a href="#tabs-monitor-disk">Disk</a></li> {/if}
    {if $isApahce} <li><a href="#tabs-monitor-apache">Apache</a></li> {/if}
    {if $isMysql} <li><a href="#tabs-monitor-mysql">MySQL</a></li> {/if}
    {* 
    {if $isMysql} <li><a href="#tabs-monitor-mysql">MySQL Server</a></li> {/if}
    {if $isMysql} <li><a href="#tabs-monitor-myisam">MyISAM database engine performance</a></li> {/if}
    {if $isMysql} <li><a href="#tabs-monitor-innodb">InnoDB database engine performance</a></li> {/if}
    *}
    {if $isNginx} <li><a href="#tabs-monitor-nginx">Nginx</a></li> {/if}
    {if $isExim} <li><a href="#tabs-monitor-exim">Exim</a></li> {/if}
    {if $isNamed} <li><a href="#tabs-monitor-named">Named</a></li> {/if}
  </ul>
  {if $isCpu}
      <div id="tabs-monitor-cpu">
          
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
      <div id="tabs-monitor-memory">
        
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
    <div id="tabs-monitor-disk">
        
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
    <div id="tabs-monitor-apache">
        
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
    <div id="tabs-monitor-mysql">
        
        
        <div id="tabs-containner-mysql">
            <ul>
                <li><a href="#tabs-monitor-mysql-server">MySQL Server</a></li>
                <li><a href="#tabs-monitor-mysql-myisam">MyISAM database engine performance</a></li>
                <li><a href="#tabs-monitor-mysql-innodb">InnoDB database engine performance</a></li>
            </ul>
        
            <div id="tabs-monitor-mysql-server">
                
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
            
            <div id="tabs-monitor-mysql-myisam">
                
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
            
            <div id="tabs-monitor-mysql-innodb">
                
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
        
        
    </div>
  {/if}
  {*
  {if $isMysql}
    <div id="tabs-monitor-mysql">
        
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
    <div id="tabs-monitor-myisam">
        
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
    <div id="tabs-monitor-innodb">
        
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
    <div id="tabs-monitor-nginx">
        
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
    <div id="tabs-monitor-exim">
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
    <div id="tabs-monitor-named">
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
  
</div>


<!-- START HIDDEN  -->
<input type="hidden" id = "account-id"  name="account-id" value="{$accountId}">
<input type="hidden" id = "server-id"  name="server-id" value="{$serverId}">
<input type="hidden" id = "client-id"  name="client-id" value="{$clientId}">
<!-- END HIDDEN -->