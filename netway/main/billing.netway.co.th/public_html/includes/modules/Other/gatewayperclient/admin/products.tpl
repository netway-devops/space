{include file="navbar.tpl"}

<script src="{$moduleurl}js/scripts.js"></script>

<link rel="stylesheet" href="{$moduleurl}css/style.css">

{if $action == 'products'}
    <table class="glike hover" width="100%" cellspacing="0" cellpadding="3" border="0">
        <tr>
            <th>ID</th>
            <th>Products</th>
            <th>Gateways</th>
            <th style="width: 100px;"></th>
        </tr>
        {foreach from=$configs item=config name=fff}
            <tr>
                <td>{$config.id}</td>
                <td>
                    {foreach from=$config._products item=item}
                        {if $item.type == 'product'}
                            <a target="_blank" href="?cmd=services&action=product&id={$item.id}">{$item.category_name}: #{$item.id} {$item.name}</a>
                        {elseif $item.type == 'category'}
                            Category: <a target="_blank" href="?cmd=services&action=category&id={$item.id}">{$item.name}</a>
                        {/if}
                        <br>
                    {/foreach}
                </td>
                <td>
                    {foreach from=$config._gateways item=gtw}
                        #{$gtw.id} {$gtw.name}
                        <br>
                    {/foreach}
                </td>
                <td style="white-space: nowrap;">
                    <a href="?cmd={$modulename}&action=removeconfig&id={$config.id}&security_token={$security_token}&page=products" onclick="return confirm('Are you sure you want to remove this config?')" style="color: red">Remove</a>
                </td>
            </tr>
            {foreachelse}
            <tr>
                <td colspan="3">Nothing found</td>
            </tr>
        {/foreach}
    </table>
{elseif $action == 'addproducts'}
    <div style="padding:15px;">
        <form action="?cmd=gatewayperclient&action=addproducts" method="POST">
            <table id="tableform" cellpadding="5" style="width: 100%">
                <tbody>
                <tr>
                    <td>
                        <label for="">Products</label>
                    </td>
                    <td>
                        <select class="form-control chosenproducts" name="items[]" multiple>
                            {foreach from=$products key=category_id item=category}
                                <option class="optcategory" value="-{$category_id}" data-category="{$category_id}" style="font-weight: bold;">Category: {$category.name}</option>
                                {foreach from=$category.products item=product}
                                    <option class="optproduct" data-parent="{$category_id}" value="{$product.id}">&nbsp; &nbsp;{$category.name}: {$product.name}</option>
                                {/foreach}
                                {foreachelse}
                                <option disabled>Nothing found</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
                </tbody>
                <tbody>
                <tr>
                    <td>
                        <label><b>Enabled Payment Gateways</b></label>
                        <p class="small-descr">
                            Select payment gateways that will be available for these products
                        </p>
                    </td>
                    <td>
                        {include file="moduleconfig.tpl"}
                    </td>
                </tr>
                </tbody>
            </table>
            <input type="hidden" name="type" value="product">
            <input type="hidden" name="make" value="add">
            <button type="submit" class="btn btn-success" style="margin-top: 20px;">{$lang.savechanges}</button>
            {securitytoken}
        </form>
    </div>
{/if}