var HBVisitor  = {
    lang: [],
    original_title: '',
    failcount:0,
    myname:'You',
    myemail:'',
    options: {
        debug: 0,
        sound: 1,
        blink_interval:800,
        msgtimeout:3000
    },
    status:'Active',
    system_url:'',
    switch_tab: function(target,el) {
        if(!$('#'+target).length)
            return false;
        $('.ico_container','#chatshelf').removeClass('active');
        $(el).addClass('active');
        $('.tab','#chatcontainer').hide();
        $('#'+target).show();
        if(target=='tab_chat')
            $('#replycontainer').show();
        else
            $('#replycontainer').hide();
        return false;
    },
    popupPrint: function() {
        var url=this.system_url+"index.php?cmd=hbchat&action=printchat";
        window.open( url, "HBChat_Print_", "scrollbars=yes,menubar=no,resizable=1,location=no,width=650,height=450,status=0" ) ;
        return false;
    },
    blink : function(that, state){
        var self = this;
        $(that).fadeTo(450, state ? 1 : 0.5 , function(){
            if($(that).hasClass('blink'))
            self.blink(that, state ? 0 : 1);
        });
    },
    sendEmailTranscript: function(that) {
        if($(that).hasClass('blink'))
            return false;
        var self = this;
        $(that).addClass('blink');
        self.blink(that);
        $.getJSON(this.system_url+'index.php?cmd=hbchat&action=emailTranscript',{},function(data){
            $(that).removeClass('blink');
            self.blink(that,true);
            if(data.status){
                $.getScript(self.system_url+"/templates/hbchat/js/jquery.jgrowl_minimized.js", function(){
                    $('#jGrowl').jGrowl(data.status_text,{
                        sticky: true
                    });
                });
            }
        });
        return false;
    },

    //Init chat - start loops, init DOM objects
    init: function() {
        this.bindEvents();
        this.initSounds();
        this.blinkLoop();
        this.original_title=document.title;
        this.msgloop(true);
    },
    prepareMSG: function(string) {
        if ( string.substr((string.length-2), string.length) == "\r\n" ) {string=string.substr(0, (string.length-2)) ;}
	else if ( string.substr((string.length-1), string.length) == "\n" ) {string= string.substr(0, (string.length-1)) ;}

        string= string.replace(/>/g, "&gt;");
        string= string.replace(/</g, "&lt;");
        
        var replacePattern1 = /(\b(https?|ftp):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/gim;
        string = string.replace(replacePattern1, '<a href="$1" target="_blank">$1</a>');

        var replacePattern2 = /(^|[^\/])(www\.[\S]+(\b|$))/gim;
        string=string.replace(replacePattern2, '$1<a href="http://$2" target="_blank">$2</a>');

        var replacePattern3 = /(\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,6})/gim;
        string = string.replace(replacePattern3, '<a href="mailto:$1">$1</a>');
        //nl2br
        return string.replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1<br/>$2');
    },
    sendMSG: function() {
        if(this.status=='Closed' || this.status=='Timeout')
            return false;
        var msg = $('#replybox').val();
        if(msg == $('#replybox').attr('default') || msg=='' || msg==' ')
            return false;
        this.displayMSG({
            type:'Client',
            submitter_name:this.myname,
            message:msg
        });
        $('#replybox').val('').focus();
        //send it
        $.post(this.system_url+'index.php?cmd=hbchat&action=message',{message:msg},function(){
            
        },'json').error(function(){});
    },
    displayMSG: function(data) {
       //render message, scroll down the window
       var m='';
       if(data.message)
           data.message = this.prepareMSG(data.message);
       if(data.type=='Client' && data.submitter_name.indexOf('#')==0)
           data.submitter_name=this.myname;
       
       m = this.renderTemplate('message_template', data);
       if(!m)
           return false;

      $('#conversation_container .messages').append(m);
      $("#conversation_container").scrollTop($("#conversation_container .messages")[0].scrollHeight);
    },
    msgloopTimeout:null,
    msgloop: function(initial) {
        var ini = typeof(initial)=='boolean' && initial==true?1:0;
        var self = HBVisitor;
        $.getJSON(self.system_url+'index.php?cmd=hbchat&action=pull',{init:ini},function(data){
            if(data.success) {
                if(data.pulldata.messages.length) {
                     for (var i in data.pulldata.messages) {
                        self.displayMSG(data.pulldata.messages[i]);
                     }
                     //play sound
                     self.playSound('newmsg');
                }
                if(data.pulldata.status=='Timeout' && self.status=="Pending") {
                  self.chatOffline();
                }
                self.status= data.pulldata.status;
            } else {
                self.failcount++;
              if(self.failcount>4) {
                  self.chatOffline();
              }
            }
      }).error(function(){
          self.failcount++;
          if(self.failcount>4) {
              self.chatOffline();
          }
      });
        if(self.msgloopTimeout)
            clearTimeout(self.msgloopTimeout);
        self.msgloopTimeout = setTimeout(self.msgloop,self.options.msgtimeout);
        var r=new Date;
        r.setTime(r.getTime()+24*60*60*1e3);
        document.cookie="HBFootprint[chat_session]=10; expires="+r.toGMTString()+"; path=/";
    },
   
    chatOffline: function() {
      //sth went wrong, redirect to chat offline screen.
       window.onbeforeunload = function() {}
      window.location=this.system_url+'index.php?cmd=hbchat&action=leavemessage';
    },

    blinkLoop: function() {
       var self=HBVisitor;
        if($('.blinking','#hb_chat_tabs_container').toggleClass('blink_on').length) {
            if(document.title.indexOf('Alert') > -1) {
                document.title=self.original_title;
            } else {
                document.title="#! Alert !# "+self.original_title;
            }
        }
        setTimeout(self.blinkLoop,self.options.blink_interval);
    },
    close: function(){
        var self = this;
        if(confirm("Are you sure?"))
        $.get(self.system_url+'index.php?cmd=hbchat&action=end', {time:0},function(){
            window.onbeforeunload = null;
            window.close();
        });
    },
    bindEvents: function() {
        var self = this;
        window.onbeforeunload = function() {            
            if(self.status!='Closed' && self.status!='Timeout')
            return "Are you sure?" ;
        }
        $(document).bind('keydown keyup', function(e){
            if(e.keyCode == 116){
                e.preventDefault();
                if(e.type == 'keydown')
                    self.msgloop();
                return false;
            }
        });
         $('#replybox').focus(function(){
             if($(this).val()==$(this).attr('default'))
                 $(this).val('');
         }).keyup(function(event){
             if(!event.shiftKey && (event.keyCode==13 || event.keyCode==10)) {
                 self.sendMSG();
             }
         });
         $('#sendbtn').click(function(){
             self.sendMSG();
         });
         $('.showtipsy ').each(function(){
             var gravity = $(this).hasClass('nw')?'nw':'ne';
             $(this).tipsy({gravity:gravity
         });
         });
    },
    //template functions
    renderTemplate: function(tpl_id, data, target) {
        if(!$('#'+tpl_id,'#hb_chat_template').length) {
            return false;
        }
        var h  = Mustache.to_html($('#'+tpl_id,'#hb_chat_template').val(),data);
        if(typeof(target)!='undefined' && $('#'+target).length)
            $('#'+target).html(h);
        return h;
    },

    sound_newmsg:false,
    sound_swfpath:false,

    initSounds: function() {
        var p = this.sound_swfpath
      
        if(this.sound_newmsg) {
            var s=this.sound_newmsg;
            $("#sound_newmsg").jPlayer({
                ready: function () {
                    this.element.jPlayer("setFile",s);
                },
                swfPath:p
            });
        }
     
    },
    playSound: function(which) {
        if(this.options.sound && typeof($('#sound_'+which).jPlayer)!='undefined')
            $('#sound_'+which).jPlayer('play');
    },
    toggleChatSound: function() {
        if(this.options.sound==1) {
            this.options.sound=0;
            $('.chat_sound_icon').removeClass('sound_on');
        } else {
            this.options.sound=1;
            $('.chat_sound_icon').addClass('sound_on');
        }
    }
};