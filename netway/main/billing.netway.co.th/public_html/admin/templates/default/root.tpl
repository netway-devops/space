{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'root.tpl.php');
{/php}
<link href="{$template_dir}css/style.css?v={$hb_version}" rel="stylesheet" media="all" />

<script type="text/javascript">loadelements.widgets = true;</script>
<table border="0" cellpadding="0" cellspacing="0" width="100%" >

    <tr>
        <td class="leftNav" style="line-height:20px;padding-top: 47px;">

            <button class="btn btn-primary" id="addnewwidget"><i class="fa fa-cog"></i> Add new widget</button>
            <br />   <br />
            <div style="font-size:11px;line-height:15px;">
                {if $others}
                    <strong>{$lang.whosonline}</strong>
                    <br />

                    {foreach from=$others item=o}
                        <span>{$o.username}</span>
                    {/foreach}

                    <br />
                    <br />
                {/if}

                {if 'acl:editConfiguration'|checkcondition}
                    <span style="font-size:11px;">
                    {$lang.Licenseto}: <strong>{$license.to}</strong><br />
                    {$lang.Expires}: <strong>{$license.expires}</strong><br />
                    {$lang.Version}: <strong>{$version}</strong>{if $build}<em>:{$build}</em>{/if}
                        {if $newversion}<br /><span style="color:red">{$lang.newVersion}: <strong>{$newversion}</strong></span>
                        (<a class="external" target="_blank" href="http://hostbillapp.com/changelog" >{$lang.more|capitalize}</a>)
                        {/if}
                </span>
                    <br />
                {/if}

                {if $forecast}
                    <br />

                    <strong>{$lang.incomeforecast}</strong>
                    <div id="forecast">
                        <strong>{$lang.i6m}:</strong> <br />
                        <div style="text-align:right"><strong>{$forecast.total6|price:$currency}</strong></div>
                        <strong>{$lang.i12m}:</strong> <br />
                        <div style="text-align:right"><strong>{$forecast.total|price:$currency}</strong></div>
                        <strong>{$lang.i24m}:</strong> <br />
                        <div style="text-align:right"><strong>{$forecast.total24|price:$currency}</strong></div>
                    </div>
                {/if}
            </div>
        </td>

        <td  valign="top" id="dashboard-table">

            {if $fake_pdo}
                <div class="gbox1 dashboard-header" style="background:red">
                    <div class="left">
                        <strong>Important!</strong> Please make sure you have PDO &amp; PDO_MySQL installed. After that remove line <b>$force_fake_pdo</b> from your includes/config.php
                    </div>

                    <div class="clear"></div>
                </div>
            {/if}
            {if $low_php}
                <div class="gbox1 dashboard-header" style="background:red;padding:5px 10px">
                    <div >
                        <strong>Important!</strong> You are using old (<b>End-Of-Life</b>) version of PHP. HostBill longer supports it.<br/>Please update to more recent PHP (5.6 or 7.0) release before being able to update to newer HostBill versions
                    </div>

                    <div class="clear"></div>
                </div>
            {/if}

            {if $stats}
                <div class="row no-gutter gbox1 dashboard-header">
                    <div class="col-md-6" style="padding-left:10px">
                        <span class="dashboard-income-line">{$lang.incometoday}: <strong>{$stats.today|price:$currency}</strong></span>
                        <span class="dashboard-income-line">{$lang.thismonth}: <strong>{$stats.month|price:$currency}</strong></span>
                        <span class="dashboard-income-line">{$lang.thisyear}: <strong>{$stats.year|price:$currency}</strong></span>
                    </div>
                    <div class="col-md-6" style="padding-right:10px">
                        <div class="pull-right" style="white-space: nowrap">
                            <span class="hidden-xs">{$lang.orders|capitalize}:</span>
                            <a class="dashboard-stat-line" href="?cmd=orders">Today <strong>{$stats.orders}</strong></a>
                            <a class="dashboard-stat-line" href="?cmd=orders&list=active">{$lang.Activated} <strong>{$stats.active_orders}</strong></a>
                            <a class="dashboard-stat-line" href="?cmd=orders&list=pending">{$lang.Pending} <strong>{$stats.pending_orders}</strong></a>
                            <a class="dashboard-stat-line {if $stats.requests>0}dashboard-stat-red{/if}" href="?cmd=logs&action=cancelations">{$lang.pendingtocancel} <strong>{$stats.requests}</strong></a>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
            {/if}

            <div id="customWidgetBoxContainer"></div>

            <div class="row no-gutter" >
                <div class="col-md-12 top-widgets" data-widget-group="dashboard" data-widget-panel="top">
                    {adminwidget module="dashboard" section="blocks" wrapper="adminwidgets/wrap_dashboard.tpl" panel="top"}
                </div>

                <div class="col-md-6  mainleftcol" data-widget-group="dashboard" data-widget-panel="left" >

                    {if !$temp_queue_check}
                        <div class="box box-solid box-icewhite" >
                            <div class="box-header" >
                                <h3 class="box-title">Note: Enable queue module</h3>

                            </div>
                            <div class="box-body" style="display: block;">
                                Queue is included in your HostBill for free, it runs tasks in background improving frontend performance.
                                In next couple releases it will be included as core feature. To enable:<br><br>
                                <ol>
                                    <li>Add new crontab entry:<br>
                                        <code>* * * * * php {$hb_maindir}queue.php</code></li>
                                    <li style="margin-top:5px;">Activate queue module:<br>
                                        <a href="?cmd=managemodules&action=other&activate&modulename=class.hostbillqueue.php&security_token={$security_token}" class="btn btn-xs btn-success">Activate</a>
                                    </li>
                                </ol>

                            </div>
                        </div>
                    {/if}

                    {adminwidget module="dashboard" section="blocks" wrapper="adminwidgets/wrap_dashboard.tpl" panel="left"}
                </div>

                <div class="col-md-6  mainrightcol" data-widget-group="dashboard" data-widget-panel="right" >
                    {adminwidget module="dashboard" section="blocks" wrapper="adminwidgets/wrap_dashboard.tpl" panel="right"}
                </div>

                <div class="col-lg-12 col-md-6" data-widget-group="dashboard" data-widget-panel="bottom">
                    {adminwidget module="dashboard" section="blocks" wrapper="adminwidgets/wrap_dashboard.tpl" panel="bottom"}
                </div>
            </div>
            {if $qc_features}
            {literal}
                <script type="text/javascript">
                    function appendMe1() {
                        $.facebox({ajax: '?cmd=root&action=initialconfig'});
                    }
                    appendLoader('appendMe1');
                </script>
            {/literal}
            {/if}


            <div id="customWidgetBox" class="bborder">
                <div class="bborder_header">Widget <a href="?refresh=widget" title="Refresh all widget." class="btn btn-sm btn-default box-widget-refresh" data-widget="refresh"><i class="fa fa-refresh"></i></a></div>
                <div class="bborder_content">
                
                <table>
                <tr>
                    <td>
                
                <!-- Admin widget -->
                <ul class="widgetBox300s">
                    
                    {foreach from=$aWidgets item=widget}
                    <li id="{$widget}">
                        <a {if $widget == 'widgetNewCreditLog'}href="?cmd=clientcredit&markasread=1"{else}href="?cmd=widgeter&action=lists&widget={$widget}"{/if}>
                        
                            <label>0</label>
                            <span>Loading...</span>
                        </a>

                    </li>
                    <script language="JavaScript">
                    var refresh     = '{php}if (isset($_GET['refresh'])) {echo $_GET['refresh'];}{/php}';
                    
                    {literal}
                        $.getJSON('?cmd=widgeter&action=counter&widget={/literal}{$widget}{literal}&refresh='+ refresh, function(data) {
                            var wg  = $('#{/literal}{$widget}{literal}');
                            wg.find('a label').html(data.count);
                            wg.find('a span').html(data.title);
                            if (data.count == '0') {
                                wg.attr('style', 'background-color:#EEFFC1; color:green; border: 1px solid #C1D15D; ');
                                wg.find('a').click(function(){return false;});
                            } else {
                                wg.attr('style', 'background-color:#FFE8E8; color:red; border: 1px solid red; ');
                            }
                            
                            wg.hover(
                              function () {
                                $(this).css('overflow', 'visible');
                                $(this).css('height', 'auto');
                              },
                              function () {
                                $(this).css('overflow', 'hidden');
                              }
                            );
                            
                        });
                    {/literal}
                    </script>
                    {/foreach}
                    
                </ul>
                
                   </td>
                </tr>
                </table>
                
                </div>
            </div>

            <div id="fp_leftcol">
                <table id="dashboard-sections">

                </table>


                {if $HBaddons.mainpage}
                    <div class="bborder">
                        <div class="bborder_header">
                            {$lang.Plugins}
                        </div>
                        <div class="bborder_content">
                            {foreach from=$HBaddons.mainpage item=module}
                                <div class="addon_module"><strong><a href="?cmd=module&module={$module.id}">{$module.name}</a></strong></div>
                                <div class="clear"></div>
                            {/foreach}
                        </div>
                    </div>
                {/if}

            </div>

            <div id="fp_bottomcol">

            </div>

        </td>
    </tr>
</table>
<script>
    loadelements.pops=false;

{literal}
$(document).ready( function () {
    $('#customWidgetBox').appendTo('#customWidgetBoxContainer');
});
{/literal}

</script>
<link href="templates/default/dist/plugins/datatables/dataTables.bootstrap.min.css" type="text/css" rel="stylesheet">
<script src="templates/default/dist/plugins/chartjs/Chartjs.min.js"></script>
<script src="templates/default/dist/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="templates/default/dist/plugins/datatables/dataTables.bootstrap.min.js"></script>