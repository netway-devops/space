<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li>
                <a href="?cmd=services"><span class="ico money">{$lang.orpages}</span></a>
            </li>
            {if $category}
                <li>
                    <a href="?cmd=services&action=category&id={$category.id}"><span
                                class="ico money">{$category.name}</span></a>
                </li>
            {else}
                <li class="">
                    <a href="?cmd=services&action=addcategory"><span class="ico formn">{$lang.addneworpage}</span></a>
                </li>
            {/if}
            <li class="active last">
                <a href="?cmd=services&action=bulkupdate&cat_id=50{$category.id}"><span
                    >Bulk Update</span></a>
            </li>
        </ul>
    </div>
</div>

<div class="nicerblu" style="height: 10px;"></div>
<form id="serializeit" action="" method="post">
    <div class="container-fluid clear lighterblue" style="padding-top:14px; padding-bottom: 14px;">
        <div class="row">
            <div class="col-lg-12 col-sm-12 col-md-12">
                <div class="form-group">
                    <label>Select what you wish to update</label>
                    <select name="actiontype" class="form-control" id="bulk-action-select">
                        <option value="updateprices" {if $actiontype == 'updateprices'}selected{/if}>Update prices
                        </option>
                        <option value="updatetags" {if $actiontype == 'updatetags'}selected{/if}>Update tags</option>
                        <option value="updatewidgets" {if $actiontype == 'updatewidgets'}selected{/if}>Update client
                            functions
                        </option>
                        <option value="copysettings" {if $actiontype == 'copysettings'}selected{/if}>Copy settings</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row" id="bulk-action">
            {include file="services/bulk/ajax.`$actiontype`.tpl"}
        </div>
    </div>
    {securitytoken}
</form>
{literal}
    <script>
        $(function () {
            var bulkact = $('#bulk-action-select');
            bulkact.on('change', function () {
                $('#serializeit').off('.bulk');
                $('#bulk-action').addLoader();

                $.post(window.location.href, {
                    actiontype: bulkact.val(),
                    product: $('#products').val()
                }, function (data) {
                    $('#bulk-action').html(parse_response(data));
                })
            })
        })
    </script>
{/literal}