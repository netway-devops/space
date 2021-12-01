
{literal}
    <style>
        .table-import{
            margin-bottom: 15px;
        }

        #import-items tr td {
            padding: 10px;
            border-bottom: 1px solid #ddd
        }

        #import-items tr + tr.placeholder {
            display: none;
        }

        #import-items .placeholder td {
            padding: 12px 15px;
            color: #ccc;
            border: 2px dashed #ddd;
        }

        #import-items code {
            padding: 2px 4px;
            font-size: 90%;
            color: #35779E;
            background-color: #F2F4F9;
            border-radius: 4px;
        }
    </style>
    <script type="text/x-handlebars" id="import-item-tpl">
        <tr data-index="{{index}}">
            <td>
                <input type="hidden" name="import[{{index}}][items]" value="{{value}}"/>
                {{#each items}}
                <code>{{name}}</code>
                {{/each}}

                <input type="hidden" name="import[{{index}}][client]" value="{{client.id}}"/>
                <input type="hidden" name="import[{{index}}][product]" value="{{product.id}}"/>

            </td>
            <td>
                {{client.name}}
            </td>
            <td>
                {{product.category}} - {{product.name}}
            </td>
            <td>
                <a class="rem btn btn-default btn-sm" href="#rem">Remove</a>
            </td>
        </tr>
    </script>
    <script>
        $(function () {
            init_import_form();
        })
    </script>
{/literal}

<form method="POST" action="" id="import-form">
    <input type="hidden" value="{$data_id}" name="id">
    <input type="hidden" value="{$server_id}" name="server_id">

    <div class="container-fluid" style="margin-top: 10px;">
        <div class="row">
            <div class="col-md-12">


                <span>Select domain to import</span>
                <p class="alert alert-info">
                    Found {$domains|@count} domains(s) that can be imported
                </p>

                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Domains</label>
                            <select name="domains" id="domains" class="form-control chosen"
                                    data-placeholder="Select Zones to import"
                                    multiple>
                                <option></option>
                                {foreach from=$domains item=domain key=id}
                                    <option value="{$domain.name}">{$domain.name}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Client</label>
                            <select name="client" class="form-control" id="client-search">
                                {if $import_contacts}
                                    <option value="import">Import client from domain contacts</option>
                                {/if}
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Product</label>
                            <select name="product" class="form-control chosen" id="import-product"
                                    data-placeholder="Select TLD product">
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
                                <a id="add" class="btn btn-primary btn-md" href="#add">Add item</a>
                                <a id="add-all" class="btn btn-default btn-md " href="#add-all">
                                    Add all <span></span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <table class="table table-striped table-import">
                    <col style="width: 40%"/>
                    <tbody id="import-items">
                        <tr class="placeholder">
                            <td colspan="4">No items added to import yet.</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="blu" style="padding: 10px 15px">
        <button class="btn btn-primary" type="submit">Import selected</button>
        <a class="btn btn-default" href="?cmd={$modulename}">Go Back</a>
    </div>
    {securitytoken}
</form>