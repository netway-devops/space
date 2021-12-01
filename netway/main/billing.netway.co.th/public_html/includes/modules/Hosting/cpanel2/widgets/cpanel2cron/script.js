$(function() {
    var options = $('select[id$=_options]'),
        common = $('#common_options');

    common.change(function() {
        var preset = common.val().split(' ');
        for (var i = 0; i < preset.length; i++) {
            options.eq(i + 1).val(preset[i]).change();
        }
    });

    options.not(common).each(function() {
        var self = $(this),
            input = $('#' + self.attr('id').replace('_options', ''));
        
        self.change(function() {
            input.val(self.val());
        })
        input.bind('input keyup change', function(){
            self.val(input.val().replace(/\s|^0(\d+)/gi,"$1"));
        });
    })
})

