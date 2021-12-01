<script type="text/javascript">loadelements.clients = true;</script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td ><h3>{if $action!='configuration'}{$lang.Affiliates}{else}{$lang.affconfig}{/if}</h3></td>
        <td  ></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=newclient"  class="tstyled btn btn-success"><strong>{$lang.registernewcustomer}</strong></a><br />
            <a href="?cmd=clients"  class="tstyled">{$lang.managecustomers}</a> 
            <a href="?cmd=clients&list=active"  class="tstyled tsubit ">{$lang.Active}</a>
            <a href="?cmd=clients&list=closed"  class="tstyled tsubit ">{$lang.Closed}</a>
            <a href="?cmd=clients&action=groups"  class="tstyled ">Client Groups</a>
            <a href="?cmd=clients&action=fields"  class="tstyled">{$lang.customerfields}</a>

            <br />
            <a href="?cmd=affiliates"  class="tstyled  {if $action=='affiliate' || $action=='withdrawals' || $action=='queue' || $action=='statistics' || $action=='commissions' || $action=='default' || !$action}selected{/if}">{$lang.Affiliates}</a>
            <a href="?cmd=affiliates&action=configuration"  class="tstyled {if $action=='configuration' || $action=='commision' || $action=='campaigns' || $action=='campaign'}selected{/if}">{$lang.affconfig}</a>
        </td>   
        <td  valign="top"  class="bordered">
            {if $action=='affiliate'}   
                {include file="affiliates/affiliate.tpl"}
            {else}
                <div id="bodycont">
                    {include file="affiliates/default_header.tpl"}
                    {if $action=='default'}
                        {include file="affiliates/default.tpl"}
                    {elseif $action=='commissions'}
                        {include file="affiliates/commissions.tpl"}
                    {elseif $action=='withdrawals'}
                        {include file="affiliates/withdrawals.tpl"}
                    {elseif $action=='queue'}
                        {include file="affiliates/queue.tpl"}
                    {elseif $action=='statistics'}
                        {include file="affiliates/statistics.tpl"}
                    {elseif $action=='configuration'}
                        {include file="affiliates/configuration.tpl"}
                    {elseif $action=='commision'}
                        {include file="affiliates/plan.tpl"}
                    {elseif $action=='vouchers'}
                        {include file="affiliates/vouchers.tpl"}
                    {elseif $action=='campaigns'}
                        {include file="affiliates/campaigns.tpl"}
                    {elseif $action=='campaign'}
                        {include file="affiliates/campaign.tpl"}
                    {/if}
                </div>
            {/if}
        </td>
    </tr>
</table>