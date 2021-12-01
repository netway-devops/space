{include file="navbar.tpl"}

<script src="{$moduleurl}js/scripts.js"></script>
<script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>

{literal}
    <style>
        a.sorter-handler {
            cursor: n-resize
        }

        a.sorter-handler:active {
            border-color: #B0B0B0 !important;
            background: #f2f2f2 !important
        }

        ul.grab-sorter {
            border: solid 1px #ddd;
            border-bottom: none;
            position: relative;
        }

        ul.grab-sorter li {
            border-bottom: solid 1px #ddd;
            clear: both;
            background: #fff;
            width: 100%
        }

        ul.grab-sorter li div {
            float: left;
            padding: 10px 5px;
        }

        ul.grab-sorter li:after {
            content: ".";
            display: block;
            clear: both;
            visibility: hidden;
            line-height: 0;
            height: 0;
        }

        ul.grab-sorter li div.lastitm {
            width: 150px;
            float: right;
            padding: 3px 5px;
            background: #F0F0F3;
            color: #767679;
        }

        ul.grab-sorter li div.actions {
            height: 15px;
            width: 80px;
        }

        ul.grab-sorter li:hover div.lastitm, ul.grab-sorter li:hover {
            background: #FFFED1;
        }

        ul.grab-sorter li.placeHolder {
            height: 35px;
            border: dashed 1px #999
        }
    </style>

<script type="text/javascript">
    $(function () {
        $(".grab-sorter").dragsort({
            dragSelector: "a.sorter-handler",
            dragBetween: false,
            itemSelector: 'li',
            placeHolderTemplate: "<li class='placeHolder'></li>",
            dragEnd: function () {
                var list = $(this).parents(".grab-sorter");
                var len = list.find('.sort-order').length;
                list.find('.sort-order').each(function (i) {
                    $(this).val(len - i);
                });
                ajax_update("{/literal}?cmd={$cmd}&action={$action}&make=sort&security_token={$security_token}{literal}&" + list.find('.sort-order').serialize(), {}, '#configsupdater');
            }
        });
    });

</script>
{/literal}

<form method="post">
    <div class="nicerblu">
        <div class="sectioncontent">
            <div class="panel panel-default">
                <div class="panel-body">
                    On this page you can set priorities for created configurations. <br>
                    The group/configuration with the highest priority will be set for the client if the items of this configuration match the client data.
                </div>
            </div>
            {if $configs}
                <ul class="grab-sorter" id="configsupdater">
                    {include file="ajax.priorities.tpl"}
                </ul>
            {else}
                <table class="glike hover" width="100%" cellspacing="0" cellpadding="3" border="0">
                    <tr>
                        <td colspan="1">Nothing found</td>
                    </tr>
                </table>
            {/if}
        </div>
    </div>
</form>