<hr>
<input type="hidden" name="remove" value=""  id="form-group-remove-list"/>
<div class="ajax_container">
    <div class="container-fluid row">
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">Applied items</div>
                <div id="applied-container" class="list-group section-applies"></div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="pull-right" >
                        <input type="checkbox" class="search_form_exact"/> Exact match
                    </div>
                    Suggested items to apply
                </div>
                <div class="list-group">
                    <div class="list-group-item">
                        <input type="text" placeholder="Search items"
                               class="search_forms form-control">
                    </div>
                    <div id="result-container" class="section-applies"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<hr>
{include file='formgroups/applies.hbs.tpl'}
{literal}
<script>
    setFormGroupDara({
        type: 'form_item_group',
        param: 'item_id',
        confirm: 'Do you really want to remove this item from group?',
        group: {/literal}{$group|@json_encode}{literal},
    })
</script>
{/literal}