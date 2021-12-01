<link href="{$template_dir}css/jquery-ui.css?v={$hb_version}" rel="stylesheet" media="all" />
<div class="blu">
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
        <tbody><tr><td>
                    <a  href="?cmd=reports">
                        <strong>&laquo; Back to all reports</strong>
                    </a>
                </td><td align="right"></td></tr>
        </tbody></table>
</div>
<div style="padding:15px;">
    {if $report.custom}
    {include file='reports/editor.tpl'}
    {/if}
    <form action="?cmd=reports&action=show&report={$report.id}" method="post" id="reportform" target="_blank" >
        <div class="sectioncontent">
            {if !$report.custom}
            <h2>{$report.name}</h2>
            {/if}

            {if !$exception}

            <table border="0" cellspacing="0" cellpadding="6" width="100%">
                <tr>
                    <td  class="enum"><h1>1.</h1></td>
                    <td>
                        {include file='reports/report.columns.tpl'}

                    </td>
                </tr>
                <tr>
                    <td class="enum"><h1>2.</h1></td>
                    <td>
                        {include file='reports/report.params.tpl'}
                    </td></tr>

                <tr>
                    <td class="enum"><h1>3.</h1></td>
                    <td> <strong>Export as:</strong>
                        <div id="subwiz_opt" class="p5">
                            {foreach from=$outputs item=out name=fr key=k}
                            <span {if (!$report.state.output && $smarty.foreach.fr.first) || $report.state.output==$out.name}class="active"{/if}>
                                <input type="radio" onclick="$('.opt_settings').hide();$('#premade{$k}_html').show();prswitch(this);"  id="premade{$k}" value="{$out.name}" name="output"
                                      {if (!$report.state.output && $smarty.foreach.fr.first) || $report.state.output==$out.name}checked="checked"{/if}>
                                   <label >{$out.name}</label>
                            </span>
                            {/foreach}
                        </div>
                        <div id="settingshtml">
                            {foreach from=$outputs item=out name=fr key=k}
                            <div {if !$smarty.foreach.fr.first}style="display:none"{/if} id="premade{$k}_html" class="opt_settings">
                                {$out.config}
                            </div>
                            {/foreach}
                        </div>

                        <div style="margin:30px 0px;height:30px;">
                        <a  href="#" class="new_dsave new_menu" onclick="$('#reportform').attr('action','?cmd=reports&action=save&report={$report.id}').removeAttr('target').submit();return false;">
                            <span>Save parameters</span>
                        </a>
                        <a  href="#" class="new_ddown new_menu" onclick="$('#reportform').attr('action','?cmd=reports&action=show&report={$report.id}').attr('target','_blank').submit();return false;">
                            <span>Generate report</span>
                        </a></div>
                    </td></tr>

                <tr>
                    <td  class="enum"><h1>4.</h1></td>
                    <td>
                        <strong>Optionally: Create widget to be added to Admin dashboard</strong>
                        <div class="clear"></div>
                        <div class="p5 pull-left" style="margin-right:20px">
                            <table border="0" cellspacing="0" cellpadding="3" id="trtable" >
                                <tr>
                                    <td width="120">Widget name:</td>
                                    <td width="350"><input type="text" name="widget_name" class="col-lg-12 form-control" value="{$report.name}"/></td>
                                </tr>
                                <tr>
                                    <td width="120">Widget type:</td>
                                    <td width="350"><select name="widget_type" class="form-control">
                                            <option value="table">Data table</option>
                                            <option value="pie-chart">Pie chart</option>
                                            <option value="bar-chart">Bar graph</option>
                                            <option value="line-chart">Line graph</option>
                                            <option value="metric">Data metric</option>
                                        </select></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type="submit" class="btn btn-sm btn-primary"  value="Add widget" onclick="$('#reportform').attr('action','?cmd=reports&action=savewidget&report={$report.id}').removeAttr('target').submit();return false;"/>

                                    </td>
                                </tr>
                                </table>
                        </div>
                        <div class="" style="margin-left:20px">
                            <b>Note:</b><br/>
                            -
                                    When creating widget currently selected columns/params/conditions will be used. <br/>Changing them after widget is created will not affect previously generated widgets.
                            <br/><br/>
                            - To use <strong>Pie/line/bar charts</strong> your report should have only two columns exported:<br>
                            first one holding labels, second holding values
                            <br/><br/>
                            - When using <strong>Data metric</strong> type, your report should only return one row of data, each column will be sparate metric



                        </div>
                        <div class="clear"></div>

                        {if $widgets}
                            <strong>Previous widgets:</strong>
                            <div class="p5">
                                <table class="table table-stripped table-condensed">
                                    {foreach from=$widgets item=w}
                                        <tr>
                                            <td width="30">
                                                <a href="?cmd=reports&action=removewidget&widget_id={$w.id}&report={$report.id}&security_token={$security_token}" class="btn btn-xs btn-danger" onclick="return confirm('Are you sure?');"><i class="fa fa-trash"></i></a>
                                            </td>
                                            <td width="20">
                                                <span class="fa fa-{$w.type}"></span>
                                            </td>
                                            <td>
                                                {$w.name}
                                            </td>
                                        </tr>
                                    {/foreach}
                                </table>

                                <div class="clear"></div>
                            </div>
                        {/if}
                    </td>
                </tr>
            </table>
            {else}
            <h2>Query contains errors: {$exception}</h2>
            Please correct your SQL and save changes to get full options

            {/if}



{securitytoken}
    </form>
    <div class="clear"></div>
</div>{literal}
<style>
    .sectioncontent  ul.ui-sortable  { list-style-type: none; margin: 0; padding: 0; margin-bottom: 10px; min-height: 37px;margin:0px;}
    .sectioncontent h2 { margin:0px 0px 16px;}
    .sectioncontent .ui-sortable li { margin: 5px 5px 0px; padding: 5px;  cursor:move; display:inline-block; vertical-align: middle}
    #subwiz_opt span {text-transform: uppercase;}
    #subwiz_opt span.active {font-weight: bold;}
    .p5 {margin-bottom:20px;}
    .enum {
        vertical-align: top;
        border-right:solid 1px #ddd;
        width:50px;
    }
    .enum h1 {
        font-size:26px;
        color:#666;
    }

</style>
<script>



</script>
{/literal}