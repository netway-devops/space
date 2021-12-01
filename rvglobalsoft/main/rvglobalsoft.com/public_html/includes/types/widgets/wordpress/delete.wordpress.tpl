<div class="wbox">
    <div class="wbox_header"><span style="float: right; margin-top: -2px;">
            <a class="imgbg back" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget=wordpress">{$lang.backto} {$lang.servicedetails}</a>
        </span>{$lang.delete}- http://{if $wpd.subdomain}{$wpd.subdomain}.{/if}{$service.domain}/{if $wpd.path}{$wpd.path}/{/if}
    </div>
    <div id="cartSummary" class="wbox_content">
        <p>{$lang.youagreeoremoveresource}</p>

        <form action="" method="post" id="wpform">
            <p style="text-align: center;">
                <label><input type="checkbox" name="del_db" /> <b>{$wpd.name}</b> ({$lang.database})</label>
                {if $service.username != $wpd.user}<label><input type="checkbox" name="del_dbu" /> <b>{$wpd.user}</b> ({$lang.databaseuser})</label>{/if}
                {if $wpd.subdomain}<label><input type="checkbox" name="del_sub" /> <b>{$wpd.subdomain}</b> ({$lang.subdomain})</label>{/if}
                {if $wpd.dir != '/public_html'}<label><input type="checkbox" name="del_files" /> <b>{$wpd.dir}</b> ({$lang.directory})</label>{/if}
                <input type="submit" value="Delete" />
                <input type="hidden" name="make" value="delete" />
            </p>
        </form>


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