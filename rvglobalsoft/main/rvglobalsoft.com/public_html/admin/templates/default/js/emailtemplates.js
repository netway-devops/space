var before_form_submit = [];
function submitform(el) {
    for (var i = 0; i < before_form_submit.length; i++){
        before_form_submit[i]();
    }

    var form = $(el),
        data = form.serializeForm();

    if(data.inline !== '1'){
        return true;
    }

    ajax_update(form.attr('action'), data);
    return false;
}

$(function () {
    function getEditor(textarea){
        var editor;
        if (typeof tinyMCE !== "undefined" && (editor = tinyMCE.get(textarea.attr('id'))) !== undefined) {
            return {type: "tinymce", obj: editor};
        }else if (textarea.data('ace') && (editor = textarea.data('aceeditor')) !== undefined) {
            return {type: "ace", obj: editor};
        }else{
            var data = textarea.data('editor');
            if(!data){
                data = {type: "textarea", obj: textarea, query: 0};
                textarea.data('editor', data)
            }else{
                data.query++;
            }
            return data;
        }
    }

    function updateCounters(){
        $('.char_counter, .char_counter_alt').each(function () {
            var self = $(this),
                id = self.data('id'),
                name = 'message';

            if (self.hasClass('char_counter_alt'))
                name = 'altmessage';

            var textarea = $('textarea[name="' + name + '[' + id + ']"]');
            var editor = getEditor(textarea), counter;

            if(editor.obj._char_counter){
                editor.obj._char_counter();
                return;
            }

            if (editor.type === 'tinymce') {
                counter = function () {
                    self.html(editor.obj.getContent().length);
                };
                editor.obj.onKeyUp.add(counter);
            }else if (editor.type === 'ace') {
                counter = function () {
                    self.html(editor.obj.getSession().getValue().length);
                };
                editor.obj.getSession().on('keyup', counter);
            }else {
                counter = function () {
                    self.html(editor.obj.val().length);
                };
                editor.obj.on('keyup', counter)
            }

            if(counter){
                editor.obj._char_counter = counter;
                counter();
            }
        });
    }

    $('.tabs_wysiw li a').click(function () {
        var index = $(this).parent().index();
        var el = $('table[id^="langform"]').hide().eq(index).show();
        $('.tabs_wysiw li select').val(index);
        return false;
    });

    var groups = $('.change-group');
    groups.on('change update', function () {
        groups.val($(this).val());
    }).trigger('update');

    var sendas = $('.form-sendas'),
        main_editor = $('.wysiw_editor.message');

    sendas.on('change update', function () {
        var self = $(this),
            value = self.val();
        sendas.val(value);

        $('.altmessage-form').toggle(value === 'both');
        $('.body-type').text(value === 'plain' ? '(Plain text)' : '(HTML)')


        main_editor.each(function () {
            var self = $(this),
                html = value === 'both' || value === 'html',
                wysiwyg = self.data('wysiwyg') || null;

            if(!self.is('.input-wysiwyg')){
                return;
            }

            if(html){
                if(!wysiwyg){
                    var settings = $.extend({}, HBInputTranslate.tinyMCESimple, {
                        height: main_editor.height(),
                        plugins: "pagebreak,style,layer,table,save,advhr,advimage,advlink,preview,,contextmenu,paste,directionality,fullscreen,visualchars,nonbreaking,xhtmlxtras",
                        theme_advanced_buttons1: "formatselect,fontselect,fontsizeselect,forecolor,backcolor,|,bold,italic,underline,separator,strikethrough,justifyleft,justifycenter,justifyright,justifyfull,bullist,numlist,link,unlink,tablecontrols,|,code",
                    });

                    self.addClass('tinyApplied');
                    wysiwyg = new tinymce.Editor(this.id, settings);

                    wysiwyg.isReady = false;
                    wysiwyg.onInit.add(function () {
                        wysiwyg.isReady = true;
                        updateCounters();
                    });
                    wysiwyg.render();

                    before_form_submit.push(function () {
                        !wysiwyg.isHidden() && wysiwyg.save();
                    });

                } else if(wysiwyg.isHidden() && wysiwyg.isReady){
                    wysiwyg.show();
                    self.addClass('tinyApplied');
                    updateCounters();
                }
            }

            if(!html && wysiwyg){
                wysiwyg.save();
                wysiwyg.hide();
                self.removeClass('tinyApplied');
                updateCounters();
            }

            self.data('wysiwyg', wysiwyg);
        });

        if(typeof tinymce === 'object'){
            tinymce.dom.Event._pageInit(window); //workaround for when tinymce is loaded by ajax
        }

        updateCounters();
    }).trigger('update');
});

