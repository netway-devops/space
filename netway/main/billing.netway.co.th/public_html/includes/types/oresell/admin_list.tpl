<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover" >
                <tbody>
                  <tr>
                    <th width="20"><input type="checkbox" id="checkall"/></th>
                    <th width="70"><a href="?cmd=accounts&list={$currentlist}&orderby=id|ASC" class="sortorder">{$lang.accounthash}</a></th>
                    <th width="200"><a href="?cmd=accounts&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                    <th ><a href="?cmd=accounts&list={$currentlist}&orderby=domain|ASC"  class="sortorder">Hostname</a></th>
                    <th width="140"><a href="?cmd=accounts&list={$currentlist}&orderby=bw_usage|ASC"  class="sortorder">Memory</a></th>
                    <th  width="140"><a href="?cmd=accounts&list={$currentlist}&orderby=disk_usage|ASC"  class="sortorder">Disk</a></th>
                    <th width="95"><a href="?cmd=accounts&list={$currentlist}&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                    <th ><a href="?cmd=accounts&list={$currentlist}&orderby=name|ASC"  class="sortorder">{$lang.Service}</a></th>
                    <th  width="160"><a href="?cmd=accounts&list={$currentlist}&orderby=total|ASC"  class="sortorder">{$lang.Price}</a></th>
                    <th width="90"><a href="?cmd=accounts&list={$currentlist}&orderby=next_due|ASC"  class="sortorder">{$lang.nextdue}</a></th>
                    <th width="20"/>
                  </tr>
                </tbody>
                <tbody id="updater">

              {if file_exists("`$custolist_dir`ajax.admin_list.tpl")}
					{include file="`$custolist_dir`ajax.admin_list.tpl"}
			  {/if}
    </tbody><tbody id="psummary">
            <tr>
                <th></th>
                <th colspan="10">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
        </tbody>
</table>
{literal}
<style type="text/css">
.progress-content {
    position:absolute;background:#5C9CCC url('templates/default/img/bg_slide.png') repeat-x center left;height:15px;
      border-bottom-left-radius: 4px;
    border-top-left-radius: 4px;
    border:1px solid #4297D7;
    margin:-1px;
}
.progress-radius {
  border-radius: 4px;
}
.progress-left {
    position:absolute;
    top:1px;
    left:4px;
    color:white;
    font-size:10px
}
.progress-right {
    position:absolute;
    top:1px;
    right:4px;
    color:white;
    font-size:10px
}
.progress-dark {
    color:#404040;
}
.progress-container {
position:relative;width:120px;height:15px;border:1px solid #CCCCCC;
    border-radius: 4px;
}
</style>
{/literal}