{include file="$tplPath/admin/header.tpl"}
{literal}
<style>
    
    tr.table-orderpage-config > td {
        text-align: center;
    }
    
</style>
{/literal}
<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.5/css/bootstrap.min.css" integrity="sha384-AysaV+vQoT3kOAXZkl02PThvDr8HYKPZhNT5h/CXfBThSRXQ6jW5DO2ekP5ViFdi" crossorigin="anonymous">
<script src="templates/default/js/jQuery-Plugin-To-Fix-Table-Headers-Columns-Sticky-js/src/sticky.js"></script>
<h2>Service request - Fulfillment</h2>

<table id="orderPage" class="table table-hover" border="1">
<thead class="thead-inverse">
<tr>
    <th rowspan="2">Product Order Page</th>
    <th rowspan="2">URL</th>
    <th colspan="5" style="text-align: center; background-color: #333333">SEO</th>
    <th colspan="5" style="text-align: center; background-color: #666666">Product Content</th>
    <th colspan="4" style="text-align: center; background-color: #333333">Zendesk Guide</th>
    <th colspan="2" style="text-align: center; background-color: #666666">Pipedrive</th>
</tr>
    <th  style="background-color: #666666"><div align="center">Meta Title</div></th>
    <th  style="background-color: #666666"><div align="center">Meta Description</div></th>
    <th  style="background-color: #666666"><div align="center">FB title</div></th>
    <th  style="background-color: #666666"><div align="center">FB description</div></th>
    <th  style="background-color: #666666"><div align="center">FB image</div></th>
    <th  style="background-color: #333333"><div align="center">Description</div></th>
    <th  style="background-color: #333333"><div align="center">tab1 name</div></th>
    <th  style="background-color: #333333"><div align="center">tab2 name</div></th>
    <th  style="background-color: #333333"><div align="center">tab3 name</div></th>
    <th  style="background-color: #333333"><div align="center">tab4 name</div></th>
    <th  style="background-color: #666666"><div align="center">FAQ</div></th>
    <th  style="background-color: #666666"><div align="center">Service request</div></th>
    <th  style="background-color: #666666"><div align="center">datasheet</div></th>
    <th  style="background-color: #666666"><div align="center">Resource</div></th>
    <th  style="background-color: #333333"><div align="center">New</div></th>
    <th  style="background-color: #333333"><div align="center">Renew</div></th>
</tr>
</thead>
<tbody>
{assign var="catName" value=""}
{foreach from=$aCategory key=catId item=aCat}
{assign var="aOptionConfig" value=$aCat.opconfig|unserialize}
<tr class="table-orderpage-config">
    <td>
        
        {if $catName != $aCat.name}
        <a href="?cmd=services&action=category&id={$catId}" target="_blank">{$aCat.name}</a>
        {assign var="catName" value=$aCat.name}
        {/if}
        
    </td>
    <td>
        
        {if $aCat.slug}
        <a href="{$system_url}{$aCat.slug}" target="_blank">{$system_url}{$aCat.slug}</a>
        {/if}
        
    </td>
    <td>
        
        {if $aPageSeo.$catId.title}
            {$aPageSeo.$catId.title}
        {/if}
        
    </td>
    <td>
        
        {if $aPageSeo.$catId.description}
            {$aPageSeo.$catId.description}
        {/if}
        
    </td>
    <td>
        
        {if $aOptionConfig.sharetitle}<i class="fas fa-check-circle" style="color: green;"></i>{else}<i class="fas fa-times-circle" style="color: red;"></i>{/if}
        
    </td>
    <td>
        
        {if $aOptionConfig.sharedesc}<i class="fas fa-check-circle" style="color: green;"></i>{else}<i class="fas fa-times-circle" style="color: red;"></i>{/if}
        
    </td>
    <td>
        
        {if $aOptionConfig.shareimage}<i class="fas fa-check-circle" style="color: green;"></i>{else}<i class="fas fa-times-circle" style="color: red;"></i>{/if}
        
    </td>
    <td>
        
        {if $aOptionConfig.webhtml}<i class="fas fa-check-circle" style="color: green;"></i>{else}<i class="fas fa-times-circle" style="color: red;"></i>{/if}
        
    </td><td>
        
        {if $aOptionConfig.tab1value}<i class="fas fa-check-circle" style="color: green;"></i>{else}<i class="fas fa-times-circle" style="color: red;"></i>{/if}
        
    </td><td>
        
        {if $aOptionConfig.tab2value}<i class="fas fa-check-circle" style="color: green;"></i>{else}<i class="fas fa-times-circle" style="color: red;"></i>{/if}
        
    </td><td>
        
        {if $aOptionConfig.tab3value}<i class="fas fa-check-circle" style="color: green;"></i>{else}<i class="fas fa-times-circle" style="color: red;"></i>{/if}
        
    </td><td>
        
        {if $aOptionConfig.tab4value}<i class="fas fa-check-circle" style="color: green;"></i>{else}<i class="fas fa-times-circle" style="color: red;"></i>{/if}
        
    </td>
    <td>
        
        {if array_key_exists($aOptionConfig.zendeskfaq,$aArticle)}
            <a href="{$aArticle[$aOptionConfig.zendeskfaq].html_url}" target="_blank">{$aOptionConfig.zendeskfaq}</a>
        {else}
            <i class="fas fa-times-circle" style="color: red;"></i>
        {/if}
        
    </td>
    <td>
        
        {if array_key_exists($aOptionConfig.zendesksection,$aSection)}
            <a href="https://support.netway.co.th/hc/th/sections/{$aOptionConfig.zendesksection}" target="_blank">{$aOptionConfig.zendesksection}</a>
        {else}
            <i class="fas fa-times-circle" style="color: red;"></i>
        {/if}
        
    </td>
    <td>
        
        {if array_key_exists($aOptionConfig.zendeskservicerequest,$aSection)}
            <a href="https://support.netway.co.th/hc/th/sections/{$aOptionConfig.zendeskservicerequest}" target="_blank">{$aOptionConfig.zendeskservicerequest}</a>
        {else}
            <i class="fas fa-times-circle" style="color: red;"></i>
        {/if}
        
    </td>
    <td>
        
        {if array_key_exists($aOptionConfig.zendeskcategory,$aZendeskCategory)}
            <a href="https://support.netway.co.th/hc/th/categories/{$aOptionConfig.zendeskcategory}" target="_blank">{$aOptionConfig.zendeskcategory}</a>
        {else}
            <i class="fas fa-times-circle" style="color: red;"></i>
        {/if}
        
    </td>
    <td>
        
        {if $aOptionConfig.pipedrivestageid}{$aOptionConfig.pipedrivestageid}{else}<i class="fas fa-times-circle" style="color: red;"></i>{/if}
        
    </td>
    <td>
        
        {if $aOptionConfig.renewpipedrivestageid}{$aOptionConfig.renewpipedrivestageid}{else}<i class="fas fa-times-circle" style="color: red;"></i>{/if}
    
    </td>
</tr>
{/foreach}
</tbody>
</table>
<script>
{literal}
$(document).ready( function () {
    $('#orderPage').sticky( {
        cellWidth   : 200,
        cellHeight  : 30,
        columnCount : 0,
        offset  : { top: 10, left: 10 },
        scrollContainer : window,
    });
});
{/literal}
</script>
{include file="$tplPath/admin/footer.tpl"}
