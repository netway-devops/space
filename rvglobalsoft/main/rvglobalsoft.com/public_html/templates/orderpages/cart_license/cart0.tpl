<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}cart_license/style.css" />

{php}
    $templatePath = $this->get_template_vars('template_path');
    include(dirname($templatePath) . '/orderpages/cart_license/cart0.tpl.php');
{/php}

	<div class="container">
		<h2>Price &amp; Order</h2>

 		<div> 
        	<h2 class="line-title"><span>Web Server Control Panel</span></h2>
            <div class="row-fluid">
                <div class="price-product">
                	<div class="span4 acenter"></div>
                    <div class="span4">
                    	<div class="block">
                        	<div><img src="{$orderpage_dir}cart_license/images/logo-cpanel.gif" alt="cpanel" width="183" height="54" /></div>
                            <div class="padbot"><span class="price">$15.95</span><span class="month">/monthly </span></div>
                            <div><a href="?cmd=cart&action=add&id=111" class="buy"><i class="fa fa-cart-plus"></i>  Buy now</a></div>
                        </div>
                    </div>
                    <div class="span2"></div>
                    <!--
                    <div class="span4">
                    	<div class="block">
                        	<div><img src="{$orderpage_dir}cart_license/images/logo-isp.gif" alt="isp" width="139" height="54" /></div>
                            <div class="padbot"><span class="price">$4.95</span><span class="month">/monthly </span></div>
                            <div><a href="?cmd=cart&action=add&id=135" class="buy"><i class="fa fa-cart-plus"></i>  Buy now</a></div>
                        </div>
                    </div>
                    -->
                </div> 
			</div>
         </div>
         
         <div class="clearit"></div>
         
         <div>
         	<h2 class="line-title"><span>Additional Products</span></h2>   
            <div class="row-fluid">
                <div class="price-product">
                    <!--
                	<div class="span4">
                    	<div class="block">
                        	<div><img src="{$orderpage_dir}cart_license/images/logo-litepeed.gif" alt="license" width="152" height="54" /></div>
                            <div class="padbot"><span class="price">$13.95</span><span class="month">/monthly </span></div>
                            <div><a href="?cmd=cart&action=add&id=138" class="buy"><i class="fa fa-cart-plus"></i>  Buy now</a></div>
                        </div>
                    </div>
                    -->
                    <div class="span4">
                    	<div class="block">
                        	<div><img src="{$orderpage_dir}cart_license/images/logo-soft.gif" alt="license" width="180" height="60" /></div>
                            <div class="padbot"><span class="price">$1.50</span><span class="month">/monthly </span></div>
                            <div><a href="?cmd=cart&action=add&id=145" class="buy"><i class="fa fa-cart-plus"></i>  Buy now</a></div>
                        </div>
                    </div>
                    <div class="span4">
                    	<div class="block">
                        	<div><img src="{$orderpage_dir}cart_license/images/logo-cloudlinux.gif" alt="cloudlinux" width="142" height="66" /></div>
                            <div class="padbot"><span class="price">$11.95</span><span class="month">/monthly </span></div>
                            <div><a href="?cmd=cart&action=add&id=116" class="buy"><i class="fa fa-cart-plus"></i>  Buy now</a></div>
                        </div>
                    </div>
                    <div class="span4">
                        <div class="block">
                            <div><img src="{$orderpage_dir}cart_license/images/virtualizor.gif" alt="virtualizor" width="246" height="50" /></div>
                            <br>
                            <div class="padbot"><span class="price">$9.00</span><span class="month">/monthly </span></div>
                            <div><a href="?cmd=cart&action=add&id=149" class="buy"><i class="fa fa-cart-plus"></i>  Buy now</a></div>
                        </div>
                    </div>
                </div> 
			</div>
		</div>
        
        <div>  
            <div class="row-fluid">
                <div class="price-product">
                	<div class="span2">
                    	
                    </div>
                	<div class="span4">
                    	<div class="block">
                        	<div><img src="{$orderpage_dir}cart_license/images/logo-rvskin.jpg" alt="rvskin" width="93" height="73" /></div>
                        	{if $isPartner != ''}
                            <div><a href="{$ca_url}clientarea/services/noc-licenses/" class="buy"><i class="fa fa-cart-plus"></i>  Issue license</a></div>
                            {else}
                            <div class="padbot"><span class="price">$2.95</span><span class="month">/monthly </span></div>
                            <div><a href="?cmd=cart&action=add&id=71" class="buy"><i class="fa fa-cart-plus"></i>  Buy now</a></div>
                            {/if}
                        </div>
                    </div>
                    <div class="span4">
                    	<div class="block">
                        	<div><img src="{$orderpage_dir}cart_license/images/logo-rvsb7.png" alt="rvsitbuilder" width="200" height="69" /></div>
                            {if $isPartner != ''}
                            <div><a href="{$ca_url}clientarea/services/noc-licenses/" class="buy"><i class="fa fa-cart-plus"></i> Issue license</a></div>
                            {else}
                            <div class="padbot"><span class="price">$15.00</span><span class="month">/monthly </span></div>
                            <div><a href="?cmd=cart&action=add&id=158" class="buy"><i class="fa fa-cart-plus"></i>  Buy now</a></div>
                            {/if}
                        </div>
                    </div>
                    <div class="span2">
                    	
                    </div>
                </div> 
			</div>
         </div>
         <!--
         <div>   
            <div class="row">
                <div class="price-product">
                	<div class="span4"></div>
                    <div class="span4">
                    	<div class="block">
                        	<div><img src="{$orderpage_dir}cart_license/images/virtualizor.gif" alt="virtualizor" width="246" height="50" /></div>
                            <br>
                            <div class="padbot"><span class="price">$9.00</span><span class="month">/monthly </span></div>
                            <div><a href="?cmd=cart&action=add&id=149" class="buy"><i class="fa fa-cart-plus"></i>  Buy now</a></div>
                        </div>
                    </div>
                    <div class="span4"></div>
                </div> 
			</div>
		</div>
		-->
    <!--   
	<div class="price-product">	
        <div class="bg2factor">  
            <div class="container">
            	<div class="span2"><img src="{$orderpage_dir}cart_license/images/spacer.gif" alt="" width="1" height="1" /></div>
                <div class="block span8">
                    <div class="span4 linedash"><img src="{$orderpage_dir}cart_license/images/2factor.jpg" alt="2factor" width="224" height="175" /></div>
                    <div class="span3">
                        <div>
                            <div><img src="{$orderpage_dir}cart_license/images/logo-2factor.gif" alt="rv2factor" width="212" height="66" /></div>
                            <div class="padbot"><span class="price">$3.00</span><span class="month">/monthly </span></div>
                            <div><a href="?cmd=cart&action=add&id=58" class="buy"><i class="fa fa-cart-plus"></i> Buy now</a></div>
                        </div>
                     </div>
                 </div>
                 <div class="span2"><img src="{$orderpage_dir}cart_license/images/spacer.gif" alt="" width="1" height="1" /></div>
            </div>
        </div>
     </div> 
     -->
