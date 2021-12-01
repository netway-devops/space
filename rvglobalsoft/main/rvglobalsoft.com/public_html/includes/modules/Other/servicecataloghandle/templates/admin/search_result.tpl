{include file="$tplPath/admin/header.tpl"}

{include file="$tplPath/admin/search_box.tpl"}

<div><p>&nbsp;</p></div>

<h3>Search result ({$total} รายการ)</h3>
<div class="mod_desc">
<div class="mmdescr">
    {if $aLists|@count}
    <ul id="grab-sorter" style="width:100%">
        
        {foreach from=$aLists item=aList}
        <li {if $aList.is_publish == '0'} style="background-color: #F9F9F9;" {/if}>
            <table width="100%" cellspacing="0" cellpadding="0" border="0">
            <tbody>
            <tr>
                <td width="70%">
                    <h3>{$aList.title}</h3>
                    <p style="color:gray; margin: 3px;">{$aList.desc}</p>
                    Owner: <u>{$aList.firstname}</u>
                    &nbsp;
                    Category: <u>{$aList.category}</u>
                    &nbsp;
                    <small style="color:gray;">{$aList.date}</small>
                </td>
                <td class="mrow1">
                    <a href="?cmd=servicecataloghandle&action=view&id={$aList.id}" class="menuitm menuc">แก้ไข</a>
                    <a href="?cmd=servicecataloghandle&action=deleteServiceCatalog&id={$aList.id}" onclick="return confirm('ยืนยันการลบ?');" class="menuitm menul"><span style="color:#FF0000">ลบ</span></a>
                </td>
            </tr>
            </tbody>
            </table>
        </li>
        {/foreach}
        
        <li>
            <p align="center">
                <a href="{if ! $prev}#{/if}?cmd=module&module=servicecataloghandle&action=serviceCatalog&p={$prev}&searchKeyword={$searchKeyword}"> &lt; Prev </a>
                 &nbsp; | &nbsp; 
                <a href="{if ! $next}#{/if}?cmd=module&module=servicecataloghandle&action=serviceCatalog&p={$next}&searchKeyword={$searchKeyword}"> Next &gt; </a>
            </p>
        </li>
        
    </ul>
    {/if}
</div>
</div>

{include file="$tplPath/admin/footer.tpl"}
