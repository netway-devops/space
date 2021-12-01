{literal}
    <style type="text/css">
        #seo_form a.menuitm, #seo_form a.greenbtn {
            display: inline-block;
            line-height: 14px;
            height: 14px;
            vertical-align: middle;
            margin: 10px 6px 8px 0px;
        }

        #seo_form {
            font-size: 11px !important;
            width: 800px;
            padding-top: 10px;
        }

        #seo_form input, #seo_form textarea {
            width: 500px;
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

<form style="margin: 12px auto 6px 6px;" class="p6" id="seo_form">
    <input type="hidden" value="{$moduleid}" name="module">
    <input type="hidden" value="{$type}" name="update">
    <input type="hidden" value="{$id}" name="eid">
    <table>
        <tr id="seo_title">
            <td width="160" align="right">
                <strong>SEO Title:</strong><br/>
                <small>&nbsp;</small>
            </td>
            <td>
                <input class="inp" value="{$data.title|escape}" id="seotitle" name="seotitle"><br/>
                <small>Title is limited to <font style="color: red">70</font> characters.</small>
            </td>
        </tr>
        <tr id="seo_description">
            <td width="160px" align="right">
                <strong>SEO Description:</strong>
                <br/>
                <small>&nbsp;</small>
            </td>
            <td>
                <textarea rows="5" class="inp" id="seodescription" name="seodescription">{$data.description|escape}</textarea>
                <br/>
                <small>Description of the page is limited to the <font style="color: red">155</font> characters.</small>
            </td>
        </tr>
        <tr id="seo_keywords">
            <td width="160px" align="right"><strong>SEO Keywords:</strong></td>
            <td><input class="inp" value="{$data.keywords|escape}" size="60" id="seokeywords" name="seokeywords"></td>
        </tr>
        <tr>
            <td></td>
            <td>
                <a id="seo_btn" href="#" class="btn btn-success btn-xs">Save changes</a>
                <span id="seo_saved"></span>
            </td>
        </tr>
    </table>
</form>
