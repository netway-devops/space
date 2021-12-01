//PouchDB.destroy('rvglobalkb');
var pdb     = new PouchDB('rvglobalkb');
var remoteCouch     = false;
var localDb         = false;

function localStorageKb (catId) {
    pdb.allDocs({include_docs: true}, function(error, response) {
        if (! response.rows.length) {
            return false;
        }
        $.each(response.rows, function(i, oArr) {
            pdb.remove(oArr.id, oArr.value.rev, function(error, response) { });
        });
    });

    $.get('?cmd=kbhandle&action=indexing&catId='+ catId +'', function (data) {
        parse_response(data);
        if (data.indexOf("<!-- {") == 0) {
            var codes = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
            if (codes.DATA.length == 0) {
                return false;
            }
            
            var oData       = codes.DATA[0];
            
            $.each(oData, function( i, oArr ) {
                pdb.post(oArr, function(error, response) {
                    //console.log(response);
                });
            });
            
        }
        
        
    });
    
}

function kbQuery (categoryId,searchKeyword)
{
    var map = function(doc) {
        /*
        var searchkey, regex;
        keyword     = 'project';
        searchkey   = keyword.replace(/[$-\/?[-^{|}]/g, '\\$&');
        regex       = new RegExp(searchkey,'i');
        */
        
        if (doc.title.match(/project/g) ||
            doc.desc.match(/project/g) ||
            doc.tags.match(/project/g)) {
            emit(doc._id, {id: doc.id, title: doc.title, slug: doc.slug});
        }
    }
    var x       = new Date().getSeconds();console.log(x);
    pdb.query(map, {limit:5}, function(error, response) {
        console.log(response);
        if (! response.rows.length) {
            return false;
        }
        $('#kbArticles').show();
        $.each(response.rows, function(i, oArr) {
            kbSuggestionShow_ext(oArr.value);
        });
        
        var y       = new Date().getSeconds();console.log(y);
    });
    
}

function isLocalDbReady()
{
    if (! localDb) {
        pdb.info(function(error, info) {
            if (info.doc_count > 0) {
                localDb     = true;
            }
        });
    }
    
    return localDb;
}
