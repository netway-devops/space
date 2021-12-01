<div style="padding:15px;">
    <div class="sectioncontent ">
        <a href="?cmd=reports&action=snapshots" id="currentlist" style="display:none" updater="#updater"></a>
        <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="whitetable hover">
            <thead>
            <tr>
                <th><a href="?cmd=reports&action=snapshots&orderby=id|ASC" class="sortorder">Snapshot</a></th>
                <th><a href="?cmd=reports&action=snapshots&orderby=report_id|ASC" class="sortorder">Report</a></th>
                <th width="250"><a href="?cmd=reports&action=snapshots&orderby=frequency|ASC" class="sortorder">Frequency</a></th>
                <th width="250"><a href="?cmd=reports&action=snapshots&orderby=target|ASC" class="sortorder">Target</a></th>
                <th width="100"><a href="?cmd=reports&action=snapshots&orderby=generated_count|ASC" class="sortorder">Total exports</a></th>
                <th><a href="?cmd=reports&action=snapshots&orderby=generated_at|ASC" class="sortorder">Last exported</a></th>
                <th><a href="?cmd=reports&action=snapshots&orderby=created_at|ASC" class="sortorder">Created</a></th>
                <th width="50"></th>
            </tr>
            </thead>
            <tbody id="updater">
                {if $snapshots}
                    {include file="reports/ajax.snapshots.tpl"}
                {else}
                    <strong>{$lang.nothing}</strong>
                {/if}
            </tbody>
            <tbody id="psummary">
            <tr>
                <th colspan="100%">
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
    </div>
</div>