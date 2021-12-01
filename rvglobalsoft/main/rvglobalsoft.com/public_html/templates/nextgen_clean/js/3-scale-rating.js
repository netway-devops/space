$(function () {
    $('.rating-box .rating-icon').off().on('click',function () {
        var self = $(this),
            value = self.data('value'),
            data = [];

        if(self.data('id'))
            data.push(self.data('id'));
        if(self.data('hash'))
            data.push(self.data('hash'));
        $.post('?cmd=tickets&action=rate', {rate: value, data:data}, function(data){
            var box = self.parents('.rating-box'),
                boxparent = box.parents('div').eq(0);
            box.find('.rating-icon').each(function () {
                if($(this).data('value') != value){
                    $(this).hide();
                }
            });
            boxparent.find('.byline').hide();
            parse_response(data)
        })
    });
});