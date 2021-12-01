<script language="JavaScript">
   
    var TableOfContent     = function () {
        this.data   = {};
    };

TableOfContent.prototype.buildData      = function () {

    var i       = {h1:0,h2:0,h3:0,h4:0,h5:0};
    var oHead   = $('.content').find('h1:first');
    if (! oHead.length) {
        oHead   = $('.content').find('h2:first');
    }
    if (! oHead.length) {
        oHead   = $('.content').find('h3:first');
    }

    while (oHead.length) {
        var oData   = {};
        var text    = oHead.text();
        
        if (oHead.is('h1')) {
            i.h1++;
            var id = 'h1'+ i.h1; 
            oHead.prepend('<div id="'+ id +'"style="padding: 60px 0px 0px 0px;">');
            oData   = { 
                [i.h1]: { id: id, text: text, child: {} }
            };
            oTableOfContent.data    = $.extend(true, oTableOfContent.data, oData);
        }
        
        if (oHead.is('h2')) {
            i.h2++;
            var id = 'h2'+ i.h2;
            oHead.prepend('<div id="'+ id +'"style="padding: 58px 0px 0px 0px;">');
            oData   = {
                [i.h1]: {
                    child: {
                        [i.h2]: { id: id, text: text, child: {} }
                    }
                }
            };
            oTableOfContent.data    = $.extend(true, oTableOfContent.data, oData);
        }
        
        if (oHead.is('h3')) {
            i.h3++;
            var id = 'h3'+ i.h3;
            oHead.prepend('<div id="'+ id +'">');
            oData   = {
                [i.h1]: { 
                    child: {
                        [i.h2]: {
                            child: {
                                [i.h3]: { id: id, text: text, child: {} }
                            }
                        }
                    }
                }
            };
            oTableOfContent.data    = $.extend(true, oTableOfContent.data, oData);
        }
        
        if (oHead.is('h4')) {
            i.h4++;
            var id = 'h4'+ i.h4;
            oHead.prepend('<div id="'+ id +'"style="padding: 58px 0px 0px 0px;">');
            oData   = {
                [i.h1]: {
                    child: {
                        [i.h2]: {
                            child: {
                                [i.h3]: {
                                    child: {
                                        [i.h4]: { id: id, text: text, child: {} }
                                    }
                                }
                            }
                        }
                    }
                }
            };
            oTableOfContent.data    = $.extend(true, oTableOfContent.data, oData);
        }
        
        if (oHead.is('h5')) {
            i.h5++;
            var id = 'h5'+ i.h5;
            oHead.prepend('<div id="'+ id +'"style="padding: 58px 0px 0px 0px;">');
            oData   = {
                [i.h1]: { 
                    child: {
                        [i.h2]: {
                            child: {
                                [i.h3]: {
                                    child: {
                                        [i.h4]: {
                                            child: {
                                                [i.h5]: { id: id, text: text, child: {} }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            };
            oTableOfContent.data    = $.extend(true, oTableOfContent.data, oData);
        }
        
        oHead   = oHead.next();
       
    }

    
    //console.log(oTableOfContent.data);
    
    var html    = '';
    var wordContent ='<br><center>เนื้อหา</center><br/>' ;
    html        = oTableOfContent.getChild(oTableOfContent.data);
    var toc     = $('#kbContent:contains("[TOC]")');
   
  
   if(toc.length){  
     $('p:contains("[TOC]")').attr('id','toc').html(); 
     $('#toc').attr('class','tableOfContent').html(wordContent+html);
      $('#kbContent').find('h1').css('background-color', '#f1f1f1' ).css('padding' ,'0 0 30px 10px');
      
    } 
    if(! toc.length){   
     $( 'h1' ).css( 'background-color', 'transparent' )

    } 
     if ( ! Object.keys(oTableOfContent.data).length) {
        $('.tableOfContent').hide();
    }
    
};

       

TableOfContent.prototype.getChild     = function (oData) { 
    
    var count   = Object.keys(oData).length; 
    var html    = '';
    
    if (count) {
        html += '<ol class="list" >';
        $.each(oData, function (k, v) {
            
            html += '<li class=" listNum countList "> <a  class="dynamic-nav"  href="#'+v.id+'" style="color:#0645ad" >'+ v.text;
           
            html += oTableOfContent.getChild(v.child);
            
            html += '</a></li>';
           
        });
        html += '</ol>';     
    }
    
    return html;
};


var oTableOfContent    = new TableOfContent(); 
$(document).ready( function () {
    oTableOfContent.buildData();
     $("a.dynamic-nav").on('click', function(event) {
        if (this.hash !== "") {
          event.preventDefault();
          var hash = this.hash;
          $('html, body').animate({
            scrollTop: $(hash).offset().top-50
          }, 800, function(){
            window.location.hash = hash;
          });
        }
        toggleActiveClass($(this));
    });
});

</script>