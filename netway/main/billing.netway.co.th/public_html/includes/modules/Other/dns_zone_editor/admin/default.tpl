<link href="templates/default/js/chosen/chosen.css" rel="stylesheet" type="text/css"/>
<script src="templates/default/js/chosen/chosen.min.js" type="text/javascript"></script>
<link href="{$template_dir}dist/plugins/datatables/dataTables.bootstrap.min.css?v={$hb_version}" type="text/css"
      rel="stylesheet">
<script src="{$template_dir}dist/plugins/datatables/jquery.dataTables.min.js?v={$hb_version}"></script>
<script src="{$template_dir}dist/plugins/datatables/dataTables.bootstrap.min.js?v={$hb_version}"></script>
<script src="{$template_dir}dist/plugins/datatables/num-html.min.js?v={$hb_version}"></script>
<link href="{$moduleurl}styles.css" rel="stylesheet" type="text/css"/>
<script src="{$moduleurl}js/types.js" type="text/javascript"></script>
<script src="{$moduleurl}js/leftNav.js" type="text/javascript"></script>
{literal}
    <script>
        function ask() {
            if (!confirm('Do you really want to delete this zone?'))
                return false;
        }
    </script>
{/literal}
<ul class="hbnav breadcrumb">
    {foreach from=$dnscrumbs item=crumb}
        <li class="step {if $crumb.active}active{/if}">
            <a {if $crumb.url && !$crumb.active} href="{$crumb.url}&security_token={$security_token}"{/if}>
                <span>{$crumb.label}</span>
            </a>
        </li>
    {/foreach}
</ul>
<div id="dnszoneeditor">


    {if $section == 'default'}
        <form method="GET" action="" class="form-horizontal">
            <div class="form-group">
                <input type="hidden" value="dns_zone_editor" name="cmd">
                <input type="hidden" value="show" name="action">
                <div class="col-sm-4">
                    <h2><strong>{$lang.managedns}</strong></h2>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-4">
                    <select name="server" class="chosen form-control">
                        {foreach from=$groups item=group}
                            <optgroup label="{$group.name}">
                                {foreach from=$group.servers item=server}
                                    <option value="{$server.id}">{$server.name}</option>
                                {/foreach}
                            </optgroup>
                        {/foreach}
                    </select>
                </div>
                <div class="col-sm-1">
                    <button type="submit" class="btn btn-primary">{$lang.Continue}</button>
                </div>
            </div>
            {securitytoken}
        </form>
    {elseif $section=='show'}
        {include file="tpl/show.tpl"}
    {elseif $section=='nozones'}
        <p class="info">
            No zones were found.
        </p>
    {elseif $section=='result'}
        {include file="tpl/results.tpl"}
        {securitytoken}
    {elseif $section=='edit'}
        <div class="row">
            <label class="col-sm-2 text-center">
                <h2><strong>{$lang.edit|ucfirst} {$lang.record}</strong>: {$record.type}</h2>
            </label>
        </div>
        {include file='tpl/edit.tpl'}
        {securitytoken}
    {elseif $section=='add'}
        <div class="row">
            <label class="col-sm-4 text-center">
                <h2><strong>{$lang.Add} {$lang.New|lcfirst} "{$params.type}" {$lang.record}</strong></h2>
            </label>
        </div>
        {include file="tpl/add.tpl"}
        {securitytoken}
    {elseif $section=='addZone'}
        {include file="tpl/addzone.tpl"}
    {elseif $section=='dnssec'}
        {include file="tpl/dnssec.tpl"}
    {elseif $section=='import'}
        {include file="tpl/import.tpl"}
    {/if}
</div>
