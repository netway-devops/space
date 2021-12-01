{literal}
    <style type="text/css">
        .import-control {
            margin-left: 20px;
        }

        .import-method {
            overflow-y: auto;
        }

        .import-list li:nth-child(2n) {
            background: #f9f9f9;
        }

        .import-list .vtip_description {
            line-height: 0;
        }
    </style>
{/literal}
<div class="panel panel-default">
    <div class="panel-heading">Import method</div>
    <ul class="list-group import-list clear" id="import-list"
        data-import="{$submit.import|@json_encode|escape}"
        data-methods="{$import_methods|@json_encode|escape}"></ul>
    <div class="panel-footer">
        <button class="btn btn-success" id="import-new" type="button">
            Add another import method
        </button>
    </div>
</div>
{if $imap_warn}
    <div id="pop-import-alert" class="alert alert-danger" style="display: none">
        PHP IMAP extension is not installed, POP import method will not work
    </div>
{/if}
<div id="pipe-import-alert" class="alert alert-info" style="display: none">
    For PIPE import you will need to setup your email forwarder using given command
    <input type="text" readonly="readonly" value=" | php -q {$path}" class="form-control"/>
</div>
<div style="display:none" bootbox id="pipe-testing"
     data-title="PIPE Import Test"
     data-btntitle="{$lang.Continue}">
    <div id="pipe-test-result">
        <ul>
            <li {if $action!='edit'}style="color:red"{/if}>Save this department settings
                before
                performing import test
            </li>
            <li>Make sure that Email forwarder is added in your control panel</li>
        </ul>
    </div>
