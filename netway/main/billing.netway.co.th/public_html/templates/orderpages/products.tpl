{if $custom_overrides.products}
    {include file=$custom_overrides.products}
{else}
{literal}
    <style>
        .products-list .products-box {
            display: -webkit-box;
            display: -webkit-flex;
            display: -moz-box;
            display: -ms-flexbox;
            display: flex;
            align-items: flex-start;
            background-color: white;
            box-shadow: rgba(0, 0, 0, 0.16) 0 1px 4px;
            overflow: hidden;
            border: 1px solid #ebecf0;
            padding: 10px;
            border-radius: 5px;
            flex-direction: column;
            text-decoration: none;
            margin-bottom: 10px;
            height: 100%;
        }
        .products-list .products-box-title {
            font-size: 1.14rem;
        }
        .products-list .products-box-description {
            margin-top: 10px;
            color: #666;
        }
        .products-list .products-box-footer {
            margin: 10px 0;
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
            width: 100%;
        }
        .products-list .products-box-price {
            font-size: 14px;
            color: #333;
        }
        .products-list .products-box-button {
            background: #3daee9;
            border-radius: 5px;
            color: #ffffff;
            font-size: 14px;
            padding: 7px 15px 7px 15px;
            text-decoration: none;
        }
        .products-list .products-box-button:hover,
        .products-list .products-box-button:active{
            background: #3cb0fd;
            text-decoration: none;
            color: #ffffff;
        }
        .products-list .products-box-button:active {
            position: relative;
            top: 1px;
        }
    </style>
{/literal}
    <section class="products-list">
        <div>
            <h4>{$lang.checkoffersphrase}</h4>
        </div>
        <div class="row-fluid">
            {foreach from=$categories item=cat name=loop}
                {if $smarty.foreach.loop.iteration%2==1}
                    </div>
                    <div class="row-fluid">
                {/if}
                <div class="span6">
                    <div class="products-box d-flex flex-column justify-content-center">
                        <a href="{$cat.url}" class="products-box-title">{$cat.name}</a>
                        {if $cat.description}
                            <div class="products-box-description">{$cat.description}</div>
                        {/if}
                        <div class="products-box-footer">
                            <div class="products-box-price">{if $cat.min_price}{$lang.from|ucfirst} <b>{$cat.min_price|price:$currency:true:true}</b>{/if}</div>
                            <a class="products-box-button" href="{$cat.url}">{$lang.select|default:"Select"}</a>
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>
    </section>
{/if}