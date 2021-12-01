<div class="wbox">
    <div class="wbox_header"><span style="float: right; margin-top: -2px;">
            <a class="imgbg back" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget=wordpress">{$lang.backto} {$lang.servicedetails}</a>
        </span>{$lang.mydetails}
    </div>
    <div id="cartSummary" class="wbox_content">
        <table class="checker table table-striped" style="width:100%">
            <tbody>
                <tr>
                    <td style="text-align: right; width: 160px;">{$lang.domain}</td>
                    <td><a target="_blank" href="http://{if $wpd.subdomain}{$wpd.subdomain}.{/if}{$service.domain}/{if $wpd.path}{$wpd.path}/{/if}">{if $wpd.subdomain}{$wpd.subdomain}.{/if}{$service.domain}</a></td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 160px;">{$lang.wordpressversion}</td>
                    <td>{$wpd.version}</td>
                </tr>
                {if $wpd.path}<tr>
                    <td style="text-align: right; width: 160px;">{$lang.path}</td>
                    <td>{$wpd.path}</td>
                </tr>{/if}
                <tr>
                    <td style="text-align: right; width: 160px;">{$lang.directory}</td>
                    <td>{$wpd.dir}</td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 160px;">{$lang.databasehost}</td>
                    <td>{$wpd.host}</td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 160px;">{$lang.databasename}</td>
                    <td>{$wpd.name}</td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 160px;">{$lang.databaseuser}</td>
                    <td>{$wpd.user}</td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 160px;">{$lang.databasepassword}</td>
                    <td>
                        <span style="display:none" id="showpassword">{$wpd.password}</span>
                        <a href="#" onclick="$(this).hide();$('#showpassword').show();return false;" class="fs11">{$lang.revealpassword}</a>
                    </td>
                </tr>
            </tbody>
        </table>
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
    a.back {
        background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/restore-backup.png);
    }
    form label {
        vertical-align: middle;
        margin-left: 6px;
        margin-right: 6px;
    }
    form input {
        vertical-align: middle;
    }
    form input[type=submit] {
        margin: 6px 18px 6px 18px;
    }
</style>
{/literal}