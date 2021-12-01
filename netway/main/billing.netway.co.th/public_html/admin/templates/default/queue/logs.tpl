{literal}
    <script>
        function showlog(title, logg) {
            var tpl = $('#' + logg).html()

            bootbox.dialog({
                title: title,
                message: tpl,
                size: 'large',
                backdrop: true
            });
            return false;
        }
    </script>
{/literal}
    <div  class="searchbox">

        <div id="hider" style="display:none"></div>
    </div>
<form action="" method="post" id="testform">
    <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
    <div class="blu">

        <div class="left menubar">
            {if $queuestatus}
                <a href="?cmd=queue&action=restart&security_token={$security_token}"
                   class="menuitm" onclick="return confirm('Are you sure?');">
                    <strong>Restart queue</strong>
                </a>
            {/if}
            Queue is:
            <span class="label label-{if $queuestatus}success{else}danger{/if}">
                {if $queuestatus}Running{else}Stopped{/if}
            </span>
        </div> <div id="hider2" style="padding-top:4px" class=" pull-right" >
            &nbsp;&nbsp;&nbsp;
            <a href="?cmd=queue&action=getadvanced" class="fadvanced">{$lang.filterdata}</a> <a href="?cmd=domains&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
        </div>
        <div class="right">
            <div class="pagination"></div>

        </div>
        <div class="clear"></div>
    </div>
    <a href="?cmd=queue" id="currentlist" style="display:none" updater="#updater"></a>
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover"
           style="table-layout: fixed;">
        <tbody>
            <tr>
                <th width="40"><a href="?cmd=queue&orderby=id|ASC" class="sortorder">Id</a></th>
                <th width="80" ><center><a href="?cmd=queue&orderby=parent_id|ASC" class="sortorder">Parent</a></center></th>
                <th width="120" ><a href="?cmd=queue&orderby=queue|ASC" class="sortorder">Queue</a></th>
                <th width="120">Target</th>
                <th><a href="?cmd=queue&orderby=description|ASC" class="sortorder">Description</a></th>
                <th width="150"><a href="?cmd=queue&orderby=added|ASC" class="sortorder">Scheduled</a></th>
                <th width="150"><a href="?cmd=queue&orderby=changed|ASC" class="sortorder">Changed</a></th>
                <th width="60"><a href="?cmd=queue&orderby=status|ASC" class="sortorder">Status</a></th>
                <th width="60">Info</th>
                <th width="60">Error</th>
            </tr>
        </tbody>
        <tbody id="updater">
            {include file="queue/ajax.logs.tpl"}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th></th>
                <th colspan="9">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span
                            id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span
                            id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
        </tbody>
    </table>
    <div class="blu">

        <div class="right">
            <div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>
    {securitytoken}
</form>
