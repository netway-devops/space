/* 2019-01 */
    $(document).ready(function(){
        $('.customer-logos').slick({
            slidesToShow: 6,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 1500,
            arrows: false,
            dots: false,
            pauseOnHover: false,
            responsive: [{
                breakpoint: 768,
                settings: {
                    slidesToShow: 4
                }
            }, {
                breakpoint: 520,
                settings: {
                    slidesToShow: 3
                }
            }]
    });
    
        $('#sendMail').submit(function(){
                    
                    var name    = $('#name').val();  
                    var email   = $('#email').val();           
                    var phone   = $('#phone').val();
                    var comment = $('#comment').val();
                    event.preventDefault();
                    $.post( "?cmd=zendeskhandle&action=CeoEmailTicket", 
                    {
                        name     : name ,
                        email    : email,
                        comment  : comment ,
                        phone    : phone 
                       
                    },function( data ) {
                          $('div.modal-body').html(" <p style=\"text-align: center;font-size: 20px;margin-top: 15px;font-family: Roboto, Arial, sans-serif;\">Pairote Rojanaphusit</p><hr><p  style=\"font-size: 20px;font-family: Roboto, Arial, sans-serif;  margin-bottom: 20px;text-align: center;\"> ขอบคุณครับที่ส่งข้อมูลเข้ามา  ผมจะติดต่อกลับโดยเร็วที่สุด</p>");
                          document.getElementById('sendMail').reset();
                          $('#ceoModal').modal('toggle');
                    });
       
         });
         
        $("p.gs-d").click(function(){
            $("i.x").toggleClass("fa fa-angle-down pull-right x fa fa-angle-up pull-right x");
            $( "ul.detail" ).slideToggle( "slow" );
            $( "p.txt-gs" ).toggle();
        });

        $("p.gs-d1").click(function(){
               $("i.xx").toggleClass("fa fa-angle-down pull-right xx fa fa-angle-up pull-right xx");
               $( "ul.detail-1" ).slideToggle( "slow" );
               $( "p.txt-gs-1" ).toggle();
        });

        $("p.gs-d2").click(function(){
                $("i.xxx").toggleClass("fa fa-angle-down pull-right xxx fa fa-angle-up pull-right xxx");
                $( "ul.detail-2" ).slideToggle( "slow" );
                $( "p.txt-gs-2" ).toggle();
        });
    
        $(".bg-q").click(function(){
                $("i.x").toggleClass("fa fa-angle-down pull-right x fa fa-angle-up pull-right x");
                $( "ul.detail" ).slideToggle( "slow" );
                $( "p.gs-text" ).toggle();
        });

        $(".bg-q-1").click(function(){
               $("i.xx").toggleClass("fa fa-angle-down pull-right xx fa fa-angle-up pull-right xx");
               $( "ul.detail-1" ).slideToggle( "slow" );
               $( "p.gs-text-1" ).toggle();
           });

        $(".bg-q-2").click(function(){
               $("i.xxx").toggleClass("fa fa-angle-down pull-right xxx fa fa-angle-up pull-right xxx");
               $( "ul.detail-2" ).slideToggle( "slow" );
               $( "p.gs-text-2" ).toggle();
           });

     
  });



	$('.lazy').Lazy({
	    scrollDirection: 'vertical',
	    delay: 2000,
	    effect: 'fadeIn',
	    visibleOnly: true,
	    onError: function(element) {
	        console.log('error loading ' + element.data('src'));
	    }
	});
	
	$('.lazy-hero').Lazy({
	   scrollDirection: 'false',
	   delay: 800,
	   effect: 'fadeIn',
	   visibleOnly: true,
	   onError: function(element) {
	       console.log('error loading ' + element.data('src'));
	   }
	});





