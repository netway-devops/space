{if $widget_group === 'all' || $widget_group === 'sidemenu'}
    <li class="nav-item">
        <a class="nav-link {if !$widget}active{/if}" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">
            <span class="widg-image widg_default"></span>
            <span>{$lang.servicedetails}</span>
        </a>
    </li>
{/if}

{foreach from=$widgets item=widg}
    {if $widg.group === $widget_group || $widget_group === 'all'}
        <li class="nav-item">
            <a class="nav-link {if $widget.name==$widg.name && $widget.fullname == $widg.fullname} active{/if}" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}">
                <span class="widg-image widg_{$widg.widget}"></span>
                <span>{$widg.fullname}</span>
            </a>
        </li>
    {/if}
{/foreach}

{if $service.status=='Active' && $service.isvpstpl && ($widget_group === 'all' || $widget_group === 'sidemenu')}
    {if $commands.RebuildOS}
        <li class="nav-item">
            <a class="nav-link" href="#" onclick="return callcustomfn('RebuildOS',{$service.id}, '#_rebuild', true)">
                <span class="widg-image widg_reload"></span>
                <span>{$lang.reload_os}</span>
            </a>
        </li>
    {/if}
    {if $commands.Backup}
        <li class="nav-item">
            <a class="nav-link" href="#">
                <span class="widg-image widg_backup"></span>
                <span>{$lang.backup}</span>
            </a>
        </li>
    {/if}
    {if $commands.ResetRootPassword}
        <li class="nav-item">
            <a class="nav-link" onclick="return process('ResetRootPassword',{$service.id}, '#_rootp')" href="#">
                <span class="widg-image widg_resetpass"></span>
                <span>{$lang.reset_root}</span>
            </a>
        </li>
    {/if}
    {if ($commands.Statistics)}
        <li class="nav-item">
            <a class="nav-link " href="#" onclick="return callcustomfn('Statistics',{$service.id}, '#_stats')">
                <span class="widg-image widg_quotausage"></span>
                <span>{$lang.Statistics}</span>
            </a>
        </li>
    {/if}
    {if ($commands.Console)}
        <li class="nav-item">
            <a class="nav-link " href="#" onclick="return callcustomfn('Console',{$service.id}, '#_console')">
                <span class="widg-image widg_console"></span>
                <span>{$lang.Console}</span>
            </a>
        </li>
    {/if}
{/if}
{if $service.status=='Active' && ($widget_group === 'all' || $widget_group === 'sidemenu')}
    {foreach from=$commands item=command}
        {if $service.isvpstpl && ($command=='RebuildOS' || $command=='Backup' || $command=='ResetRootPassword' || $command=='Statistics' || $command=='Console' || $command=='GetStatus'  || $command=='Stop'  || $command=='Start'  || $command=='Reboot' || $command=='Shutdown'  || $command=='FastStat' || $command=='PowerON' || $command=='PowerOFF' || $command=='Destroy' || $command=='VMDetails')}
        {else}
            <li class="nav-item">
                <a class="nav-link " href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&customfn={$command}" onclick="return callcustomfn('{$command}',{$service.id}, '#_ocustom', true)">
                    <span class="widg-image widg_console"></span>
                    <span>{if $lang.$command}{$lang.$command}{else}{$command}{/if}</span>
                </a>
            </li>
        {/if}
    {/foreach}
{/if}
{if $enableFeatures.dnsmanagement!='off' && $dnsmodule_id && ($widget_group === 'all' || $widget_group === 'sidemenu')}
    <li class="nav-item">
        <a class="nav-link " href="{$ca_url}module&amp;module={$dnsmodule_id}">
            <span class="widg-image widg_dnsmanagement_widget"></span>
            <span>{$lang.mydns}</span>
        </a>
    </li>
{/if}
{if $widget_group === 'all' || $widget_group === 'sidemenu'}
    {foreach from=$haveaddons item=newaddon}
        <li class="nav-item">
            <a class="nav-link no-restriction" href="{$ca_url}cart&amp;action=add&amp;cat_id=addons&amp;id={$newaddon.id}&amp;account_id={$service.id}&amp;addon_cycles[{$newaddon.id}]={$newaddon.paytype}">
                <span class="widg-image widg_default"></span>
                <span class="plus">{$lang.Add} {$newaddon.name}</span>
            </a>
        </li>
    {/foreach}
{/if}

{if $service.status!='Terminated' && $service.status!='Cancelled' && ($widget_group === 'all' || $widget_group === 'sidemenu')}
    <li class="last nav-item">
        <a class="nav-link text-danger" href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel">
            <span class="widg-image widg_cancellation"></span>
            <span class="cancellation">{$lang.cancelrequest}</span>
        </a>
    </li>
{/if}

{if $widget_group === 'all' || $widget_group === 'sidemenu'}
    {literal}
        <script type="text/javascript">
            function process(f, id, pole) {
                if (f == 'Start' || f == 'Stop' || f == 'Reboot' || f == 'GetStatus')
                    ajax_update('?cmd=clientarea&action=checkstatus&do=' + f + '&id=' + id, {}, '#vpsdetails');
                else
                    callcustomfn(f, id, pole);
                return false;
            }
            function callcustomfn(f, id, pole) {
                $('#extrafields').hide();
                $('#extrafields #content_field').html('');
                $('#extrafields').show();
                ajax_update('?cmd=clientarea&action=customfn&val=' + f + '&id=' + id, {}, '#extrafields #content_field');
                return false;
            }
        </script>
    {/literal}
{/if}