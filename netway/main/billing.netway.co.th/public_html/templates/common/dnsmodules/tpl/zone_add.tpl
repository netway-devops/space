<form action="{$service_url}&act=add_domain"
      method="POST" class="dns-add-zone">
    <div class="wbox">
        <div class="wbox_header"><strong>{$lang.addzone}</strong></div>
        <div class="wbox_content form-horizontal">
            <div class="control-group">
                <label class="control-label" for="zone-name"><b>{$lang.domain}</b></label>
                <div class="controls">
                    <input type="text" name="domain" value="" class="styled" id="zone-name"/>
                    <span class="help-inline">{$lang.enter_domain_name} 'example.com'</span>
                </div>
            </div>
            {if $require_ip}
                <div class="control-group">
                    <label class="control-label" for="zone-ip"><b>{$lang.ipadd}</b></label>
                    <div class="controls">
                        <input type="text" name="ipaddress" value="" class="styled" id="zone-ip"/>
                    </div>
                </div>
            {/if}

            {include file='../common/dnsmodules/tpl/import_options.tpl'}

            <div class="text-center">
                <button type="submit" name="submit" class="btn btn-primary" value="1">
                    {$lang.submit}
                </button>
                {$lang.or}
                <a href="{$service_url}">
                    {$lang.cancel}
                </a>
            </div>
        </div>
    </div>
    {securitytoken}
</form>