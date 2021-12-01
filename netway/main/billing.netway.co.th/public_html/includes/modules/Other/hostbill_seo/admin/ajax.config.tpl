{literal}
    <style type="text/css">
        #seo_form {
            font-size: 11px !important;
            padding-top: 20px;
        }
    </style>
    <script type="text/javascript">
        $(document).on('click', '#seo_btn', function (e) {
            e.preventDefault();
            var data = $('#seo_form').serializeForm();
            $('#seo_btn').next().text('');
            $.post('index.php?cmd=module', data, function (data) {
                if (data.status == 'ok') {
                    $('#seo_btn').next().text('saved');
                }
            }, 'json');
        });
    </script>
{/literal}

<div class="newhorizontalnav" id="newshelfnav-config">
    {if $brands}
        <div class="list-2">
            <div class="subm1 haveitems">
                <ul class="list-2-ul">
                    {foreach from=$brands item=brand}
                        <li {if $brand.id == 1}class="picked" {/if}><a href="#brand_{$brand.id}"><span>{$brand.name}</span></a></li>
                    {/foreach}
                </ul>
            </div>
        </div>
    {/if}
</div>
<form class="panel panel-default" id="seo_form">
    <input type="hidden" value="{$moduleid}" name="module">
    <input type="hidden" value="{$type}" name="update">
    <input type="hidden" value="{$id}" name="eid">
    <div id="seo-config">
        {if $brands}
            {foreach from=$brands item=brand}
                <div class="panel-body">
                    <div class="form-group" id="seo_title">
                        <label>SEO Title</label>
                        {if is_array($data.title)}
                            {hbinput id="seotitle" value=$data.title[$brand.id]|escape  name="seotitle[`$brand.id`]" class="form-control"}
                        {else}
                            {hbinput id="seotitle" value=$data.title|escape  name="seotitle[`$brand.id`]" class="form-control"}
                        {/if}
                        <div class="help-block">
                            Title is limited to <font style="color: red">70</font> characters.
                        </div>
                    </div>
                    <div class="form-group" id="seo_description">
                        <label>SEO Description</label>
                        {if is_array($data.description)}
                            {hbwysiwyg value=$data.description[$brand.id]|escape class="form-control"
                            rows="6" id="seodescription" name="seodescription[`$brand.id`]" blockwysiwyg="true" wrapper="div"}
                        {else}
                            {hbwysiwyg value=$data.description|escape class="form-control"
                            rows="6" id="seodescription" name="seodescription[`$brand.id`]" blockwysiwyg="true" wrapper="div"}
                        {/if}
                        <div class="help-block">
                            Description of the page is limited to the <font style="color: red">155</font> characters.
                        </div>
                    </div>
                    <div class="form-group" id="seo_keywords">
                        <label>SEO Keywords</label>
                        {if is_array($data.keywords)}
                            {hbinput id="seokeywords" value=$data.keywords[$brand.id]|escape  name="seokeywords[`$brand.id`]" class="form-control"}
                        {else}
                            {hbinput id="seokeywords" value=$data.keywords|escape  name="seokeywords[`$brand.id`]" class="form-control"}
                        {/if}
                    </div>
                    <a id="seo_btn" href="#" class="btn btn-success btn-xs">Update SEO configuration</a>
                    <span id="seo_saved"></span>
                </div>
            {/foreach}
        {else}
            <div class="panel-body">
                <div class="form-group" id="seo_title">
                    <label>SEO Title</label>
                    {hbinput id="seotitle" value=$data.title|escape  name="seotitle" class="form-control"}
                    <div class="help-block">
                        Title is limited to <font style="color: red">70</font> characters.
                    </div>
                </div>
                <div class="form-group" id="seo_description">
                    <label>SEO Description</label>
                    {hbwysiwyg value=$data.description|escape class="form-control"
                    rows="6" id="seodescription" name="seodescription" blockwysiwyg="true" wrapper="div"}
                    <div class="help-block">
                        Description of the page is limited to the <font style="color: red">155</font> characters.
                    </div>
                </div>
                <div class="form-group" id="seo_keywords">
                    <label>SEO Keywords</label>
                    {hbinput id="seokeywords" value=$data.keywords|escape  name="seokeywords" class="form-control"}
                </div>
                {if $brand_active}
                    <div class="content" style="padding-bottom: 20px;">
                        <div class="row">
                            <div class="col-sm-12">
                                <h4>Variables available:</h4>
                            </div>
                            <div class="col-sm-12">
                                <ul>
                                    <li><code>{ldelim}$brand.name{rdelim}</code></li>
                                    <li><code>{ldelim}$brand.custom_1{rdelim}</code></li>
                                    <li>...</li>
                                    <li><code>{ldelim}$brand.custom_9{rdelim}</code></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                {/if}
                <a id="seo_btn" href="#" class="btn btn-success btn-xs">Update SEO configuration</a>
                <span id="seo_saved"></span>
            </div>
        {/if}
    </div>

</form>
<input type="hidden" name="picked_tab" id="picked-tab-config" value="0"/>
{literal}
    <script>
        $(function () {
            var pickedTab = $('#picked-tab-config'),
                tabMenu = $('#newshelfnav-config');

            tabMenu.find('.subm1 li').on('click', function(){
                pickedTab.val($(this).index());
            });

            tabMenu.TabbedMenu({
                elem: '#seo-config > .panel-body',
                picker: '.subm1 li',
                picked: pickedTab.val() || 0,
                picktab: true
            });
        })
    </script>
{/literal}