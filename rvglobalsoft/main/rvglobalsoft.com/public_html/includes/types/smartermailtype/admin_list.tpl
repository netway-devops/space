<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover" style="table-layout: fixed;">
                <tbody>
                  <tr>
                    <th width="20"><input type="checkbox" id="checkall"/></th>
                    <th width="70"><a href="?cmd=accounts&list={$currentlist}&orderby=id|ASC" class="sortorder">{$lang.accounthash}</a></th>
                    <th width="200"><a href="?cmd=accounts&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                    <th><a href="?cmd=accounts&list={$currentlist}&orderby=domain|ASC"  class="sortorder">{$lang.Domain}</a></th>
                    <th width="95"><a href="?cmd=accounts&list={$currentlist}&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                    <th ><a href="?cmd=accounts&list={$currentlist}&orderby=name|ASC"  class="sortorder">{$lang.Service}</a></th>
                    <th width="90"><a href="?cmd=accounts&list={$currentlist}&orderby=size|ASC"  class="sortorder">Size</a></th>
                    <th width="90"><a href="?cmd=accounts&list={$currentlist}&orderby=users|ASC"  class="sortorder">Users</a></th>
                    <th width="90"><a href="?cmd=accounts&list={$currentlist}&orderby=aliases|ASC"  class="sortorder">Aliases</a></th>
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
                <th colspan="11">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
        </tbody>
</table>