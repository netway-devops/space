<script type="text/javascript" src="{$template_dir}js/jquery-1.3.2.min.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/packed.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js//jquery.sortable.js?v={$hb_version}"></script>

<script type="text/javascript" src="{$template_dir}js/facebox/facebox.js"></script>
<link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />

<style type="text/css">
{literal}
.sortableItem{ display: block; margin-right: 50px;}
.sortableItem li{ 
    display: block; 
    list-style: none; 
    border:1px solid #DBDBDB; 
    background-color:#EFEFEF; 
    line-height: 1.8em; 
    margin:2px;
    padding:2px;
}
.sortable-dragging {
    background-color:#D1FFD1;
}
{/literal}
</style>

<div id="formcontainer">
    <div id="formloader">
        
        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td class="conv_content form"  valign="top">
                
            <!-- Start content -->
            
            <h3 style="margin-bottom:0px;">ลากเพื่อจัดลำดับการแสดงผลก่อนหลัง</h3>
            
            <h4>{if $aCats|@count}จัดลำดับหมวด{/if}</h4>
            <ul id="sortCat" class="sortableItem">
                {if count($aCats)}
                {foreach from=$aCats item=aCat}
                <li value="{$aCat.id}">{$aCat.id} {$aCat.name}</li>
                {/foreach}
                {/if}
            </ul>
            
            <h4>{if $aItems|@count}จัดลำดับเอกสาร{/if}</h4>
            <ul id="sortItem" class="sortableItem">
                {if count($aItems)}
                {foreach from=$aItems item=aItem}
                <li value="{$aItem.id}">{$aItem.id} {$aItem.title}</li>
                {/foreach}
                {/if}
            </ul>

            <!-- End content -->
                
            </td>
        </tr>
        </table>
        
    </div>
    
    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">

            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>

        </div>
        <div class="clear"></div>
    </div>
</div>

<script type="text/javascript">
{literal}

$(document).ready( function () {
    
    var catLength       = {/literal}{$aCats|@count}{literal};
    $('#sortCat').sortable().bind('sortupdate', function() {
        $('.spinner').show();
        var sorts   = '0';
        $('#sortCat li').each( function (i) {
            if (i == catLength) {
                return false;
            }
            sorts   += ','+ $(this).attr('value');
        });
        $.post('?cmd=kbhandle&action=sorterUpdate', {
            type    : 'cat',
            catId   : {/literal}{$catId}{literal},
            lists   : ''+sorts+''
        }, function (data) { 
            parse_response(data); 
            $('.spinner').hide();
        });
    });
    
    var itemLength      = {/literal}{$aItems|@count}{literal};
    $('#sortItem').sortable().bind('sortupdate', function() {
        $('.spinner').show();
        var sorts   = '0';
        $('#sortItem li').each( function (i) {
            if (i == itemLength) {
                return false;
            }
            sorts   += ','+ $(this).attr('value');
        });
        $.post('?cmd=kbhandle&action=sorterUpdate', {
            type    : 'item',
            catId   : {/literal}{$catId}{literal},
            lists   : ''+sorts+''
        }, function (data) { 
            parse_response(data); 
            $('.spinner').hide();
        });
    });
    
});

{/literal}
</script>