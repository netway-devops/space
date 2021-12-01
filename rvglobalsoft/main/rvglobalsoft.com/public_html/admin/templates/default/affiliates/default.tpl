
<form action="" method="post" id="testform" >
    <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
    <div class="blu">
        <div class="right"><div class="pagination"></div></div>
        <div class="left">
            {$lang.withselected}
            <input type="submit" name="sendmail" value="{$lang.SendMessage}" onclick="return send_msg('clients')" class="btn btn-sm btn-primary" />
        </div>
        <div class="clear"></div>
    </div>   
    <a href="?cmd=affiliates" id="currentlist" style="display:none"></a>
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
        <tbody>
            <tr>
                <th width="20"><input type="checkbox" id="checkall"/></th>
                <th><a href="?cmd=affiliates&list={$currentlist}&orderby=id|ASC" class="sortorder">{$lang.affiliatehash}</a></th>
                <th><a href="?cmd=affiliates&list={$currentlist}&orderby=firstname|ASC"  class="sortorder">{$lang.firstname}</a></th>
                <th><a href="?cmd=affiliates&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.lastname}</a></th>
                <th><a href="?cmd=affiliates&list={$currentlist}&orderby=visits|ASC"  class="sortorder">{$lang.visitors}</a></th>
                <th><a href="?cmd=affiliates&list={$currentlist}&orderby=signups|ASC"  class="sortorder">Approved Orders</a></th>
                <th><a href="?cmd=affiliates&list={$currentlist}&orderby=signups_pending|ASC"  class="sortorder">Pending Approval</a></th>
                <th><a href="?cmd=affiliates&list={$currentlist}&orderby=balance|ASC"  class="sortorder">{$lang.balance}</a></th>
                <th><a href="?cmd=affiliates&list={$currentlist}&orderby=total_withdrawn|ASC"  class="sortorder">{$lang.withdrawn}</a></th>      
                <th><a href="?cmd=affiliates&list={$currentlist}&orderby=status|ASC"  class="sortorder">{$lang.status}</a></th>    
                <th width="20"></th>   
                <th width="20"></th>   
            </tr>
        </tbody>

        <tbody id="updater">
            {include file='ajax.affiliates.tpl'}
        </tbody>

        <tbody id="psummary">
            <tr>
                <th></th>
                <th colspan="11">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
        </tbody>
    </table>

    <div class="blu">
        <div class="right"><div class="pagination"></div></div>
        <div class="left">
            {$lang.withselected}
            <input type="submit" name="sendmail" value="{$lang.SendMessage}" onclick="return send_msg('clients')" class="btn btn-sm btn-primary" /></div>
        <div class="clear"></div>		
    </div>

    {securitytoken}
</form>