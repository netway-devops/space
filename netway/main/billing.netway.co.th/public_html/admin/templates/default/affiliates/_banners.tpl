<script id="banner-template-item" type="text/x-custom-template">
    <div class="banner-box-item">
        {foreach from=$client_languages item=langg}
            {$langg|ucfirst}:
            <br>
            <input style="margin-bottom:10px;width: 700px;" type="text"
                   name="AffIntegrationBanners[catid123][banners][itid123][{$langg}]" class="inp">
            <br>
        {/foreach}
        <a href="#" style="color: red;" class="btn btn-sm btn-default banner_removeInput">Remove</a>
        <br>
    </div>
</script>

<script id="banner-template-category" type="text/x-custom-template">
    <div class="tab-pane" id="bannercatcatid123" data-cat="catid123">
        <p><b>Category name:</b></p>
        <div class="form-group" style="width: 400px;">
            <input type='text' name='AffIntegrationBanners[catid123][name]' class='form-control af_translate_input'
                   id='af_translate_input_catid123' value="New category name"/>
            <div class='l_editor l_editor_af_translate_input'><span class='translations'><span
                            style="display: none;" class='taag'>Tags: </span></span>
                <a class='fs11 editbtn l_adder banner_addTranslation' data-input="af_translate_input_catid123" href='#'>Add
                    translation</a>
                <div class='clear'></div>
            </div>
        </div>
        <p><b>Banners:</b></p>
        <div class="banner-box">
            <div class="banner_addInput"><a href="#">Add item</a></div>
        </div>
    </div>
</script>

Integration banners:
<br/>
<div class="banner-example">
    {assign var=banner_example value="<img width='250' height='250' src='https://example.com/banners/banner.gif' alt='banner_250x250'>"}
    <small>Example: </small><br>
    <pre>{$banner_example|escape}</pre>
</div>

<div class="banner-categories">
    <ul class="nav nav-tabs">
        {foreach from=$configuration.AffIntegrationBanners key=category_key item=category}
            <li>
                <a href="#bannercat{$category_key}" data-toggle="tab">{$category.name}</a>
                <span class="banner_removeCategory">x</span>
            </li>
        {/foreach}
        <li class="add_category"><a href="#" class="banner_addCategory" data-toggle="tab">+</a></li>
    </ul>
    <div class="tab-content">
        {foreach from=$configuration.AffIntegrationBanners key=category_key item=category}
            <div class="tab-pane" id="bannercat{$category_key}" data-cat="{$category_key}">
                <p><b>Category name:</b></p>
                <div class="form-group" style="width: 400px;">
                    <input type='text' name='AffIntegrationBanners[{$category_key}][name]'
                           class='form-control af_translate_input' id='af_translate_input_{$category_key}'
                           value="{$category.name|escape}"/>
                    <div class='l_editor l_editor_af_translate_input'><span class='translations'><span
                                    style="display: none;" class='taag'>Tags: </span></span>
                        <a class='fs11 editbtn l_adder banner_addTranslation' href='#'
                           data-input="af_translate_input_{$category_key}">Add translation</a>
                        <div class='clear'></div>
                    </div>
                </div>
                <p><b>Banners:</b></p>
                <div class="banner-box">
                    {foreach from=$category.banners key=banner_key item=banners}
                        <div class="banner-box-item">
                            {foreach from=$client_languages item=lang_key}
                                {$lang_key|ucfirst}:
                                <br>
                                <input style="margin-bottom:10px;width: 700px;" type="text"
                                       name="AffIntegrationBanners[{$category_key}][banners][{$banner_key}][{$lang_key}]"
                                       class="inp" value="{$banners[$lang_key]|escape}">
                                <br>
                            {/foreach}
                            <a href="#" style="color: red;" class="btn btn-sm btn-default banner_removeInput">Remove</a>
                            <br>
                        </div>
                    {/foreach}
                    <div class="banner_addInput"><a href="#">Add item</a></div>
                </div>
            </div>
        {/foreach}
    </div>
</div>

