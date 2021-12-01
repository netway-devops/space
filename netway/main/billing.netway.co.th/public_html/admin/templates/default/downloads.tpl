<link rel="stylesheet" href="{$template_dir}js/gui.elements.css" type="text/css" />
<script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/jquery.elastic.min.js?v={$hb_version}"></script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td ><h3>{$lang.Downloads}</h3></td>
        <td></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=downloads"  class="tstyled selected">{$lang.Downloads}</a>
        </td>
        <td valign="top"  class="bordered"><div id="bodycont" style="">

                {if $action=='addcategory'}
                    <form action="" method="post">
                        <input type="hidden" name="make" value="add" />
                        <div class="container-fluid clear lighterblue" style="padding: 14px 20px;">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>{$lang.Name}</label>
                                        {hbinput value=$submit.name style="" size="80" name="name" class="form-control"}
                                    </div>
                                    <div class="form-group">
                                        <label>{$lang.Visible}</label><br>
                                        <input type="checkbox" value="1" name="visible" class="form-check-input" checked="checked" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>{$lang.Description}</label><br>
                                        {hbwysiwyg value=$submit.description class="inp wysiw_editor form-control" cols="100" rows="6" name="description" wrapper="div"}
                                    </div>
                                </div>
                            </div>
                            {adminwidget module="downloads" section="forms"}
                        </div>
                        <div class="blu">
                            <input type="submit" value="{$lang.addnewcat}" class="btn btn-sm btn-primary" style="font-weight:bold"/>
                            <a class="btn btn-sm btn-warning" href="?cmd=downloads">{$lang.Cancel}</a>
                        </div>
                        {securitytoken}</form>

                {elseif $action=='category'}
                    <form action="" method="post">
                        <input type="hidden" name="make" value="update" />

                        <div class="container-fluid clear lighterblue" style="padding: 14px 20px;">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>{$lang.Name}</label>
                                        {hbinput value=$category.name style="" size="80" name="name" class="form-control"}
                                    </div>
                                    <div class="form-group">
                                        <label>{$lang.Visible}</label><br>
                                        <input type="checkbox" value="1" name="visible" class="form-check-input" {if $category.visible}checked="checked"{/if} />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>{$lang.Description}</label><br>
                                        {hbwysiwyg value=$category.description class="inp wysiw_editor form-control" cols="100" rows="6" name="description" wrapper="div"}
                                    </div>
                                </div>
                            </div>
                            {adminwidget module="downloads" section="forms"}
                        </div>
                        <div class="blu">
                            <input type="submit" value="{$lang.savechanges}" class="btn btn-sm btn-primary" style="font-weight:bold"/>
                            <a class="btn btn-sm btn-warning" href="?cmd=downloads">{$lang.Cancel}</a>
                        </div>
                        {securitytoken}</form>
                    {elseif $action=='add'}

                    <form action="" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="make" value="add" />
                        <div class="container-fluid clear lighterblue" style="padding: 14px 20px;">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>{$lang.Name}</label>
                                        {hbinput value=$submit.name style="" size="80" name="name" class="form-control"}
                                    </div>
                                </div>
                            </div>
                            <script type="text/javascript">
                                {literal}
                                function vala(ele) {
                                    if ($(ele).val() == 'true') {
                                        $('#uploader').show();
                                        $('#pathx').hide();
                                    } else {
                                        $('#pathx').show();
                                        $('#uploader').hide();
                                    }
                                }
                                {/literal}
                            </script>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>{$lang.file}</label><br>
                                        <input type="radio" name="upload" value="true" onclick="vala(this)" checked="checked"/> {$lang.uploadnew}<br>
                                        <input type="radio" name="upload" value="false"  onclick="vala(this)"/> {$lang.specifyfile}
                                        <div id="uploader" style="margin-top:10px;">
                                            {if !$writeable}
                                                <span style="color:red;font-weight:bold;">{$lang.notwrite}</span>
                                            {/if}
                                            <input type="file"  name="file" />
                                        </div>
                                    </div>
                                    <div id="pathx" class="form-group" style="display: none;">
                                        <label>{$lang.filename}</label>
                                        <input name="path" type="text" class="form-control" size="80"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>{$lang.Category}</label>
                                        <select class="form-control" name="category_id">
                                            {foreach from=$categories item=category}
                                                <option value="{$category.id}" {if $category.id==$submit.category_id}selected="selected"{/if}>{$category.name}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>{$lang.Description}</label><br>
                                        {hbwysiwyg value=$submit.description class="inp wysiw_editor form-control" cols="100" rows="6" name="description" wrapper="div"}
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>{$lang.clientsonly}</label><br>
                                        <input type="checkbox" name="clients" value="1" {if $file.clients=='1'}checked="checked"{/if} class="form-check-input"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>{$lang.hasproduct}</label><br>
                                        <input type="checkbox" onclick="check_i(this)" />
                                        <select name="product_id" disabled="disabled"  class="config_val form-control">
                                            {foreach from=$products item=category}
                                                {if $category.products}
                                                    {foreach from=$category.products item=product}
                                                        <option value="{$product.id}" {if $file.product_id==$product.id}selected="selected"{/if}>{$category.name}: {$product.name}</option>
                                                    {/foreach}
                                                {/if}
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                            </div>
                            {adminwidget module="downloads" section="forms"}
                        </div>
                        <div class="blu">
                            <input type="submit" value="{$lang.addnewfile}" class="btn btn-sm btn-primary" style="font-weight:bold"/>
                            <a class="btn btn-sm btn-warning" href="?cmd=downloads">{$lang.Cancel}</a>
                        </div>
                        {securitytoken}</form>
                    {elseif $action=='edit'}
                    <form method="post" action="">
                        <input type="hidden" name="make" value="update" />


                        <div class="container-fluid clear lighterblue" style="padding: 14px 20px;">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>{$lang.Name}</label>
                                        {hbinput value=$file.name style="" size="80" name="name" class="form-control"}
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <a href="?cmd=root&action=download&type=downloads&id={$file.id}">{$lang.download}</a> <em>({$file.downloads} {$lang.timesdown})</em>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>{$lang.filename}</label>
                                        <input class="form-control" type="text" name="filename" value="{$file.filename}" size="80"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>{$lang.Category}</label>
                                        <select class="form-control" name="category_id">
                                            {foreach from=$categories item=category}
                                                <option value="{$category.id}" {if $category.id==$file.category_id}selected="selected"{/if}>{$category.name}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>{$lang.Uploaded}</label><br>
                                        <input name="uploaded" value="{$file.uploaded|dateformat:$date_format}" class="form-control haspicker" size="12"/><br>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>{$lang.Description}</label><br>
                                        {hbwysiwyg value=$file.description class="inp wysiw_editor form-control" cols="100" rows="6" name="description" wrapper="div"}
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>{$lang.clientsonly}</label><br>
                                        <input type="checkbox" name="clients" value="1" {if $file.rel_type=='1'}checked="checked"{/if} class="form-check-input"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>{$lang.hasproduct}</label><br>
                                        <input type="checkbox" onclick="check_i(this)" {if $file.product_id!='0'}checked="checked"{/if} class="form-check-input"/>
                                        <select name="product_id" {if $file.product_id=='0'}disabled="disabled"{/if} class="config_val form-control">
                                            {foreach from=$products item=category}
                                                {if $category.products}
                                                    {foreach from=$category.products item=product}
                                                        <option value="{$product.id}" {if $file.product_id==$product.id}selected="selected"{/if}>{$category.name}: {$product.name}</option>
                                                    {/foreach}
                                                {/if}
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                            </div>
                            {adminwidget module="downloads" section="forms"}
                        </div>
                        <div class="blu">
                            <input type="submit" value="{$lang.savechanges}" class="btn btn-sm btn-primary" style="font-weight:bold"/>
                            <a class="btn btn-sm btn-warning" href="?cmd=downloads">{$lang.Cancel}</a>
                        </div>
                        {securitytoken}</form>	
                    {else}
                    <div class="blu">
                        <input type="button" href="?cmd=downloads&action=add" class="linkDirectly btn btn-sm btn-success " value="{$lang.addnewfile}">
                        <input type="button" href="?cmd=downloads&action=addcategory" class="linkDirectly btn btn-sm btn-success " value="{$lang.addnewcat}">
                    </div>

                    <table class="table glike" width="100%" cellspacing="0" cellpadding="3" border="0">
                        {if $categories}
                            <tr>
                                <th width="70%">Name</th>
                                <th>Downloaded</th>
                                <th></th>
                            </tr>

                            {foreach from=$categories item=cat}

                                <tr>
                                    <td colspan="5">
                                        <table  width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                                            <tr>
                                                <td width="{if $cat.id}70%{else}50%{/if}"><strong>{$lang.Category}: {if !$cat.id}Single client files{else}<a href="?cmd=downloads&action=category&id={$cat.id}">{$cat.name}</a>{/if}</strong></td>
                                                {if !$cat.id}
                                                    <td width="{if !$cat.id}20%{/if}">Client</td>
                                                {/if}
                                                <td></td>
                                                <td  width="135" style="text-align: right">
                                                    {if $cat.id}<a href="?cmd=downloads&action=category&id={$cat.id}" class="menuitm menu-auto "><span style="color: red">{$lang.Edit}</span></a>{/if}
                                                    {if $cat.id}<a href="?cmd=downloads&make=deletecat&id={$cat.id}&security_token={$security_token}" class="menuitm menu-auto " onclick="return confirm('{$lang.dconfirm2}')"><span class="delsth"></span></a>{/if}
                                                </td>
                                            </tr>	
                                            {foreach from=$cat.files item=file}
                                                <tr class="product">
                                                    <td>{if $cat.id}<a href="?cmd=downloads&action=edit&id={$file.id}">{$file.name}</a>{else}{$file.name}{/if}</td>
                                                    {if !$cat.id}
                                                        <td><a href="?cmd=clients&action=show&id={$file.client_id}">{$file.client_name}</a></td>
                                                    {/if}
                                                    <td>{$file.downloads}</td>
                                                    <td width="150" style="text-align: right">
                                                        <a href="?cmd=root&action=download&type=downloads&id={$file.id}" class="menuitm menu-auto ">{$lang.download}</a>
                                                        {if $cat.id}<a href="?cmd=downloads&action=edit&id={$file.id}" class="menuitm menu-auto " ><span style="color: red">{$lang.Edit}</span></a>{/if}
                                                        <a href="?cmd=downloads&make=delete&id={$file.id}&security_token={$security_token}" class="menuitm menu-auto" onclick="return confirm('{$lang.dconfirm1}')"><span class="delsth"></span></a>
                                                    </td>
                                                </tr>

                                            {/foreach}	
                                        </table>

                                    </td>

                                </tr>
                            {/foreach}

                        {else}
                            <tr>
                                <td align="center" colspan="5" align="center"><strong>{$lang.nothingtodisplay}</strong></td>
                            </tr>
                        {/if}

                    </table>
                {/if}
            </div></td></tr></table>{literal}
<script type="text/javascript">
    function check_i(element) {
        var td = $(element).parent();
        if ($(element).is(':checked'))
            $(td).find('.config_val').removeAttr('disabled');
        else
            $(td).find('.config_val').attr('disabled', 'disabled');
    }

</script>
{/literal}