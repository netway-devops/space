<div class="nicerblu" id="addtask" style="padding: 15px;">
        <center>
           <b> To make queue process tasks in background, please add following to your crontab:</b><br/><input type="text" value="* * * * * php -q {$cronpath}" readonly="readonly" size="100"/><br/>
        </center>

</div>
<div >
    <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
    <a href="?cmd=hostbillqueue" id="currentlist" style="display:none"  updater="#updater"></a>
    <table class="glike hover" width="100%" cellspacing=0 >
        <thead>
        <tr>
            <th width="10"><a href="?cmd=hostbillqueue&orderby=id|ASC" class="sortorder">Id</a></th>
            <th width="80"><a href="?cmd=hostbillqueue&orderby=parent_id|ASC" class="sortorder">Parent</a></th>
            <th width="100"><a href="?cmd=hostbillqueue&orderby=queue|ASC" class="sortorder">Queue</a></th>
            <th width="120">Target</th>
            <th ><a href="?cmd=hostbillqueue&orderby=description|ASC" class="sortorder">Description</a></th>
            <th width="150"><a href="?cmd=hostbillqueue&orderby=added|ASC" class="sortorder">Added</a></th>
            <th width="150"><a href="?cmd=hostbillqueue&orderby=changed|ASC" class="sortorder">Changed</a></th>
            <th width="60"><a href="?cmd=hostbillqueue&orderby=status|ASC" class="sortorder">Status</a></th>
        </tr>
        </thead>
        <tbody id="updater">
            {include file="ajax.default.tpl"}
        </tbody>
    </table>
    <div>
        <div class="right"><div class="pagination"></div></div>
        <div class="clear"><br/></div>
    </div>
</div>
