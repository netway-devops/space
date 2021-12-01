{if $service}
    {include file='services/service_details.tpl'}
{else}
    <!-- for product cpanel:6 ,rvsitebuilder:8, rvskin:7 -->

    {if $cid==6 || $cid == 9}
    	{if $cid == 9}
    	    {include file='rvlicense/product_perpetual_btn.tpl'} 
			{php}
            	include_once $this->template_dir . 'rvlicense/services_product_perpetual_license.tpl.php';
        	{/php}
    	{else}
    	 	{php}
            	include_once $this->template_dir . 'rvlicense/services_product_license.tpl.php';
        	{/php}
    	{/if}
       
		{include file='rvlicense/services_product_license_footer.tpl.php'}
    {elseif $cid==8}
    <!--
	    <div class="service-box" style="width:90%;height:100%;padding:10px 10px 10px 10px;">
	       We are migrating license data to the new system. It will take a few days.In the meanwhile, <br /> 
	       please login on the old system at  <a href="https://member.rvskin.com/index_idn.php" target="_blank"> https://member.rvskin.com/index_idn.php</a> using your old login credential. 
	    </div>-->
        {include file='rvlicense/product_partner_btn.tpl'} 
        {php}
            include_once $this->template_dir . 'rvlicense/services_product_partner_license.tpl.php';
        {/php}
        <!--  {include file='rvlicense/services_product_license_footer.tpl.php'}-->
    {elseif $services}
        {if $custom_template}
            {include file=$custom_template}
        {else}
            {if $cid==1}
            <pre>
                {php}
                    include_once $this->template_dir . 'services/services_ssl.tpl.php';
                {/php}
            </pre>
            {/if}
			<p>This section is for your SSL Certificates. Under the column Product/Service, you will see the SSL for individual domains and server.</p>
            <div class="text-block clear clearfix"> <!-- Block A -->
                <div class="clear clearfix">
                    <div class="table-box">
                        <div class="table-header">
                            <p class="inline-block">
                                {if $action=='services' && $cid}
                                    {foreach from=$offer item=o}{if $action=='services' && $cid==$o.id}{$o.name}
                                        {/if}
                                    {/foreach}
                                {else}
                                    {$lang[$action]|capitalize}
                                {/if}
                            </p>
                        </div>
                        <a href="{$ca_url}clientarea&amp;action=services&amp;cid={$cid}" id="currentlist" style="display:none" updater="#updater"></a>
                        <table class="table table-striped table-hover">
                            <tr class="table-header-high">
                                <th class="w30"><a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=name|ASC">{$lang.service}</a></th>
                                <th class="w15"><a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=status|ASC">{$lang.status}</a></th>
                                    {if $action=='vps'}
                                    <th class="w15 cell-border">
                                        <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=domain|ASC">{$lang.hostname}</a>
                                    </th>
                                    <th>{$lang.ipadd}</th>
                                    {else}
                                    <th class="w15 cell-border">
                                        <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=total|ASC">{$lang.price}</a>
                                    </th>
                                    <th>
                                        <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=billingcycle|ASC">{$lang.bcycle}</a>
                                    </th>
                                {/if}
                                <th class="w15 cell-border">
                                    <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=next_due|ASC">{$lang.nextdue}</a>
                                </th>
                                <th class="w10 cell-border"></th>
                            </tr>
                            <tbody id="updater">

                                {include file='ajax/ajax.services.tpl'}

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>  <!-- Block A -->
        {/if}
        <div class="top-btm-padding">
            {if $cid}
                {foreach from=$offer item=oo}
                    {if $cid==$oo.id && $oo.visible=='1'}
                         {if $oo.name=='RV2Factor'}
                         <form method="post" action="{$ca_url}cart&cat_id={$cid}" style="display:inline-block;">
                            <button class="clearstyle btn green-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> {$lang.Upgrade} {$oo.name}</button>
                         </form>
                         {else}
                         <form method="post" action="{$ca_url}cart&cat_id={$cid}" style="display:inline-block;">
                            <button class="clearstyle btn green-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> {$lang.Add} {$oo.name}</button>
                         </form>
                         {/if}
                            {securitytoken}
                        
                        {/if}
                    {/foreach}
                {/if}
                {if $totalpages}
                <div class="pagination pagination-box">
                    <div class="right p19 pt0 no-margin">
                        <div class="pagelabel left ">{$lang.page}</div>
                        <div class="btn-group right" data-toggle="buttons-radio" id="pageswitch">
                            {section name=foo loop=$totalpages}
                                <button class="btn {if $smarty.section.foo.iteration==1}active{/if}">{$smarty.section.foo.iteration}</button>
                            {/section}
                        </div>
                        <input type="hidden" id="currentpage" value="0" />
                    </div>
                </div>
            {/if}
        </div>
    {else}
        <div class="text-block clear clearfix">
			<p>Manage your RV2Factor from this section. Learn more about RV2Factor from <br /><a href="https://rvglobalsoft.com/rv2factor/">www.rvglobalsoft.com/rv2factor.</a> </p>
            <h5>{$lang[$action]|capitalize}</h5>
            <div class="clear clearfix">
                <center>
                    <strong>{$lang.nothing}</strong>
                </center>
                {if $cid}
                    {foreach from=$offer item=oo}
                        {if $cid==$oo.id && $oo.visible=='1'}
                            <form method="post" action="{$ca_url}cart&cat_id={$cid}">
                                <button class="clearstyle btn green-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> {$lang.Add} {$oo.name}</button>
                                {securitytoken}
                            </form>
                        {/if}
                    {/foreach}
                {/if}
            </div>
        </div>
    {/if}
{/if}