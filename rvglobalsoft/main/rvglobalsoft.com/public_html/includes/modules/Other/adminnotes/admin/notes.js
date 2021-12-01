$(function() {

    var allnotes = {};
    var noteSelected = 0;
    

    var noteLiHtml = '<div class="notes-snippet" data-note-id="%noteid%">'+
        '<h6 class="notes-title">%title%</h6>'+
        '<span class="notes-date">%date%</span>'+
        '</div>';

    var updateNoteList = function (notes) {
        allnotes = {};
        for(var i=0;i < notes.length;i++) {
            allnotes[notes[i].id]=notes[i];
        }
        var noteList = '';
        $.each( notes, function( id, note ) {
            var titleElement = document.createElement("DIV");
            $(titleElement).html(note.note);
            var title = $(titleElement).text();
            noteList += noteLiHtml.replace('%title%', note.title).replace('%date%', note.date).replace('%noteid%', note.id);

        });

        $('#notes-container .note-list-container').html(noteList);
        $('#notes-container .notes-snippet').removeClass('active');
        $('#notes-container .notes-snippet[data-note-id="'+noteSelected+'"]').addClass('active');
    };

    var openNote = function (noteID) {
        try {
            noteSelected = noteID;
            $('#adminnoteditor > .scroll-content').html(allnotes[noteID].note);
            $('#notes-container .notes-snippet').removeClass('active');
            $('#notes-container .notes-snippet[data-note-id="'+noteSelected+'"]').addClass('active');
        } catch (e) { }
    };

    var getArr = function (obj) {
        var arr=[];
        $.each( obj, function( id, note ) {
           arr.push(note);
        });
        return arr;
    }

    $.getJSON('?cmd=adminnotes&action=listnotes',{},function(notes){
        updateNoteList(notes);
        if(notes.length>0) {
            openNote(notes[0].id);
        }


        $('body').on('click', '.notes-snippet', function () {
            openNote($(this).attr('data-note-id'));
        });


        $('#addnote').unbind('click').click ( function () {
            bootbox.prompt("Note title?", function(result) {
                if (result === null) {
                } else {
                    $.post('?cmd=adminnotes&action=add',{title:result},function(data){

                        updateNoteList(data);
                        var last = Object.keys(data).pop();
                        openNote(data[last].id);

                    });
                }
            });

        });

        $('#savenote').unbind('click').click(function () {
            $.post('?cmd=adminnotes&action=save',{id:noteSelected,note: $('#adminnoteditor > .scroll-content').html()});;
        });
        $('#rmnote').unbind('click').click ( function () {
            $.post('?cmd=adminnotes&action=rm',{id:noteSelected},function(data){


            });

            delete allnotes[noteSelected];
            updateNoteList(getArr(allnotes));
            var last = Object.keys(allnotes).pop();
            openNote(allnotes[last].id);


        });

        $('#adminnoteditor > .scroll-content')[0].addEventListener('input', function () {
            allnotes[noteSelected].note =  $('#adminnoteditor > .scroll-content').html();
            updateNoteList(getArr(allnotes));
        }, false);




        $('#adminnote').summernote({
            airMode: true,
            airPopover: [
                ['color', ['color']],
                ['font', ['bold', 'underline', 'clear']],
                ['para', ['ul', 'paragraph']],
                ['table', ['table']],
               ['insert', ['link']]
            ],
        });


    });

  


});
