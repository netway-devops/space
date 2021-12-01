{include file="cart_2019wizard/header.tpl"}
<section class="orderpage orderpage-cart_2019wizard">
    <div>
        <h1 class="my-5">{$opconfig.headertext}</h1>
        <h4 class="my-5">{$opconfig.subheadertext}</h4>
    </div>

    {if $opconfig.show_parent_category_contents && $main_category}
        <section class="mb-4">
            {include file="`$main_category.template`.tpl"
            cat=$main_category
            subcategories=$main_category.subcategories
            opconfig=$main_category.opconfig
            selected_cat=$category.id}
        </section>
    {/if}

    <div id="cartCarousel">
        {foreach from=$products item=i name=loop}
            <div class="card h-100 m-4 shadow border-0 overflow-hidden">
                <div class="card-wave">
                    <svg class="{if $i.out_of_stock} bg-gray-svg {else} bg-primary-svg {/if}" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 320">
                        <path fill-opacity="1" d="M0,256L48,261.3C96,267,192,277,288,261.3C384,245,480,203,576,202.7C672,203,768,245,864,256C960,267,1056,245,1152,229.3C1248,213,1344,203,1392,197.3L1440,192L1440,0L1392,0C1344,0,1248,0,1152,0C1056,0,960,0,864,0C768,0,672,0,576,0C480,0,384,0,288,0C192,0,96,0,48,0L0,0Z"></path>
                    </svg>
                </div>
                <div class="mb-3 card-top mb-2 p-4">
                    {if $i.out_of_stock}
                        <h1 class="text-muted card-title pricing-card-title font-weight-bold mb-2">{$i.name}</h1>
                        <div class="text-muted card-price my-4 h1 d-flex flex-row justify-content-start">
                            <div>{$lang.out_of_stock_btn}</div>
                        </div>
                    {else}
                        <h1 class="text-white card-title pricing-card-title font-weight-bold mb-2">{$i.name}</h1>
                        <div class="text-white card-price my-4 h1 d-flex flex-column flex-md-row justify-content-start">
                            <span>{include file="common/price.tpl" product=$i}</span>
                            <small class="text-white d-flex flex-column flex-md-row small card-price-month">
                                <span class="ml-2 mr-1 d-none d-md-inline-block">/</span>
                                <span class="">{include file='common/cycle.tpl' product=$i}</span>
                            </small>
                        </div>
                    {/if}
                </div>
                <div class="card-body d-flex flex-column justify-content-end px-4 py-2">
                    {specs var="awords" string=$i.description}
                    {foreach from=$awords item=prod name=lla key=k}
                        {if $prod.specs}
                            {if $smarty.foreach.lla.index == 0 || $smarty.foreach.lla.index == 1}<div class="my-3">{/if}
                            {foreach from=$prod.specs item=feat name=plan key=ka}
                                <div class="row mx-1 my-1">
                                    <div class="col-6 p-1 text-right font-weight-light text-muted overflow-wrap-normal">{$feat[0]}</div>
                                    <div class="col-6 p-1 text-left font-weight-bold text-primary d-flex align-items-center">{$feat[1]}</div>
                                </div>
                            {/foreach}
                            {if $smarty.foreach.lla.index == 0 || $smarty.foreach.lla.index == 1}</div>{/if}
                        {/if}
                    {/foreach}
                    {assign var=awords value=false}
                </div>
                <div class="card-body d-flex flex-column justify-content-end px-4 py-3">
                    {if $i.out_of_stock}
                        <a href="#" class="disabled btn-border btn w-100 btn-outline-dark btn-border1px font-weight-bold btn-rounded">{$lang.order}</a>
                    {else}
                        <form method="post" action="" class=" mt-4 parentform d-flex flex-row justify-content-center">
                            <input type="hidden" name="action" value="add"/>
                            <input type="hidden" name="id" value="{$i.id}"/>
                            <button type="submit" class="btn-border btn w-100 btn-outline-primary btn-border1px font-weight-bold btn-rounded">{$lang.order}</button>
                        </form>
                    {/if}
                </div>
            </div>
        {/foreach}
    </div>
</section>