<link rel="stylesheet" href="{$system_url}{$flavordir}list_wizard/style.css?t=1">
<div class="orderpage">
    <input type="hidden" name="flavor_id" value="0" id="flavor_id"/>

    <ul class="plan-list">
        {foreach from=$list item=i name=loop}
            <li>
                <div class="plan">
                    <div class="plan-top clearfix">
                        <div class="pull-right right-text">
                            <span>
                                {$i.price_on|price:$currency:true:false:true:3} <span
                                        class="price-cycle">/ {$lang.hourly}</span><br/>
                                {$i.monthly|price:$currency} <span class="price-cycle">/ {$lang.monthly}</span>
                            </span>
                            <div class="order-form">
                                <a href="#" class="plan-detailsr">{$lang.moreinfo}</a>
                            </div>
                            <div class="order-form">
                                <a href="#" class="plan-order" data-value="{$i.id}">
                                    {$lang.select|default:"Select"}
                                </a>
                            </div>
                        </div>
                        <p>{$i.name}</p>
                        <div class="clear"></div>
                    </div>

                    {if $i.description}
                        <div class="plan-details clearfix" style="display: none;">
                            {$i.description}
                        </div>
                    {/if}
                </div>
            </li>
        {/foreach}

    </ul>
</div>
{literal}
<script>
    var flavor_data = {/literal}{$ui_data}{literal} || {};;

    $(function () {
        if(flavor_data && flavor_data.selected){
            window.setTimeout(function () {
                $('#orderpage .btn-select[data-value=' + flavor_data.selected + ']').click();
            }, 500);
        }

    })

</script>
{/literal}
<script src="{$system_url}{$flavordir}list_wizard/script.js"></script>