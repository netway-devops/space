(function (window, document, undefined) {
    var HB = Handlebars.create(),
        $document = $(document),
        src = {};

    HB.registerHelper('rend', function (options) {
        if (this.tpl) {
            console.log('rend custom tpl')
            HB.partials.tmp = this.tpl
            return 'tmp';
        }

        console.log('rend', this.type);
        if (this.type === 'select' && this.options === undefined) {
            this.options = {input:"Input", textarea:"Textarea", date:"Date"};
        }
        return  this.type || 'text';
    })

    HB.registerHelper('eq', function (a, b, options) {
        console.log('eq', a, ' == ', b);
        if (a == b)
            return options.fn(this);
        return options.inverse(this);
    })

    src.label = '<label {{#unless description}}class="nodescr"{{/unless}}>{{name}}{{> description}}</label>'
    src.description = '<small>{{description}}</small>';

    src.checkbox = '<input type="hidden" name="{{index}}" value="0"/><input type="checkbox" name="{{index}}" value="1" {{#eq value 1}}checked{{/eq}} />';
    src.text = '<input type="text" name="{{index}}" value="{{value}}" placeholder="{{placeholder}}" class="form-control" />';
    src.textarea = '<textarea name="{{index}}" {{attr}} placeholder="{{placeholder}}" class="form-control">{{value}}</textarea>';
    src.select = '<select name="{{index}}" class="form-control">\
                {{#each options}}<option value="{{@key}}" {{#eq @key ../value}}selected{{/eq}}>{{this}}</option>{{/each}}\
            </select>';

    src.container = '<h3>{{title}}</h3>{{#each forms}}<div class="form-group row {{classes}}">\
            <div class="col-sm-3">{{> label this}}</div>\
            <div class="col-sm-8">{{> (rend) values=../values}}</div>\
        </div>\
    {{/each}}';
    src.form = '<div id="formcontainer" class="bootstrap-facebox">\
<div id="formloader" >\
    <form method="post" action="{{action}}" id="submitform" enctype="multipart/form-data">\
        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">\
            <tr>\
                <!--\
                <td width="140" id="s_menu" style="" valign="top">\
                    <div id="lefthandmenu">\
                        {foreach from=$tabsinfo item=tab key=tabname}\
                            <a class="tchoice" href="#">{if $lang.$tabname}{$lang.$tabname}{else}{$tabname}{/if}</a>\
                        {/foreach}\
                     </div>\
                </td>\
                -->\
                <td class="conv_content form"  valign="top">\
                    {{#each tabs}}\
                        <div class="tabb">\
                            <div class="form-horizontal container-fluid">\
                                {{>container this}}\
                            </div>\
                        </div>\
                   {{/each}}\
                </td>\
            </tr>\
        </table>\
    </form>\
</div>\
<div class="dark_shelf dbottom">\
    <div class="left spinner"><img src="ajax-loading2.gif"></div>\
    <div class="right">\
        <span class="bcontainer fcb-save" >\
            <a class="new_control greenbtn" href="#">\
            <span>Save</span></a>\
        </span>\
        <span class="dhidden" >or</span> \
        <span class="bcontainer fcb-close">\
            <a href="#" class="submiter menuitm">\
            <span>Close</span></a>\
        </span>\
    </div>\
    <div class="clear"></div>\
</div>\
</div>';

    HB.partials = $.extend({}, src);
    HB.templates = {
        form: HB.compile(src.form)
    };
    $(document).on('init.facebox', function () {
        //remove old one
        $('#facebox').remove();
    });
    $document.on('reveal.facebox', function () {
        var facebox = $('#facebox');

        $('.fcb-save', facebox).on('click', function () {
            $('#formcontainer .spinner', facebox).show();

            if (typeof (onFaceboxSubmit) == 'function') {
                var ret = onFaceboxSubmit();
                if (ret) {
                    $('form', facebox).submit();
                }
            } else {
                $('form', facebox).submit();
            }
            return false;
        });

        $('.haspicker', facebox).datePicker();
        $('#lefthandmenu', facebox).TabbedMenu({elem: '.tabb'});
        $('.fcb-close', facebox).on('click', $.facebox.close);
    })

    $.facebox.dynamic = function (spec) {
        $.facebox.reveal(HB.templates.form(spec));
    };
})(window, document)
/*
 {
 tabs: [
 {
 name: 'example',
 forms: spec
 }
 ]
 }
 */