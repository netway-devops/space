<script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
<h3>Edit series in widget</h3>
Widget: <b>{$widget.name}</b><br/>
Related report: <b><a href="?cmd=reports&action=get&id={$widget.report_id}" target="_blank">{$widget.report_name}</a></b>
<br/><br/>

<table class="table table-bordered table-striped">
<tr>
    <th width="80"></th>
    <th>Series name:</th>
</tr>
</table>
<form id="serializeit">
    <ul id="grab-sorter" class="grabsortdomain">
        {foreach from=$widget.series item=data}
            <li><div>
                    <table class="table table-bordered table-striped">
                        <tr>
                            <td width="80" class="text-center">
                                <div class="btn-group" role="group" style="margin-right: 5px;">
                                <a class="sorter-handle" style="display: inline-block">sort</a>
                                </div>
                                <div class="btn-group" role="group">
                                    <a class="btn btn-primary btn-xs" {literal}onclick="$.facebox({ajax: '?cmd=reports&action=editseries&series_id={/literal}{$data.id}{literal}&widget_id={/literal}{$widget.id}{literal}'});return false;"{/literal}><i class="fa fa-pencil"></i></a>
                                    <a class="btn btn-danger btn-xs" href="?cmd=reports&action=rmseries&series_id={$data.id}&widget_id={$widget.id}&security_token={$security_token}" onclick="return confirm('Are you sure?');"><i class="fa fa-trash"></i></a>
                                </div>
                            </td>
                            <td>
                                {$data.name}
                                <span class="colorbox" data-id="{$data.id}" {if $data.color}style="background-color: {$data.color}"{/if} data-color="{$data.color}"><i class="fa fa-hashtag"></i></span>
                            </td>
                        </tr>
                    </table>
                    <input type="hidden" name="sort[]" value="{$data.id}" />
                </div></li>
        {/foreach}
    </ul>
</form>
<input type="hidden" id="widget_id" value="{$widget.id}">
<br/>{literal}
<button class='btn btn-sm btn-success' onclick="$.facebox({ajax: '?cmd=reports&action=addseries&widget_id={/literal}{$widget.id}{literal}'});return false;"><i class="fa fa-plus"></i> Add new data series</button>
{/literal}

{literal}
    <script type="text/javascript">

        $("#grab-sorter").dragsort({
            dragSelector: "a.sorter-handle",
            dragBetween: true,
            dragEnd: saveOrder,
            placeHolderTemplate: "<li class='placeHolder'><div></div></li>"
        });

        function saveOrder() {
            var sorts = $('#serializeit').serialize();
            ajax_update('?cmd=reports&action=updateseries&' + sorts + '&widget_id=' + $('#widget_id').val(), {});
        }
        var c = HBUtils.hbColors;
        var colors = [];
        jQuery.each(c, function (i, v) {
            if (v[0].length === 7)
                colors.push(v[0]);
        });

        var colorbox = $('.colorbox');
        colorbox.each(function (i, v) {
           if (isEmpty($(this).data('color'))) {
               $(this).data('color', colors[i]);
           }
            $(this).css('background-color', $(this).data('color'));

            $(this).hbpicker({color: $(this).data('color'), colors:colors}).on('hbpicker.color',function(e,color){
                $(this).css('background-color',color);
                ajax_update('?cmd=reports&action=updateseries&id=' + $(this).data('id') + '&color=' + color.substring(1) + '&widget_id=' + $('#widget_id').val(), {});
            });
        });



    </script>
    <style>
        .colorbox {
            float: right;
            margin-right: 10px;
            color: white;
            border-radius: 5px;
            padding: 2px 7px;
            background-color: red;
            font-size: 90%;
            text-shadow: 0 0 0.2em #000;
        }
        .hbpicker {
             width: 210px !important;
        }
    </style>
{/literal}