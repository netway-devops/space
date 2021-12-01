<form action="" method="post" id="seo-form">

    <input type="hidden" value="{$currentpage}" name="currentpage" id="main-tab"/>
    <input type="hidden" name="picked_tab" id="picked-tab" value="{$picked_tab|default:0}"/>
    <div class="newhorizontalnav" id="newshelfnav">
        <div class="list-1">
            <ul class="tabss">
                {foreach from=$availpages item=apg name=fl}
                    <li {if $currentpage === $apg}class="active picked"{/if} data-tab="{$apg}" id="tab-{$apg}">
                        <a href="" onclick="switchPage('{$apg}'); return false;"
                           class="tchoice {if $currentpage == $apg}picked{/if}">
                            {if $apg == 'root'}Main Page{else}{$apg|capitalize}{/if}
                        </a>
                    </li>
                {/foreach}
            </ul>
        </div>
        {if $brands}
            <div class="list-2">
                <div class="subm1 haveitems">
                    <ul class="list-2-ul">
                        {foreach from=$brands item=brand name=bl}
                            <li {if $picked_tab == $smarty.foreach.bl.index}class="picked"{/if}>
                                <a href="#brand_{$brand.id}"><span>{$brand.name}</span></a>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        {/if}
    </div>

    {foreach from=$availpages item=apg}
        <div id="" class='page_{$apg} nicerblu {if $currentpage == $apg}page_shown'{else}' style="display:none"{/if}>
        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike hover tableform_{$apg}">
            {if $brands}
                {foreach from=$brands item=brand}
                    <tbody>
                    <tr>
                        <td width="150" valign="top" style="padding: 20px; font-weight:bold; text-align: right;">SEO
                            Title
                        </td>
                        <td style="padding: 20px;">
                            {if is_array($seoconfig.$apg.title)}
                                {hbinput value=$seoconfig.$apg.title[$brand.id]|escape
                                name="seoconfig[`$apg`][title][`$brand.id`]" class="form-control"}
                            {else}
                                {hbinput value=$seoconfig.$apg.title|escape
                                name="seoconfig[`$apg`][title][`$brand.id`]" class="form-control"}
                            {/if}
                            <small>Title is limited to <font style="color: red">70</font> characters.</small></td>
                    </tr>
                    <tr>
                        <td valign="top" style="padding: 20px;font-weight:bold; text-align: right;">Description</td>
                        <td style="padding: 20px;">
                            {if is_array($seoconfig.$apg.description)}
                                {hbwysiwyg value=$seoconfig.$apg.description[$brand.id]|escape class="form-control"
                                rows="6" name="seoconfig[`$apg`][description][`$brand.id`]" blockwysiwyg="true" wrapper="div"}
                            {else}
                                {hbwysiwyg value=$seoconfig.$apg.description|escape class="form-control"
                                rows="6" name="seoconfig[`$apg`][description][`$brand.id`]" blockwysiwyg="true" wrapper="div"}
                            {/if}

                            <small>Description of the page is limited to the <font style="color: red">155</font>
                                characters.</small></td>
                    </tr>
                    <tr>
                        <td valign="top" style="padding: 20px;font-weight:bold; text-align: right;">Keywords</td>
                        <td style="padding: 20px;">
                            {if is_array($seoconfig.$apg.keywords)}
                                {hbwysiwyg value=$seoconfig.$apg.keywords[$brand.id]|escape class="form-control"
                                rows="6" name="seoconfig[`$apg`][keywords][`$brand.id`]" blockwysiwyg="true" wrapper="div"}
                            {else}
                                {hbwysiwyg value=$seoconfig.$apg.keywords|escape class="form-control"
                                rows="6" name="seoconfig[`$apg`][keywords][`$brand.id`]" blockwysiwyg="true" wrapper="div"}
                            {/if}
                        </td>
                    </tr>
                    </tbody>
                {/foreach}
            {else}
                <tbody>
                <tr>
                    <td width="150" valign="top" style="padding: 20px; font-weight:bold; text-align: right;">SEO Title
                    </td>
                    <td style="padding: 20px;">
                        {hbinput value=$seoconfig.$apg.title|escape
                        name="seoconfig[`$apg`][title]" class="form-control"}
                        <small>Title is limited to <font style="color: red">70</font> characters.</small></td>
                </tr>
                <tr>
                    <td valign="top" style="padding: 20px;font-weight:bold; text-align: right;">Description</td>
                    <td style="padding: 20px;"
                    ">
                    {hbwysiwyg value=$seoconfig.$apg.description|escape class="form-control"
                    rows="6" name="seoconfig[`$apg`][description]" blockwysiwyg="true" wrapper="div"}
                    <small>Description of the page is limited to the <font style="color: red">155</font>
                        characters.</small></td>
                </tr>
                <tr>
                    <td valign="top" style="padding: 20px;font-weight:bold; text-align: right;">Keywords</td>
                    <td style="padding: 20px;">
                        {hbwysiwyg value=$seoconfig.$apg.keywords|escape class="form-control"
                        rows="6" name="seoconfig[`$apg`][keywords]" blockwysiwyg="true" wrapper="div"}
                    </td>
                </tr>
                </tbody>
            {/if}
        </table>
        </div>
    {/foreach}
    <div class="lighterblue" style="padding: 10px">
        <div style="padding: 10px">
            <input class="btn btn-primary" type="submit" name="savecharges" value="Save Changes"/>
        </div>
    </div>
    {securitytoken}
</form>

<script>
    var pages = [];
    {foreach from=$availpages item=apg}
    pages.push('{$apg}');
    {/foreach}
</script>
{literal}
    <script>
        function switchPage(pag) {

            var elem = $('#tab-' + pag);
            $('#main-tab').val(pag);

            $('.page_shown').hide().removeClass('page_shown');
            $('.page_' + pag).show().addClass('page_shown');
            $('li', '#newshelfnav').removeClass('picked').removeClass('active');

            elem.addClass('picked').addClass('active');

            var p = parseInt($('#picked-tab').val()) || 0;
            $('.list-2-ul').children().each(function (i, v) {
                if (i === p) {
                    $(v).click();
                    return false;
                }
            })
        }

        $(function () {
            var mainTab = $('#main-tab').val() || 'root',
                pickedTab = $('#picked-tab'),
                tabMenu = $('#newshelfnav');

            switchPage(mainTab)

            tabMenu.find('.subm1 li').on('click', function(){
                pickedTab.val($(this).index());
            });

            $.each(pages, function (i, v) {
                tabMenu.TabbedMenu({
                    elem: '.tableform_' + v + ' > tbody',
                    picker: '.subm1 li',
                    picked: pickedTab.val() || 0,
                    picktab: true,
                });
            });

            // $('#seo-form').on('submit', function (e){
            //     e.preventDefault();
            //     var form = $(this),
            //         data = form.serializeForm();
            //     form.addLoaders();
            //
            //     data.savecharges = 1;
            //     $.post(window.location.href, data, function(data){
            //         parse_response(data);
            //         form.hideLoader();
            //     })
            //     return false;
            // })
        })
    </script>
{/literal}