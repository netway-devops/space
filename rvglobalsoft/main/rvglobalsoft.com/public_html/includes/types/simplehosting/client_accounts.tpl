<link media="all" type="text/css" rel="stylesheet" href="{$system_url}includes/types/simplehosting/css/styles.css" />
<div class="bordered-section" style="padding: 0 7px 0 0">
    <div id="leftcol" class="left left-content">
        <h2><b>{$service.name}</b></h2>
        <span class="domaininfo">{$service.domain}</span>
        <ul class="leftmenu">
            <li class="{if !$widget}current{/if}">
                <a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">
                    <span class="home">{$lang.accdetails}</span>
                </a>
            </li>
            {if $service.status=='Active'} 
                {foreach from=$widgets item=widg}
                    {if $widg.group=='apps' || $widg.name=='diskbandusage'}{continue}
                    {/if}
                    <li class="{if $widget && $widget.name==$widg.name}current{/if}"><a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}">
                            <span class="{$widg.name}">
                                <img src="{$system_url}{$widg.config.smallimg}" alt="" />
                                {if $widg.newname!=$widg.fullname}
                                    {$widg.name}
                                {elseif $lang[$widg.name]}{$lang[$widg.name]}
                                {elseif $widg.fullname}{$widg.fullname}
                                {else}{$widg.name}
                                {/if}
                            </span>
                        </a>
                    </li>
                {/foreach}
            {/if}
        </ul>

        {if $service.status=='Active' && $bdstats}
            {foreach from=$widgets item=widg}
                {if $widg.name=='diskbandusage'}
                    <div class="clear"></div> 
                    <div class="dbu ">
                        <span class="{$widg.name}">{if $lang[$widg.name]}{$lang[$widg.name]}{elseif $widg.fullname}{$widg.fullname}{else}{$widg.name}{/if}</span>

                        {if $bdstats.bandwidth}
                            <div class="bcontnet">
                                <span class="left">{$lang.monthlybandwidth}</span> <span class="right">{$bdstats.bandwidth.usage} / {if $bdstats.bandwidth.limit=='unlimited'}&#8734;{else}{$bdstats.bandwidth.limit}MB{/if}</span>
                                <div class="clear"></div>
                                <div style="" class="progress-container">
                                    <div style="width:{$bdstats.bandwidth.ratio}%" class="progress-content"></div>
                                </div>
                            </div>
                        {/if}
                        {if $bdstats.disk} 
                            <div class="bcontnet">
                                <span class="left">{$lang.diskspaceusage}</span> <span class="right"> {$bdstats.disk.usage} / {if $bdstats.disk.limit=='unlimited'}&#8734;{else}{$bdstats.disk.limit}MB{/if}</span>
                                <div class="clear"></div>
                                <div style="" class="progress-container">
                                    <div style="width:{$bdstats.disk.ratio}%" class="progress-content"></div>
                                </div>
                            </div>
                        {/if}
                    </div>
                {/if} 
            {/foreach}
        {/if}
    </div>

    <div id="rightcol" class="left right-content">
        <div class="nbreadcrumb" style="clear:right">
            {$lang.yourehere}:
            <a href="{$ca_url}clientarea/">{$lang.clientarea}</a> &raquo;<a href="{$ca_url}clientarea/services/{$service.slug}/">{$service.catname}</a>

            {if $widget}&raquo; <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">{$service.name}</a> 
                &raquo; {if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if} 
            {else}
                &raquo; {$service.name}
            {/if}
        </div>
        {if !$widget.replacetpl && !$widget.appendtpl &&  $service.status=='Active'}
            <div class="icons">
                {foreach from=$widgets item=widg}
                    {if $widg.group=='apps'}
                        <h2>{$lang.apps}</h2>{break}
                    {/if}
                {/foreach}
                <ul>
                    {foreach from=$widgets item=widg}
                        {if $widg.group=='apps'}<li>
                                <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}">
                                    <img src="{$system_url}{$widg.config.bigimg}" alt="">
                                    <span>{if $widg.newname!=$widg.fullname}{$widg.name}
                                    {elseif $lang[$widg.name]}{$lang[$widg.name]}
                                    {elseif $widg.fullname}{$widg.fullname}
                                    {else}{$widg.name}
                                    {/if}
                                </span>
                            </a>
                        </li> {/if}
                    {/foreach}
                </ul>
            </div>
        {/if}

        {if $widget.appendtpl }
            {include file=$widget.appendtpl}
        {/if}

        {if $widget.replacetpl}
            {include file=$widget.replacetpl}
        {elseif !$widget.appendtpl}
            <div class="wbox"  id="billing_info" >
                <div class="wbox_header">
                    {$lang.accdetails}
                </div>
                <div class="wbox_content">
                    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker table table-striped">
                        {include file='service_billing.tpl'}
                    </table>
                </div>
            </div>
            {if $addons}
                <div class="wbox">
                    <div class="wbox_header">
                        {$lang.accaddons|capitalize}
                    </div>

                    <div class="wbox_content">
                        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">

                            <tr>
                                <td colspan="2" style="border:none">
                                    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
                                        <colgroup class="firstcol"></colgroup>
                                        <colgroup class="alternatecol"></colgroup>
                                        <colgroup class="firstcol"></colgroup>
                                        <colgroup class="alternatecol"></colgroup>
                                        <tbody>
                                            <tr>
                                                <th width="40%" align="left">{$lang.addon}</th>
                                                {if $service.showbilling} <th align="left">{$lang.price}</th>
                                                    <th>{$lang.nextdue}</th>
                                                    <th >{$lang.status}</th>
                                                {/if}
                                            </tr>
                                            {foreach from=$addons item=addon name=foo}
                                                <tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if}>
                                                    <td>{$addon.name} 
                                                        {if $addon.info && $addon.status == 'Active'}
                                                            <a href="" onclick="showAddonInfo(this,{$addon.id}); return false;" style="color: red; font-size: 11px">{$lang.moreinfo}</a>
                                                        {/if}
                                                    </td>
                                                    {if $service.showbilling}
                                                        <td>{$addon.recurring_amount|price:$currency}</td>
                                                        <td align="center">{$addon.next_due|dateformat:$date_format}</td>
                                                        <td align="center" ><span class="{$addon.status}">{$lang[$addon.status]}</span></td>{/if}
                                                    </tr>
                                                    {if $addon.info && $addon.status == 'Active'}
                                                        <tr class="addoninfo_r{$addon.id} {if $smarty.foreach.foo.index%2 == 0} even{/if}" style="display:none">
                                                            <td colspan="4"> <div style="padding: 10px">
                                                                    {$addon.info|replace:'"':"'"|nl2br}</div>
                                                            </td>
                                                        </tr>
                                                    {/if}
                                                    {/foreach}
                                                    </tbody>
                                                </table>
                                                {if $service.status!='Fraud' && $service.status!='Cancelled' && $service.status!='Terminated'}
                                                    {$service.id|string_format:$lang.clickaddaddons}
                                                {/if}
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            {literal}
                                <script type="text/javascript">
                                
                function showAddonInfo(elem,id) {
                    if($('.addoninfo_r'+id).hasClass('shown')) {
                        $('.addoninfo_r'+id).removeClass('shown').hide();
                        $(elem).html('{/literal}{$lang.moreinfo}{literal}');}
                    else {
                        $('.addoninfo_r'+id).addClass('shown').show();
                        $(elem).html('{/literal}{$lang.hide}{literal}');
                    }
                }
                                </script>
                            {/literal}
                            {elseif $haveaddons && $service.status!='Fraud' && $service.status!='Cancelled' && $service.status!='Terminated'}
                                <div class="wbox">
                                    <div class="wbox_header">
                                        <strong>{$lang.accaddons|capitalize}</strong>
                                    </div>
                                    <div class="wbox_content">
                                        {$service.id|string_format:$lang.clickaddaddons}
                                    </div>
                                </div>
                                {/if}
                            {/if}
                            </div>
                            <div style="clear:both"></div>
                            <script type="text/javascript">
                                if($('#rightcol').height() < $('#leftcol').outerHeight() )
                                    $('#rightcol').height($('#leftcol').outerHeight()-30);
                            </script>
                        </div>
                        <div class="clear"></div>