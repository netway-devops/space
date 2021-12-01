<!--BOF: FILEUPLOAD -->
<script src="{$template_dir}js/fileupload/vendor/jquery.ui.widget.js"></script>
<script src="{$template_dir}js/fileupload/vendor/tmpl.min.js"></script>
<script src="{$template_dir}js/fileupload/jquery.iframe-transport.js"></script>
<script src="{$template_dir}js/fileupload/jquery.fileupload.js"></script>
<script src="{$template_dir}js/fileupload/jquery.fileupload-ui.js"></script>
{literal}
    <script type="text/javascript">

       $(function () {
            function enablesubmit() {
                $('#submitbutton').addClass('btn-success').removeClass('disabled').removeClass('btn-inverse').removeAttr('disabled');
                $('.fileupload-progress').hide();
            }
            function disablesubmit() {
                $('#submitbutton').removeClass('btn-success').addClass('disabled').addClass('btn-inverse').attr('disabled','disabled');
                $('.fileupload-progress').show();
            }
            function showdropzone(e) {
              var dropZone = $('#dropzone').not('.hidden');
                dropZone.show();
                     setTimeout(function () {
                        hidedropzone()
                    }, 6000);
            }
            function hidedropzone() {
                $('#dropzone').hide().addClass('hidden');
            }
            $('#fileupload').fileupload();
            $('#fileupload').bind('fileuploadstart', disablesubmit)
                .bind('fileuploadstop', enablesubmit)
                .bind('fileuploaddragover', showdropzone)
                .bind('fileuploaddrop', hidedropzone);
    });
    </script>

    <script id="template-upload" type="text/x-tmpl">
        {% for (var i=0, file; file=o.files[i]; i++) { console.log(file); %}
        <tr class="template-upload fade">
            <td class="name w40"><span>{%=file.name%}</span></td>
            <td class="size w15"><span>{%=o.formatFileSize(file.size)%}</span></td>
            {% if (file.error) { %}
                <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
            {% } else if (o.files.valid && !i) { %}
                <td {% if (o.options.autoUpload) { %}colspan="2"{% } %}>
                    <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                        <div class="bar" style="width:0%;"></div>
                    </div>
                </td>
                {% if (!o.options.autoUpload) { %}
                    <td class="start w15">
                        <button class="btn btn-primary btn-mini">
                            <i class="icon-upload icon-white"></i>
                            <span>Start</span>
                        </button>
                </td>
                {% } %}
            {% } else { %}
                <td colspan="2"></td>
            {% } %}
            <td class="cancel w15" width="90" align="right">
            {% if (!i) { %}
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
                <td class="name w40"><span>{%=file.name%}</span></td>
                <td class="size w15"><span>{%=o.formatFileSize(file.size)%}</span></td>
                <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
            {% } else { %}
                <td class="name" width="40%">{%=file.name%} <input type="hidden" name="asyncattachment[]" value="{%=file.hash%}" /></td>
                <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
                <td colspan="2"></td>
            {% } %}
            <td class="delete w15" align="right">
                <button class="btn btn-danger btn-mini" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}">
                    <i class="icon-trash icon-white"></i>
                    <span>{/literal}{$lang.delete}{literal}</span>
                </button>
            </td>
        </tr>
    {% } %}
    </script>
{/literal}
<!--EOF: FILEUPLOAD -->
