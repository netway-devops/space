<!-- Breadcrumbs -->
<div class="breadcrumbs-box center-area clearfix">
    <ul class="breadcrumb">
        <li>
            <a href="#">{$lang.youhere}</a><span class="divider"></span>
        </li>

        {if $cmd == 'clientarea' && $action == 'default'}
            <li class="active">
                {$lang.dashboard}
            </li>
        {elseif $cmd == 'cart'}
            <li class="active">
                {$lang.order}
            </li>
        {elseif $cmd == 'clientarea' && ( $action == 'service' || $action == 'services' || $action == 'domains')}
            <li>
                <a href="{$ca_url}clientarea/">{$lang.clientarea}</a>
                <span class="divider"></span>
            </li>
        {elseif $cmd == 'clientarea' && !( $action == 'service' || $action == 'services' || $action == 'domains' || $action == 'cancel') && $action != 'default'}
            <li>
                <a href="{$ca_url}clientarea/">{$lang.account}</a>
                <span class="divider"></span>
            </li>
        {elseif $cmd == 'support' || $cmd == 'tickets' || $cmd == 'downloads' || $cmd == 'knowledgebase'} 
            <li {if $action == 'support'}class="active"{/if}>
                {if $cmd != 'support'}
                    <a href="{$ca_url}support/">{$lang.support}</a>
                    <span class="divider"></span>
                {else}
                    {$lang.support}
                {/if}
            </li>
        {elseif $cmd == 'affiliates'}
            <li{if $action == 'default'} class="active"{/if}>
                {if $action != 'default'}
                    <a href="{$ca_url}affiliates/">{$lang.affiliates}</a>
                    <span class="divider"></span>
                {else}
                    {$lang.affiliates}
                {/if}
            </li>
        {else}
            <li class="active">
                {if $pagetitle}{$pagetitle}
                {elseif $lang.$cmd}{$lang.$cmd}
                {else}{$cmd}
                {/if}
            </li>
        {/if}

        {if $cmd == 'clientarea' && ( $action == 'service' || $action == 'services' || $action == 'domains')}
            {if $action == 'service' || $action == 'services'}
                {foreach from=$offer item=o}
                    {if $cid==$o.id || $service.category_id==$o.id}
                        <li {if !$service}class='active'{/if}>
                            {if $service}
                                <a href="{$ca_url}clientarea/services/{$o.slug}/"  >{$o.name}</a>
                                <span class="divider"></span>
                            {else}{$o.name}
                            {/if}
                        </li>
                        {break}
                    {/if}
                {/foreach}
                {if $service}
                    <li {if !$widget && !$domain.domain}class='active'{/if}>
                        {if $widget || $domain.domain}
                            <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}"  >{$service.name}</a>
                            <span class="divider"></span>
                        {else}{$service.name}
                        {/if}
                    </li>
                {/if}
                {if $domain.domain}
                    <li class='active'>
                        {$domain.domain}
                    </li>
                {/if}
            {else}
                <li {if !$details && !$widget}class='active'{/if}>
                    {if $details || $widget}
                        <a href="{$ca_url}clientarea/domains/"  >{$lang.domains}</a>
                        <span class="divider"></span>
                    {else}{$lang.domains}
                    {/if}
                </li>
                {if $details}
                    <li {if !$widget}class='active'{/if}>
                        {if $widget}
                            <a href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}"  >{$details.name}</a>
                            <span class="divider"></span>
                        {else}{$details.name}
                        {/if}
                    </li>
                {/if}
            {/if}

            {if $widget}
                <li class='active'>
                    {if $lang[$widget.name]}{$lang[$widget.name]}
                    {elseif $widget.fullname}{$widget.fullname}
                    {else}{$widget.name}
                    {/if}
                </li>
            {/if}
        {elseif $cmd == 'clientarea' && !( $action == 'service' || $action == 'services' || $action == 'domains' || $action == 'cancel') && $action != 'default'}
            {if $action!='default' && $lang.$action}
                <li class='active'>
                    {$lang.$action}
                </li>
            {/if}
        {elseif $cmd == 'tickets' || $cmd == 'downloads' || $cmd == 'knowledgebase'} 
            {if $lang.$cmd}
                <li {if $action=='default' }class='active'{/if}>
                    {if $action!='default'}
                        <a href="{$ca_url}{$cmd}/" >{$lang.$cmd}</a>
                        <span class="divider"></span>
                    {else}{$lang.$cmd}
                    {/if}
                </li>
            {/if}

            {if $cmd == 'knowledgebase'}
                {if $action!='default' && $lang.$action && !$path}
                    <li class='active'>
                        {$lang.$action}
                    </li>
                {/if}

                {foreach from=$path item=p name=kbloc}
                    <li>
                        {if !$smarty.foreach.kbloc.last || $article}
                            <a href="{$ca_url}knowledgebase/category/{$p.id}/{$p.slug}/">{$p.name}</a> 
                            <span class="divider"></span>
                        {else}
                            {$p.name}
                        {/if}
                    </li>
                {/foreach}

                {if $article}
                    <li class='active'>
                        {$article.title|truncate:30}
                    </li>
                {/if}
            {elseif $cmd == 'downloads'}
                {if $category}
                    <li class='active'>
                        {$category.name}
                    </li>
                {/if}
            {else}
                {if $action =='new'}
                    <li class='active'>
                        {$lang.openticket}
                    </li>
                {elseif $action=='view'}
                    <li class='active'>
                        {$lang.Ticket} #{$ticket.ticket_number}
                    </li>
                {elseif $action!='default' && $lang.$action}
                    <li class='active'>
                        {$lang.$action}
                    </li>
                {/if}
            {/if}

        {elseif $cmd == 'affiliates'}
            {if $action=='commissions'}
                <li class='active'>
                    {$lang.mycommissions}
                </li>
            {elseif $action!='default' && $lang.$action}
                <li class='active'>
                    {$lang.$action}
                </li>
            {/if}
        {/if}

    </ul>
</div>
<!-- End of Breadcrumbs -->