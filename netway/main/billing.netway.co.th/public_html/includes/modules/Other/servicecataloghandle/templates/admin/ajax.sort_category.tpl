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
            <td width="140" id="s_menu" style="" valign="top">
                <div id="lefthandmenu">
                    <a class="tchoice" href="#">Sort</a>
                 </div>
            </td>
            <td class="conv_content form"  valign="top">
                
                <div class="tabb">
                    <h3>เรียงลำดับ {if $type == 'incidentKB'}Incident KB{else}Service Catalog{/if} category</h3>
                    
                    <!-- Start content -->
                    
                    <p style="margin-bottom:0px;">ลากเพื่อจัดลำดับการแสดงผลก่อนหลัง</p>
                    
                    <h4>{if $aCats|@count}จัดลำดับหมวด{/if}</h4>
                    <ul id="sortCat" class="sortableItem">
                        {if count($aCats)}
                        {foreach from=$aCats item=aCat}
                        <li value="{$aCat.id}">#{$aCat.id} {$aCat.name}</li>
                        {/foreach}
                        {/if}
                    </ul>
                    
                    <!-- End content -->
                    
                </div>
                
            </td>
        </tr>
        </table>
        
    </div>
    
    <script type="text/javascript">
    {literal}
    
    $('#lefthandmenu').TabbedMenu({elem:'.tabb'{/literal}{if $picked_tab},picked:{$picked_tab}{/if}{literal}});
    
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
            $.post('?cmd=servicecataloghandle&action=orderCategory', {
                parentId: {/literal}{$parentId}{literal},
                type    : '{/literal}{$type}{literal}',
                lists   : ''+sorts+''
            }, function (a) { 
                parse_response(a); 
                $('.spinner').hide();
            });
        });
        
    });
    
    {/literal}
    </script>
    
    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">

            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>

        </div>
        <div class="clear"></div>
    </div>
</div>