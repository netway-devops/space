{if $vpsdo=='upgrade'}
    {include file="`$onappdir`header.cloud.tpl"}
    {include file="`$onappdir`upgrade.tpl"}
    {include file="`$onappdir`footer.cloud.tpl"}

{else}

    {include file="`$onappdir`header.cloud.tpl"}
    <div class="header-bar">
        <h3 class="resources hasicon">{$lang.reslabel}</h3>

        <div class="clear"></div>
    </div>
    <div class="content-bar section-resources">
        <div class="notice">{$lang.resnotice} </div>
        <table cellspacing="0" cellpadding="0" width="100%" class="ttable cloud-resources">
            <thead>
            <tr>
                <th class="name md-show-block md-hide-bottom" width="120"></th>
                <th class="usage md-show-block md-hide-top">{$lang.Usage}</th>
                <th class="total" width="120">{$lang.Totallabel}</th>
                <th class="total-left" width="120">{$lang.Leftlabel}</th>
            </tr>
            </thead>
            <tbody>
            {foreach from=$stats item=stat}
                <tr>
                    <td class="name md-show-block md-hide-bottom"><b>{$lang[$stat.lang]|default:$stat.name}</b></td>
                    <td class="usage md-show-block md-hide-top" >
                        <div class="progress-bar">
                            <div class="bar {if $stat.percent>90}red{else}green{/if}" style="width:{$stat.percent}%"></div>
                        </div>
                    </td>
                    <td class="bigger total">{$stat.avail} {$stat.unit}</td>
                    <td class="bigger total-left">{$stat.free} {$stat.unit}</td>
                </tr>
            {/foreach}
            </tbody>
        </table>
        <div class="btn-group-cloud">
            <a href="{$service_url}&vpsdo=upgrade" class="btn btn-primary">{$lang.UpgradeDowngrade}</a>
        </div>
    </div>

    {include file="`$onappdir`footer.cloud.tpl"}

{/if}