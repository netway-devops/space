{include file="affiliates/top_nav.tpl"}

<h5 class="my-5">{$lang.commission_plans}</h5>

<section class="section-affiliates">
    <div class="table-responsive table-borders table-radius">
        <table class="table position-relative stackable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>{$lang.name}</th>
                    <th>{$lang.commission}</th>
                    <th>Products</th>
                </tr>
            </thead>
            <tbody>
                {foreach from=$commission_plans key=k item=commission}
                    <tr>
                        <td>{$commission.id}</td>
                        <td>{$commission.name}</td>
                        <td>
                            {if $commission.type != 'Percent'}{$commission.rate|price:$currency:true:true}{/if}
                            {if $commission.type == 'Percent'}{$commission.rate}%{/if}
                        </td>
                        <td width="400">
                            {if $commission.applicable_products.products_info}
                                {assign var="scount" value=1}
                                {foreach from=$commission.applicable_products.products_info item=category}
                                    {foreach from=$category item=product name=fooo}
                                        <span>{$product.catname} - {$product.name},</span><br>
                                        {assign var="scount" value=$scount+1}
                                        {if $scount == 3}
                                            <span class="text-secondary">and {$commission.applicable_products.products_count-$scount+1} more...</span>
                                            <br>
                                            {break}
                                        {/if}
                                    {/foreach}
                                    {if $scount == 3}
                                        {break}
                                    {/if}
                                {/foreach}
                            {/if}
                            <a class="btn btn-primary btn-sm" href="#commission_plans_{$k}" data-toggle="modal">{$lang.showall}</a>
                            <div id="commission_plans_{$k}" class="modal fade fade2" tabindex="-1" role="dialog" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h4 class="modal-title font-weight-bold mt-2">Applicable products</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <i class="material-icons">cancel</i>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <h4>Products</h4>
                                            {if $commission.applicable_products.products_info}
                                                {foreach from=$commission.applicable_products.products_info item=category}
                                                    <ul>
                                                        {foreach from=$category item=product}
                                                            <li><a href="?cmd=cart&action=add&id={$product.id}">{$product.catname} - {$product.name}</a></li>
                                                        {/foreach}
                                                    </ul>
                                                {/foreach}
                                            {/if}

                                            {if $commission.applicable_products.addons_info}
                                                <h4>Addons</h4>
                                                <ul>
                                                    {foreach from=$commission.applicable_products.addons_info item=addon}
                                                        <li>{$addon.name}</li>
                                                    {/foreach}
                                                </ul>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
    {include file="components/pagination.tpl"}
</section>