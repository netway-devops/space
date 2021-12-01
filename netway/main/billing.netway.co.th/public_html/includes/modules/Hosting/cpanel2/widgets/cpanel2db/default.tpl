<div class="wbox_content">
    {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
</div>
{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>{$lang.cpanel_name}</strong><br>
        {$lang.checkyourloginpassword}
        </di>
    {else}
        <div >
            {foreach from=$widgets item=wig}
                {if $widget.name == $wig.name}
                    {assign value=$wig.location var=widgeturl}
                {/if}
            {/foreach}
            <div id="billing_info" class="form-inline">

                <h2>{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</h2>
                <br />

                {if $act=='redirect'}
                    {literal}
                        <p>{$lang.cpanel_redirect_to_phpmyadmin}</p>
                        <script>
                            setTimeout(function () {
                                window.location = '{/literal}{$access.url}&goto_uri={$access.token}/3rdparty/phpMyAdmin/index.php?db={$db}#PMAURL-1:db_structure.php?db={$db}';{literal}
                                    }, 1000);
                        </script>
                    {/literal}
                {else}

                    <ul class="nav nav-tabs">
                        <li {if $act == 'default'}class="active"{/if}><a href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}">{$widget_lang.db_list}</a></li>
                        <li {if $act == 'usermanage'}class="active"{/if}><a href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act=usermanage">{$widget_lang.db_users}</a></li>
                        <li {if $act == 'hostmanage'}class="active"{/if}><a href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act=hostmanage">{$widget_lang.host_list}</a></li>
                    </ul>

                    <div id="widget-section" class="section">
                        {if $myadmin}
                            <form action="{$myadmin}/login/" method="post" target="_blank" id="myadmin" >
                                <input type="hidden" name="user" value="{$myadmin_user}" />
                                <input type="hidden" name="pass" value="{$myadmin_pass}" />
                                <input type="hidden" name="login_theme" value="cpanel" />
                                <input type="hidden" name="goto_uri" value="frontend/x3/sql/PhpMyAdmin.html" />
                            </form>
                        {/if}
                        <form autocomplete="off" action="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}" method="post">
                            <table class="checker table table-striped form-inline" width="100%" cellspacing="0" cellpadding="0" border="0">
                                {if $act=='default'}
                                    <thead>
                                        <tr>
                                            <td align="right">{$widget_lang.db_name}</td>
                                            <td align="center">{$lang.type}</td>
                                            <td align="center">{$widget_lang.management_functions}</td>
                                        </tr>
                                    </thead>
                                    <tbody id="updater">
                                        {include file="$widget_dir`$widget.ajaxtpl`"}
                                    </tbody>
                                    <tfoot>
                                        <tr><td style="border:none" colspan="3" align="right"><input type="submit" name="save" value="{$widget_lang.add_new_db}" class="btn"> <input type="text" name="name"></td></tr>
                                    </tfoot>

                                {elseif $act=='usermanage'}

                                    <thead>
                                        <tr>
                                            <td align="right">{$widget_lang.db_username}</td>
                                            <td align="center">{$widget_lang.management_functions}</td>
                                        </tr>
                                    </thead>
                                    <tbody id="updater">
                                        {include file="$widget_dir`$widget.ajaxtpl`"}
                                    </tbody>
                                    <tfoot>
                                        <tr><td colspan="2">&nbsp;</td></tr>
                                        <tr><td colspan="2"  align="left">{$widget_lang.add_new_usr}</td></tr>
                                        <tr>
                                            <td style="border:none" colspan="2" align="right">
                                                <div style="display:inline-block; padding:3px">
                                                    {$widget_lang.db_username}:<br> 
                                                    <input autocomplete="off" type="text" name="name" class="" >
                                                </div>

                                                <div style="display:inline-block; padding:3px;vertical-align:bottom">
                                                    Database<br>
                                                    <select name="database" class="">
                                                        <option>{$lang.none}</option>
                                                        {if $listdb}
                                                            {foreach from=$listdb item=dbentry}
                                                                <option>{$dbentry.db}</option>
                                                            {/foreach}
                                                        {/if}
                                                    </select>
                                                </div>	
                                                <div style="display:inline-block; padding:3px">
                                                    {$lang.password}: <br>
                                                    <input autocomplete="off" type="password" name="passmain" class="">
                                                </div>
                                                <div style="display:inline-block; padding:3px">
                                                    {$lang.confirmpassword}:<br> 
                                                    <input autocomplete="off" type="password" name="passcheck" class="">
                                                </div>
                                                <div style="display:table-cell; padding:3px; vertical-align:bottom">
                                                    <input type="submit" name="save" value="{$lang.shortsave}" class="btn"> 
                                                </div>						
                                            </td>
                                        </tr>
                                    </tfoot>

                                {elseif $act=='hostmanage'}

                                    <thead>
                                        <tr>
                                            <td align="right">{$widget_lang.ip_list}</td>
                                            <td align="center">{$widget_lang.management_functions}</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {include file="$widget_dir`$widget.ajaxtpl`"}
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td style="border:none" colspan="3" align="right">
                                                Host (% {$lang.wildcardallowed}): 
                                                <input type="submit" name="save" value="{$widget_lang.add_new_ip}" class="btn"> 
                                                <input type="text" name="name">
                                            </td>
                                        </tr>
                                    </tfoot>

                                {/if}
                            </table>
                        </form>
                    </div>
                {/if}
            </div>
        </div>
        <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/font-awesome.min.css">
        <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/cp.css">
        <script type="text/javascript" src="{$widgeturl}../js/script.js"></script>
    {/if}