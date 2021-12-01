<script type="text/javascript" src="{$moduleurl}script.js"></script>
<div class="lighterblue" style="padding: 10px">
    <select class="inp" id="prodctstype">
        <option value="Product" >Product</option>
        <option value="Domain" >Domain</option>
        <option value="Addon" >Addon</option>
    </select>
    <select class="inp" id="prodcts">
        <option value="0" id="empty_opt" >Select product..</option>
        {foreach from=$categories item=category}
            <optgroup class="{if $category.product_type=='DomainsType'}group_Domain{else}group_Product{/if}" label="{$category.name}">
                {foreach from=$category.products item=catproduct}
                    <option value="{$catproduct.id}" >{$catproduct.name}</option>
                {/foreach}
            </optgroup>
        {/foreach}
        <optgroup class="group_Addon" label="Addons">
            {foreach from=$addons item=addon}
                <option value="{$addon.id}" >{$addon.name}</option>
            {/foreach}
        </optgroup>
    </select>
</div>
<form action="" method="post">
    <table cellspacing="0" cellpadding="3" border="0" class="glike hover" width="100%">
        <thead>
            <tr>
                
                <th>Product</th>
                <th width="90">Limit</th>
                <th width="20"></th>
            </tr>
        </thead>
        <tbody id="limitslist">
            {if $limits}
                {foreach from=$limits item=limit}
                    <tr id="limit_{$limit.id}_{$limit.type}">
                        
                        <td>{$limit.name}</td>
                        <td><input size="5" style="text-align: right" value="{$limit.limit}" name="limits[{$limit.type}][{$limit.id}]"/></td>
                        <td><a href="#" class="delbtn"></a></td>
                    </tr>
                {/foreach}
            {else}
                <tr class="nothing"><td colspan="6" style="text-align: center; padding: 5px;"><strong>Nothing to display</strong></td></tr>
            {/if}
        </tbody>
        <tbody>
            <tr class="template" style="display:none"> 
                <td></td>
                <td><input size="5" style="text-align: right" value="1" name=""/></td>
                <td><a href="#" class="delbtn"></a></td>
            </tr>
        </tbody>
    </table>
    <div class="lighterblue" style="padding: 10px">
        <input style="font-weight: bold;" type="submit" name="savecharges" value="Save Changes" />
    </div>
</form>