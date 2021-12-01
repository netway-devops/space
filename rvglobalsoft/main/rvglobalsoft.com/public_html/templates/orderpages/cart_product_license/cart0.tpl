{php}
    $templatePath = $this->get_template_vars('template_path');
    include(dirname($templatePath) . '/orderpages/cart_product_license/cart0.tpl.php');
{/php}

<h2>Price &amp; Order</h2>
<hr />

<div class="row">
    <div class="span5">
        <h3>Server Related</h3>
        <hr />
        
        <h3>Control Panel</h3>
        <ul class="unstyled">
            {foreach from=$aProducts key="group" item="aProduct"}
                {if $group == 'Control Panel'}
                    {foreach from=$aProduct key="slug" item="arr"}
                        <li>
                            <h4><a href="{$ca_url}cart/{$currentSlug}/&product={$slug}" class="text-info">{$arr.name}</a> 
                            <!--<a href="#productModal" onclick="loadProductInfo('{$slug}');" data-toggle="modal"><i class="icon-info-sign"></i></a>-->
                            <span class="label">{$arr.price}</span>
                            <a href="{$ca_url}cart/{$currentSlug}/&product={$slug}" class="btn btn-inverse pull-right">Buy now</a></h4>
                        </li>
                    {/foreach}
                {/if}
            {/foreach}
        </ul>
        
        <hr />
        
        <h3>Additional Product</h3>
        <ul class="unstyled">
            {foreach from=$aProducts key="group" item="aProduct"}
                {if $group == 'Additional Product'}
                    {foreach from=$aProduct key="slug" item="arr"}
                        <li>
                            {if (($slug == 'rvskin' || $slug == 'rvsitebuilder') && $isPartner != '')}
                            <h4>{$arr.name}
                            <span class="muted pull-right">Issue license</span></h4>
                            {else}
                            <h4><a href="{$ca_url}cart/{$currentSlug}/&product={$slug}" class="text-info">{$arr.name}</a> 
                            <!--<a href="#productModal" onclick="loadProductInfo('{$slug}');" data-toggle="modal"><i class="icon-info-sign"></i></a>-->
                            <span class="label">{$arr.price}</span>
                            <a href="{$ca_url}cart/{$currentSlug}/&product={$slug}" class="btn btn-inverse pull-right">Buy now</a></h4>
                            {/if}
                        </li>
                    {/foreach}
                {/if}
            {/foreach}
        </ul>
        
    </div>
    <div class="span5 offset1">
        <h3>Integrated Softwares</h3>
        <hr />
        
        <h3>Security</h3>
        <ul class="unstyled">
            {foreach from=$aProducts key="group" item="aProduct"}
                {if $group == 'Security'}
                    {foreach from=$aProduct key="slug" item="arr"}
                        <li>
                            <h4><a href="{$arr.url}#{$ca_url}cart/{$currentSlug}/&product={$slug}" class="text-info">{$arr.name}</a> 
                            <!--<a href="#productModal" onclick="loadProductInfo('{$slug}');" data-toggle="modal"><i class="icon-info-sign"></i></a>-->
                            <span class="label">{$arr.price}</span>
                            <a href="{$arr.url}#{$ca_url}cart/{$currentSlug}/&product={$slug}" class="btn btn-inverse pull-right">Buy now</a></h4>
                        </li>
                    {/foreach}
                {/if}
            {/foreach}
        </ul>
        
        <hr />
        
        <h3>Billing System</h3>
        <ul class="unstyled">
            <li>Comming soon</li>
            <!--
            {foreach from=$aProducts key="group" item="aProduct"}
                {if $group == 'Billing System'}
                    {foreach from=$aProduct key="slug" item="arr"}
                        <li>
                            <h4><a href="{$ca_url}cart/{$currentSlug}/&product={$slug}" class="text-info">{$arr.name}</a> 
                            <a href="#productModal" onclick="loadProductInfo('{$slug}');" data-toggle="modal"><i class="icon-info-sign"></i></a>
                            <span class="label">{$arr.price}</span>
                            <a href="{$ca_url}cart/{$currentSlug}/&product={$slug}" class="btn btn-inverse pull-right">Buy now</a></h4>
                        </li>
                    {/foreach}
                {/if}
            {/foreach}
            -->
        </ul>
        
    </div>
</div>

