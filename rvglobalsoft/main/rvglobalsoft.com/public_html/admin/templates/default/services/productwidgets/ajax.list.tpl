{if $widgets}
    <ul id="grab-sorter2" class="grab-sorter product-wiegets-list">
        {foreach from=$widgets item=widget key=k}
            <li class="product-widget {if $widget.unique}unique{/if} {if $widget.assigned}active{else}disabled{/if} w{$widget.widget_id}"
                id="widget-{$widget.id}" data-widget="{$widget.widget_id}" data-ids="{$widget.ids|@json_encode|escape}">
                <div class="row">
                    {if $widget.parent}
                        <div class="pull-right badge">
                            {if $lang[$widget.parent.name]}{$lang[$widget.parent.name]}
                            {else}{$widget.parent.name}
                            {/if}
                        </div>
                    {/if}

                    <div class="col-md-3">
                        {if $widget.id}
                            <input type="hidden" name="sort[]" value="{$widget.id}" class="ser"/>
                        {/if}
                        <a name="f{$widget.id}"></a>

                        <div class="btn-group">
                            <a class="sorter-ha btn-default btn btn-sm">
                                <i class="fa fa-sort"></i>
                            </a>

                            <a class="widget-edit btn btn-default btn-sm" title="{$lang.Edit}"
                               data-widget="{$widget.widget_id}" data-id="{$widget.id}">
                                <i class="fa fa-pencil"></i>
                            </a>
                        </div>

                        <div class="btn-group">
                            <a class="widget-toggle widget-disable btn btn-default btn-sm"
                               data-widget="{$widget.widget_id}" data-id="{$widget.id}">
                                <i class="fa fa-toggle-on"></i> Disable
                            </a>

                            <a class="widget-toggle widget-enable btn btn-default btn-sm"
                               data-widget="{$widget.widget_id}"">
                            <i class="fa fa-toggle-off"></i> Enable
                            </a>
                        </div>

                    </div>
                    <div class="col-md-7">
                        {$widget.name}
                    </div>
                </div>
            </li>
        {/foreach}
    </ul>
{else}
    <div class="blank_state_smaller blank_forms">
        <div class="blank_info">
            {if $bulk}
                {if !$product_id}
                    <h3>Selecte some products to display available client functions</h3>
                {else}
                    <h3>No client functions available. Selected product do not have or do not share the same client functions.</h3>
                {/if}
            {else}
                <h3>{$lang.widgetsbs}</h3>
                <div class="clear"></div>
                <br/>
                <a href="#" class="new_control" onclick="return HBWidget.addCustomWidgetForm();">
                    <span class="addsth"><strong>{$lang.assign_custom_widg}</strong></span>
                </a>
            {/if}
            <div class="clear"></div>

        </div>
    </div>
{/if}
{literal}
    <script type="text/javascript">
        HBWidget.init()
    </script>
{/literal}

