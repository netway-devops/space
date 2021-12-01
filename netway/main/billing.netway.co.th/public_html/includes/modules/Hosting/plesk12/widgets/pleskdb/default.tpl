<div >
    {foreach from=$widgets item=wig}
        {if $widget.name == $wig.name}
            {assign value=$wig.location var=widgeturl}
        {/if}
    {/foreach}
    <div id="billing_info" class="wbox">
        <div class="wbox_header">
            <a href="{$widget_url}" {if $act == 'default'}class="active"{/if}>{$lang.plesk_db_list}</a>
            | <a href="{$widget_url}&act=usermanage" {if $act == 'usermanage'}class="active"{/if}>{$lang.plesk_db_users}</a>
        </div>
        <div class="wbox_content">
            <form autocomplete="off" action="{$widget_url}&act={$act}" method="post">
                <table class="checker table table-striped" width="100%" cellspacing="0" cellpadding="0" border="0">
                    {if $act=='default'}
                    <thead>
                    <tr>
                        <td align="right">{$lang.plesk_db_name}</td>
                        <td align="center">{$lang.type}</td>
                        <td align="center">{$lang.plesk_management_functions}</td>
                    </tr>
                    </thead>
                    <tbody id="updater">
{include file="$widget_dir`$widget.ajaxtpl`"}
                        </tbody>
                        <tfoot>
                            <tr><td style="border:none" colspan="3" align="right"><input type="submit" name="save" value="{$lang.plesk_add_new_db}" class="btn btn-primary"> <input type="text" name="name"></td></tr>
                        </tfoot>

                    {elseif $act=='usermanage'}

                        <thead>
                            <tr>
                                <td align="left">{$lang.plesk_db_username}</td>
                                <td align="left">{$lang.plesk_db_name}</td>
                                <td align="center" style="width: 50%">{$lang.plesk_management_functions}</td>
                            </tr>
                        </thead>
                        <tbody id="updater">
                            {include file="$widget_dir`$widget.ajaxtpl`"}
                        </tbody>
                        <tfoot>
                            <tr><td colspan="3">&nbsp;</td></tr>
                            <tr><td colspan="3"  align="left">{$lang.plesk_add_new_usr}</td></tr>
                            <tr>
                                <td style="border:none" colspan="3" align="right">
                                    <div style="display:table-cell; padding:0 3px">{$lang.plesk_db_username}:<br> <input autocomplete="off" type="text" name="name" class="span2" ></div>
                                    <div style="display:table-cell; padding:0 3px">{$lang.password}: <br><input autocomplete="off" type="password" name="passmain" class="span2"></div>
                                    <div style="display:table-cell; padding:0 3px">{$lang.confirmpassword}:<br> <input autocomplete="off" type="password" name="passcheck" class="span2"></div>
                                    <div style="display:table-cell; padding:0 3px;vertical-align:bottom">
                                        <select name="database" class="span2" >
                                            <option value=""> - </option>
                                            {if $listdb}
                                                {foreach from=$listdb item=dbentry}
                                                    <option value="{$dbentry.id}">{$dbentry.name}</option>
                                                {/foreach}
                                            {/if}
                                        </select>
                                    </div>		
                                    <div style="display:table-cell; padding:0 3px;vertical-align:bottom"><input type="submit" name="save" value="{$lang.shortsave}" class="btn btn-primary"> </div>
                                </td>
                            </tr>
                        </tfoot>
                    {/if}
                </table>
                {securitytoken}
            </form>
        </div>
    </div>
</div>
<script type="text/javascript" src="{$widgetdir_url}../jquery.noreferrer.js"></script>
<script type="text/javascript" src="{$widgetdir_url}../widget.js"></script>
<link rel="stylesheet" type="text/css" href="{$widgetdir_url}../widget.css"  media="all">