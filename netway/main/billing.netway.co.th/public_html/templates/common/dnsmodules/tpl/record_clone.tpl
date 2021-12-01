<form action="" method="POST" class="form-horizontal">
    <div class="wbox">
        <div class="wbox_header"><strong>{$lang.clone_zone}</strong></div>
        <div class="wbox_content">

            {include file='../common/dnsmodules/tpl/import_options.tpl'}

        </div>
    </div>
    <div class="wbox">
        <div class="wbox_header">{$lang.bulkdomains}</div>
        <div class="wbox_content">
            {foreach from=$sected_domains item=domain name=row}
                <div {if  $smarty.foreach.row.index == 0}class="first"{/if}>
                    <input type="checkbox" value="{$domain.$domain_indent}" name="dom[]" checked="checked"/>
                    {$domain.domain}
                </div>
            {/foreach}
            <div class="text-center">
                <button type="submit" name="submit" class="btn btn-primary" value="1s">
                    {$lang.submit}
                </button>
                {$lang.or}
                <a href="{$service_url}">{$lang.cancel}</a>
            </div>
        </div> 
    </div>
    {securitytoken}
</form>