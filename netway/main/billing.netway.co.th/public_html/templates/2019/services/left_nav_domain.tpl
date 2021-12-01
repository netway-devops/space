{if $widget_group === 'all' || $widget_group === 'sidemenu'}
    <li class="nav-item">
        <a class="nav-link {if !$widget}active{/if}" href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/">
            <span class="widg-image widg_default"></span>
            <span>{$lang.domdetails}</span>
        </a>
    </li>
{/if}

{foreach from=$widgets item=widg name=cst}
    {if $widg.name!='reglock' && $widg.name!='nameservers'  && $widg.name!='autorenew' }
        {if $widg.name=='idprotection' && $details.offerprotection && !$details.offerprotection.purchased}
            {continue}
        {/if}
        {if $widg.group === $widget_group || $widget_group === 'all'}
            <li class="nav-item">
                <a class="nav-link {if $widget.name==$widg.name}active{/if}" href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}#{$widg.name}">
                    <span class="widg-image widg_{$widg.widget}"></span>
                    <span>{$widg.fullname}</span>
                </a>
            </li>
        {/if}
    {/if}
{/foreach}
{if $custom}
    {foreach from=$custom item=btn name=cst}
        <li class="nav-item">
            <a class="nav-link" href="#" onclick="$('#cbtn_{$btn}').click(); return false;">
                <span>{$lang.$btn}</span>
            </a>
        </li>
    {/foreach}
{/if}

{if $cancanel && $service.status!='Terminated' && $service.status!='Cancelled' && ($widget_group === 'all' || $widget_group === 'sidemenu')}
    <li class="last nav-item">
        <a class="nav-link text-danger" href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/&cancel">
            <span class="widg-image widg_cancellation"></span>
            <span class="cancellation">{$lang.cancelrequest}</span>
        </a>
    </li>
{/if}