<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
       <tr>
        <td ><h3>{$lang.systemstatistics}</h3></td>
        <td></td>
    </tr>
    <tr>
        <td class="leftNav">

			{include file='reports/sidebar.tpl'}
        </td>
        <td  valign="top"  class="bordered" rowspan="2"><div id="bodycont" style="">{if $action=='get'}
            {include file='reports/getreport.tpl'}
                {else}
                <div class="blu">
            <table width="100%" cellspacing="0" cellpadding="0" border="0">
            <tbody><tr><td></td><td align="right">
                        <a class="editbtn" href="?cmd=reports&action=customize&id=0&security_token={$security_token}">Create new custom report</a>
                    </td></tr>
            </tbody></table>
            </div>
                <div style="padding:15px;">
                    <div class="sectioncontent">
                        {if $reports}
                        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
                            <tbody>

                               
	{foreach from=$reports key=type item=rep}

                                <tr>
                                    <th colspan="5" align="left">{$type}</th>
                                </tr>
                                    {foreach from=$rep item=report name=fr}
                                        <tr class="havecontrols {if $smarty.foreach.fr.index%2==0}even{/if} ">
                                            <td><a href="?cmd=reports&action=get&id={$report.id}" >{if $report.displayname}{$report.displayname}{else}{$report.name}{/if}</a></td>
                                            <td width="20">{if $report.havewidget}<i class="fa fa-table vtip vtip-description" title="This report have widget"></i>{/if}</td>
                                            {if !($report.options & 1)}
                                                {if $customize == true}
                                                    <td width="60"></td>
                                                {/if}
                                            <td width="20"><a href="?cmd=reports&action=delete&id={$report.id}&security_token={$security_token}" onclick="return confirm('Are you sure you wish to remove this report?');" class="delbtn">Delete</a></td>
                                            {else}
                                                {if $customize == true}
                                                    <td width="60">
                                                        <a href="?cmd=reports&action=customize&id={$report.id}&security_token={$security_token}" class="editbtn editgray">Customize</a>
                                                    </td>
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

                    </div>
                </div>
           {/if} </div>
        </td>
    </tr>
</table>