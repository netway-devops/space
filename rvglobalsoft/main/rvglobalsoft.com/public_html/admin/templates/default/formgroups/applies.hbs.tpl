{literal}
    <style>
        .form-group-item{
            padding: 4px 10px;
            text-decoration: none;
        }
        .form-group-item .fa{
            color: #808080;
            line-height: 20px;
        }
        .applied-actions{
            margin: -3px -8px 0 0;
            padding: 0 0 0 15px;
        }
    </style>
    <script id="applied-template" type="text/x-handlebars-template">
        {{#if items}}
            {{#each items}}
                <div class="list-group-item form-group-item-group">
                    <div class="pull-right applied-actions">
                        <a href="?cmd=services&action=product&id={{product_id}}&picked_tab=4&picked_subtab=0"
                        target="_blank" class="btn btn-sm btn-default">
                            <i class="fa fa-external-link"></i>
                            Go to product
                        </a>
                        <a style="color: red;" href="{{../url}}{{id}}" data-id="{{id}}"
                           class="menuitm menu-auto do-unapply">
                            Remove from group
                        </a>
                    </div>
                    <strong>{{category_name}} - {{product_name}} </strong> - {{fullname}}
                    {{#if unapplied}}<input type="hidden" name="{{../form_param}}[]" value="{{id}}" />{{/if}}
                </div>
            {{/each}}
        {{else}}
            <div class="list-group-item form-group-item-group">
                <span class="center">Nothing added yet</span>
            </div>
        {{/if}}
    </script>
    <script id="forms-template" type="text/x-handlebars-template">
        {{#if suggested}}
            {{#each suggested}}
                <div class="list-group-item form-group-item-group">
                    <strong class="list-group-item-headin">{{@key}}</strong>
                    {{#each this}}
                        <a href="{{../../url}}{{id}}" data-id="{{id}}" class="list-group-item form-group-item do-apply">
                            <i class="fa fa-plus pull-right"></i>
                            {{name}}
                        </a>
                    {{/each}}
                </div>
            {{/each}}
        {{else}}
            <div class="list-group-item els_nothing">
                {{nothing_msg}}
            </div>
        {{/if}}
        {{#if hidden}}
            <a class="list-group-item list-group-item-warning form-group-item-group-more" data-offset="{{next_offset}}">
                There are {{hidden}} hidden items, click here to show more or narrow your search criteria.
            </a>
        {{/if}}
    </script>
{/literal}