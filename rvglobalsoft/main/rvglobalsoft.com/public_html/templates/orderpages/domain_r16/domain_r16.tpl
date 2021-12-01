{* @@author:: HostBill team
@@name:: Domain Cart
@@type:: domain
@@configfile:: config.yml
@@description:: Offers domain registration and transfer, in bulk and single mode. 
@@thumb:: thumb.png
@@img:: preview.png 
*}
<link href="{$orderpage_dir}domain_r16/css/font-awesome.min.css" media="all" type="text/css" rel="stylesheet" />
<link href="{$orderpage_dir}domain_r16/css/domains.css" media="all" type="text/css" rel="stylesheet" />
<script src="templates/common/js/cart.js"></script>
<script src="{$orderpage_dir}domain_r16/js/autosize.js"></script>
<script src="{$orderpage_dir}domain_r16/js/handlebars.js"></script>
<script src="{$orderpage_dir}domain_r16/js/jquery.lazy.js"></script>
<script src="{$orderpage_dir}domain_r16/js/domains.js"></script>
{literal}
    <script type="text/javascript">
        HBCart.init({/literal}{$cart|@json_encode}{literal}, {
            url: {/literal}'{$system_url}'{literal},
            categoryId: {/literal}'{$domain_cat}'{literal},
        })
    </script>
{/literal}
<div id="orderpage">
    <div class="domain-header">

        <div class="domain-search">
            <h1 class="mode mode-register">{$lang.findrightdomainname}</h1>    
            <h1 class="mode mode-transfer">{$lang.transferyourdomain}</h1>
            <div class="domain-input">
                <button class="domain-search-btn">{$lang.search}</button>
                <div class="domain-textarea">
                    <textarea rows="1" placeholder="{$lang.enteryourdesireddomainname}"
                              data-mode-register="{$lang.enteryourdesireddomainname}"
                              data-mode-transfer="{$lang.enterdomaintotransfer}">{$searchtext}</textarea>
                </div>
            </div>
            <div class="domain-modes">
                <a href="#register" class="mode-register">{$lang.bulksearch}</a>
                <a href="#transfer" class="mode-transfer">{$lang.transdomain}</a>
            </div>
        </div>
    </div>
    {literal}
        <script id="result-row-data" type="text/x-handlebars-template">
            <div class="result-data">
                <div class="result-hostname" title="{{hostname}}">
                    <span class="result-sld min">{{dots sld tld 25}}</span>
                    <span class="result-sld mid max">{{dots sld tld 50}}</span>
                    <span class="result-tld">{{tld}}</span>
                    {{#eq status ''}}
                    <a href="#whois/{{hostname}}" class="result-whois-link">whois</a>
                    {{/eq}}
                </div>
                {{#if price}}
                    <div class="result-price">
                        <span class="price-amount">{{$ price.price}}</span>
                        <span class="price-period">{{price.title}}</span>
                    </div>
                {{else}}
                    <div class="result-price empty"></div>
                {{/if}}
            </div>
            <div class="result-actions">
                {{#if premium}}
                <label class="label">{/literal}{$lang.premium}{literal}</label>
                {{/if}}
                {{#if canRegister}}
                <a class="result-button domain-register"> {/literal}{$lang.register}{literal}</a>
                {{else if canTransfer}}
                <a class="result-button domain-transfer"> {/literal}{$lang.transfer}{literal}</a>
                {{else eq status -1}}
                <a class="result-button domain-loading"></a>
                {{else}}
                <a class="result-button domain-noaction"> {/literal}{$lang.Unavailable}{literal} </a>
                {{/if}}
                <div class="result-incart">
                    <a href="#remove" class="result-remove">{/literal}{$lang.removefromcart}{literal}</a>
                    <a href="#cart" class="result-button result-cart" title="Continue">
                        <span class="max">
                        <i class="fa fa-shopping-cart"></i>
                        <span class="cart-cnt">{{@domains}}</span>
                        </span>
                        <span class="min mid">{/literal}{$lang.continue}{literal}</span>
                    </a>
                </div>
            </div>
        </script>
        <script id="result-row" type="text/x-handlebars-template">
            <li class="result-row {{#if lazy}}lazy{{/if}} {{#if inCart}}active{{/if}}" id="{{htmlId}}" data-id="{{@key}}" data-loader="whois">
            {{> resultRowData }}
            </li>
        </script>
        <script id="result-group" type="text/x-handlebars-template">
            {{#each items}}
            <div class="result-query">{/literal}{$lang.resultsfor}{literal}: <span class="result-query-text">{{query}}</span></div>

            <ul class="result-group" data-id="{{@key}}">
            {{#each display}} 
            {{> resultRow }}
            {{/each}}
            </ul>
            {{/each}}
        </script>
    {/literal}
    <div class="domain-search-results"></div>
    <div class="domain-order">
        <a href="{$system_url}{$ca_url}cart/&cat_id=domains" class="hidden" id="order-submit"></a>
        <a href="#order" class="result-button result-cart">
            <i class="fa fa-shopping-cart"></i> 
            <span class="cart-cnt">{$cart.domains|@count}</span>
            <span class="cart-order-txt">{$lang.orderselecteddomains}</span>
        </a>
    </div>

    {if $category.opconfig.spotlight}
        {include file="domain_r16/widgets/spotlight.tpl"}
    {/if}

    {if $category.opconfig.custdescription}
        {include file="domain_r16/widgets/description.tpl"}
    {/if}

    {if $category.opconfig.pricing}
        {include file="domain_r16/widgets/pricing.tpl"}
    {/if}
</div>
