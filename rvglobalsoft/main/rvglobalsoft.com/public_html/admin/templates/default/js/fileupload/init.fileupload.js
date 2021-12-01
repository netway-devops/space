function _fileupload_init(){
    $('input[type=file][data-upload]').each(function(){
        var that = $(this),
            url = that.attr('data-upload');
        if(that.data('fileup'))
            return true;
        that.data('fileup', true).fileupload({
            dataType: 'json',
            url: url
        });
    });
}
function fileupload_init(){
    _fileupload_init();
}
fileupload_init();