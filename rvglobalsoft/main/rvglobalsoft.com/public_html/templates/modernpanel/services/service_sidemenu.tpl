<aside class="shared-hosting-menu">
    <div class="header">
        <p>{$lang.menu}</p>
    </div>
    <ul class="nav">

        <li {if !$widget}class="active"{/if}>
            <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">
                <i class="icon-sh-details"></i> 
                <p>{$lang.servicedetails}</p>
            </a>
            <div class="c-border">
                <span></span>
            </div>
            <div class="bg-fix"></div>
        </li>

        {if $service.status=='Active'}
            {foreach from=$widgets item=widg}
                <li {if $widget.name==$widg.name}class="active"{/if}>
                    <a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}">
                        <i>
                            <img src="{$system_url}{$widg.config.smallimg}" alt="" />
                        </i>
                        <p>
                            {assign var=widg_name value="`$widg.name`_widget"}
                            {if $lang[$widg_name]}
                                {$lang[$widg_name]}
                            {elseif $lang[$widg.name]}
                                {$lang[$widg.name]}
                            {elseif $widg.fullname}
                                {$widg.fullname}
                            {else}
                                {$widg.name}
                            {/if}
                        </p>
                    </a>
                    <div class="c-border">
                        <span></span>
                    </div>
                    <div class="bg-fix"></div>
                </li>
            {/foreach}
        {/if}


        {if $service.status=='Active' && $service.isvpstpl}
            {if $commands.RebuildOS} 	
                <li>
                    <a href="#" onclick="return callcustomfn('RebuildOS',{$service.id}, '#_rebuild', true)">
                        <i class="icon icon-cog"></i> 
                        <p >{$lang.reload_os}</p>
                    </a>
                    <div class="c-border">
                        <span></span>
                    </div>
                    <div class="bg-fix"></div>
                </li>
            {/if}
            {if $commands.Backup}	
                <li>
                    <a class="tchoice" href="#">
                        <i class="icon icon-cog"></i> 
                        <p >{$lang.backup}</p>
                    </a>
                    <div class="c-border">
                        <span></span>
                    </div>
                    <div class="bg-fix"></div>
                </li>
            {/if}
            {if $commands.ResetRootPassword} 	
                <li>
                    <a onclick="return process('ResetRootPassword',{$service.id}, '#_rootp')" href="#">
                        <i class="icon icon-cog"></i> 
                        <p >{$lang.reset_root}</p>
                    </a>
                    <div class="c-border">
                        <span></span>
                    </div>
                    <div class="bg-fix"></div>
                </li>
            {/if}
            {if ($commands.Statistics)}	
                <li>
                    <a  href="#" onclick="return callcustomfn('Statistics',{$service.id}, '#_stats')">
                        <i class="icon icon-cog"></i> 
                        <p >{$lang.Statistics}</p>
                    </a>
                    <div class="c-border">
                        <span></span>
                    </div>
                    <div class="bg-fix"></div>
                </li>
            {/if}
            {if ($commands.Console)}	
                <li>
                    <a  href="#" onclick="return callcustomfn('Console',{$service.id}, '#_console')">
                        <i class="icon icon-cog"></i> 
                        <p >{$lang.Console}</p>
                    </a>
                    <div class="c-border">
                        <span></span>
                    </div>
                    <div class="bg-fix"></div>
                </li>
            {/if}
        {/if}


        {if $service.status=='Active'}
            {foreach from=$commands item=command}
                {if $service.isvpstpl && ($command=='RebuildOS' || $command=='Backup' || $command=='ResetRootPassword' || $command=='Statistics' || $command=='Console' || $command=='GetStatus'  || $command=='Stop'  || $command=='Start'  || $command=='Reboot' || $command=='Shutdown'  || $command=='FastStat' || $command=='PowerON' || $command=='PowerOFF' || $command=='Destroy' || $command=='VMDetails')}

                {else}
                    <li>
                        <a href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&customfn={$command}" onclick="return callcustomfn('{$command}',{$service.id}, '#_ocustom', true)">
                            <i class="icon icon-cog"></i> 
                            <p >{if $lang.$command}{$lang.$command}{else}{$command}{/if}</p>
                        </a>
                        <div class="c-border">
                            <span></span>
                        </div>
                        <div class="bg-fix"></div>
                    </li>
                {/if}

            {/foreach}
        {/if}


        {if $enableFeatures.dnsmanagement!='off' && $dnsmodule_id}
            <li><a href="{$ca_url}module&amp;module={$dnsmodule_id}">
                    <i class="icon icon-cog"></i> 
                    <p>{$lang.mydns}</p>
                </a>
                <div class="c-border">
                    <span></span>
                </div>
                <div class="bg-fix"></div>
            </li>
        {/if}

        {foreach from=$haveaddons item=newaddon}
            <li>
                <a class="no-restriction" href="{$ca_url}cart&amp;action=add&amp;cat_id=addons&amp;id={$newaddon.id}&amp;account_id={$service.id}&amp;addon_cycles[{$newaddon.id}]={$newaddon.paytype}">	
                    <i class="icon icon-cog"></i> 
                    <p class="plus">{$lang.Add} {$newaddon.name}</p>
                </a>
                <div class="c-border">
                    <span></span>
                </div>
                <div class="bg-fix"></div>
            </li>
        {/foreach}


        {if $service.status!='Terminated' && $service.status!='Cancelled'}
            <li class="last">
                <a href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel">
                    <i class="icon icon-remove"></i> 
                    <p class="cancellation">{$lang.cancelrequest}</p>
                </a>
                <div class="c-border">
                    <span></span>
                </div>
                <div class="bg-fix"></div>
            </li>
        {/if}
    </ul>
</aside>

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


