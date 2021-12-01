<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                <tbody>
                  <tr>
                    <th width="20"><input type="checkbox" id="checkall"/></th>
                    <th><a href="?cmd=accounts&list={$currentlist}&orderby=id|ASC" class="sortorder">{$lang.accounthash}</a></th>
					<th><a href="?cmd=accounts&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
					<th><a href="?cmd=accounts&list={$currentlist}&orderby=ip|ASC"  class="sortorder">{$lang.IPaddress}</a></th>
					<th><a href="?cmd=accounts&list={$currentlist}&orderby=name|ASC"  class="sortorder">{$lang.Service}</a></th>
					<th><a href="?cmd=accounts&list={$currentlist}&orderby=total|ASC"  class="sortorder">{$lang.Price}</a></th>
					<th><a href="?cmd=accounts&list={$currentlist}&orderby=billingcycle|ASC"  class="sortorder">{$lang.billingcycle}</a></th>
					<th><a href="?cmd=accounts&list={$currentlist}&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
					<th><a href="?cmd=accounts&list={$currentlist}&orderby=next_due|ASC"  class="sortorder">{$lang.nextdue}</a></th>
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
                <th colspan="16">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
        </tbody>
</table>
{literal}
<style type="text/css">
.percentbar > div {position:relative;padding:2px;border:solid 1px #000;z-index:1; text-align:center;overflow:hidden;white-space: nowrap;}
.percentbar div > div{position:absolute;height:100%;top:0;left:0;z-index:-1}
.glike tr.alert td{Background:#fcc} 
#preloader{z-index:100}
</style>
{/literal}