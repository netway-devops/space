<script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/ace/ace.js?v={$hb_version}"></script>

{literal}
    <script type="text/javascript">
        function loadWYSIWYG() {
            var w = {
                theme: "advanced",
                theme_advanced_buttons1: "bold,italic,underline,separator,justifyleft,justifycenter,justifyright,bullist,numlist,separator,fontselect,fontsizeselect,forecolor,backcolor,separator,code",
                theme_advanced_buttons2: "visualaid,separator,tablecontrols",
                skin: "o2k7",
                visual: false, //hide table borders
                skin_variant: "silver",
                convert_urls: false,
                plugins: "table,inlinepopups",
                nowrap: false,
                apply_source_formatting: true, //allow new lines in html source
                convert_fonts_to_spans: false,
                verify_html: false,
                entity_encoding: "raw",
                forced_root_block: false,

                extended_valid_elements: "htmlpageheader[name],htmlpagefooter[name],sethtmlpageheader[name|page|value|show-this-page],sethtmlpagefooter[name|page|value|show-this-page]",
                theme_advanced_buttons3: "",
                font_size_style_values: "8px,9px,10px,11px,12px,14px,16px,18px,22px",
                theme_advanced_font_sizes: "8px,9px,10px,11px,12px,14px,16px,18px,22px",
                theme_advanced_toolbar_location: "top",
                theme_advanced_toolbar_align: "left",
                theme_advanced_statusbar_location: "bottom",
                body_class: "my_class",
                valid_children: "+body[style]",
                theme_advanced_fonts:
                "Arial=arial,helvetica,sans-serif;" +
                "Arial Black=arial black,avant garde;" +
                "Georgia=georgia,palatino;" +
                "Helvetica=helvetica;" +
                "Tahoma=tahoma,arial,helvetica,sans-serif;" +
                "Times New Roman=times new roman,times;" +
                "Verdana=verdana,geneva;"
            };

            var textarea = $('#tplcontent');
            textarea.addClass('tinyApplied').tinymce(w);
            textarea.data('getValue', function(){
                return textarea.val();
            })
        }

        function loadSrcEditor(){
            var textarea = $('#tplcontent'),
                acetor = ace.edit('tplcontent-ace');

            acetor.setTheme("ace/theme/chrome");
            acetor.getSession().setMode("ace/mode/smarty");
            acetor.setOptions({
                minLines: 15,
                maxLines: 9999,
                highlightActiveLine: false
            });

            textarea.data('ace', true)
            textarea.data('aceeditor', acetor);
            acetor.getSession().setValue(textarea.val())

            textarea.closest('form').on('submit', function () {
                console.log('submit ace')
                textarea.val(acetor.getValue());
            })

            textarea.data('getValue', function(){
                return acetor.getValue();
            })
        }


        function previewTemplate() {
            var template = $('#tplcontent');

            $('#preview_content').val(template.data('getValue')());
            $('#previewform').submit();
            return false;
        }

        function switchVariableGroup(el) {
            var v = $(el).val();
            $('optgroup', '#tpl_variables').hide().eq(0).show();
            $('#og_' + v, '#tpl_variables').show();

            $('#tpl_variables').val(0);
        }

        function switchVariable(el) {
            var v = $(el).val();
            if (v == 0)
                return;
            $('#var-container').val(v);
            $('#variable-box').show();
        }

        $(function () {
            $('#var-container').on('click', function(){
                this.select() || this.setSelectionRange(0, this.value.length);
                document.execCommand('copy');
            });
        })

    </script>
    <style>
        .mceIframeContainer{
            height: 100%;
        }
    </style>
{/literal}
<form id="previewform" target="_blank" method="post"
      action="?cmd=configuration&action=invoicetemplates&make=preview">
    <input type="hidden" name="content" id="preview_content" value=""/>
    <input type="hidden" name="target" value="{$template.target}"/>
    {securitytoken}
</form>
{if !$mbstring}
    <div class="alert alert-danger">
        <strong>Note: Your PHP is missing mbstring extension
            - changes made here will only affect HTML template.</strong>
    </div>
{/if}

<form action="" method="post" id="invoiceeditform" style="padding: 10px 0">
    <input type="hidden" name="template_id" value="{$template.id}"/>
    <input type="hidden" name="target" value="{$template.target}"/>
    <input type="hidden" name="name" value="{$template.name}"/>
    <input type="hidden" name="content_id" value="{$template.content_id}"/>
    <input type="hidden" name="make" value="edit"/>


    <div class="container-fluid">
        {if !$systemtemplate}
            <div class="form-group">
                <label>Template name</label>
                <input type="text" name="name" value="{$template.name}" size="30" class="form-control"/>
            </div>
        {/if}

        <div class="row">

            {if $editor_type == 'wysiwyg'}
            <div class="form-group col-lg-8" style="max-width: 210mm;">
                <div style="width: 100%; padding-bottom: 150%; position: relative;">
                    <div style="position: absolute; top: 0; bottom: 0; left: 0; right: 0;">
                        <textarea name="content" id="tplcontent"
                                  style="width:100%;height:100%;">{$template.content}</textarea>

                    </div>
                </div>
                <script>appendLoader('loadWYSIWYG');</script>
            </div>
            {else}
                <div class="form-group col-lg-8" >
                   <textarea name="content" id="tplcontent"
                             style="width:100%;height:100%; display: none;">{$template.content}</textarea>
                    <div class="ace-editor-wy" id="tplcontent-ace" style="display: block"></div>
                    <script>appendLoader('loadSrcEditor');</script>
                </div>
            {/if}

            <div class="form-group col-lg-4">
                {if $vars}
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Template variables
                            <span class="vtip_description">
                                <span>
                                    Variables will be replaced by actual values when document is
                                    displayed/downloaded.<br/>
                                    I.e. {literal}{$client.firstname}{/literal} will be replaced with client name
                                </span>
                            </span>
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <select class="form-control" onchange="switchVariable(this);"
                                        id="tpl_variables">
                                    <option value="0">---</option>
                                    {foreach from=$vars item=v key=k}
                                        <optgroup label="{if $lang[$k]}{$lang[$k]}{else}{$k}{/if}">
                                            {foreach from=$v item=i key=kk}
                                                <option value="{$kk}" class="opt_{$k}">{$i}</option>
                                            {/foreach}
                                        </optgroup>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="form-group" id="variable-box" style="display:none">
                                <label class="fs11">Copy & paste to template:</label>
                                <input type="text" readonly id="var-container"
                                     class="form-control" />
                            </div>
                        </div>
                    </div>
                {/if}

                <div>
                    <a class="btn btn-default" href="#" onclick="return previewTemplate();">
                        <i class="fa fa-search"></i>
                        {$lang.Preview}
                    </a>
                    <a class="btn btn-success" href="#"
                       onclick="$('#invoiceeditform').submit();return false;">
                        {$lang.savechanges}
                    </a>
                    <span class="orspace fs11">{$lang.Or}</span>
                    <a href="?cmd=configuration&action=invoicetemplates"
                       onclick="window.history.go(-1); return false;"
                       class="fs11 editbtn">{$lang.Cancel}</a>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <span class="fs11">
                    You can change editor type in
                    <a href="?cmd=configuration&picked_tab=6&picked_subtab=2">Settings &raquo; Other &raquo; Admin Portal</a>

                </span>
            </div>
        </div>
    </div>


    {securitytoken}
</form>