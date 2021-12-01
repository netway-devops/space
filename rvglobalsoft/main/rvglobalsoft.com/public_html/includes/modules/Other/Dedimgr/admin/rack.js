$(function() {
    
    $('#sortable tr.have_items').each(function(n){
        var that = $(this);
        var s=parseInt($(this).attr('size'));

        if( s>1) {
            var x=that.next();
            for(var i=1;i<s;i++) {
                if(!x.hasClass('have_items')) {
                    x.remove();
                }
                x=that.next();
            }
        }
    });
    $( "#sortable" ).sortable({
        update: function(event, ui) {
            var total = $( "#rowcols tr" ).length -1 ;
            //re-assign positions, save changes
            var i=0;
            var o={};
            var size=1;
            $( "#sortable .dragdrop" ).each(function(n){
                size=parseInt($(this).attr('size'));
                $(this).attr('pos',total-i);
                if($('td.contains',$(this)).length) {
                    o[total-i] = $('td.contains',$(this)).attr('id').replace('item_','');
                }
                i=i+size;
            });

            ajax_update('?cmd=module&module=dedimgr&do=setnewpositions&rack_id='+$('#rack_id').val(),{
                vars:o
            });


        },
        handle: '.im_sorthandle'
    });
});