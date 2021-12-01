{once}
<script src="{$template_dir}js/fileupload/init.fileupload.js?v={$hb_version}"></script>
<!--EOF: FILEUPLOAD -->
{literal}
    <script >
        $(function () {
            var tpl = '<div class="result "><input type="file" data-upload="%url" name="%name" multiple/></div>',
                t_progress = '<div class="upload-result"><a class="attachment">%name</a>\
                    <span class="ui-autocomplete-loading" style="padding: 10px;"></span></div>',
                t_btn = '<a href="#" class="btn btn-default btn-xs"><i clas="fa fa-trash"></i> Remove</a>';

            $('.form-file-add').on('click', function () {
                var _always, _send,
                    self = $(this),
                    resultlist = {},
                    name = $('#account_id, #domain_id').val() + self.data('name').replace(/[\[\]]+/g, '_'),
                    url = self.data('url') + '&param=' + name,
                    place = $(tpl.replace('%url', url).replace('%name', name));

                _always = function (e, data) {
                    $('input, .ui-autocomplete-loading', place).remove();
                    console.log('always', data);

                    for (var i in data.result) {
                        if (!resultlist[i])
                            continue;

                        var r = resultlist[i];
                        if (data.result[i].error) {
                            r.append('<span>' + data.result[i].error + '</span>');
                        } else {
                            r.append('<input name="' + self.data('name') + '" value="' + data.result[i].hash + '" type="hidden"/>');
                            $(t_btn).appendTo(r)
                                .click(function () {
                                    $.post(data.result[i].delete_url);
                                    r.remove();
                                    return false;
                                });
                        }

                    }
                    //place.children().remove().text(data.result);
                };

                _send = function (e, data) {
                    place.children('input').hide();
                    for (var i in data.files) {
                        resultlist[i] = $(t_progress.replace('%name', data.files[i].name)).appendTo(place);
                    }
                };

                place.on('fileuploadsend', _send)
                    .on('fileuploadalways', _always);

                self.next().append(place)
                fileupload_init();

                return false;
            })
            
            $('.form-file-list').on('click', '.file-remove', function(){
                var self = $(this),
                    parent = self.closest('.upload-result');
                parent.after(parent.find('input').attr('type', 'hidden').val('_del_').detach());
                parent.remove();
                return false;
            })
        })
    </script>
{/literal}
{/once}

{foreach from=$c.items item=cit}

    <div class="form-file" id="custom_field_{$c.id}" >
        <span class="btn btn-xs btn-default form-file-add" 
              data-url="?cmd=downloads&action=formupload&cid={$c.id}&cit={$cit.id}"
              data-name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$c.id}][{$cit.id}][]"
              >
            <i class="fa fa-plus"></i> Attach file
        </span>
        <div class="form-file-list">
            {foreach from=$c.data[$cit.id]|json_decode:true key=fid item=name}
                <div class="upload-result">
                    <a class="attachment" href="?cmd=root&action=download&type=downloads&id={$fid}">{$name}</a>
                    <input name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$c.id}][{$cit.id}][{$fid}]" value="{$name|escape}" type="hidden"/>
                    <a href="#" class="btn btn-default btn-xs file-remove"> <i clas="fa fa-trash"></i> Remove</a>
                </div>
            {/foreach}
        </div>
    </div>

{/foreach}

