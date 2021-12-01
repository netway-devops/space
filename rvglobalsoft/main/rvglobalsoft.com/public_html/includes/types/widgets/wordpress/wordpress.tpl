{if $widget.subappendtpl}
    {include file=$widget.subappendtpl}
{/if}
<div class="wbox">
        </span>
    <div class="wbox_header"><span style="float: right; margin-top: -2px;">
            <a class="imgbg upgrade" target="_blank" href="http://codex.wordpress.org/Updating_WordPress">{$lang.upgradeinfo}</a>
            {if $wact!='install' && $wact!='wpdetails'}
            <a class="imgbg newinstall" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget=wordpress&wact=install">{$lang.newinstallation}</a>
            {/if}
        </span>WordPress
    </div>
    <div id="cartSummary" class="wbox_content">
        {if $wps}
        <table class="checker table table-striped" style="width:100%">
            <thead>
            <th>{$lang.domain}</th>
            <th>{$lang.databasename}</th>
            <th>{$lang.databaseuser}</th>
            <th>{$lang.version}</th>
            <th>{$lang.actions}</th>
            </thead>
            <tbody>
                {foreach from=$wps item=wp}
                <tr class="{$wp.row}">
                    <td style="text-align: center;"><a href="http://{if $wp.subdomain}{$wp.subdomain}.{/if}{$service.domain}/{if $wp.path}{$wp.path}/{/if}">{if $wp.subdomain}{$wp.subdomain}.{/if}{$service.domain}</a></td>
                    <td style="text-align: center;">{$wp.name}</td>
                    <td style="text-align: center;">{$wp.user}</td>
                    <td style="text-align: center;">{$wp.version}</td>
                    <td style="text-align: center;">{if $wp.version=='init'}
                        <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget=wordpress&wact=reinstall&wpid={$wp.id}">{$lang.reinstall}</a>
                        {else}
                        <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget=wordpress&wact=details&wpid={$wp.id}">{$lang.mydetails}</a>
                        {if $wact!='wpdetails'}
                        <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget=wordpress&wact=delete&wpid={$wp.id}">{$lang.delete}</a>
                        {/if}
                        {/if}
                    </td>
                </tr>
                {/foreach}
            </tbody>
        </table>
        {else}
        <p style="margin: 6px 12px 6px 12px;">{$lang.youdonthavewordpressinstalled}.</p>
        {/if}
    </div>
</div>


<script type="text/javascript">
    {literal}
    
</script>
<style type="text/css">
    a.imgbg {
        font-size: 11px;
        padding-left: 20px;
        line-height: 18px;
        vertical-align: middle;
        background-position: 0px 1px;
        background-repeat:no-repeat;
        display: inline-block;
        margin: auto 6px auto 3px;
        vertical-align: middle;
        color: #005bb8;
        font-weight: normal;
    }
    a.newinstall {
        background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/vm-on.png);
    }
    a.upgrade {
        background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/helpi.png);
    }
</style>
{/literal}