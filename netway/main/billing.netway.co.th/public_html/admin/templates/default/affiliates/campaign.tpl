<link rel="stylesheet" href="{$template_dir}js/gui.elements.css" type="text/css" />
<script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>
<form action="" method="post">
    {include file="affiliates/configuration_header.tpl"}
    <div class="lighterblue2">
        <table border="0" cellpadding="6" cellspacing="0" width="100%">
            <tr>
                <td width="160" align="right"><label for="name"><strong>{$lang.Name}</strong></label></td>
                <td>{hbinput id="name" value=$campaign.name style="width:700px;" size="" name="name" class="inp"}</td>
            </tr>
            <tr>
                <td width="160" align="right"><label for="campid"><strong>Campaign ID</strong></label></td>
                <td><input type="text" id="campid" style="width:700px;" name="campid" value="{$campaign.campid}"></td>
            </tr>
            <tr>
                <td align="right"><label for="status"><strong>{$lang.Status}</strong></label></td>
                <td>
                    <select class="inp" name="status" id="status">
                        <option value="Draft" {if $campaign.status=='Draft'}selected="selected"{/if}>{$lang.Draft}</option>
                        <option value="Active" {if $campaign.status=='Active'}selected="selected"{/if}>{$lang.Active}</option>
                        <option value="Inactive" {if $campaign.status=='Inactive'}selected="selected"{/if}>{$lang.Inactive}</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right"><strong>Description</strong></td>
                <td>{hbwysiwyg value=$campaign.description style="width:700px;" class="inp wysiw_editor" cols="100" rows="6" id="description" name="description" featureset="full"}</td>
            </tr>
            <tr>
                <td width="160" align="right"><label for="redirect_url"><strong>Redirect URL</strong></label></td>
                <td><input type="text" name="redirect_url" id="redirect_url" style="width:700px;" value="{$campaign.redirect_url}"></td>
            </tr>
            <tr>
                <td align="right"><label for="date_start"><strong>Start date</strong></label></td>
                <td>
                    <input name="date_start" id="date_start" class="inp config_val haspicker dp-applied" value="{$campaign.date_start|dateformat:$date_format}">
                </td>
            </tr>
            <tr>
                <td align="right"><label for="date_end"><strong>End Date</strong></label></td>
                <td>
                    <input type="checkbox" name="date_end_check" value="1" onclick="check_i(this)" style="float:left" {if $campaign && $campaign.date_end!='0000-00-00'}checked="checked"{/if}/>
                    <input name="date_end" class="inp config_val haspicker" {if !$campaign || $campaign.date_end==''} disabled="disabled"{/if} {if $campaign.date_end}value="{$campaign.date_end|dateformat:$date_format}"{/if}/>
                </td>
            </tr>
            <tr>
                <td width="160" align="right"><strong>{$lang.notesadmin}</strong></td>
                <td>
                    <textarea name="notes" class="form-control">{if $campaign.notes}{$campaign.notes}{/if}</textarea>
                </td>
            </tr>
            <tr>
                <td width="160" align="right"><strong>Integration codes</strong></td>
                <td>
                    <div class="banner-example">
                        <small>Examples: </small><br>
                        <pre>{$banner_example1|escape}
                            <br>{$banner_example2|escape}<hr>{literal}{$affcampurl}{/literal} will be replaced with campaign URL in clientarea</pre>
                    </div>

                    <div class="banner-categories">
                        <ul class="nav nav-tabs">
                            {foreach from=$campaign.banners key=banner_key item=banner}
                                <li>
                                    <a href="#banner{$banner_key}" data-toggle="tab">{$banner.name}</a>
                                    <span class="banner_removeBanner">x</span>
                                </li>
                            {/foreach}
                            <li class="add_banner"><a href="#" class="banner_addBanner" data-toggle="tab">+</a></li>
                        </ul>
                        <div class="tab-content">
                            {foreach from=$campaign.banners key=banner_key item=banner}
                                <div class="tab-pane" id="banner{$banner_key}">
                                    <p><b>Banner name:</b></p>
                                    <div class="form-group" style="width: 400px;">
                                        <input type='text' name='banners[{$banner_key}][name]' class='form-control af_translate_input' id='af_translate_input_{$banner_key}' value="{$banner.name}" />
                                        <div class='l_editor l_editor_af_translate_input'><span class='translations'><span style="display: none;" class='taag'>Tags: </span></span>
                                            <a class='fs11 editbtn l_adder banner_addTranslation' data-input="af_translate_input_{$banner_key}" href='#'>Add translation</a>
                                            <div class='clear'></div>
                                        </div>
                                    </div>
                                    <div class="banner-box">
                                        <div class="banner-box-item">
                                            {foreach from=$client_languages item=lang_key}
                                                {$lang_key|ucfirst}:
                                                <br>
                                                <input style="margin-bottom:10px;width: 700px;" type="text" name="banners[{$banner_key}][inputs][{$lang_key}]" class="inp" value="{$banner.inputs[$lang_key]|escape}">
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                    </div>

                </td>
            </tr>
        </table>
    </div>
    <div class="blu">
        <table border="0" cellpadding="2" cellspacing="0" >
            <tr>
                <td><a href="?cmd={$cmd}&action=campaigns"><strong>&laquo; {$lang.backto} {$lang.affcampaigns}</strong></a>&nbsp;</td>
                <td>
                    <input type="hidden" name="make" value="{$make}">
                    <input type="hidden" name="id" value="{$campaign.id}">
                    <input type="submit" name="save" class="btn btn-sm btn-primary" value="{if $make=='add'}{$lang.addcampaign}{else}{$lang.savechanges}{/if}" style="font-weight:bold;"/>
                </td>
            </tr>
        </table>
    </div>
    {securitytoken}
        <script id="banner-template" type="text/x-custom-template">
            <div class="tab-pane" id="banneritid123">
                <p><b>Banner name:</b></p>
                <div class="form-group" style="width: 400px;">
                    <input type='text' name='banners[itid123][name]' class='form-control af_translate_input' id='af_translate_input_itid123' value="New banner name"/>
                    <div class='l_editor l_editor_af_translate_input'><span class='translations'><span style="display: none;" class='taag'>Tags: </span></span>
                        <a class='fs11 editbtn l_adder banner_addTranslation' data-input="af_translate_input_itid123" href='#'>Add translation</a>
                        <div class='clear'></div>
                    </div>
                </div>
                <div class="banner-box">
                    <div class="banner-box-item">
                        {foreach from=$client_languages item=langg}
                            {$langg|ucfirst}:
                            <br>
                            <input style="margin-bottom:10px;width: 700px;" type="text" name="banners[itid123][inputs][{$langg}]" class="inp">
                            <br>
                        {/foreach}
                    </div>
                </div>
            </div>
        </script>

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
                $(document).on("click", ".nav-tabs li:not(.add_banner) a", function (e) {
                    e.preventDefault();
                    $(this).tab('show');
                });
                $(document).on('click', '.banner_addBanner', function (e) {
                    e.preventDefault();
                    var id = randomId(),
                            tabHtml = '<li><a href="#banner' + id + '">New banner name</a><span class="banner_removeBanner">x</span></li>',
                            boxHtml = $('#banner-template').html().replace(/itid123/g, id);

                    $(this).parent('li').before(tabHtml);
                    $('.banner-categories .tab-content').append(boxHtml);
                    $(".nav-tabs").find(':not(.add_banner) a').last().tab('show');
                });
                $(document).on('click', '.banner_removeBanner', function (e) {
                    e.preventDefault();
                    if (!confirm("The banner will be deleted. Are you sure?"))
                        return false;
                    $($(this).prev('a').attr('href')).remove();
                    $(this).parent().remove();
                });
                function parseTranslations(input) {
                    var id = input.closest('.tab-pane').attr('id'),
                            val = input.val(),
                            transs = input.closest('.tab-pane').find('.l_editor_af_translate_input .translations');
                    if (!val) val = '_';
                    $('.nav-tabs').find('a[href="#' + id + '"]').html(val);
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

                .banner-categories .nav-tabs > li:not(.add_banner) {
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

                .banner-categories .nav-tabs > li.add_banner {
                    background: #eee;
                    border-bottom: 1px solid #ddd;
                }

                .banner-categories .nav-tabs > li.add_banner > a {
                    font-size: 20px;
                    text-align: center;
                    line-height: 17px;
                    background: #eee;
                    color: #888;
                }

                .banner-categories .nav-tabs > li.add_banner:hover {
                    background: #dbdbdb;
                }

                .banner-categories .nav-tabs > li.add_banner:hover > a {
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
</form>
{literal}
    <script>
        function string_to_slug (str) {
            str = str.replace(/^\s+|\s+$/g, ''); // trim
            str = str.toLowerCase();
            // remove accents, swap ñ for n, etc
            var from = "àáäâèéëêìíïîòóöôùúüûñçćśąęółżźń·/_,:;";
            var to   = "aaaaeeeeiiiioooouuuunccsaeolzzn--_---";
            for (var i=0, l=from.length ; i<l ; i++) {
                str = str.replace(new RegExp(from.charAt(i), 'g'), to.charAt(i));
            }
            str = str.replace(/[^a-z0-9 _-]/g, '') // remove invalid chars
                .replace(/\s+/g, '-') // collapse whitespace and replace by -
                .replace(/-+/g, '-'); // collapse dashes
            return str;
        }
        $('#name').keyup(function(){
            $('#campid').val(string_to_slug($(this).val()).toLowerCase());
        });
        function check_i(element) {
            var td = $(element).parent();
            if ($(element).is(':checked'))
                $(td).find('.config_val').removeAttr('disabled');
            else
                $(td).find('.config_val').attr('disabled', 'disabled');
        }
    </script>
{/literal}
