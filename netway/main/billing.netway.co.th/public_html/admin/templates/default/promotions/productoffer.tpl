{if $section=='submenu'}
    {if $action !== 'default'}
        <ul class="breadcrumb" style="margin-bottom: 0">
            <li>
                <a href="?cmd={$cmd}">List Free offers</a>
            </li>
            {if  $action == 'new'}
                <li>New Promotion</li>
            {elseif $action == 'edit' }
                <li class="active">#{$entry.id} {$entry.name|escape}</li>
            {/if}
        </ul>
    {/if}
    {if $warn_cart}
        <div class="alert alert-warning">
            Free product offers work only if <b>Multi-Item Cart</b> is enabled.
            You can enable this option in
            <a href="?cmd=configuration&picked_tab=1" class="external" target="_blank">
                {$lang.generalsettings} > {$lang.Ordering}
            </a>
        </div>
    {/if}
{elseif $action=='edit' || $action=='add'}
{literal}
    <style>
        .ace-editor-wy {
            padding-top: 0
        }
    </style>
{/literal}
    <link rel="stylesheet" href="{$template_dir}css/query-builder.default.css?v={$hb_version}" type="text/css"/>
    <script src="{$template_dir}js/querybuilder/query-builder.standalone.min.js?v={$hb_version}"></script>
    <script src="{$template_dir}js/ace/ace.js?v={$hb_version}"></script>
    <script src="{$template_dir}js/productoffer.js?v={$hb_version}"></script>
    <form method="post">
        <input type="hidden" name="make" value="{if $action=='new'}add{else}update{/if}"/>
        <div class="lighterblue2 container-fluid" style="padding: 15px 15px 0;">
            <div class="row">
                <div class="form-group col-md-12">
                    <label>{$lang.Name}</label>
                    {hbinput value=$entry.name|escape style="" name="name" class="form-control"}
                </div>
                <div class="form-group col-md-12">
                    <label>Client area description</label>
                    {hbwysiwyg value=$submit.description name="cartcode" value=$entry.cartcode
                    wrapper="div" style="width:100%;"  class="form-control"
                    featureset="ace" editortag="HTML" editortype="ace" rows="10"}
                </div>
                <div class="form-group col-md-12">
                    <label>Admin description</label>
                    <textarea class="form-control" name="description">{$entry.description|escape}</textarea>
                </div>
                <div class="form-group col-md-6">
                    <label>{$lang.status}</label>
                    <select name="status" class="form-control">
                        <option value="0">Disabled</option>
                        <option value="1" {if $entry.status==1}selected{/if}>Enabled</option>
                    </select>
                </div>
                <div class="form-group col-md-6">
                    <label>Expiration Date</label>
                    <input class="form-control datepicker" name="expire_at" type="text"
                           value="{if $entry.expire_at}{$entry.expire_at|dateformat:$date_format}{/if}"/>
                </div>
                <div class="form-group col-md-6">
                    <label>Target Audience</label>
                    <select class="form-control" name="target">
                        <option value="0">All Clients</option>
                        <option value="1" {if $entry.target == 1}selected{/if}>
                            New Clients (no orders)
                        </option>
                        <option value="2" {if $entry.target == 2}selected{/if}>
                            Existing Clients
                        </option>
                    </select>
                </div>
                <div class="form-group col-md-6">
                    <label>Free for</label>
                    <select class="form-control" name="cycle">
                        <option value="once">First billing period</option>
                        <option value="recurring" {if $entry.cycle == 'recurring'}selected{/if}>
                            Lifetime
                        </option>
                    </select>
                </div>
                <div class="form-group col-md-6">
                    <label>Max Usage per client</label>
                    <input class="form-control" name="maxuse" type="text" value="{$entry.maxuse}"/>
                    <span class="help-block">Leave empty or zero for unlimited use</span>
                </div>
                <div class="form-group col-md-12">
                    <label>If Conditions are met</label>
                    <div id="conditions-query-builder"
                         data-name="conditions"
                         data-filters="{$filters|@json_encode|escape}"></div>
                    <input type="hidden" name="conditions" id="conditions"
                           value="{$entry.conditions|@json_encode|escape}">
                </div>
                <div class="form-group col-md-12">
                    <label>Then offer products</label>
                    <div id="offer-query-builder"
                         data-name="offer"
                         data-filters="{$product_filters|@json_encode|escape}"></div>
                    <input type="hidden" name="offer" id="offer"
                           value="{$entry.offer|@json_encode|escape}">
                </div>
            </div>
        </div>
        <div class="blu" style="padding: 10px 15px">
            <button type="submit" class="btn btn-primary">{$lang.savechanges}</button>
            &nbsp;
            <a href="?cmd={$cmd}">{$lang.Cancel}</a>
        </div>
        {securitytoken}
    </form>
{else}
    <form action="" method="post" id="testform">
        <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
        <div class="blu">
            <a href="?cmd=productoffer&action=add" class="btn btn-default btn-sm">Add new offer</a>
            <div class="right">
                <div class="pagination"></div>
            </div>
            <div class="clear"></div>
        </div>

        <a href="?cmd={$cmd}" id="currentlist" style="display:none" updater="#updater"></a>
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
                <tr>
                    <th><a href="?cmd={$cmd}&orderby=id|ASC" class="sortorder">#</a></th>
                    <th><a href="?cmd={$cmd}&orderby=name|ASC" class="sortorder">{$lang.Name}</a></th>
                    <th><a href="?cmd={$cmd}&orderby=status|ASC" class="sortorder">{$lang.Status}</a></th>
                    <th><a href="?cmd={$cmd}&orderby=expire_at|ASC" class="sortorder">{$lang.Expires}</a></th>
                    <th>{$lang.Description}</th>
                    <th width="20"></th>
                </tr>
            </tbody>
            <tbody id="updater">
                {include file="promotions/ajax.productoffer.tpl"}
            </tbody>
            <tbody id="psummary">
                <tr>
                    <th colspan="7">
                        {$lang.showing}
                        <span id="sorterlow">{$sorterlow}</span> -
                        <span id="sorterhigh">{$sorterhigh}</span>
                        {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                    </th>
                </tr>
            </tbody>
        </table>
        <div class="blu">
            <a href="?cmd=productoffer&action=add" class="btn btn-default btn-sm">Add new offer</a>
            <div class="right">
                <div class="pagination"></div>
            </div>
            <div class="clear"></div>
        </div>
        {securitytoken}
    </form>
{/if}