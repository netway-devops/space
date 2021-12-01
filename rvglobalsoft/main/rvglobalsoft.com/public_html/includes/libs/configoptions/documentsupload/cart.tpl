{foreach from=$cf.items item=cit}
    {if !$document_uploadform_js}
        {assign var=document_uploadform_js value="1"}
        <!--BOF: FILEUPLOAD -->
        <script src="{$template_dir}js/fileupload/vendor/jquery.ui.widget.js"></script>
        <script src="{$template_dir}js/fileupload/vendor/tmpl.min.js"></script>
        <script src="{$template_dir}js/fileupload/jquery.iframe-transport.js"></script>
        <script src="{$template_dir}js/fileupload/jquery.fileupload.js"></script>
        <script src="{$template_dir}js/fileupload/jquery.fileupload-ui.js"></script>
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}js/fileupload/styles.css" />

        <!--EOF: FILEUPLOAD -->

        {literal}
            <style>
                .dropzonecontainer {
                    position:relative;
                }
                .fileupload-progress.fade {
                    display: none;
                }
                .fileupload-progress.fade.in {
                    display: block;
                }
                .dropzone {
                    position:absolute;
                    display:none;
                    top:0px;
                    left:0px;
                    bottom:0px;
                    right:0px;
                    z-index:100;
                    text-align:center;
                    padding:15px 0px;
                    min-height:60px;
                    opacity:0.8;
                    background:#f5f8c2;
                }
            </style>
            <script id="template-upload" type="text/x-tmpl">
                {% for (var i=0, file; file=o.files[i]; i++) { %}
                <tr class="template-upload fade">
                <td class="name" width="40%"><span>{%=file.name%}</span></td>
                <td class="size" width="90"><span>{%=o.formatFileSize(file.size)%}</span></td>
                {% if (file.error) { %}
                <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
                {% } else if (o.files.valid && !i) { %}
                <td>            <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar" style="width:0%;"></div></div>

                </td>
                <td class="start" width="90">{% if (!o.options.autoUpload) { %}
                <button class="btn btn-primary btn-mini">
                <i class="icon-upload icon-white"></i>
                <span>Start</span>
                </button>
                {% } %}</td>
                {% } else { %}
                <td colspan="2"></td>
                {% } %}
                <td class="cancel" width="90" align="right">{% if (!i) { %}
                <button class="btn btn-warning  btn-mini">
                <i class="icon-ban-circle icon-white"></i>
                <span>{/literal}{$lang.cancel}{literal}</span>
                </button>
                {% } %}</td>
                </tr>
                {% } %}
            </script><!-- The template to display files available for download -->
            <script id="template-download" type="text/x-tmpl">
                {% for (var i=0, file; file=o.files[i]; i++) { %}
                <tr class="template-download fade">
                {% if (file.error) { %}
                <td class="name" width="40%"><span>{%=file.name%}</span></td>
                <td class="size" width="90"><span>{%=o.formatFileSize(file.size)%}</span></td>
                <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
                {% } else { %}
                <td class="name" width="40%">{%=file.name%} <input type="hidden" name="{%=file.inputname%}[]" value="{%=file.hash%}" /></td>
                <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
                <td colspan="2"></td>
                {% } %}
                <td class="delete" width="90" align="right">
                <button class="btn btn-danger btn-mini" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}">
                <i class="icon-trash icon-white"></i>
                <span>{/literal}{$lang.delete}{literal}</span>
                </button>
                </td>
                </tr>
                {% } %}
            </script>
            
        {/literal}
    {/if}

    {assign value="file`$cart.cartindex`_`$cf.id`_`$cit.id`" var=cf_key_name}
    <script >

        {literal}

            $(function () {

                var inputname = {/literal}'{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]'{literal};
                var f = $('#custom_field_{/literal}{$cf.id}{literal}');

                loadFileUpload().done(function () {

                    f.fileupload();
                    var fileup = f.data("fileupload") || f.data("blueimpFileupload");

                    if(!fileup){
                        console.warn('File upload not initialized');
                        return false;
                    }

                    f.bind('fileuploaddragover', function () {
                        var dropZone = f.find('.dropzone').not('.hidden');
                        dropZone.show();
                        setTimeout(function () {
                            f.find('.dropzone').hide().addClass('hidden');
                        }, 6000);
                    })
                    .bind('fileuploaddrop', function () {
                        f.find('.dropzone').hide().addClass('hidden');
                    })
                    .bind('fileuploadalways', function (e, data) {
                        for (var i in data.result) {
                            data.result[i].inputname = inputname;
                        }
                    })
                    .bind('fileuploadcompleted fileuploadfailed fileuploaddestroyed', function (e) {
                        if (typeof (simulateCart) == 'function')
                            simulateCart('#cart3');
                    });



                    var uploaded = {/literal}{$smarty.session.upfiles_keys[$cf_key_name]|@json_encode}{literal} || [],
                        del_url = {/literal}'?cmd=downloads&action=formupload&cit={$cit.id}&cid={$cf.id}&param={$cf_key_name}&_method=DELETE'{literal},
                        list = $('tbody.files', f),
                        files = [];


                    $.each(uploaded, function (k, name) {
                        files.push({
                            inputname: inputname,
                            name: name,
                            hash: k.replace('temp_', ''),
                            //size: 0,
                            delete_type: 'POST',
                            delete_url: del_url + '&file=' + name
                        })
                    });
                    if (files.length){
                        list.append(fileup._renderDownload(files).addClass('in'))
                    }
                });
            });
        {/literal}
    </script>
    <div id="custom_field_{$cf.id}" data-url="?cmd=downloads&action=formupload&cid={$cf.id}&cit={$cit.id}&param={$cf_key_name}">
        <div class="dropzonecontainer">
            <div class="dropzone"><h2>{$lang.droptoattach}</h2></div>
            <div class="fileupload-buttonbar">
                <div class="span5" style="float:left">
                    <!-- The fileinput-button span is used to style the file input field as button -->
                    <span class="btn btn-mini fileinput-button">
                        <i class="icon-plus"></i>
                        <span>{$lang.attachfile}</span>
                        <input type="file" name="{$cf_key_name}[]" multiple  />
                    </span>
                    <div class="fs11">{$extensions|string_format:$lang.allowedext}</div>
                </div>
                <!-- The global progress information -->
                <div class="span5 fileupload-progress fade"  style="float:left">
                    <!-- The global progress bar -->
                    <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                        <div class="bar" style="width:0%;"></div>
                    </div>
                    <!-- The extended global progress information -->
                    <div class="progress-extended">&nbsp;</div>
                </div>
                <div class="clear"></div>
            </div>
            <table role="presentation" class="table table-striped"><tbody class="files"></tbody></table>
        </div>
    </div>

    <input name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}][]"
           value=""
           class="styled custom_field custom_field_{$cf.id}" type="hidden"

           />
{/foreach}