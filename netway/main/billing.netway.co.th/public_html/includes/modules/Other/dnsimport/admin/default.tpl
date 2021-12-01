<link href="{$moduleurl}admin/styles.css" rel="stylesheet" type="text/css"/>
<script src="{$moduleurl}admin/script.js" type="text/javascript"></script>

<ul class="hbnav breadcrumb">
    <li class="step {if $section == 'default'}active{/if}">
        <a {if $section != 'default'} href="?cmd={$modulename}"{/if}><span>Select Server</span></a>
    </li>
    <li class="step {if $section == 'setup' }active{/if}">
        <a {if $section == 'setup'} href="?cmd={$modulename}&action=setup&server={$sid}"{/if}><span>Select Zones</span></a>
    </li>
    <li class="step {if $section == 'result' || $section == 'nozones'}active{/if}">
        <a><span>Result</span></a>
    </li>
</ul>
<div id="dnsimport">


    {if $section == 'default'}
        <form method="GET" action="">
            <input type="hidden" value="dnsimport" name="cmd">
            <input type="hidden" value="setup" name="action">
            <h2>Select App to import from</h2>
            <div>
                <select name="server" class="chosen">
                    {foreach from=$groups item=group}
                        <optgroup label="{$group.name}">
                            {foreach from=$group.servers item=server}
                                <option value="{$server.id}">{$server.name}</option>
                            {/foreach}
                        </optgroup>
                    {/foreach}
                </select>
                <hr />
                <button type="submit" class="btn btn-primary">Continue</button>
            </div>
            {securitytoken}
        </form>
    {elseif $section=='setup'}
        <form method="POST" action="">
            <input type="hidden" value="{$server|escape}" name="server">
            {if !$products}
                <p class="error">
                    No valid products. This tool requires at leas one product configured for DNS module used with selected server.
                </p>
                <a class="dns-btn" href="?cmd={$modulename}" >Go Back</a>
            {else}
                <h2>Select domain to import</h2>
                <p class="info clearfix">
                    Found {$zones|@count} zone(s) that can be imported
                </p>

                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Zone</label>
                            <select name="zones" id="zones" class="form-control chosen"  data-placeholder="Select Zones to import" multiple>
                                <option></option>
                                {foreach from=$zones item=zone key=zid}
                                    <option value="{$zone.id}" data-local="{$zone.local|@json_encode|escape}">{$zone.name}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Client</label>
                            <select name="client" class="form-control" id="client-search"></select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Product</label>
                            <select name="product"  class="form-control chosen"  data-placeholder="Select dns product">
                                {foreach from=$products item=category}
                                    <optgroup label="{$category.name}">
                                        {foreach from=$category.products item=product}
                                            <option value="{$product.id}">{$product.name}</option>
                                        {/foreach}
                                    </optgroup>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="hide-sm">&nbsp;</label>
                            <div>
                                <a id="add" class="btn btn-primary btn-md" href="#add" >Add item</a>
                                <a id="add-all" class="btn btn-default btn-md " href="#add-all" >Add all items</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="alerts" class="alert alert-warning" hidden>
                    Some of the selected zones are already assigned to a 
                    service in hostbill, if you choose to re-import those zones
                    it may be assigned to a different service depending on 
                    your client and product selection.   

                    <br /><br />
                    <strong>Zones:</strong>
                    <div class="list">
                    </div>
                </div>           

                <table class="table table-striped">
                    <col style="width: 40%" />
                    <tbody id="dnsitems">
                        <tr class="placeholder">
                            <td colspan="4">No items added to import yet.</td>
                        </tr>
                    </tbody>
                </table>
                <hr />
                <div>
                    <button class="btn btn-primary" type="submit">Import selected</button>
                    <a class="btn btn-default" href="?cmd={$modulename}" >Go Back</a>
                </div>
                {securitytoken}
            {/if}
        </form>
        <div hidden>
            <div id="import-all" >
                <div class="radio">
                    <label >
                        <input type="radio" name="import" value="1" checked>
                        Add all zones with currently selected Client and Product.
                    </label>
                </div>
                <div class="radio">
                    <label class="radio">
                        <input type="radio" name="import" value="2">
                        Add all zones with currently selected Product, use assigned Client for existing zones.
                    </label>
                </div>
                <div class="radio">
                    <label class="radio">
                        <input type="radio" name="import" value="3">
                        Add all zones with currently selected Client, use assigned Product for existing zones.
                    </label>
                </div>
            </div>
        </div>
    {elseif $section=='nozones'}
        <p class="info">
            No DNS zones to import. Either there are no zones on selected server or all of them exist in hostbill database.
        </p>
        <a class="dns-btn" href="?cmd={$modulename}" >Go Back</a>
    {elseif $section=='result'}
        {if $progress.percent < 100}
            <p>Import is running in a background task, this page will auto update to show result for each imported zone.</p>
            <div class="progress" >
                <div class="progress-bar progress-bar-striped active" role="progressbar" style="width: 1%;">
                </div>
            </div>
        {/if}
        <div id="result">
            {include file='ajax.default.tpl'}
        </div>

        <a class="btn btn-default" href="?cmd={$modulename}" ><i class="fa fa-refresh"></i> Start over</a>
    {/if}
</div>