</div>
{literal}
<script type="text/x-handlebars-template" id="method-entry-tpl">
    <li class="list-group-item clearfix" data-index="{{@index}}">
        {{#if id}}
        <input name="import[{{@index}}][id]" type="hidden" value="{{id}}"/>
        <div class="import-control pull-right">
            <a href="#" class="editbtn btn-edit">Edit</a>

            <a href="#" class="editbtn btn-remove">Delete</a>
        </div>
        <div class="import-display">
            <div class="row">
                <div class="col-sm-4">
                    {{selected.label}}
                </div>
                <div class="col-sm-4">
                    {{#if config.email}}
                    {/literal}{$lang.Email}:{literal}
                    {{config.email}}
                    {{/if}}
                </div>
            </div>
        </div>
        {{else}}
        <div class="import-control pull-right">
            <a href="#" class="editbtn btn-remove">Delete</a>
        </div>
        {{/if}}
        <div class="import-edit" {{{attrHidden}}} >
        <div class="form-group import-method">
            <select name="import[{{@index}}][method]" class="form-control">
                {{#each methods}}
                <option value="{{value}}" {{selected}}>
                    {{label}}
                </option>
                {{/each}}
            </select>
        </div>
        <div class="row import-method-config">
            {{> render_form }}
        </div>
        </div>
    </li>
</script>
    <script type="text/x-handlebars-template" id="method-form-tpl">
        {{#each forms}}
        <div class="form-group col-md-4">
            <label>
                {{label}}
                {{#if tooltip}}<span class="vtip_description">{{{tooltip}}}</span>{{/if}}
            </label>
            {{#switch type}}
            {{#case 'select'}}
            <select name="import[{{@../index}}][config][{{name}}]" class="form-control">
                {{#each items}}
                <option value="{{value}}" {{selected}}>{{label}}</option>
                {{/each}}
            </select>
            {{/case}}
            {{#case 'textarea'}}
            <textarea name="import[{{@../index}}][config][{{name}}]" class="form-control">{{value}}</textarea>
            {{/case}}
            {{#default}}
            <input type="{{type}}" name="import[{{@../index}}][config][{{name}}]"
                   value="{{value}}" class="form-control fake-search">
            {{/default}}
            {{/switch}}
        </div>
        {{/each}}
        <div class="form-group col-md-4">
            <label class="visible-lg visible-md">&nbsp;</label>
            <button class="btn btn-default btn-test" type="button">
                <i class="fa fa-magic"></i> Test configuration
            </button>
        </div>
    </script>
<script type="text/javascript">


    $(function () {

        var dept_id = $('#dept_id').val(),
            list = $('#import-list'),
            import_data = list.data('import') || [],
            methods_data = list.data('methods') || [],
            _handlebars = Handlebars.create(),
            render_item = _handlebars.compile($('#method-entry-tpl').html()),
            render_form = _handlebars.compile($('#method-form-tpl').html());

        _handlebars.registerPartial('render_form', render_form);
        _handlebars.registerHelper('switch', function (value, options) {
            this.switch_value = value;
            this.switch_break = false;
            return options.fn(this);
        });

        _handlebars.registerHelper('case', function (value, options) {
            if (value === this.switch_value) {
                this.switch_break = true;
                return options.fn(this);
            }
        });

        _handlebars.registerHelper('default', function (options) {
            if (this.switch_break === false) {
                return options.fn(this);
            }
        });

        function setupMethod(impdta) {
            if (impdta.hasOwnProperty('selected') && impdta.selected) {
                impdta.selected.selected = '';
            }
            if (impdta.hasOwnProperty('id')) {
                impdta.attrHidden = 'style="display:none"';
            }

            if (impdta.methods.hasOwnProperty(impdta.method) && impdta.methods[impdta.method]) {
                impdta.selected = impdta.methods[impdta.method];
                impdta.selected.selected = 'selected';
                impdta.forms = impdta.methods[impdta.method].forms;
            } else {
                impdta.forms = [];
            }

            if (!impdta.hasOwnProperty('config') || !impdta.config) {
                impdta.config = {};
            }

            for (var i = 0; i < impdta.forms.length; i++) {
                var form = impdta.forms[i];
                if (impdta.config.hasOwnProperty(form.name)) {
                    form.value = impdta.config[form.name];
                }
            }
            return impdta;
        }

        function toggleAlert() {
            var methods = {PIPE: 0, POP: 0};
            for (var i = 0; i < import_data.length; i++) {
                import_data[i]
                && methods.hasOwnProperty(import_data[i].method)
                && methods[import_data[i].method]++;
            }
            $("#pipe-import-alert").toggle(methods.PIPE > 0);
            $("#pop-import-alert").toggle(methods.POP > 0);
        }

        function pipeTestModal(data) {
            var dialog;

            $('#pipe-testing').bootboxform({
                callback: function (e) {
                    var result = dialog.find('#pipe-test-result');
                    dialog.find('.btn-success').remove();
                    dialog.find('.btn-default').text('Close');

                    result.html('<div class="text-center"><img src="ajax-loading.gif" /></div>');
                    $.post('?cmd=ticketdepts&action=test_connection', data, function (resp) {
                        resp = parse_response(resp);
                        result.html(resp !== true && resp.length > 0 ? resp : 'Error');
                    });
                    return false;
                }
            }).on('bootbox-form.shown', function (e, _dialog) {
                dialog = _dialog;
            }).trigger('show');
        }

        var html = '';
        for (var i = 0; i < import_data.length; i++) {
            var impdta = import_data[i];

            impdta.methods = $.extend(true, {}, methods_data);
            setupMethod(impdta);
            html += render_item(impdta, {data: {index: i}})
        }

        list.html(html);
        list.find('.vtip_description').vTip();

        list.on('change', ".import-method select", function () {
            var self = $(this),
                index = parseInt(self.closest('li').data('index')) || 0,
                impdta = import_data[index];

            impdta.method = self.val();
            setupMethod(impdta);

            var part = list.find('.import-method-config').eq(index);
            part.html(render_form(impdta, {
                data: {index: index}
            }));

            part.find('.vtip_description').vTip();
            toggleAlert();
        });

        list.on('click', ".btn-edit", function () {
            var self = $(this).closest('li');
            self.find('.import-display').toggle();
            self.find('.import-edit').toggle();
            return false;
        });

        list.on('click', ".btn-remove", function () {
            var self = $(this).closest('li');
            delete import_data[self.data('index')];
            self.remove();
            toggleAlert();
            return false;
        });


        list.on('click', ".btn-test", function () {
            var self = $(this).closest('li'),
                form = self.find('input, select, textarea').serializeForm(),
                data = form.import[Object.keys(form.import)[0]];

            data.dept_id = dept_id;

            if (data.method === 'PIPE') {
                pipeTestModal(data);
                return false;
            }

            var alert = bootbox.dialog({
                message: '<div class="text-center"><i class="fa fa-spin fa-spinner"></i> Loading...</div>',
                size: 'large',
                backdrop: true,
                onEscape: true
            });

            var general_msg = 'Test finished with error. Check HostBill error logs for more information. ';
            var throwError = function(msg) {
                $('.bootbox-body', alert).html($('<span></span>')
                    .css({fontWeight: 'bold', color: ' #990000'}).text(msg))
            };

            $('.modal-body',alert).css("font-family", 'monospace');

            $.ajax('?cmd=ticketdepts&action=test_connection', {
                data: data,
                type: 'post',
                error: function(xhr, status, error) {
                    throwError(xhr.status + ' ' + error + '. ' + general_msg);
                },
                success: function(data) {
                    if (!data || !data.length)
                        return throwError(general_msg);

                    $('.bootbox-body', alert).html(parse_response(data));
                },
            });
        });

        $('#import-new').on('click', function () {
            import_data.push(setupMethod({
                method: 'PIPE',
                methods: $.extend(true, {}, methods_data)
            }));

            var index = import_data.length - 1;
            list.append(render_item(import_data[index], {
                data: {index: index}
            }));
            toggleAlert();
            return false;
        });

        toggleAlert();
    });

    function testImportConfiguration(type, el) {
        var parent = $(el).parents('tr').eq(0);
        if (type === undefined || type == 'POP') {
            parent = parent.next();
            $('.result', parent).html('<img src="ajax-loading.gif" />');
            ajax_update('?cmd=ticketdepts&action=test_connection', {
                'host': $('.pop-host', parent).val(),
                'login': $('.pop-login', parent).val(),
                'password': $('.pop-pass', parent).val(),
                'port': $('.pop-port', parent).val()
            }, $('.result', parent), false);
        } else if (type == 'PIPE') {
            $.facebox({div: '#pipe_testing'});
            var ctrl = $('<span id="pipebutton"></span>')
            {/literal}{if $action=='edit'}
                .append('<a class="new_control clear" href="#">{$lang.Continue}</a>').click(function (){literal} {
                    testImportConfiguration('PIPE2', el)
                }{/literal})
                .append(' {$lang.Or} ')
                {/if}
                .append('<a class="new_control clear" href="#" onclick="$.facebox.close();">{$lang.Close}</a>')
            $('#facebox .footer').html(ctrl);
            {literal}
        } else if (type == 'PIPE2') {
            console.log(el)
            $('#facebox #pipe_testing_result')
                .html('<center><img style="height: 16px" src="ajax-loading.gif" /></center>');
            $('#pipebutton').remove();
            ajax_update('?cmd=ticketdepts&action=test_pipe', {
                id: '{/literal}{$submit.id}{literal}',
                email: $('.import-email', parent).val()
            }, '#facebox #pipe_testing_result');
        }
    }
</script>
{/literal}