
            <a href="?cmd=configuration"  class="tstyled  {if ($cmd =='taxconfig' || $cmd == 'configuration' || $cmd =='currencytocountry') &&  $action!='cron'}selected{/if}">{$lang.generalsettings}</a>
            <a href="?cmd=configuration&action=cron"  class="tstyled {if $action=='cron' || $action=='cronprofiles'}selected{/if}">{$lang.cronprofiles}</a>
            <a href="?cmd=whoisservers"  class="tstyled {if $cmd == 'whoisservers'}selected{/if}">{$lang.domainsettings}</a>
            <a href="?cmd=dns_automation"  class="tstyled {if $cmd == 'dns_automation'}selected{/if}">{$lang.dnssettings}</a>
            <a href="?cmd=security"  class="tstyled {if $cmd == 'security'}selected{/if}">{$lang.securitysettings}</a>
            <a href="?cmd=langedit"  class="tstyled {if $cmd == 'langedit'}selected{/if}">{$lang.languages}</a>