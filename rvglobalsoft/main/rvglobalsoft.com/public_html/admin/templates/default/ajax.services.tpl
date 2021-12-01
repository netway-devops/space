{if $action=='default' || $action=='addcategory' || $action=='editcategory' || $action=='category'}
    <script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
    <script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>
{/if}
{if ($action=='category' || $action=='editcategory') && $category}
    {include file='services/category.tpl'}
{elseif $action=='default' || $action=='addproduct' || $action=='addcategory'}
    {include file="services/categories.tpl"}
{elseif $action=='newpageextra'}

{elseif $action=='addonseditor'}
    {if $addons.addons || $addons.applied}{if $addons.applied}<div class="p5">

                <table border="0" cellpadding="6" cellspacing="0" width="100%" >

                    {foreach from=$addons.addons item=f}
                        {if $f.assigned}<tr class="havecontrols">
                                <td width="16">
                                    <div class="controls"><a href="#" class="rembtn"  onclick="return removeadd('{$f.id}')">{$lang.Remove}</a></div></td>
                                <td align="left">{$lang.Addon}: <strong>{$f.name}</strong>
                                </td>
                                <td align="right">
                                    <div class="controls fs11">
                                        {$lang.goto}
                                        <a href="?cmd=productaddons&action=addon&id={$f.id}" class="editbtn editgray" style="float:none" target="_blank">{$lang.addonpage}</a>
                                    </div>
                                </td>
                            </tr>
                        {/if}
                    {/foreach}
                </table>
            </div>
            <div style="padding:10px 4px">
                {if $addons.available}
                    <a href="#" class="new_control" onclick="$(this).hide();
                            $('#addnew_addons').ShowNicely();
                            return false;"  id="addnew_addon_btn">
                        <span class="addsth" >{$lang.assign_new_addons}</span>
                    </a>
                {/if}
            </div>
        {else}
            <div class="blank_state_smaller blank_forms">
                <div class="blank_info">
                    <h3>{$lang.offeraddons}</h3>
                    <div class="clear"></div>
                    <br/>
                    {if $addons.available}
                        <a  href="#" class="new_control"  onclick="$('#addnew_addons').ShowNicely();
                                return false;" ><span class="addsth" ><strong>{$lang.assign_new_addons}</strong></span></a>
                                {else}
                        <a href="?cmd=productaddons&action=addon&id=new"class="new_control"   target="_blank"><span class="addsth" ><strong>{$lang.createnewaddon}</strong></span></a>
                                {/if}
                    <div class="clear"></div>
                </div>
            </div>
        {/if}

        {if $addons.available}
            <div class="p6" id="addnew_addons" {if $addons.applied}style="display:none"{/if}>
                <table  cellpadding="3" cellspacing="0">
                    <tr>
                        <td>
                            {$lang.Addon}: <select name="addon_id">
                                {foreach from=$addons.addons item=f}
                                    {if !$f.assigned}
                                        <option value="{$f.id}">{$f.name}</option>
                                    {/if}
                                {/foreach}
                            </select>
                        </td>
                        <td >
                            <input type="button" value="{$lang.Add}" style="font-weight:bold" onclick="return addadd()"/>
                            <span class="orspace">{$lang.Or}</span> <a href="#" onclick="$('#addnew_addons').hide();
                                    $('#addnew_addon_btn').show(); return false;" class="editbtn">{$lang.Cancel}</a>
                        </td>
                    </tr>

                </table>
            </div>
        {/if}
    {else}

        <div class="blank_state_smaller blank_forms">
            <div class="blank_info">
                <h3>{$lang.noaddonsyet}</h3>
                <div class="clear"></div>
            </div>
        </div>
    {/if}
    {literal}
        <script type="text/javascript">
            $('#addonsditor_content .havecontrols').hover(function () {
                $(this).find('.controls').show();
            }, function () {
                $(this).find('.controls').hide();
            });
        </script>
    {/literal}

{elseif $action=='product' }

    <form action="" method="post" name="productedit" id="productedit" onsubmit="selectalladdons(); saveconnectapp(this); " enctype="multipart/form-data">
        <input type="hidden" name="make" value="editproduct"/>
        <input type="hidden" name="id" value="{$product.id}"/>

        <div>
            {if $maintpl}
                {include file=$maintpl}
            {else}
                {include file='newservices.tpl'}
            {/if}
        </div>

        <script type="text/javascript">
                var zero_value = '{0|price:$currency:false:false}';
                var picked = {literal}{{/literal}
                    main: {$picked_tab|default:0},
                    sub: {$picked_subtab|default:0}
            {literal}};{/literal}
        
        {literal}
        
         // === start rv save cpanel manage2
         function saveconnectapp(obj){
            if ($('form#productedit').find('#frm_appcpanel').val() == 'yes') {
                setTimeout(function(){
                $.post("?cmd=rvcpanel_manage2&action=saveDataPriceLinkCpanel"
                
                , $('form#productedit').serialize(), function(data){
    
                });
                },10);
            }
           return true;
         }
         // === end rv save cpanel manage2
         
        {/literal}
        
        </script>

        <script type="text/javascript" src="{$template_dir}js/services_product.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/gui.elements.js?v={$hb_version}"></script>
        <link rel="stylesheet" href="{$template_dir}js/gui.elements.css" type="text/css" />
        <script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>


        {securitytoken}
    </form>
{elseif $action == 'bulkupdate'}
    {include file='services/ajax.bulkupdate.tpl'}
{elseif $action=='updatetags'}
    {include file='services/ajax.updatetags.tpl'}
{elseif $action=='updateprices'}
    {include file='services/ajax.updateprices.tpl'}
{/if}
