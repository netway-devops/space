{literal}
    <style>
        .dropzonecontainer {
            position:relative;
        }
        .fileupload-progress.fade {
            display: none;
        }
        .fileupload-progress.fade.in, .template-upload.fade.in, .template-download.fade.in {
            display: table-row;
            opacity: 1;
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
        .dropzonecontainer table {
            width: 100%;
        }
    </style>
<script id="template-upload" type="text/x-tmpl">
    {% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
    <td class="name" width="40%"><span>{%=file.name%}</span></td>
    <td class="size" width="90"><span>{%=o.formatFileSize(file.size)%}</span></td>
    {% if (file.error) { %}
    <td class="error" colspan="2"><span class="badge badge-danger">Error</span> {%=file.error%}</td>
    {% } else if (o.files.valid && !i) { %}
    <td>            <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar" style="width:0%;"></div></div>

    </td>
    <td width="90">{% if (!o.options.autoUpload) { %}
    <button class="btn btn-primary btn-mini start">
    <i class="icon-upload icon-white"></i>
    <span>Start</span>
    </button>
    {% } %}</td>
    {% } else { %}
    <td colspan="2"></td>
    {% } %}
    <td width="90" align="right">{% if (!i) { %}
    <button class="btn btn-warning  btn-mini cancel">
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
    <td class="error" colspan="2"><span class="badge badge-danger">Error</span> {%=file.error%}</td>
    {% } else { %}
    <td class="name" width="40%">{%=file.name%} <input type="hidden" name="{%=file.inputname%}[]" value="{%=file.hash%}" /></td>
    <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
    <td colspan="2"></td>
    {% } %}
    <td width="90" align="right">
    <button class="btn btn-danger btn-mini delete" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}">
    <i class="icon-trash icon-white"></i>
    <span>{/literal}{$lang.delete}{literal}</span>
    </button>
    </td>
    </tr>
    {% } %}
</script>
<script>
    (function($, window){
        window.loadFileUpload = function () {
            return $.Deferred().resolve(2);
        };
    })(jQuery, window)
</script>
{/literal}