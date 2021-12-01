<div id="formloader" class="product-widget-form">
    <form id="saveform" method="post" action="?cmd=productwidgets" enctype="multipart/form-data">
        <input type="hidden" name="wid" value="{$widget.id}" id="widget_id"/>
        <input type="hidden" name="widget" value="{$widget.widget_id}"/>
        <input type="hidden" name="make" value="{$action}"/>
        <input type="hidden" name="action" value="{$action}"/>
        {if $bulk}
            <input type="hidden" name="cat_id" value="{$cat_id}"/>
            <input type="hidden" name="bulk" value="1"/>
        {/if}
        {foreach from=$products item=product_id}
            <input type="hidden" name="product_id[]" value="{$product_id}"/>
        {/foreach}

        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
            <tr>
                <td width="140" id="s_menu" style="" valign="top">
                    <div id="lefthandmenu">
                        <a class="tchoice" href="#">Appearance</a>
                        {foreach from=$widget.info.templates item=tp key=tpname}
                            <a class="tchoice" href="#">{$tpname}</a>
                        {/foreach}

                    </div>
                    {if $widget.info.description}
                        <div class="description" style="margin-top:80px">{$widget.info.description}</div>
                    {/if}
                </td>
                <td class="conv_content pw-form" valign="top">
                    <div class="tabb">
                        <h3>
                            <img src="../{$widget.config.smallimg}" alt=""/> Function
                            &raquo; {$widget.info.fullname} &raquo; Appearance
                        </h3>

                        <div class="form-group">
                            <label for="pw-name">Display as</label>
                            {hbinput value=$widget._name|escape id="pw-name" class="form-control" size="60" name="name"}
                        </div>

                        <div class="form-group">
                            <label>Display in</label>
                            <select class="form-control" name="group">
                                <option value="sidemenu" {if $widget.group=='sidemenu'}selected="selected"{/if}>
                                    Service sidemenu
                                </option>
                                <option value="apps" {if $widget.group=='apps'}selected="selected"{/if}>Service
                                    "apps" menu
                                </option>
                            </select>
                        </div>

                        <div class="row no-gutter">

                            <div class="form-group col-md-8">
                                <label>Small icon</label>
                                <input type="text" class="form-control" name="config[smallimg]"
                                       value="{$widget.config.smallimg}" style="margin:0px 5px 5px 0px;"/>
                                <div class="help-block">Use 16x16px png image</div>
                                <div class="fs11">
                                    Upload new
                                    <input type="file" name="smallimgnew"/>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <img src="../{$widget.config.smallimg}" alt="" style="margin:5px 10px;"/>
                            </div>
                        </div>

                        <div class="row no-gutter">
                            <div class="form-group col-md-8">
                                <label>Large icon</label>
                                <input type="text" class="form-control" name="config[bigimg]"
                                       value="{$widget.config.bigimg}" style="margin:0px 5px 5px 0px;"/>
                                <div class="help-block">Use 48x48px png image</div>
                                <div class="fs11">
                                    Upload new
                                    <input type="file" name="bigimgnew"/>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <img src="../{$widget.config.bigimg}" alt="" style="margin:5px 10px;"/>
                            </div>
                        </div>

                        <div class="form-group">

                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="updateall" value="1"/>
                                    Apply changes to all client functions of this type
                                </label>
                            </div>
                        </div>
                    </div>

                    {foreach from=$widget.info.templates item=tp key=tpname}
                        <div class="tabb" style="display:none">
                            <h3><img src="../{$widget.config.smallimg}" alt="" style="margin-right:5px"
                                     class="left"/> Function &raquo; {$widget.info.fullname} &raquo; {$tpname}</h3>
                            {include file=$tp}
                        </div>
                    {/foreach}

                </td>
            </tr>
        </table>
        {securitytoken}
    </form>
</div>
{literal}
<script type="text/javascript">
    $('#picked_tab').clone().appendTo('#saveform');
    $('#lefthandmenu').TabbedMenu({
        elem: '.tabb',
        picker_id: 'picked_subtab'{/literal}{if $picked_tab},
        picked:{$picked_tab}{/if}{literal}});
</script>
{/literal}
<div class="dark_shelf dbottom">
    <div class="left spinner"><img src="ajax-loading2.gif"></div>
    <div class="right">
        <span class="bcontainer ">
            <a class="new_control greenbtn" href="#" onclick="$('.spinner').show();
                        $('#saveform').submit();
                        return false;"><span>{$lang.savechanges}</span></a>
        </span>
        <span>{$lang.Or}</span>
        <span class="bcontainer">
            <a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');
                        return false;"><span>{$lang.Close}</span>
            </a>
        </span>
    </div>
    <div class="clear"></div>
</div>
