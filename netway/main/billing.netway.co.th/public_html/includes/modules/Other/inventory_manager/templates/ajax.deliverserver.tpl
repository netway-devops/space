<h3>Finish server build, provide target account, update item locations</h3>
<label >Tick to mark as delivered</label>
<input type="checkbox" name="deliver" value="1" {if $untested}disabled{/if}>
{if $untested}
    <div class="clear alert alert-warning">
        <p>This build cointains items that were not tested, please verify 
            those before compleating this build.</p>
        <ul>
            {foreach from=$untested item=item}
                <li>{$item}</li>
                {/foreach}
        </ul>
    </div>
{/if}
<div class="clear"></div>
<label class="nodescr">Assign to this account:</label>

<select name="account_id" class="w250 chosen">
    <option value="0">None</option>
    {foreach from=$accounts item=acc}

        <option value="{$acc.id}" {if $product.account_id==$acc.id}selected="selected"{/if}>#{$acc.id} {$acc.domain}</option>
    {/foreach}
</select>
<div class="clear"></div>

<label >
    New items location <small>If you wish to deliver this item you can
        provide where all server components will be located (ie. which DC/Room/Row/Rack/U)</small>
</label>
<div class="w250 left" style="clear: right; margin: 2px 0px 10px 10px;">
    <textarea name="new_location" class="inp" cols="" rows="" style="margin:0px;width:450px;height:150px;"></textarea>
</div>
<div class="clear"></div>