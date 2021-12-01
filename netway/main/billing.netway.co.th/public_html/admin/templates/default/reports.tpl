<script type="text/javascript" src="{$template_dir}js/reports.js?v={$hb_version}" ></script>
<script type="text/javascript" src="{$template_dir}js/timepicker/jquery.timepicker.min.js?v={$hb_version}" ></script>

<link media="all" rel="stylesheet" href="{$template_dir}js/timepicker/jquery.timepicker.css" />
<link href="{$template_dir}css/jquery-ui.css?v={$hb_version}" rel="stylesheet" media="all"/>

{literal}
    <style>
        .snapshot .haspicker {
            display: inline-block;
            float: none;
        }
        .snapshot a.dp-choose-date {
            display: inline-block;
            float: none;
        }
        .snapshot .inp-controls {
            display: inline-block;
            vertical-align: top;
            border: 1px solid #ccc;
            border-left: none;
            margin-left: -5px;
            margin-top: 1px;
            border-radius: 0 2px 2px 0;
        }
        .snapshot .inp-controls .btn + .btn {
            margin-top: 0;
        }
        .snapshot .inp-controls .btn {
            display: block;
            line-height: 1em;
            height: 1em;
            border: none;
            padding: 1px 4px;
            border-radius: 0 2px 2px 0;
        }
        .sectioncontent ul.ui-sortable {
            list-style-type: none;
            margin: 0;
            padding: 0;
            margin-bottom: 10px;
            min-height: 37px;
        }
        .sectioncontent h2 {
            margin: 0 0 16px;
        }

        .sectioncontent .ui-sortable li {
            margin: 5px 5px 0;
            padding: 5px;
            cursor: move;
            display: inline-block;
            vertical-align: middle
        }
        #subwiz_opt span {
            text-transform: uppercase;
        }
        #subwiz_opt span.active {
            font-weight: bold;
        }
        .p5 {
            margin-bottom: 20px;
        }
        .enum {
            vertical-align: top;
            border-right: solid 1px #ddd;
            width: 50px;
        }
        .enum h1 {
            font-size: 26px;
            color: #666;
        }
    </style>
{/literal}
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td><h3>{$lang.systemstatistics}</h3></td>
        <td></td>
    </tr>
    <tr>
        <td class="leftNav">
            {include file='reports/sidebar.tpl'}
        </td>
        <td valign="top" class="bordered" rowspan="2">
            <div id="bodycont" style="">
                <div id="newshelfnav" class="newhorizontalnav">
                    <div class="list-1">
                        <ul class="float-left">
                            <li class="{if $action=='default' || $action=='_default' || $action=='get' || !$action}active{/if}">
                                <a href="?cmd=reports"><span>{$lang.reports}</span></a>
                            </li>
                            <li class="{if $action=="groups"}active{/if}">
                                <a href="?cmd=reports&action=groups"><span>{$lang.report_groups}</span></a>
                            </li>
                            <li class="{if $action=="snapshots" || $action=="editsnapshot"}active{/if}">
                                <a href="?cmd=reports&action=snapshots"><span>Report Snapshots</span></a>
                            </li>
                        </ul>
                        {if $reports.Custom}
                            <div style="float: right; margin-top: 10px;">
                                <a class="btn btn-primary btn-sm" href="?cmd=reports&action=customize&id=0&security_token={$security_token}">
                                    <i class="fa fa-plus"></i>
                                    Create new custom report
                                </a>
                            </div>
                        {/if}
                    </div>
                </div>
                {if $action=='get'}
                    {include file='reports/getreport.tpl'}
                {elseif $action == 'snapshots'}
                    {include file="reports/snapshots.tpl"}
                {elseif $action == 'editsnapshot'}
                    {include file="reports/snapshot.tpl"}
                {else}
                    <div style="padding:15px;">
                        <div class="sectioncontent">
                            {if $action == 'default' || $action == '_default'}
                                {if $reports}
                                    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable"
                                           style="border:solid 1px #ddd;">
                                        <tbody>
                                        {foreach from=$reports key=type item=rep}
                                            <tr>
                                                <th colspan="5" align="left">{$type}</th>
                                            </tr>
                                            {foreach from=$rep item=report name=fr}
                                                <tr class="havecontrols {if $smarty.foreach.fr.index%2==0}even{/if} ">
                                                    <td>
                                                        <a href="?cmd=reports&action=get&id={$report.id}">{if $report.displayname}{$report.displayname}{else}{$report.name}{/if}</a>
                                                    </td>
                                                    <td width="20">{if $report.havewidget}
                                                            <i class="fa fa-table vtip vtip-description"
                                                               title="This report have widget"></i>
                                                        {/if}</td>
                                                    {if !($report.options & 1)}
                                                        <td width="60">
                                                            {if $type != 'Custom' && $customize[$type] && $reports.Custom}
                                                                <a href="?cmd=reports&action=customize&id={$report.id}&security_token={$security_token}"
                                                                   class="editbtn editgray">Customize</a>
                                                            {/if}
                                                        </td>
                                                        <td width="20">
                                                            {if $customize[$type]}
                                                                <a href="?cmd=reports&action=delete&id={$report.id}&security_token={$security_token}"
                                                                   onclick="return confirm('Are you sure you wish to remove this report?');"
                                                                   class="delbtn">Delete</a>
                                                            {/if}
                                                        </td>
                                                    {else}
                                                        {if $customize[$type] && $reports.Custom}
                                                            <td width="60">
                                                                <a href="?cmd=reports&action=customize&id={$report.id}&security_token={$security_token}"
                                                                   class="editbtn editgray">Customize</a>
                                                            </td>
                                                        {else}
                                                            <td width="60"></td>
                                                        {/if}
                                                        <td width="20"></td>
                                                    {/if}
                                                </tr>
                                            {/foreach}
                                        {/foreach}
                                        </tbody>
                                    </table>
                                {else}
                                    <strong>{$lang.nothing}</strong>
                                {/if}
                            {elseif $action == 'groups'}
                                {if !$manageReportGroups}
                                    {include file='ajax.lackprivileges.tpl'}
                                {else}
                                    {if $groups}
                                        {include file="ajax.report_groups.tpl"}
                                    {else}
                                        <strong>{$lang.nothing}</strong>
                                    {/if}
                                {/if}
                            {/if}
                        </div>
                    </div>
                {/if}
            </div>
        </td>
    </tr>
</table>