</div>




       
<div class="row" style="display:none;">
    <div class="span5">
        <h3>Server Related</h3>
        <hr>
        
        <h3>Control Panel</h3>
        <ul class="unstyled">
            <li>
                <h4>
                    <a class="text-info" href="?cmd=cart&action=add&id=64">cPanel</a>
                    <span class="label">$15.95 / month</span>
                    <a class="btn btn-inverse pull-right" href="?cmd=cart&action=add&id=64">Buy now</a>
                </h4>
            </li>
            <li>
                <h4>
                    <a class="text-info" href="?cmd=cart&action=add&id=135">ISPManager</a>
                    <span class="label">$4.95 / month</span>
                    <a class="btn btn-inverse pull-right" href="?cmd=cart&action=add&id=135">Buy now</a>
                </h4>
            </li>
        </ul>
        <hr>
        
        <h3>Additional Product</h3>
        <ul class="unstyled">
            <li>
                <h4>
                    {if $isPartner != ''}
                    <a class="text-info" href="#">RVSkin</a>
                    <a class="btn btn-inverse pull-right" href="#">Issue license</a>
                    {else}
                    <a class="text-info" href="?cmd=cart&action=add&id=71">RVSkin</a>
                    <span class="label">$2.95 / month</span>
                    <a class="btn btn-inverse pull-right" href="?cmd=cart&action=add&id=71">Buy now</a>
                    {/if}
                </h4>
            </li>
            <li>
                <h4>
                    {if $isPartner != ''}
                    <a class="text-info" href="#">RVSiteBuilder</a>
                    <a class="btn btn-inverse pull-right" href="#">Issue license</a>
                    {else}
                    <a class="text-info" href="?cmd=cart&action=add&id=67">RVSiteBuilder</a>
                    <span class="label">$6.00 / month</span>
                    <a class="btn btn-inverse pull-right" href="?cmd=cart&action=add&id=67">Buy now</a>
                    {/if}
                </h4>
            </li>
            <li>
                <h4>
                    <a class="text-info" href="?cmd=cart&action=add&id=116">CloudLinux</a>
                    <span class="label">$11.95 / month</span>
                    <a class="btn btn-inverse pull-right" href="?cmd=cart&action=add&id=116">Buy now</a>
                </h4>
            </li>
            <li>
                <h4>
                    <a class="text-info" href="?cmd=cart&action=add&id=138">LiteSpeed</a>
                    <span class="label">$13.95 / month</span>
                    <a class="btn btn-inverse pull-right" href="?cmd=cart&action=add&id=138">Buy now</a>
                </h4>
            </li>
            <li>
                <h4>
                    <a class="text-info" href="?cmd=cart&action=add&id=145">Softaculous</a>
                    <span class="label">$1.50 / month</span>
                    <a class="btn btn-inverse pull-right" href="?cmd=cart&action=add&id=145">Buy now</a>
                </h4>
            </li>
        </ul>
    </div>
    
    <div class="span5 offset1">
        <h3>Integrated Softwares</h3>
        <hr>
        
        <h3>Security</h3>
        <ul class="unstyled">
            <li>
                <h4>
                    <a class="text-info" href="?cmd=cart&action=add&id=58">RV2factor</a> 
                    <span class="label">Free</span>
                    <a class="btn btn-inverse pull-right" href="?cmd=cart&action=add&id=58">Buy now</a>
                </h4>
            </li>
            <li>
                <h4>
                    <a class="text-info" href="?cmd=cart&action=add&id=108">RVLogin</a> 
                    <span class="label">Free</span>
                    <a class="btn btn-inverse pull-right" href="?cmd=cart&action=add&id=108">Buy now</a>
                </h4>
            </li>
        </ul>
        <hr>
        
        <h3>Billing System</h3>
        <ul class="unstyled">
            <li>Comming soon</li>
        </ul>
        
    </div>
    
</div>

{literal}

<style>
@media (min-width: 1600px) {
    .container { 
        min-width:1360px;
    }
}
</style>

{/literal}