{literal}
    <script type="text/javascript">
        function randomId() {
            return Math.random().toString(36).substr(2, 9);
        }
        function handleTranslations($name) {
            const regex = /({\$lang\..*?})/gm;
            let $m;
            let $parsed = "";
            let $last;
            while (($m = regex.exec($name)) !== null) {
                if ($m.index === regex.lastIndex) {
                    regex.lastIndex++;
                }
                $m.forEach((line, groupIndex) => {
                    var $a = line;
                    $a = $a.replace('{$lang.', '');
                    $a = $a.replace('}', '');
                    if ($a === $last)
                        return;
                    $last = $a;
                    $parsed = $parsed + '<a href="?cmd=langedit&action=bulktranslate&key=' + $a + '" target="_blank">' + line + '</a>';
                });
            }
            return $parsed;
        }
        $(document).on("click", ".nav-tabs li:not(.add_category) a", function (e) {
            e.preventDefault();
            $(this).tab('show');
        });
        $(document).on('click', '.banner_addCategory', function (e) {
            e.preventDefault();
            var id = randomId(),
                    tabHtml = '<li><a href="#bannercat' + id + '">New category</a><span class="banner_removeCategory">x</span></li>',
                    boxHtml = $('#banner-template-category').html().replace(/catid123/g, id);

            $(this).parent('li').before(tabHtml);
            $('.banner-categories .tab-content').append(boxHtml);
            $(".nav-tabs").find(':not(.add_category) a').last().tab('show');
        });
        $(document).on('click', '.banner_removeCategory', function (e) {
            e.preventDefault();
            if (!confirm("The category will be deleted. Are you sure?"))
                return false;
            $($(this).prev('a').attr('href')).remove();
            $(this).parent().remove();
        });
        $(document).on('click', '.banner_addInput', function (e) {
            e.preventDefault();
            var id = randomId(),
                    catId = $(this).closest('.tab-pane').attr('data-cat'),
                    template = $('#banner-template-item').html().replace(/itid123/g, id).replace(/catid123/g, catId),
                    par = $(this).closest('.banner-box');
            $(par).find('.banner_addInput').before(template);
        });
        $(document).on('click', '.banner_removeInput', function (e) {
            e.preventDefault();
            $(this).closest('.banner-box-item').remove();
        });
        function escapeHtml(text) {
            var map = {
                '&': '&amp;',
                '<': '&lt;',
                '>': '&gt;',
                '"': '&quot;',
                "'": '&#039;'
            };

            return text.replace(/[&<>"']/g, function(m) { return map[m]; });
        }
        function parseTranslations(input) {
            var id = input.closest('.tab-pane').attr('id'),
                    val = input.val(),
                    transs = input.closest('.tab-pane').find('.l_editor_af_translate_input .translations');
            if (!val) val = '_';
            $('.nav-tabs').find('a[href="#' + id + '"]').html(escapeHtml(val));
            var $parsed = handleTranslations(val);
            transs.children().not('.taag').remove();
            transs.append($parsed);
        }
        $(document).on('change input', '.af_translate_input', function () {
            parseTranslations($(this));
        });
        $(document).on('click', '.banner_addTranslation', function (e) {
            e.preventDefault();
            var elem = $(this).attr('data-input');
            HBInputTranslate.addTranslation(elem);
            setTimeout(function () {
                parseTranslations($('#' + elem));
            }, 300);
        });
        $(function () {
            $('.nav-tabs').find('li').first().find('a').tab('show');
            $('.af_translate_input').each(function () {
                parseTranslations($(this));
            });
        });
    </script>
{/literal}
{literal}
    <style>
        .banner-box-item {
            width: 710px;
            background: #fafafa;
            padding: 10px 5px;
            margin-bottom: 10px;
        }

        .banner-example {
            font-size: 12px;
            color: #999;
            margin: 10px 0;
        }

        .banner-categories {
            background: #eee;
            margin-bottom: 20px;
        }

        .banner-categories .tab-content {
            padding: 10px;
        }

        .banner-categories .nav-tabs > li {
            position: relative;
        }

        .banner-categories .nav-tabs > li:not(.add_category) {
            padding-right: 14px;
        }

        .banner-categories .nav-tabs > li > a {
            display: inline-block;
            text-decoration: none;
            padding: 5px 10px;
            color: #888;
        }

        .banner-categories .nav-tabs > li:hover:not(.active) {
            background: #dbdbdb;
            text-decoration: none;
            color: #555;
            cursor: pointer;
        }

        .banner-categories .nav-tabs > li:hover:not(.active) > a {
            background: none;
            border: 1px solid #ddd;
        }

        .banner-categories .nav-tabs > li.active {
            background-color: #fff;
            border: 1px solid #ddd;
            border-bottom-color: transparent;
            cursor: default;
        }

        .banner-categories .nav-tabs > li.active > a {
            color: #555;
            background: none;
            border: none;
            border-bottom-color: transparent;
            cursor: default;
        }

        .banner-categories .nav-tabs > li.add_category {
            background: #eee;
            border-bottom: 1px solid #ddd;
        }

        .banner-categories .nav-tabs > li.add_category > a {
            font-size: 20px;
            text-align: center;
            line-height: 17px;
            background: #eee;
            color: #888;
        }

        .banner-categories .nav-tabs > li.add_category:hover {
            background: #dbdbdb;
        }

        .banner-categories .nav-tabs > li.add_category:hover > a {
            background: #dbdbdb;
            cursor: pointer;
        }

        .banner-categories .nav-tabs > li > span {
            display: none;
            cursor: pointer;
            position: absolute;
            color: #dd4444;
            height: 100%;
            right: 0;
            text-align: center;
            width: 22px;
            line-height: 27px;
            top: 0;
            margin: 0;
        }

        .banner-categories .nav-tabs > li > span:hover {
            background: #ccc;
        }

        .banner-categories .nav-tabs > li.active > span:hover {
            background: #eee;
        }

        .banner-categories .nav-tabs > li:hover > span {
            display: inline-block;
        }
    </style>
{/literal}