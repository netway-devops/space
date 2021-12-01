$(function() {

    var global_bookmark = '';

    var updateBookmarkList = function (bookmarks) {
        $('#bookmark-container').empty();
        var width = $('#bookmark-container').width();
        console.log(width);
        var row = 0;
        var colclass = '';
        for(var i=0;i < bookmarks.length;i++) {
            if (width > 800){
                colclass = 'col-sm-1';
                if (row % 12 == 0){
                    $('#bookmark-container').append('<div class="row bookmark-row"></div>');
                }
            }else{
                colclass = 'col-sm-2';
                if (row % 6 == 0){
                    $('#bookmark-container').append('<div class="row bookmark-row"></div>');
                }
            }
            $('#bookmark-container').append('<a href="'+bookmarks[i].url+'" target="_blank"><div id="bookmark'+bookmarks[i].id+'" class="col-xs-6 '+colclass+' bookmark-one text-center">' +
                '<i class="fa '+bookmarks[i].icon+' col-sm-12 bookmark-icon" aria-hidden="true"></i>' +
                '<label class="bookmark-name">'+bookmarks[i].name+'</label>' +
                '</div></a>');
            row++;
        }
        global_bookmark = bookmarks;
    };

    $.getJSON('?cmd=bookmarks&action=listbookmarks',{},function(bookmarks){
        updateBookmarkList(bookmarks);

        $('#addbookmark').unbind('click').click ( function () {
            bootbox.confirm(
                codeHTML,
                function(result) {

                    if(result){
                        $.post('?cmd=bookmarks&action=add',
                            {
                                name: $('#b-name').val(),
                                url: $('#b-url').val(),
                                icon: $('#b-icone').val()
                            },
                            function (data){
                                updateBookmarkList(data);
                            });
                    }
                });
        });

        $('#removebookmark').unbind('click').click ( function () {

            var inputOptions =[];
            for(var i=0;i < global_bookmark.length;i++) {
                inputOptions[i] = {text: global_bookmark[i].name, value: global_bookmark[i].id.toString()};
            }

            bootbox.prompt({
                title: "Remove Bookmark",
                inputType: 'select',
                inputOptions: inputOptions,
                callback: function (result) {
                    if(result){
                        $.post('?cmd=bookmarks&action=remove',
                            {
                                bookmark_id: result
                            },
                            function (data){
                                updateBookmarkList(data);
                            });
                    }
                }
            });
        });
    });

});

var codeHTML =
    "<label class=\"col-sm-12 text-center\" style='font-size: 20px; margin-bottom: 10px;'>Add Bookmark</label>"+
    "<div class='row'>"+
    "<div class='col-sm-9'>"+
    "<form id='b-form' action='' class='form-horizontal'>" +
        "<div class=\"form-group\">" +
            "<label class=\"col-sm-2 control-label\">Name:</label>" +
            "<div class=\"col-sm-10\">" +
                "<input id='b-name' type='text' name='b-name' value='' class=\"form-control\"/>" +
            "</div>" +
        "</div>" +
        "<div class=\"form-group\">" +
            "<label class=\"col-sm-2 control-label\">URL:</label>" +
            "<div class=\"col-sm-10\">" +
                "<input id='b-url' type='text' name='b-url' value='' class=\"form-control\"/>" +
            "</div>" +
        "</div>" +
        "<div class=\"form-group\">" +
            "<label class=\"col-sm-2 control-label\">Icon:</label>" +
            "<div class=\"col-sm-10\">" +
                "<input id='b-icone' type='text' name='b-icone' value='fa-chain' class=\"form-control\"/>" +
            "</div>" +
        "</div>" +
    "</form>"+
    "</div>"+
    "<div class='col-sm-3 vertical-center'>" +
    "<i id='bb-icon' class=\"fa text-center col-sm-12 bookmark-icon fa-chain\" aria-hidden=\"true\" style='min-height: 30px; margin-top: 30px;'></i>"+
    "<label id='bb-name' class='text-center col-sm-12' style='min-height: 10px; margin-top: 5px;'></label>"+
    "<script>" +
    "var earlierclass = '';"+
    "$('#b-icone').iconpicker();" +
    "$('#b-name').on('keyup', function() {$('#bb-name:last').text($(this).val());});"+
    "$('#b-icone').on('iconpickerSelected', function(event){" +
        "$('#bb-icon').removeClass('fa-chain');"+
        "$('#bb-icon').removeClass(earlierclass);"+
        "$('#bb-icon').addClass(event.iconpickerValue);"+
    "earlierclass = event.iconpickerValue;"+
    "});"
"</script>" +
    "</div> "+
"</div>";
