<script src="templates/common/js/cart.js"></script>
<script src="{$orderpage_dir}cart_2019wizard/js/handlebars.js"></script>
<script src="{$orderpage_dir}cart_2019wizard/js/jquery.lazy.js"></script>
<script src="{$orderpage_dir}cart_2019wizard/js/domains.js"></script>
{literal}
    <script type="text/javascript">
        HBCart.init({/literal}{$cart|@json_encode}{literal}, {
            url: {/literal}'{$system_url}'{literal},
            categoryId: {/literal}'{$cart.category.id}'{literal},
        })
    </script>
{/literal}
<div class="orderpage orderpage-cart_2019wizard">
{literal}
    <script id="result-row-data" type="text/x-handlebars-template">
        <div class="result-data">
            <div class="result-hostname font-weight-bold d-flex flex-row align-items-center" title="{{hostname}}">
                <span class="result-sld mid max">{{dots sld tld 50}}</span>
                <span class="result-tld">{{tld}}</span>
                {{#if price}}
                    <div class="result-price mx-4">
                        <span class="price-amount text-primary ">{{$ price.price}}</span>
                        <span class="price-period text-muted small">{{price.title}}</span>
                    </div>
                {{else}}
                    <div class="result-price empty"></div>
                {{/if}}
                {{#eq status ''}}
                    <a href="#whois/{{hostname}}" class="result-whois-link ml-2 small">whois</a>
                {{/eq}}
            </div>
        </div>
        <div class="result-actions d-flex flex-row align-items-center">
            <div class="mr-5">
                {{#if premium}}
                    <label class="badge text-danger mr-3">{/literal}{$lang.premium}{literal}</label>
                {{/if}}
            </div>
            <div class="result-row-details" data-sld="{{sld}}" data-tld="{{tld}}" data-period="{{price.period}}">
                {{#if canRegister}}
                    <div class="btn-group-toggle" data-toggle="buttons">
                      <label class="result-button btn btn-outline-primary btn-border1px btn-rounded btn-sm domain-register">
                        <input type="checkbox" autocomplete="off">
                        <i class="material-icons size-sm mr-2">shopping_cart</i>
                        {/literal}{$lang.register}{literal}
                      </label>
                    </div>
                {{else if canTransfer}}
                    <div class="btn-group-toggle" data-toggle="buttons">
                      <label class="result-button btn btn-outline-primary btn-border1px btn-rounded btn-sm domain-transfer">
                        <input type="checkbox" autocomplete="off">
                        <i class="material-icons size-sm mr-2">compare_arrows</i>
                        {/literal}{$lang.transfer}{literal}
                      </label>
                    </div>
                {{else eq status -1}}
                    <a href="#" class="result-button btn btn-sm btn-outline-primary btn-border1px btn-rounded disabled domain-loading btn-sm">
                        <div class="cart_preloader">
                            <div class="cart_preloader_line bg-primary"></div>
                            <div class="cart_preloader_line bg-primary"></div>
                            <div class="cart_preloader_line bg-primary"></div>
                        </div>
                    </a>
                {{else}}
                    <a href="#" class="result-button btn btn-sm btn-secondary disabled domain-noaction">{/literal}{$lang.domain_unavaliable}{literal} </a>
                {{/if}}
                <div class="result-incart">
                    <a href="#" href="#remove" class="btn btn-sm btn-link text-danger result-remove">{/literal}{$lang.remove}{literal}</a>
                    <a href="#" href="#cart" class="btn btn-sm btn-primary disabled btn-rounded result-cart">
                        <i class="material-icons size-sm">done</i>
                        <span class="min mid ml-2">{/literal}{$lang.domain_added}{literal}</span>
                    </a>
                </div>
            </div>
        </div>
    </script>
    <script id="result-row" type="text/x-handlebars-template">
        <div class="result-row border-bottom py-3 d-flex flex-column flex-md-row justify-content-start justify-content-md-between aling-items-center {{#if lazy}}lazy{{/if}} {{#if inCart}}active{{/if}}"
        id="{{htmlId}}"
        data-id="{{@key}}"
        data-loader="whois"
        >
            {{> resultRowData }}
        </div>
    </script>
    <script id="result-group" type="text/x-handlebars-template">
        {{#each items}}
        <div class="result-query  m-3"><span class="result-query-text text-primary">{{query}}</span></div>
            <div class="result-group d-flex flex-column m-3" data-id="{{@key}}">
            {{#each display}}
                {{> resultRow }}
            {{/each}}
            </div>
        {{/each}}
    </script>
{/literal}

    <div class="orderpage-domain">
        {include file='cart_2019wizard/header.tpl'}
        <div class="row">
            <div class="col-12 col-md-8">
                <div class="row">
                    <div class="col-12 mb-5 mt-0">
                        <div class="card shadow border-0">
                            <div class="p-4 bg-gradient-primary">
                                <h3 class="mb-4 text-white">{$lang.mydomains}</h3>
                                <div id="options" class="domain-option">
                                    <p class="text-white">{$lang.productconfig1_desc}</p>
                                    <div class="d-flex flex-row justify-content-center">
                                        <div class="btn-group-toggle mt-2 mb-4" data-toggle="buttons">
                                            {if $allowregister}
                                                <label class="btn btn-outline-light active">
                                                    <input name="domainmode" value="register" type="radio" onchange="setAction('register');" checked="checked"/> {$lang.register}
                                                </label>
                                            {/if}
                                            {if $allowtransfer}
                                                <label class="btn btn-outline-light">
                                                    <input name="domainmode" value="transfer" type="radio" onchange="setAction('transfer');"/> {$lang.transfer}
                                                </label>
                                            {/if}
                                            {if $allowown}
                                                <label class="btn btn-outline-light">
                                                    <input name="domainmode" id="domainmode_update" value="" type="radio" onchange="setAction('update');"/> {$lang.alreadyhave}
                                                </label>
                                            {/if}
                                            {if $subdomain}
                                                <label class="btn btn-outline-light">
                                                    <input name="domainmode" value="" type="radio" onchange="setAction('sub');"/> {$lang.subdomain}
                                                </label>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                                <div id="add-domain" class="domain-search">
                                    {if $allowregister || $allowtransfer}
                                        <div id="domain_textarea" class="slidme">
                                            <div class="d-flex flex-column flex-sm-row my-3 align-items-start">
                                                <textarea rows="1" class="textarea-autoresize form-control mr-2" placeholder="example.com"></textarea>
                                            </div>
                                        </div>
                                    {/if}
                                    {if $allowown}
                                        <div id="illupdate" style="display: none;" class="slidme">
                                            <form action="" id="domainpicker" method="post" onsubmit="on_submit_domain_update();">
                                                <input type="hidden" value="illupdate" name="domain" />
                                                <input type="hidden" value="{$cart_contents[0].id}" id="product_id" name="product_id" />
                                                <input type="hidden" value="{$cart_contents[0].recurring}" id="product_cycle" name="product_cycle" />
                                                <div class="d-flex flex-column items">
                                                    {if $allowownoutside}
                                                        <div class="mb-3 w-100 card item">
                                                            <div class="card-body d-flex flex-column">
                                                                <div class="form-check cursor-pointer d-flex flex-row justify-content-start align-items-center">
                                                                    <input id="iwantupdate_outside" type="radio" class="owndomain_card_toggler" checked="checked" onclick="toggleCard($(this));" />
                                                                    <label for="iwantupdate_outside" class="form-check-label">{$lang.iwantupdate_outside|sprintf:$business_name}</label>
                                                                </div>
                                                                <div class="item-body form-group">
                                                                    <div class="input-group mt-3">
                                                                        <div class="input-group-prepend">
                                                                            <div class="input-group-text rounded-0">www.</div>
                                                                        </div>
                                                                        <input type="text" value="" size="40" name="sld_update" id="sld_update" class="form-control" placeholder="example"/>
                                                                        <div class="input-group-append">
                                                                            <input type="text" value="" size="7" name="tld_update" id="tld_update" class="form-control domain-tld rounded-0 rounded-top-right rounded-bottom-right " placeholder="com"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    {else}
                                                        <input type="hidden" name="sld_update" id="sld_update"/>
                                                        <input type="hidden" name="tld_update" id="tld_update"/>
                                                    {/if}
                                                    {foreach from=$shoppingcart item=order}
                                                        {foreach from=$order.domains item=domenka}
                                                            {if $domenka.action === 'register' || $domenka.action === 'transfer'}
                                                                {assign var=showcartdomainselect value=true}
                                                                {break}
                                                            {/if}
                                                        {/foreach}
                                                    {/foreach}
                                                    {if $showcartdomainselect}
                                                        <div class="mb-3 w-100 card item">
                                                            <div class="card-body">
                                                                <div class="form-check cursor-pointer d-flex flex-row justify-content-start align-items-center">
                                                                    <input id="iwantupdate_cart" type="radio" class="owndomain_card_toggler" onclick="toggleCard($(this));" />
                                                                    <label for="iwantupdate_cart" class="form-check-label">{$lang.iwantupdate_cart}</label>
                                                                </div>
                                                                <div class="item-body" style="display: none">
                                                                    <select class="form-control mt-3 iwantupdate_cart_select">
                                                                        {foreach from=$shoppingcart item=order key=k}
                                                                            {foreach from=$order.domains item=domenka key=kk}
                                                                                {if $domenka.action === 'register' || $domenka.action === 'transfer'}
                                                                                    {assign var=showdomenka value=true}

                                                                                    {foreach from=$shoppingcart item=order2}
                                                                                        {if $order2.product.domain === $domenka.name}
                                                                                            {assign var=showdomenka value=false}
                                                                                            {break}  {* domain is already used by other hosting *}
                                                                                        {/if}
                                                                                    {/foreach}

                                                                                    {if $showdomenka}
                                                                                        <option data-sld="{$domenka.sld}" data-tld="{$domenka.tld}">{$domenka.name}</option>
                                                                                    {/if}
                                                                                {/if}
                                                                            {/foreach}
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    {/if}
                                                    <div class="mb-3 w-100 card item">
                                                        <div class="card-body">
                                                            <div class="form-check cursor-pointer d-flex flex-row justify-content-start align-items-center">
                                                                <input id="iwantupdate_myaccount" type="radio" class="owndomain_card_toggler" onclick="toggleCard($(this));" />
                                                                <label for="iwantupdate_myaccount" class="form-check-label">{$lang.iwantupdate_myaccount}</label>
                                                            </div>
                                                            <div class="item-body" style="display: none">
                                                                {if $logged=="1"}
                                                                    {clientservices}
                                                                    {if $client_domains}
                                                                        <select class="form-control mt-3 iwantupdate_myaccount_select">
                                                                        {foreach from=$client_domains item=domenka key=kk}
                                                                            {if $domenka.status === 'Active' || $domenka.status === 'Pending Registration' || $domenka.status === 'Pending Transfer'}
                                                                                <option data-domain="{$domenka.name}">{$domenka.name}</option>
                                                                            {/if}
                                                                        {/foreach}
                                                                    </select>
                                                                    {else}
                                                                        <div class="mt-3 text-left">
                                                                            <span>{$lang.youdonthaveactivedomain}</span>
                                                                        </div>
                                                                    {/if}
                                                                {else}
                                                                    <div class="mt-3 text-left">
                                                                        <span>{$lang.pleaseloginyouraccount}</span>.
                                                                        <a href="?cmd=login">{$lang.login}</a>
                                                                    </div>
                                                                {/if}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    {/if}
                                    {if $subdomain}
                                        <div id="illsub" style="display: none;" class="slidme">
                                            <form action="" id="domainpicker" method="post">
                                                <input type="hidden" value="illsub" name="domain" />
                                                <input type="hidden" value="{$cart_contents[0].id}" id="product_id" name="product_id" />
                                                <input type="hidden" value="{$cart_contents[0].recurring}" id="product_cycle" name="product_cycle" />
                                                <div class="input-group my-3 border-none rounded overflow-hidden">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text">www.</span>
                                                    </div>
                                                    <input type="text" value="" size="40" name="sld_subdomain" id="sld_subdomain" placeholder="example" class="border-0  form-control"/>
                                                    <div class="input-group-append">
                                                        <span class="input-group-text">{$subdomain}</span>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    {/if}
                                </div>
                            </div>
                            <form method="post" action="" id="form1">
                                <input type="hidden" name="domain" value="illregister">
                                <div class="domain-search-results"></div>
                                <div class="domain-order"></div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-4">
                <div class="order-summary-box cart-summary p-4 shadow card" id="cartSummary">
                    {include file='cart_2019wizard/cart.summary.tpl'}
                </div>
            </div>
        </div>
    </div>
</div>