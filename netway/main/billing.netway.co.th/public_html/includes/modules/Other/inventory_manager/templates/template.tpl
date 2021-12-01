<script type="text/javascript" src="{$template_dir}js/ace/ace.js?v={$hb_version}"></script>
{literal}
<script>
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
        });

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
{/literal}
<form id="previewform" target="_blank" method="post"
      action="?cmd=inventory_manager&action=preview_template">
    <input type="hidden" name="content" id="preview_content" value=""/>
    <input type="hidden" name="target" value="{$template.target}"/>
    {securitytoken}
</form>
<form action="" method="post" id="templateeditform" style="padding: 10px 0">
    <input type="hidden" name="template_id" value="{$template.id}"/>
    <input type="hidden" name="target" value="{$template.target}"/>
    <input type="hidden" name="name" value="{$template.name}"/>
    <input type="hidden" name="content_id" value="{$template.content_id}"/>
    <input type="hidden" name="make" value="edit"/>
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
            <div class="form-group">
                <label for="exampleInputName2">Page width <span class="vtip_description">
                        <span>Value in <b>millimeters</b>. If the field is empty or has the value 0, then A4 format will be used.</span></span></label>
                <input type="number" class="form-control" name="page[width]" value="{$page.width}">
            </div>
            <div class="form-group">
                <label for="exampleInputEmail2">Page height <span class="vtip_description">
                        <span>Value in <b>millimeters</b>. If the field is empty or has the value 0, then A4 format will be used.</span></span></label>
                <input type="number" class="form-control" name="page[height]" value="{$page.height}">
            </div>
        </div>

        <div>
            <a class="btn btn-default" href="#" onclick="return previewTemplate();">
                <i class="fa fa-search"></i>
                {$lang.Preview}
            </a>
            <a class="btn btn-success" href="#"
               onclick="$('#templateeditform').submit();return false;">
                {$lang.savechanges}
            </a>
        </div>
    </div>
</div>
{securitytoken}
</form>