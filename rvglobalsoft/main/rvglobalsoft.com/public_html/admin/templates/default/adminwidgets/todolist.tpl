{if !empty($todo)}
<p style="line-height: 1.75em;">
    {if $todo.templates_c_outside}
        <label class="label label-danger">{$lang.critical}</label> Move templates_c directory outside of web-accessible folder! <a href="https://hostbill.atlassian.net/wiki/display/DOCS/Additional+security+steps" target="_blank">Secure directories</a></a> <br />
    {/if}
    {if $todo.strictmode}
        <label class="label label-danger">{$lang.critical}</label> Your database engine have <strong>STRICT sql_mode</strong> enabled. Please disable it as it will lead to errors  <br />
    {/if}



    {if $todo.emailoff}
        <label class="label label-warning">Warning</label> {$lang.emailisturnetoff}<br />
    {/if}

    {if $todo.libsodium}
        <label class="label label-info">Note</label> Please consider installing <strong>php-sodium</strong> extension for safer password storage<br />
    {/if}


    {if $todo.emailfail}
        <label class="label label-danger">{$lang.critical}</label>  Last email was not sent correctly - check <a href="?cmd=emails">email log</a><br />
    {/if}

    {if $todo.errorlog}
        <label class="label label-warning">Warning</label>  There are some new entries in error log from Today - check <a href="?cmd=logs&action=errorlog">Error Log</a><br />
    {/if}

    {if $todo.gatewaylog}
        <label class="label label-warning">Warning</label>  There are some new failed entries in gateway log from Today - check <a href="?cmd=gtwlog">Gateway Log</a><br />
    {/if}


    {if $todo.install}
        <label class="label label-danger">{$lang.critical}</label>  {$lang.removeinstall}<br />
    {/if}
    {if $todo.changepass}
        <label class="label label-danger">{$lang.critical}</label>  {$lang.changeadminpass}<br />
    {/if}
    {if $todo.cron}
        <label class="label label-danger">{$lang.critical}</label>  {$lang.cronnotwork} <a href="?cmd=configuration&action=cron">{$lang.doitnow}.</a><br />

        {if $todo.chmodcron}
            <label class="label label-info">Info</label> {$lang.chmodcron}<br />
        {/if}
    {/if}

    {if $todo.ioncubeversion}
        <label class="label label-warning">Warning</label>  You are using old ioncube loaders. Future HostBill releases may not work. Please upgrade <a href="https://www.ioncube.com/loaders.php" target="_blank">ioncube loaders</a> when possible<br />
    {/if}

    {if $todo.maintenance}
        <label class="label label-warning">Warning</label>  Your HostBill is running in Maintenance mode - clients will not be able to access client portal.<br />
    {/if}
    {if $todo.queue_failed}
        <label class="label label-danger">{$lang.critical}</label>  Queue is not enabled in cron. Add following crontab entry: <code>* * * * * php {$hb_maindir}queue.php</code><br />
    {/if}
    {if $todo.queue_slow}
        <label class="label label-info">Info</label> You can increase your queue processing performance: <a href="https://hostbill.atlassian.net/wiki/display/DOCS/HostBill+Queue+Performance" target="_blank">Learn more</a><br />
    {/if}

    {if $todo.crontaskblock}
        <label class="label label-danger">{$lang.critical}</label> {$lang.crontaskdisabled}<a href="?cmd=configuration&action=cron">{$lang.Learnmore}.</a> <a href="?cmd=logs&action=errorlog"> Error Log</a><br />
    {/if}
    {if $todo.downindex}
        <label class="label label-danger">{$lang.critical}</label>  {$lang.placeindexdownload}<br />
    {/if}
    {if $todo.tempindex}
        <label class="label label-danger">{$lang.critical}</label>  {$lang.placeindextemplates}<br />
    {/if}
    {if $todo.attindex}
        <label class="label label-danger">{$lang.critical}</label>  {$lang.placeindexattachments}<br />
    {/if}
    {if $todo.config}
        <label class="label label-info">Info</label> {$lang.shouldeditconfig}. <a href="?cmd=configuration">{$lang.doitnow}.</a><br />
    {/if}
    {if $todo.modules}
        <label class="label label-info">Info</label> {$lang.tostartconfigservers} <a href="?cmd=managemodules">{$lang.doitnow}.</a><br />
    {/if}
    {if $todo.servers}
        <label class="label label-info">Info</label> {$lang.configureservers} <a href="?cmd=servers">{$lang.doitnow}.</a><br />
    {/if}
    {if $todo.packages}
        <label class="label label-info">Info</label> {$lang.addpackagestosell}<a href="?cmd=services&action=addproduct">{$lang.doitnow}.</a><br />
    {/if}
</p>
{/if}