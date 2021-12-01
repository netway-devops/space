<nav class="navbar fixed-top">
    <div class="navbar-left">
        <a class="navbar-brand mr-0 mr-md-2" href="{$ca_url}">
            <img src="{$template_dir}{themeconfig variable=logo_big_inverse default="dist/images/hb_logo_white.png"}" alt="{$business_name}">
        </a>
        <div class="d-flex flex-row">
            <div class="d-flex justify-content-end d-lg-none align-items-center">

                {*order products dropdown btn*}
                {if $orderpages && "acl_user:misc.accesscart"|checkcondition}
                    <div class="navbar-order">
                        <a class="btn p-1 btn-success mx-1 navbar-order-toggler" href="#" role="button" aria-haspopup="true" aria-expanded="true">
                            {$lang.order}
                            <i class="material-icons ml-1 size-sm">expand_more</i>
                        </a>
                    </div>
                {/if}

                {*shopping cart btn*}
                {if 'config:ShopingCartMode'|checkcondition && "acl_user:misc.accesscart"|checkcondition}
                    <a class="btn-left-navbar py-2 px-1 px-md-2" href="{$ca_url}cart/" role="button">
                        <i class="material-icons ">shopping_cart</i>
                        {if $shoppingcart}
                            <span class="badge badge-pill badge-primary">{$shoppingcart|@count}</span>
                        {/if}
                    </a>
                {/if}

                {*login modal btn*}
                <a class="btn-left-navbar py-2 px-1 px-md-2" href="{$ca_url}clientarea/" role="button" aria-expanded="false" data-toggle="modal" data-target="#loginModal">
                    <i class="material-icons">person</i>
                </a>
            </div>

            {*burger btn*}
            <a class="btn-left-navbar btn-toggler py-2 px-1 px-md-2" href="#" data-toggle="sidebar" aria-label="Hide Sidebar">
                <i class="material-icons">menu</i>
            </a>
        </div>
    </div>
    <div class="navbar-body d-none d-lg-flex">
        <form class="navbar-search loading form-inline my-2 my-lg-0 ">
            <div class="input-group">
                <div class="input-group-prepend input-icon-placeholder">
                    <span class="navbar-search-icon input-group-text"><i class="material-icons">search</i></span>
                </div>
                <input type="text" class="form-control form-control-noborders prompt" placeholder="{$lang.search}" id="navbar-search-box"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <div class="input-group-prepend input-icon-placeholder">
                    <span class="navbar-search-loader"></span>
                </div>
            </div>
            <div class="dropdown-menu navbar-search-results" style="display: none;"></div>
        </form>
        {if $orderpages && "acl_user:misc.accesscart"|checkcondition}
            <div class="navbar-order">
                <a class="btn btn-success mx-3 navbar-order-toggler" href="#" role="button" aria-haspopup="true" aria-expanded="true">
                    {$lang.order}
                    <i class="material-icons ml-2 size-md">expand_more</i>
                </a>
            </div>
        {/if}
        <div class="navbar-menu">
            <ul class="navbar-nav navbar-menu">

                {clientwidget module="status" section="bar" wrapper=""}

                {if 'config:ShopingCartMode'|checkcondition && "acl_user:misc.accesscart"|checkcondition}
                    <li class="nav-item dropdown d-md-down-none">
                        <a class="nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="true">
                            <i class="material-icons ">shopping_cart</i>
                            {if $shoppingcart}
                                <span class="badge badge-pill badge-primary">{$shoppingcart|@count}</span>
                            {/if}
                        </a>
                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg dropdown-menu-shoppingcart">
                            {if $shoppingcart}
                                <div class="dropdown-item disabled"><strong>{$lang.cart}</strong></div>
                                {foreach from=$shoppingcart item=order key=k}
                                    {if $order.product}
                                        <a class="dropdown-item d-flex flex-row justify-content-between align-items-center" href="{$ca_url}cart&cart=edit&order={$k}">
                                            <span>
                                                {$order.product.category_name} - {$order.product.name}
                                                {if $order.product.domain}({$order.product.domain}){/if}
                                            </span>
                                            <span class="badge badge-primary ml-4">{$order.total.total|price:$currency:true:true}</span>
                                        </a>
                                    {elseif $order.domains }
                                        {foreach from=$order.domains item=domenka key=kk}
                                            <a class="dropdown-item d-flex flex-row justify-content-between align-items-center" href="{$ca_url}cart&cart=edit&order={$k}">
                                                <span>
                                                    {if $domenka.action=='register'}{$lang.domainregister}
                                                    {elseif $domenka.action=='transfer'}{$lang.domaintransfer}
                                                    {elseif $domenka.action=='renew'}{$lang.domainrenewal}
                                                    {/if} - {$domenka.name} - {$domenka.period} {$lang.years}
                                                </span>
                                                <span class="badge badge-primary ml-4">{$domenka.price|price:$currency:true:true}</span>
                                            </a>
                                        {/foreach}
                                    {/if}
                                {/foreach}
                            {else}
                                <div class="dropdown-item disabled d-flex flex-column justify-content-center align-items-center">
                                    <i class="material-icons size-hg m-3">shopping_cart</i>
                                    <strong>{$lang.yourcartisempty}</strong>
                                </div>
                            {/if}
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="{$ca_url}cart/">
                                {if $shoppingcart|@count > 0}
                                    {$lang.proceedtocart}
                                {else}
                                    {$lang.browseprod}
                                {/if}
                            </a>
                        </div>
                    </li>
                {/if}
                {if $languages}
                    <li class="nav-item dropdown d-md-down-none">
                        <a class="nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="true">
                            <i class="material-icons">language</i>
                            {foreach from=$languages item=ling}
                                {if  $language==$ling}
                                    <small class="text-nowrap">{$ling|capitalize}</small>{break}
                                {/if}
                            {/foreach}
                            <i class="material-icons">arrow_drop_down</i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg">
                            {foreach from=$languages item=ling}
                                <a class="dropdown-item language-change" href="{$ca_url}{$cmd}&action={$action}&languagechange={$ling|capitalize}">
                                    {$lang[$ling]|capitalize}
                                </a>
                            {/foreach}
                        </div>
                    </li>
                {/if}
                <li class="nav-item dropdown">
                    <a class="nav-link nav-link" href="{$ca_url}clientarea/" role="button" aria-expanded="false" data-toggle="modal" data-target="#loginModal">
                        <i class="material-icons">person</i>
                        <small class="text-nowrap">{$lang.login} / {$lang.clientregister}</small>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="dropdown-menu dropdown-order-items p-4">
        <div class="row">
            <div class="col-12">
                <h3>{$lang.placeorder}</h3>
                <hr>
            </div>
            <div class="col-12 col-md-8 col-lg-9 dropdown-order-items-els">
                <div class="row">
                    {foreach from=$orderpages item=op}
                        <div class="col-12 col-md-6 col-lg-4">
                            <a class="navbar-dropdown-item" href="{$ca_url}{$op.slug}">{$op.name}</a>
                        </div>
                    {/foreach}
                </div>
            </div>
            <div class="col-12 col-md-4 col-lg-3">
                <div class="d-flex flex-column justify-content-center align-items-center h-100 text-center">
                    <p class="text-secondary">{$lang.checkoffersphrase}</p>
                    <a href="{$ca_url}{if $shoppingcart|@count > 0}cart/{else}products/{/if}" class="btn btn-success">
                        <i class="material-icons mr-3 size-md">shopping_cart</i>
                        {if $shoppingcart|@count > 0}
                            {$lang.proceedtocart}
                        {else}
                            {$lang.browseprod}
                        {/if}
                    </a>
                </div>
            </div>
        </div>
    </div>
</nav>