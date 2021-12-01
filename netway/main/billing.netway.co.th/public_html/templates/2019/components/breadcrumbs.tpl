<!-- Breadcrumbs -->
<nav aria-label="breadcrumb">
    {if $inside || !(($action == 'services' && $service) || ($action == 'domains' && $details) || ($cmd=='clientarea' && $action=='default')) }
        <ol class="breadcrumb {$action} {if $inside}inside-breadcrumb{/if}">
            {if $logged=='1' && !($cmd == 'clientarea' && $action == 'default')}
                <li class="breadcrumb-item">
                    <a href="{$ca_url}">{$lang.dashboard}</a>
                </li>
            {/if}
            {if $cmd == 'clientarea' && $action == 'default'}
                <li class="active breadcrumb-item">
                    {$lang.dashboard}
                </li>
            {elseif $cmd == 'cart'}
                {if $step!=5 && $step>0}
                    <li class="breadcrumb-item">
                        <a href="{$ca_url}cart/">{$lang.order}</a>
                    </li>
                    {if $step>2 && (!$cart_contents[2] || $cart_contents[2][0].action == 'hostname')}
                        {assign var='pclass' value='asw3'}
                    {elseif $step==1 || ($cart_contents[2] && $cart_contents[2][0].action!='own')}
                        {assign var='pclass' value='asw5'}
                    {elseif $step>1 && $cart_contents[2][0].action=='own'}
                        {assign var='pclass' value='asw4'}
                    {/if}

                    {if $pclass!='asw3'}
                        <li class="breadcrumb-item {if $step<2} active{/if}">
                            {if $step<=1}{$lang.mydomains}
                            {else}<a href="{$ca_url}cart/&step=1">{$lang.mydomains}</a>
                            {/if}
                        </li>
                    {elseif $pclass=='asw3'}
                        <li class="breadcrumb-item {if $step<2} active{/if}">
                            {if $step<=3}{$lang.productconfig}
                            {else}<a href="{$ca_url}cart/&step=3">{$lang.productconfig}</a>
                            {/if}
                        </li>
                    {/if}

                    {if $pclass=='asw5'}
                        <li class="breadcrumb-item {if $step==2} active{/if}">
                            {if $step<=2}{$lang.productconfig2}
                            {else}<a href="{$ca_url}cart/&step=2">{$lang.productconfig2}</a>
                            {/if}
                        </li>
                    {elseif $pclass=='asw4'}
                        <li class="breadcrumb-item {if $step==3} active{/if}">
                            {if $step<=3}{$lang.productconfig}
                            {else}<a href="{$ca_url}cart/&step=3">{$lang.productconfig}</a>
                            {/if}
                        </li>
                    {/if}

                    {if $pclass=='asw5'}
                        <li class="breadcrumb-item {if $step==3} active{/if}">
                            {if $step<=3}{$lang.productconfig}
                            {else}<a href="{$ca_url}cart/&step=3">{$lang.productconfig}</a>
                            {/if}
                        </li>
                    {/if}
                    <li class="breadcrumb-item {if $step==4} active{/if}">
                        {if $step<=4}{$lang.ordersummary}
                        {else}<a href="{$ca_url}cart/&step=4">{$lang.ordersummary}</a>
                        {/if}
                    </li>
                    <li class="breadcrumb-item">
                        {$lang.checkout}
                    </li>
                {else}
                    <li class="breadcrumb-item active">
                        {$lang.order}
                    </li>
                {/if}

            {elseif $cmd == 'clientarea' && ( $action == 'service' || $action == 'services' || $action == 'domains')}
                <li class="breadcrumb-item">
                    <a href="{$ca_url}clientarea/">{$lang.clientarea}</a>
                </li>
            {elseif $cmd == 'clientarea' && !( $action == 'service' || $action == 'services' || $action == 'domains' || $action == 'cancel') && $action != 'default'}
                <li class="breadcrumb-item">
                    <a href="{$ca_url}clientarea/">{$lang.account}</a>
                </li>
            {elseif $cmd == 'support' || $cmd == 'tickets' || $cmd == 'downloads' || $cmd == 'knowledgebase'}
                <li class="breadcrumb-item {if $cmd == 'support'} active{/if}">
                    {if $cmd != 'support'}
                        <a href="{$ca_url}support/">{$lang.support}</a>

                    {else}
                        {$lang.support}
                    {/if}
                </li>
            {elseif $cmd == 'netstat'}
                <li class="breadcrumb-item">
                    <a href="{$ca_url}support/">{$lang.support}</a>
                </li>
                <li class="breadcrumb-item active">
                    {$lang.netstat}
                </li>
            {elseif $cmd == 'profiles'}
                <li class="breadcrumb-item">
                    <a href="{$ca_url}clientarea/">{$lang.account}</a>

                </li>
                <li class="breadcrumb-item {if $action!='add' && $action!='edit'} active{/if}">
                    {if $action!='add' && $action!='edit'}
                        {$lang.profiles}
                    {else}
                        <a href="{$ca_url}{$cmd}/">{$lang.profiles}</a>
                    {/if}
                </li>
            {elseif $cmd == 'affiliates'}
                <li class="breadcrumb-item {if $action == 'default'} active{/if}">
                    {if $action != 'default'}
                        <a href="{$ca_url}affiliates/">{$lang.affiliates}</a>

                    {else}
                        {$lang.affiliates}
                    {/if}
                </li>
            {else}
                <li class="breadcrumb-item active">
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
                            <li class="breadcrumb-item {if !$service} active{/if}">
                                {if $service}
                                    <a href="{$ca_url}clientarea/services/{$o.slug}/"  >{$o.name}</a>

                                {else}{$o.name}
                                {/if}
                            </li>
                            {break}
                        {/if}
                    {/foreach}
                    {if $service}
                        <li class="breadcrumb-item {if !$widget && !$domain.domain} active{/if}">
                            {if $widget || $domain.domain}
                                <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}"  >{$service.name}</a>

                            {else}{$service.name}
                            {/if}
                        </li>
                    {/if}
                    {if $domain.domain}
                        <li class="breadcrumb-item active">
                            {$domain.domain}
                        </li>
                    {/if}
                {else}
                    <li class="breadcrumb-item {if !$details && !$widget} active{/if}">
                        {if $details || $widget}
                            <a href="{$ca_url}clientarea/domains/"  >{$lang.domains}</a>

                        {else}{$lang.domains}
                        {/if}
                    </li>
                    {if $details}
                        <li class="breadcrumb-item {if !$widget} active{/if}">
                            {if $widget}
                                <a href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}"  >{$details.name}</a>

                            {else}{$details.name}
                            {/if}
                        </li>
                    {/if}
                {/if}

                {if $widget}
                    <li class="breadcrumb-item active">
                        {$widget.fullname}
                    </li>
                {/if}
            {elseif $cmd == 'clientarea' && !( $action == 'service' || $action == 'services' || $action == 'domains' || $action == 'cancel') && $action != 'default'}
                {if $action=='emails' && $email}
                    <li class="breadcrumb-item">
                        <a href="{$ca_url}clientarea/{$lang.$action}/">{$lang.$action}</a>
                    </li>
                    <li class="breadcrumb-item active">
                        {$email.subject|strip|truncate}
                    </li>
                {elseif $action=='history' }
                    <li class="breadcrumb-item active">
                        {$lang.myhistory}
                    </li>
                {elseif $action=='profilepassword' }
                    <li class="breadcrumb-item active">
                        {$lang.changepass}
                    </li>
                {elseif $action!='default' && $lang.$action}
                    <li class="breadcrumb-item active">
                        {$lang.$action}
                    </li>
                {else}
                    <li class="breadcrumb-item active">
                        {$lang.page}
                    </li>
                {/if}
            {elseif $cmd == 'tickets' || $cmd == 'downloads' || $cmd == 'knowledgebase'}
                {if $lang.$cmd}
                    <li class="breadcrumb-item {if $action=='default' } active{/if}">
                        {if $action!='default'}
                            <a href="{$ca_url}{$cmd}/" >{$lang.$cmd}</a>

                        {else}{$lang.$cmd}
                        {/if}
                    </li>
                {/if}

                {if $cmd == 'knowledgebase'}
                    {if $action!='default' && $lang.$action && !$path}
                        <li class="breadcrumb-item active">
                            {$lang.$action}
                        </li>
                    {/if}

                    {foreach from=$path item=p name=kbloc}
                        <li class="breadcrumb-item {if $smarty.foreach.kbloc.last && !$article} active{/if}">
                            {if !$smarty.foreach.kbloc.last || $article}
                                <a href="{$ca_url}knowledgebase/category/{$p.id}/{$p.slug}/">{$p.name}</a>

                            {else}
                                {$p.name}
                            {/if}
                        </li>
                    {/foreach}

                    {if $article}
                        <li class="breadcrumb-item active">
                            {$article.title|truncate:30}
                        </li>
                    {/if}
                {elseif $cmd == 'downloads'}
                    {if $category}
                        <li class="breadcrumb-item active">
                            {$category.name}
                        </li>
                    {/if}
                {else}
                    {if $action =='new'}
                        <li class="breadcrumb-item active">
                            {$lang.openticket}
                        </li>
                    {elseif $action=='view'}
                        <li class="breadcrumb-item active">
                            {$ticket.subject|escape}
                        </li>
                    {elseif $action!='default' && $lang.$action}
                        <li class="breadcrumb-item active">
                            {$lang.$action}
                        </li>
                    {/if}
                {/if}

            {elseif $cmd == 'affiliates'}
                {if $action=='commissions'}
                    <li class="breadcrumb-item active">
                        {$lang.mycommissions}
                    </li>
                {elseif $action!='default' && $lang.$action}
                    <li class="breadcrumb-item active">
                        {$lang.$action}
                    </li>
                {/if}
            {elseif $cmd == 'profiles'}
                {if $action=='add'}
                    <li class="breadcrumb-item active">
                        {$lang.addnewprofile}
                    </li>
                {elseif $action=='edit'}
                    <li class="breadcrumb-item active">
                        {$lang.editcontact}
                    </li>
                {/if}
            {/if}

        </ol>
    {/if}
    <!-- End of Breadcrumbs -->
</nav>