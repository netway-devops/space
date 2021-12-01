<div class="mmfeatured">
<div class="mmfeatured-inner">

        <table border="0" width="100%" cellpadding="2" cellspacing="2">
        <tr>
            <td width="60%">
                
            <form id="searchForm" method="get" action="">
            <input type="hidden" name="cmd" value="servicecataloghandle" />
            <input type="hidden" name="action" value="search" />
            <input type="hidden" name="type" value="{$oInfo->type}" />
            <div style="padding:5px;background:#305083;border:1px solid #021437;color:#ffffff;-moz-border-radius: 5px;border-radius: 5px; margin-bottom:10px;" class="blureribbon">
            <div style="padding:3px" class="bl_searchbox">
            <table width="100%" cellspacing="0" cellpadding="2" border="0">
            <tbody>
            <tr>
                <td>
                <input id="search-input" name="searchKeyword" value="{$searchKeyword}" placeholder="ค้นหา {if $oInfo->type == 'incidentKB'} Incident KB {else} Service Catalog {/if} " style="width:99%" class="styled inp">
                </td>
                <td width="60" align="right"> 
                <a class="new_control greenbtn" href="#" onclick="$('#searchForm').submit();"><span>Search</span></a>
                </td>
            </tr>
            </tbody>
            </table>
            </div>
            </div>
            </form>
                
            </td>
            <td>
                    
            &nbsp;&nbsp;&nbsp;
            <a href="?cmd=servicecataloghandle&action=browse{if $oInfo->type == 'incidentKB'}&type=incidentKB{/if}"><strong>Browse</strong></a>
            &nbsp;&nbsp;&nbsp;
            <a href="?cmd=servicecataloghandle&action={if $oInfo->type == 'incidentKB'}requestForIncidentKB{else}requestForServiceCatalog{/if}"><strong>Add New</strong></a>
            &nbsp;&nbsp;&nbsp;
                
            </td>
        </tr>
        </table>

</div>
</div>