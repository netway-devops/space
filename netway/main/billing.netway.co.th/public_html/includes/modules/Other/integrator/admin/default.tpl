{include file='header.tpl'}

{literal}
    <script>var editors={};</script>
{/literal}
<script type="text/javascript" src="templates/default/js/ace/ace.js"></script>
<form action="" method="post" >
    <div class="container-fluid" style="padding-top:14px;padding-bottom:14px;">

        <div class="row">
            <div class="col-md-12" style="margin-bottom: 10px">
                This module provides code samples for products / features in your HostBill installation which you can use on your website
            </div>


            {foreach from=$cats item=c}
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="name">{$c.name}</label>
                        <button class="btn btn-xs pull-right btn-success code-export" name="submit" value="sample.html" data-target="{$c.id}">Download code</button>
                        <a href="?cmd=integrator&action=preview&id={$c.id}&template={$c.snippet}" class="btn btn-xs pull-right btn-info code-preview" name="submit" target="_blank" value="{$c.id}"  >Preview sample</a>
                        <textarea class="form-control" id="ace-{$c.id}" name="doc[{$c.id}]" rows="6">{include file=$c.snippet}</textarea>
                    </div>

                </div>
                <script>
                    var editor = ace.edit("ace-{$c.id}");
                    editor.setTheme("ace/theme/chrome");
                    editor.getSession().setMode("ace/mode/html");

                    {literal}
                    editor.setOptions({
                        minLines: 6,
                        maxLines: 15,
                        highlightActiveLine: false
                    });

                    {/literal}
                    editors['{$c.id}']=editor;
                </script>
            {/foreach}



        </div>
    </div>
    {securitytoken}
</form>



{literal}
    <script>


        $('.code-export').on('click', function () {
            var filename = $(this).val(), target = $(this).data('target');
            var text = editors[target].getValue();


            var pom = document.createElement('a'),
                file = new File([text], {type:'text/plain'});

            pom.setAttribute('href', window.URL.createObjectURL(file));
            pom.setAttribute('download', filename );

            if (document.createEvent) {
                var event = document.createEvent('MouseEvents');
                event.initEvent('click', true, true);
                pom.dispatchEvent(event);
            } else {
                pom.click();
            }
            return false;
        });
    </script>
{/literal}