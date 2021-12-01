{if $action=='getlatest'}
    {if $latest}
        {foreach from=$latest item=feed name=floop}
            <div class="addon_module addon_module_new" {if $smarty.foreach.floop.last}style="border:none"{/if}>
                <strong><a href="{$feed.link}" title="{$feed.title}" target="_blank">{$feed.title}</a></strong><br />
                <span style="color:#B0B0B0;font-size:11px;">{$feed.pubDate}</span><br/>
                {$feed.description}
            </div>

        {/foreach}
    {/if}
{elseif $action=='ajaxactivate'}
    <script type="text/javascript">{literal}
    function gdesc(itm) {

        var el = $(itm).hide();
        $.post('?cmd=managemodules&action=getdescr&module=' + $(itm).attr('rel') + '&type={/literal}{$target}{literal}', {empty1r: 'asas'}, function (data) {
            var resp = parse_response(data);
            if (resp) {
                $('#descr-' + el.attr('target')).html(resp).slideDown();
            }
        });
        return false;
    }
    function findModuleList(el) {
        var v = $(el).val();
        $('#grab-sorter .module_li').show();
        if (v == '')
            return false;
        $('#grab-sorter .module_li').each(function () {
            if ($(this).attr('id').toString().search(new RegExp(v, "i")) < 0)
                $(this).hide();
        });
        return false;
    }
        {/literal}
    </script>
    <div class="mod_desc" style="margin-bottom:0px;border-radius:5px 5px 0px 0px">
        <div class="headshelf">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="mrow1" width="50%"><strong>{$lang.Module}</strong></td>
                    <td class="mrow1"><strong>{$lang.Description}</strong></td>

                </tr>
            </table>
        </div>

        <div class="mmdescr" style="height:330px;overflow:auto">
            <ul id="grab-sorter" style="width:100%">
                {foreach from=$avail_modules item=b name=modfor}
                    <li  style="background:#ffffff" id="row_{$b.filename}" class="module_li">
                        <div>
                            <form name="" action="?cmd=managemodules&action={$target}" method="post" {if $callback}onsubmit="{$callback}"{/if}>
                                <input type="hidden" name="modulename" value="{$b.filename}" />
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td class="mrow1" width="50%" valign="top">
                                            <div style="padding-bottom:10px" class="left"><strong>{$b.name}</strong></div>
                                            <div style="text-align:right;padding:5px 0px"  class="right">
                                                <a class="new_control greenbtn" href="#" onclick="$('#activate-btn-{$b.key}').click();
                                                        return false;"><span >{$lang.Activate}</span></a>
                                            </div>
                                            <div class="clear"></div>
                                            <input type="submit" value="{$lang.Activate}"  name="activate" style="display:none" id="activate-btn-{$b.key}"/>
                                        </td>
                                        <td class="mrow1" valign="top">
                                            <div style="padding-bottom:10px" id="descr-{$b.key}" class="left">&nbsp;</div>
                                            <div style="padding:5px 0px" class="left"> <a   class="new_control loaddescr" rel="{$b.filename}" target="{$b.key}" href="#" onclick="return gdesc(this)"><span ><strong>{$lang.loaddetails}</strong></span></a>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                {securitytoken}
                            </form>
                        </div>
                    </li>
                {/foreach}
            </ul>
        </div>
    </div>
    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="left fs11" style="color:white">
            <span class="left">Search: </span>
            <div class="spinner left" style="display:block;margin-left:5px;">
                <input type="text" id="searchin" style="font-size:11px !important;" onkeyup="findModuleList(this)" /></div>
            <div class="clear"></div>
        </div>
        <div class="right">
            <span class="bcontainer">
                <a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');
                    return false;"><span>{$lang.Close}</span></a>
            </span>
        </div>
        <div class="clear"></div>
    </div>
{elseif $action=='searchmodule'}
    {if $result}
        {foreach from=$result item=module key=k name=floop}
            <div class="addon_module {$module.type}"  {if $smarty.foreach.floop.last}style="border:none"{/if}>
                <div class="left">
                    <strong>
                        {if $module.active=='1'}
                            <a href="?cmd=managemodules&action={$module.type|strtolower}&expand=true&id={$module.id}&security_token={$security_token}">{$module.modname}</a>
                        {else}
                            <a href="?cmd=managemodules&action={$module.type|strtolower}&do=inactive&&expand=true&id={$module.filename}&security_token={$security_token}">{$module.modname}</a>
                        {/if}
                    </strong>
                    <br />
                    {$module.description}
                </div>
                <div class="right">
                    {if $module.active=='1'}
                        <a href="?cmd=managemodules&action={$module.type}&expand=true&id={$module.id}&security_token={$security_token}" class="menuitm disabled">
                            <span>Activated</span>
                        </a>
                    {else}
                        <a href="?cmd=managemodules&action={$module.type}&activate&modulename={$module.filename}&security_token={$security_token}" class="new_control greenbtn">
                            <span>Activate</span>
                        </a>
                    {/if}

                </div>
                <div class="clear"></div></div>
            {/foreach}
        {else}
        <center>
            <strong>{$lang.nothingtodisplay}</strong>
        </center>
    {/if}
{elseif $action=='getdescr'}
    {if $details}
        {if $details.modname}<strong>{$lang.modulename}: </strong>{$details.modname}<br />{/if}
        {if $details.version}<strong>{$lang.version}: </strong>{$details.version}<br />{/if}
        {if $details.filename}<strong>{$lang.filename}: </strong>{$details.filename}<br />{/if}
        {if $details.type=='Payment'}<strong>{$lang.supcurrencies}: </strong>{if $details.currencies}{$details.currencies}{else}{$lang.All}{/if}<br />{/if}
        {if $details.txt}<strong>{$lang.detaileddescr}: </strong>{$details.txt}<br />{/if}
        {if $details.author}<strong>{$lang.author}: </strong>{$details.author}&nbsp;&nbsp;{/if} {if $details.website}<a href="{$details.website}" target="_blank">{$details.website}</a>&nbsp;&nbsp;{/if}
        {if $details.wiki}<strong>{$lang.wiki}: </strong><a href="{$details.wiki}" target="_blank">{$details.wiki}</a><br />{/if}
        {if $details.cron=='add'}<div class="important_notify">{$lang.havecron} <a href="?cmd=configuration&action=cron&viewaddform=true" target="_blank" class="editbtn"><strong>{$lang.clicktoadd}</strong></a></div>{/if}
    {/if}
{elseif $action=='quickactivate'}
{if $modconfig.config}
    {literal}
        <script type="text/javascript">
            function submit_externalc(f) {
                var s = $(f).serialize();
                $('#facebox .spinner').show();
                $.post('?cmd=managemodules&action={/literal}{$type}{literal}&' + s, {changeconfig: true}, function () {
                    $(document).trigger('close.facebox');
                });
                return false;
            }
        </script>
    {/literal}
    <div style="padding:10px;background:#fff;" class="form conv_content">
        <h3>{$modconfig.module} Configuration</h3>
        <form action="" method="post" onsubmit="return submit_externalc(this);" >
            <input type="hidden" name="filename" value="{$modconfig.filename}" />
            <input type="hidden" name="id" value="{$modconfig.id}" />

            <table border="0" width="100%" cellpadding="5" cellspacing="0">
                {foreach from=$modconfig.config item=conf key=k}
                    <tr >
                        {assign var="name" value=$k}
                        {assign var="name2" value=$modconfig.module}
                        {assign var="baz" value="$name2$name"}

                        {if $conf.type=='input'}
                            <td width="170" align="right">{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}:</td>
                            <td ><input type="text" name="option[{$k}]" value="{$conf.value}" style="margin:0px" /></td>
                            {elseif $conf.type=='password'}
                            <td width="170" align="right">{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}:</td>   <td ><input type="password" autocomplete="off" name="option[{$k}]" value="{$conf.value}" style="margin:0px" /></td>
                            {elseif $conf.type=='check'}
                            <td width="170" align="right">{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}:</td>  <td ><input name="option[{$k}]" type="checkbox" value="1" {if $conf.value == "1"}checked="checked"{/if} style="margin:0px"  /></td>
                            {elseif $conf.type=='select'}
                            <td width="170" align="right"> {if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}: </td>  <td >
                                <select name="option[{$k}]" style="margin:0px" >
                                    {foreach from=$conf.default item=selectopt}
                                        <option {if $conf.value == $selectopt}selected="selected" {/if}>{$selectopt}</option>
                                    {/foreach}
                                </select>
                            </td>
                        {elseif $conf.type=='email_id'}
                            <td width="170" align="right"> {if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}: </td>  <td >
                            <select name="option[{$k}]" style="margin:0px" >
                                {foreach from=$email_templates.All item=selectopt}
                                    <option {if $conf.value == $selectopt.id}selected="selected" {/if}  value="{$selectopt.id}">{$selectopt.for}:{$selectopt.tplname}</option>
                                {/foreach}
                            </select>
                        </td>

                        {elseif $conf.type=='admin_id'}
                            <td width="170" align="right"> {if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}: </td>  <td >
                            <select name="option[{$k}]" style="margin:0px" >
                                {foreach from=$admins item=selectopt}
                                    <option {if $conf.value == $selectopt.id}selected="selected" {/if}  value="{$selectopt.id}">{$selectopt.username}</option>
                                {/foreach}
                            </select>
                        </td>

                        {elseif $conf.type=='department_id'}
                            <td width="170" align="right"> {if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}: </td>  <td >
                            <select name="option[{$k}]" style="margin:0px" >
                                {foreach from=$ticket_departments item=selectopt}
                                    <option {if $conf.value == $selectopt.id}selected="selected" {/if} value="{$selectopt.id}">{$selectopt.name}</option>
                                {/foreach}
                            </select>
                        </td>

                        {elseif $conf.type=='textarea'}
                            <td colspan="2">{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}:<br />
                                <span style="vertical-align:top"><textarea name="option[{$k}]" rows="5" cols="60" style="margin:0px" >{$conf.value}</textarea></span>
                            </td>
                        {/if}
                    </tr>
                {/foreach}
            </table>
            <input type="submit" value="submit" style="display:none" id="moduleconfigsubmit" />
        </form>
    </div>
    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">
            <span class="bcontainer " ><a class="new_control greenbtn" href="#" onclick="$('#moduleconfigsubmit').click();
                    return false;"><span>{$lang.savechanges}</span></a></span>
            <span >{$lang.Or}</span>
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick=" saveProductFull();
                    return false;"><span>{$lang.Close}</span></a></span>
        </div>
        <div class="clear"></div>
    </div>
{/if}
{elseif $action=='default'}

    <div class="container-fluid clear" style="padding-top:14px">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">

                    <form action="" method="post" onsubmit="return perform_search()">
                    <div class="input-group">
                        <input type="text" value="{$lang.missingm}" name="search-input"  class="form-control" onclick="if ($(this).val() == '{$lang.missingm}')
                                $(this).val('');" id="search-input">
                        <span class="input-group-btn">
    <button type="button" id="test" class="btn btn-info" onclick="return perform_search();">Search</button>
    </span>
                    </div>{securitytoken}
                    </form>

                </div>
                <div class="panel panel-default" id="search-results" style="display:none;">
                    <div class="panel-heading" id="status">
                        <h3 class="panel-title">Search results</h3>
                    </div>
                    <div class="panel-body" id="sresults" > Loading ... </div>
                </div>

                <div class="panel panel-default" >
                    <div class="panel-heading" >
                        <h3 class="panel-title">Popular modules</h3>
                    </div>
                    <div class="panel-body" >
                        {foreach from=$featured item=module key=k name=floop}
                            <div class="addon_module {$module.type}"  {if $smarty.foreach.floop.last}style="border:none"{/if}>
                                <div class="left">
                                    <strong>
                                        {if $module.active=='1'}
                                            <a href="?cmd=managemodules&action={$module.type}&expand=true&id={$module.id}&security_token={$security_token}">{$module.name}</a>
                                        {else}
                                            <a href="?cmd=managemodules&action={$module.type}&do=inactive&&expand=true&id={$k}&security_token={$security_token}">{$module.name}</a>
                                        {/if}
                                    </strong>
                                    <br />
                                    {$module.description}
                                </div>
                                <div class="right">
                                    {if $module.active=='1'}
                                        <a href="?cmd=managemodules&action={$module.type}&expand=true&id={$module.id}&security_token={$security_token}" class="menuitm disabled">
                                            <span>{if $module.active=='1'}Activated{else}Activate{/if}</span>
                                        </a>
                                    {else}
                                        <a href="?cmd=managemodules&action={$module.type}&activate&modulename={$k}&security_token={$security_token}" class="new_control greenbtn">
                                            <span>{if $module.active=='1'}Activated{else}Activate{/if}</span>
                                        </a>
                                    {/if}

                                </div>
                                <div class="clear"></div></div>
                        {/foreach}
                    </div>
                </div>
            </div>


            <div class="col-md-6">

                <div class="panel panel-default" id="latest_additions">
                    <div class="panel-heading">
                        <h3 class="panel-title">Latest additions</h3>
                    </div>
                    <div class="panel-body" id="loadme"> Loading ... </div>
                </div>

            </div>
        </div>
    </div>


    <script type="text/javascript">
        {literal}
        function perform_search() {
            $('#search-results').fadeIn();
            $.get("?cmd=managemodules&action=searchmodule", {queryin: $('#search-input').val()}, function (data) {
                var r = parse_response(data);
                $('#sresults').fadeOut('fast', function () {
                    $('#sresults').html(r).fadeIn('fast');
                });
            });
            return false;
        }
        function LatestModules() {
            $.get("?cmd=managemodules&action=getlatest", {}, function (data) {
                var r = parse_response(data);
                if (r) {
                    $('#loadme').fadeOut('fast', function () {
                        $(this).html(r).fadeIn('fast');
                    });
                } else {
                    $('#latest_additions').fadeOut();
                }
            });
        }
        appendLoader('LatestModules');
        {/literal}
    </script>
{else}
    <div >

        <div class="newhorizontalnav" id="newshelfnav">
            <div class="list-1">
                <ul>
                    <li class="list-1elem {if $do!='inactive'}active picked{/if}"><a href="?cmd=managemodules&action={$action}&do=active">{$lang.Active} ({$count_active})</a></li>
                    <li class="list-1elem {if $do=='inactive'}active picked{/if} last"><a href="?cmd=managemodules&action={$action}&do=inactive">{$lang.Inactive} ({$count_avail_modules})</a></li>
                </ul>
            </div>
        </div>

        <div class="mod_desc">
            <div class="headshelf">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td {if $action=='payment'}width="30"{else}width="20"{/if}><input type="checkbox" id="checkthemall" /></td>
                        <td class="mrow1" width="30%"><strong>{$lang.Module}</strong></td>
                        <td class="mrow1"><strong>{$lang.Description}</strong></td>

                    </tr>
                </table>
            </div>
            <div class="mmdescr">
                {if $do=='inactive'}
                    {if $avail_modules}
                        <ul id="grab-sorter" style="width:100%">
                            {foreach from=$avail_modules item=b name=modfor}
                                <li  style="background:#ffffff">
                                    <div >
                                        <form name="" action="" method="post">
                                            <input type="hidden" name="modulename" value="{$b.filename}" />
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td {if $action=='payment'}width="30"{else}width="20"{/if} valign="top"><input type="checkbox"  value="{$b.filename}" class="sorters" name="selected[]"/></td>
                                                    <td class="mrow1" width="30%" valign="top">
                                                        <div style="padding-bottom:10px"><strong>{$b.name}</strong></div>
                                                        <div style="text-align:right;padding:5px 0px">
                                                            <a   class="new_control greenbtn" href="#" onclick="$('#activate-btn-{$b.key}').click();
                                                                    return false;"><span >{$lang.Activate}</span></a>
                                                        </div>
                                                        <input type="submit" value="{$lang.Activate}"  name="activate" style="display:none" id="activate-btn-{$b.key}"/>

                                                    </td>
                                                    <td class="mrow1" valign="top">
                                                        <div style="padding-bottom:10px" id="descr-{$b.key}">&nbsp;</div>
                                                        <div style="padding:5px 0px"> <a   class="new_control loaddescr" rel="{$b.filename}" target="{$b.key}" href="#"><span ><strong>{$lang.loaddetails}</strong></span></a></div>

                                                    </td>
                                                </tr>
                                            </table>
                                            {securitytoken}</form>
                                    </div>
                                </li>
                            {/foreach}
                            <li style="border:none;">
                                <div style="padding:5px;">
                                    {$lang.withselected} <a   class="new_control greenbtn" href="#" onclick="activate_s();
                                            return false;"><span >{$lang.Activate}</span></a>
                                </div>
                            </li>
                        </ul>
                    {else}
                        <center>
                            <strong>{$lang.noactivemodules}</strong>
                        </center>
                    {/if}
                {else}
                    {if $active}
                        <ul id="grab-sorter" style="width:100%">
                            {foreach from=$active item=b name=modfor}
                                <li  style="background:#ffffff">
                                    <div >
                                        <form name="" action="" method="post">
                                            <input type="hidden" name="id" value="{$b.id}" />
                                            <input type="hidden" name="filename" value="{$b.filename}" class="modfilename"/>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td {if $action=='payment' || $action=='fraud'}width="30"{else}width="20"{/if} valign="top">
                                                        <input type="checkbox"  value="{$b.id}" class="sorters" name="selected[]"/>
                                                        {if $action=='payment' || $action=='fraud'}
                                                            <a class="sorter-handle" style="float:right;margin-top:4px">{$lang.move}</a>
                                                        {/if}
                                                    </td>
                                                    <td class="mrow1" width="30%" valign="top">
                                                        <div style="padding-bottom:10px">
                                                            <strong>{$b.modname}</strong>
                                                        </div>
                                                        <div style="text-align:right;padding:5px 0px">
                                                            {if $b.type=='Payment' || $b.type=='Hosting' || $b.type=='Domain' || $b.type=='Fraud'}
                                                                <input type="hidden" name="sort[]" value="{$b.id}" class="sorters2"/>
                                                                {if (!empty($b.config) && $b.type!='Hosting' && $b.type!='Domain' ) || $b.type=='Payment' }
                                                                    <a class="menuitm menu-auto {if $expand==$b.id}activated{/if} config-toggle"   href="#" data-target="#config-row-{$b.id}" >
                                                                        <span >
                                                                            <strong>{$lang.editConfiguration}</strong>
                                                                        </span>
                                                                    </a>
                                                                {/if}
                                                                <a class="menuitm  menu-auto" href="#" onclick="$('#deactivate-btn-{$b.id}').click();
                                                                            return false;">
                                                                    <span style="color:red">{$lang.Deactivate}</span>
                                                                </a>
                                                            {elseif $b.type=='Other' || $b.type=='Notification'}
                                                                <a class="menuitm menu-auto {if $expand==$b.id}activated{/if} config-toggle" href="#" data-target="#config-row-{$b.id}">
                                                                    <span>
                                                                        <strong>{$lang.editConfiguration}</strong>
                                                                    </span>
                                                                </a>
                                                                {if $b.template}
                                                                    <a class="menuitm menu-auto"   href="?cmd=module&module={$b.id}" target="_blank">
                                                                        <span >{$lang.Manage}</span>
                                                                    </a>
                                                                {/if}
                                                                {if $b.uninstall}
                                                                    <a class="menuitm menu-auto" href="#" onclick="$('#uninstall-btn-{$b.id}').click();
                                                                            return false;">
                                                                        <span style="color:red">{$lang.Uninstall}</span>
                                                                    </a>
                                                                {/if}
                                                                <a class="menuitm  menu-auto" href="#" onclick="$('#deactivate-btn-{$b.id}').click();
                                                                            return false;">
                                                                    <span style="color:red">{$lang.Deactivate}</span>
                                                                </a>
                                                                {if $b.uninstall}
                                                                    <input type="submit" value="{$lang.Uninstall}" name="uninstall" onclick='return confirm("{$lang.uninstallmoduleconfirm}")' style="display:none" id="uninstall-btn-{$b.id}"/>
                                                                {/if}
                                                            {/if}
                                                        </div>
                                                        <input type="submit" value="{$lang.Deactivate}"  name="deactivate" style="display:none" id="deactivate-btn-{$b.id}"/>
                                                    </td>
                                                    <td class="mrow1" valign="top">
                                                        {if $b.description}<div style="margin-bottom:5px">{$b.description}</div>{/if}

                                                            {if $b.info}
                                                                <div style="margin-bottom:5px"><span class="fs11">Additional features: </span>{foreach from=$b.info item=n key=feature}
                                                                {if $knownfeatures.$feature && $lang.$feature}<a href="{$knownfeatures.$feature}" target="_blank" rel="noreferrer nofollow noopener" class="label label-info">{$lang.$feature}</a>{/if}
                                                            {/foreach}
                                                                </div>
                                                            {/if}

                                                        <div class="fs11">
                                                            {if $b.version}<strong>{$lang.version}: </strong>{$b.version} {/if}
                                                            {if $b.filename}<strong>{$lang.filename}: </strong>{$b.filename}{/if}
                                                            <strong>ID: </strong>{$b.id}<br />

                                                            {if $b.type=='Payment'}<strong>{$lang.supcurrencies}: </strong>{if $b.currencies}{$b.currencies}{else}{$lang.All}{/if}<br />{/if}
                                                        {if $b.author}<strong>{$lang.author}: </strong>{$b.author}&nbsp;&nbsp;{/if} {if $b.website}<a href="{$b.website}" target="_blank">{$b.website}</a>&nbsp;&nbsp;{/if}
                                                        {if $b.wiki}<strong>{$lang.wiki}: </strong><a href="{$b.wiki}" target="_blank">{$b.wiki}</a><br />{/if}
                                                        {if $b.cron=='add'}<div class="important_notify">{$lang.havecron} <a href="?cmd=configuration&action=cron&viewaddform=true" target="_blank" class="editbtn"><strong>{$lang.clicktoadd}</strong></a></div>{/if}

                                                    </div>
                                                </td>
                                            </tr>
                                            <tr {if $expand!=$b.id}style="display:none"{/if}  id="config-row-{$b.id}">
                                                <td></td>
                                                <td colspan="2">
                                                    <div class="clear">	</div>

                                                    <table border="0" width="100%" cellpadding="3">
                                                        {if $b.type=='Payment' || $b.type=='Other'}
                                                            <tr>
                                                                <td width="170" style="vertical-align: top;text-align: right">{$lang.dispname}: </td>
                                                                <td>
                                                                    {hbinput value=$b.modname_unparsed  name="name"}

                                                                </td>
                                                            </tr>
                                                        {/if}
                                                        {if $b.type=='Other'}
                                                            <tr>
                                                                <td width="170" style="vertical-align: top; text-align: right">{$lang.allowedtouse} </td>
                                                                <td class="fs11">
                                                                    <label>
                                                                        <input type="radio" value="1" name="admins_all" {if !$b.admins}checked="checked"{/if} />All staff members
                                                                    </label>
                                                                    <label>
                                                                        <input type="radio" value="0"  name="admins_all" {if $b.admins}checked="checked"{/if}/>Selected staff members
                                                                    </label>

                                                                    <div {if !$b.admins}style="display: none"{/if}>
                                                                        <br /><br />
                                                                        {foreach from=$admins item=adm}
                                                                            <label style="width:10%; display: inline-block">
                                                                                <input type="checkbox" {if $b.admins[$adm.id] || !$b.admins}checked="checked"{/if} name="admins[{$adm.id}]" value="{$adm.id}"/>
                                                                                {$adm.username}
                                                                            </label>
                                                                        {/foreach}
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        {/if}
                                                        {if $b.type=='Payment' || $b.type=='Notification' || $b.type=='Other'  || $b.type=='Fraud'} {if !empty($b.config)}
                                                                {foreach from=$b.config item=conf key=k}
                                                                    <tr >

                                                                        {assign var="name" value=$k}
                                                                        {assign var="name2" value=$b.module}
                                                                        {assign var="baz" value="$name2$name"}

                                                                        {if $conf.type=='input'}
                                                                            <td width="170" align="right">{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}: </td>
                                                                            <td >
                                                                                {if $conf.description}<span class="vtip_description" title="{$conf.description}"></span>{/if}
                                                                                <input name="option[{$k}]" value="{$conf.value}" />
                                                                            </td>
                                                                        {elseif $conf.type=='hbinput'}
                                                                            <td width="170" align="right" style="padding-bottom: 18px;">{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}: </td>
                                                                            <td >
                                                                                {if $conf.description} <div class="left" style="margin-right: 3px"><span class="vtip_description" title="{$conf.description}"></span></div>    {/if}
                                                                                {hbinput value=$conf.value name="option[`$k`]"}
                                                                            </td>
                                                                        {elseif $conf.type=='password'}
                                                                            <td width="170" align="right">{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}:</td>
                                                                            <td >
                                                                                {if $conf.description}<span class="vtip_description" title="{$conf.description}"></span>{/if}
                                                                                <input type="password" autocomplete="off" name="option[{$k}]" value="{$conf.value}" />
                                                                            </td>
                                                                        {elseif $conf.type=='check'}
                                                                            <td width="170" align="right">{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}:</td>
                                                                            <td >
                                                                                {if $conf.description}<a class="vtip_description" title="{$conf.description}"></a>{/if}
                                                                                <input name="option[{$k}]" type="checkbox" value="1" {if $conf.value == "1"}checked="checked"{/if} style="vertical-align: middle" />
                                                                            </td>
                                                                        {elseif $conf.type=='checklist'}
                                                                            <td width="170" align="right">{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}:
                                                                                {if $conf.description}<span class="vtip_description" title="{$conf.description}"></span>{/if}
                                                                            </td>
                                                                            <td class="fs11" >
                                                                                {foreach from=$conf.default item=selectopt}
                                                                                    <label class="left" style="padding-right:10px">
                                                                                        <input name="option[{$k}][]" type="checkbox" value="{$selectopt}" style="vertical-align: middle"
                                                                                               {if  in_array($selectopt,$conf.value)}checked="checked"{/if} />&nbsp;
                                                                                        {$selectopt}
                                                                                    </label>
                                                                                {/foreach}
                                                                            </td>
                                                                        {elseif $conf.type=='select'}
                                                                            <td width="170" align="right"> {if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}: </td>
                                                                            <td >{if $conf.description}<span class="vtip_description" title="{$conf.description}"></span>{/if}
                                                                                <select name="option[{$k}]">
                                                                                    {foreach from=$conf.default item=selectopt}
                                                                                        <option {if $conf.value == $selectopt}selected="selected" {/if}>{$selectopt}</option>
                                                                                    {/foreach}
                                                                                </select>
                                                                            </td>
                                                                        {elseif $conf.type=='textarea'}
                                                                            <td colspan="2">{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}: {if $conf.description}<span class="vtip_description" title="{$conf.description}"></span>{/if}<br />
                                                                                <span style="vertical-align:top"><textarea name="option[{$k}]" rows="5" cols="60">{$conf.value}</textarea></span>
                                                                            </td>
                                                                        {elseif $conf.type=='button'}
                                                                            <td colspan="2" >
                                                                                <a href="#" class="menuitm menu" onclick="{$conf.value}"><span><strong>{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}</strong></span></a>
                                                                            </td>
                                                                        {elseif $conf.type=='email_id'}
                                                                            <td width="170" align="right"> {if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}: </td>  <td >
                                                                            <select name="option[{$k}]" style="margin:0px" >
                                                                                {foreach from=$email_templates.All item=selectopt}
                                                                                    <option {if $conf.value == $selectopt.id}selected="selected" {/if}  value="{$selectopt.id}">{$selectopt.for}:{$selectopt.tplname}</option>
                                                                                {/foreach}
                                                                            </select>
                                                                        </td>

                                                                        {elseif $conf.type=='admin_id'}
                                                                            <td width="170" align="right"> {if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}: </td>  <td >
                                                                            <select name="option[{$k}]" style="margin:0px" >
                                                                                {foreach from=$admins item=selectopt}
                                                                                    <option {if $conf.value == $selectopt.id}selected="selected" {/if}  value="{$selectopt.id}">{$selectopt.username}</option>
                                                                                {/foreach}
                                                                            </select>
                                                                        </td>

                                                                        {elseif $conf.type=='department_id'}
                                                                            <td width="170" align="right"> {if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}: </td>  <td >
                                                                            <select name="option[{$k}]" style="margin:0px" >
                                                                                {foreach from=$ticket_departments item=selectopt}
                                                                                    <option {if $conf.value == $selectopt.id}selected="selected" {/if} value="{$selectopt.id}">{$selectopt.name}</option>
                                                                                {/foreach}
                                                                            </select>
                                                                        </td>
                                                                        {/if}



                                                                    </tr>
                                                                {/foreach}
                                                                {if  $b.currencies}
                                                                    <tr>
                                                                        <td width="170" align="right">Background conversion:</td>
                                                                        <td >
                                                                             <a class="vtip_description">
                                                                                <span>
                                                                                    When enabled, gateway will appear for all enabled currencies - even if unsupported by this gateway.
                                                                                    Unsupported currency will be converted in background to target currency selected here
                                                                                    <br>
                                                                                    Note: Target currency needs to be available in your HostBill configuration as main or additional currency
                                                                                </span>
                                                                             </a>&nbsp;
                                                                             <select name="option[background_conversion]" class="chosenedge" data-width="250px">
                                                                                <option value="" {if !$b.config.background_conversion.value}selected="selected"{/if}>None. Disable conversion</option>
                                                                                {foreach from=$b.currency_array item=cur}
                                                                                    <option value="{$cur}" {if $cur == $b.config.background_conversion.value}selected="selected"{/if}>{$cur}</option>
                                                                                {/foreach}
                                                                            </select>

                                                                        </td>
                                                                    </tr>
                                                                {/if}
                                                                {if $multicurrency}
                                                                    <tr>
                                                                        <td width="170" align="right">Limit to selected currencies:</td>
                                                                        <td >
                                                                            <a class="vtip_description">
                                                                                <span>
                                                                                    When enabled, gateway will appear only for selected currencies.
                                                                                </span>
                                                                            </a>&nbsp;
                                                                            <select name="option[restrict_currency][]" class="chosenedge gateway-currency"
                                                                                    data-width="250px"
                                                                                    data-placeholder="Disabled - show gateway with all supported currencies" multiple>
                                                                                <option value="-">
                                                                                    Disabled - show gateway with all supported currencies
                                                                                </option>
                                                                                {foreach from=$currencies item=cur}
                                                                                    <option value="{$cur.iso}"
                                                                                            {if in_array($cur.iso, $b.config.restrict_currency.value)}selected="selected"{/if}>
                                                                                        {$cur.iso}
                                                                                    </option>
                                                                                {/foreach}
                                                                            </select>
                                                                        </td>
                                                                    </tr>
                                                                {/if}
                                                                {if $b.callback}
                                                                    <tr >
                                                                        <td width="170"  align="right">{$lang.callbackurl}:</td>
                                                                        <td ><input readonly="readonly" value="{$b.callback}" size="70"/></td>
                                                                    </tr>
                                                                {/if}
                                                            {/if}
                                                        {/if}
                                                        <tr>
                                                            <td align="right" style="padding:10px;">
                                                                <a href="#" class="new_control greenbtn" onclick="$(this).parent().find('input').click();
                                                                            return false;">
                                                                    <span>{$lang.savechanges}</span>
                                                                </a>
                                                                <input type="submit" value="{$lang.savechanges}" style="font-weight:bold;margin-left:10px;display:none;" name="changeconfig"/>
                                                            </td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        {securitytoken}
                                    </form>
                                </div>
                            </li>
                        {/foreach}
                        <li style="border:none;">
                            <div style="padding:5px;">{$lang.withselected}
                                <a   class="menuitm  " href="#" onclick="deactivate_s();
                                        return false;">
                                    <span style="color:red">{$lang.Deactivate}</span>
                                </a>
                            </div>
                        </li>
                    </ul>
                    {if $action=='payment' || $action=='fraud'}
                        <script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
                        {literal}
                            <script type="text/javascript">
                                $("#grab-sorter").dragsort({dragSelector: "a.sorter-handle", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>"});
                                function saveOrder() {
                                    var sorts = $('.sorters2').serialize();
                                    ajax_update('?cmd=managemodules&action={/literal}{$action}{literal}&do=saveorder&' + sorts, {});
                                }
                                ;
                            </script>
                        {/literal}
                    {/if}
                {else}
                    <div class="blank_state blank_services">
                        <div class="blank_info">
                            <h1>{$lang.blank_mm}</h1>
                            {$lang.blank_mm_desc}
                            <div class="clear"></div>

                            <a class="new_add new_menu" href="?cmd=managemodules&action={$action}&do=inactive" style="margin-top:10px">
                                <span>{$lang.activatemodules}</span></a>
                            <div class="clear"></div>

                        </div>
                    </div>
                {/if}
            {/if}
            <script type="text/javascript">
                {literal}
                    function deactivate_s() {
                        if ($('.sorters:checked').length) {
                            window.location.href = '?cmd=managemodules{/literal}&security_token={$security_token}{literal}&action={/literal}{$action}{literal}&deactivate&' + $('.sorters').serialize();
                        }
                    }

                    function activate_s() {
                        if ($('.sorters:checked').length) {
                            window.location.href = '?cmd=managemodules{/literal}&security_token={$security_token}{literal}&action={/literal}{$action}{literal}&activate&' + $('.sorters').serialize();
                        }
                    }

                    function  getdesc() {
                        $('.gateway-currency').on('change', function (e, values) {
                            var self = $(this),
                                chosen = self.data('chosen');
                            if(values && values.selected && values.selected === '-'){
                                self.val('');
                                self.trigger('chosen:updated');
                                setTimeout(function(){
                                    chosen.close_field();
                                })
                            }
                        }).on('chosen:ready', function (e, data) {
                            data.chosen.search_field.css({
                                'color': '#555',
                                'font-size': '12px',
                                'padding-left': '8px'
                            });
                        })

                        $('.config-toggle').on('click init',function (e) {
                            var self = $(this),
                                target = $(self.data('target'));

                            if(e.type !== 'init')
                                self.toggleClass('activated');

                            target.toggle(self.is('.activated'));
                            $('.chosenedge', target).each(function () {
                                var self = $(this);
                                self.chosenedge(self.data());
                            });

                            return false;
                        }).filter('.activated').trigger('init')

                        $('.loaddescr').click(function () {
                            var el = $(this).hide();
                            $.post('?cmd=managemodules&action=getdescr&module=' + $(this).attr('rel') + '&type={/literal}{$action}{literal}', {empty1r: 'asas'}, function (data) {
                                var resp = parse_response(data);
                                if (resp) {
                                    $('#descr-' + el.attr('target')).html(resp).slideDown();
                                }
                            });
                            return false;
                        });

                        $('.sorters').click(
                            function () {
                                if ($(this).is(':checked')) {
                                    $(this).parents('li').addClass('checkedRow');
                                } else {
                                    $(this).parents('li').removeClass('checkedRow');
                                }
                            }
                        );

                        $('#checkthemall').click(function () {
                            if ($(this).is(':checked')) {
                                $('.sorters').attr('checked', true).parents('li').addClass('checkedRow');
                            } else {
                                $('.sorters').attr('checked', false).parents('li').removeClass('checkedRow');
                            }

                        });

                        $('input[name=admins_all]').change(function () {
                            var self = $(this);
                            if (self.val() == '1')
                                self.parent().nextAll('div').slideUp();
                            else
                                self.parent().nextAll('div').slideDown();
                        });

                {/literal}

                {if $do=='inactive' && $expand}
                        var inact = $('input[value="{$expand|escape:'javascript'}"]').parents('li');
                        $('.loaddescr', inact).click();
                        inact.scrollToEl();
                {elseif $expand}
                        $('#config-row-{$expand}').scrollToEl();
                {/if}
                {literal}
                    }

                    var PaymentConfigPerCurrency = {
                        add: function (id, list) {
                            if (list.indexOf('currency') == -1)
                                list.push('currency')
                            list = jQuery.map(list, function (e) {
                                return '[name="option[' + e + ']"]';
                            });

                            var fields = $(list.join(', '), '#' + id);
                            if (!fields.length)
                                return false;

                            var last = fields.eq(-1).attr('name').replace(/\]$/, '');
                            last = $('[name^="' + last + '"]:last', '#' + id);

                            var lastN = last.attr('name').match(/(\d+)\]$/);
                            lastN = lastN && lastN[1] && parseInt(lastN[1]) || 0;
                            lastN++;

                            var currencies = $('[name^="option[currency"]', '#' + id);

                            if (currencies.eq(0).children().length < lastN + 1)
                                return false;

                            fields.each(function () {
                                var self = $(this),
                                    tr = self.parents('tr').eq(0).clone(),
                                    inp = tr.find('[name]'),
                                    td = tr.children(':first');

                                td.text(td.text().replace(/(:)?(\s*)$/, ' (' + (lastN + 1) + ') $1$2'))
                                inp.val('').attr('name', inp.attr('name').replace(/\d*\]/, lastN + ']'));

                                tr.insertAfter(last.parents('tr').eq(0));
                                last = inp;
                            })


                            return false;
                        }
                    }

                    appendLoader('getdesc');
                {/literal}
            </script>
        </div>
    </div>
</div>
{/if}