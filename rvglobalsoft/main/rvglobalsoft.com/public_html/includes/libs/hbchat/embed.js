/* 
 * This is skeleton of javascript code returned for tracker/chat now icon.
 * What it does:
 * -  tracks user actions on website wherever its embeded
 * -  include tag "chat now" on website, using different widgets
 * -  handles proactive chat engage (invitation) using img return from footprint tracker
 */

//make sure there is no duplicates of our object
if(typeof(hb_footprint)=="undefined") {

    //footprint object
    var hbfootprintREPLACE_UNIQUEID = function() {

       
        this.invitelocation='topleft';
        this.chatting = false;
        this.invitebuilt=false;
        this.invited = false;
        this.footprintloop_id=0;
        this.footprintinitial=1;
        this.browserwidth=0;
        this.browserheight=0;


        this.readCookie =function(name) {
                var nameEQ = name + "=";
                var ca = document.cookie.split(';');
                for(var i=0;i < ca.length;i++) {
                        var c = ca[i];
                        while (c.charAt(0)==' ') c = c.substring(1,c.length);
                        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
                }
                return null;
        }
        this.createCookie= function(e,t,n){
            if(n){
                var r=new Date;
                r.setTime(r.getTime()+n*24*60*60*1e3);
                var i="; expires="+r.toGMTString()
            }else 
                var i="";
            document.cookie=e+"="+t+i+"; path=/"
        }

        this.analytics = this.readCookie('__utmz');
        this.analyticsval =  function() {
                var pairs = this.analytics ? this.analytics.split('.').slice(4).join('.').split('|') : [];
                var ga = {};
                for (var i = 0; i < pairs.length; i++) {
                    var temp = pairs[i].split('=');
                        ga[temp[0]] = temp[1];
                }
                return ga;
            };


        this.detectOS = function () {
           
            if(navigator.appVersion.indexOf('Win') != -1) {
                return 'Win';
            } else if(navigator.appVersion.indexOf('Mac') != -1) {
                return 'Mac';
            } else if (navigator.appVersion.indexOf('Linux') != -1) {
                return 'Linux';
            }
            return 'Mobile';

        };

        this.detectBrowser = function() {
            if( typeof( window.innerWidth ) == 'number' ) {
                this.browserwidth = window.innerWidth;
                this.browserheight = window.innerHeight;
            } else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
                this.browserwidth= document.documentElement.clientWidth;
                this.browserheight = document.documentElement.clientHeight;
            }


            if(navigator.userAgent.indexOf('MSIE') != -1) {
                return 'IE';
            } else if (navigator.userAgent.indexOf('Opera') != -1) {
                return 'Opera';
            } else if (navigator.userAgent.indexOf('Chrome') != -1) {
                return 'Chrome';
            } else if (navigator.userAgent.indexOf('Gecko') != -1) {
                return 'Firefox';
            } else if (navigator.userAgent.indexOf('Konqueror') != -1) {
                return 'Konqueror';
            } else if (navigator.userAgent.indexOf('Safari') != -1) {
                return 'Safari';
            } else  return 'Mobile';


        };

        
        this.hburl ="REPLACE_HBURLindex.php?cmd=hbchat";
        this.hburlfull="REPLACE_HBURL";
        this.invitationimage="REPLACE_INVITATIONIMAGE";
        this.tagid="REPLACE_TAGID";
        this.hbfootprintimage=0;
        this.hbdeclineimage=0;
        this.hbacceptimage=0;
        this.browser = encodeURIComponent(this.detectBrowser());
        this.os=encodeURIComponent(this.detectOS());
        this.referer = encodeURIComponent( document.referrer ) ;
        this.page = encodeURIComponent( location.toString() ) ;
        this.page_title = encodeURIComponent( document.title );

        

        this.getRandom = function () {
            var date = new Date() ;
            return date.getTime() ;
        }

        this.hideInvite=function(){
            var c = document.getElementById("hbinvitationcontainer_"+this.tagid);
            if(!c)
                return;
            c.style.display = "none";
        };

        this.inviteShow=function() {
            this.invited=true;
            //fetch invitation image, show it in overlay id hbinvitationcontainer_+this.tagid
            var invitecontainer = document.getElementById("hbinvitationcontainer_"+this.tagid);
            if(invitecontainer)
                invitecontainer.style.display="block";
        };

        this.inviteDecline=function() {
            this.hbdeclineimage=new Image;
            this.hbdeclineimage.src = (this.hburl) + "&action=declinechatinvitation";
            //hide proactive chat container
            this.hideInvite();
            this.invited=false;
        };

        this.checkChatStatus= function(){
            var self = hb_footprint || this;
            if(self.checkChatStatusTime)
                clearTimeout(self.checkChatStatusTime);
            var session = self.readCookie('HBFootprint[chat_session]'),
                count = parseInt(session);
            if(isNaN(count)){
                if(session && session =='init')
                    self.checkChatStatusTime=setTimeout(self.checkChatStatus, 1000);
                return false;
            }
            if(!count || count < 0){
                self.createCookie('HBFootprint[chat_session]', '', -1);
                $.get(self.hburl+'&action=end', {time:0});
            }else{
                self.createCookie('HBFootprint[chat_session]', parseInt(count)-1, 1);
                self.checkChatStatusTime=setTimeout(self.checkChatStatus, 1000);
            }
            
        }
        this.checkChatStatusTime=null;
       
        this.startChat= function() {
            this.hideInvite();
            this.chatting=true;
            var win = window.open(this.hburl+'&action=popup',this.getRandom(),'scrollbars=no,resizable=yes,menubar=no,location=no,screenX=50,screenY=100,width=484,height=530');
            this.createCookie('HBFootprint[chat_session]', 'init', 1);
            return win;
        };

        this.inviteAccept=function() {

            this.hbacceptimage=new Image;
            this.hbacceptimage.src = (this.hburl) + "&action=acceptchatinvitation";
            this.hideInvite();
            this.startChat();
       },


        this.scrollinvitation=function() {
            var invitecontainer = document.getElementById("hbinvitationcontainer_"+this.tagid);
            if(invitecontainer) {
                switch(this.invitelocation) {
                    case 'bottomleft':
                    case 'bottomright':
                        break;
                    case 'topright':
                    case 'topleft':
                    default:
                        var t=parseInt(document.documentElement.scrollTop ?               document.documentElement.scrollTop :               document.body.scrollTop) + 50;
                        invitecontainer.style.top=t+'px';
                        break;

                }

                
            }


        };

        this.buildinvitation = function() {
            var invitecontainer = document.getElementById("hbinvitationcontainer_"+this.tagid);
            if(invitecontainer) {
                this.invitebuilt=true;
            } else {
                return false;
            }
            var inviteimage="<a href='javascript:void(0)' onclick='hb_footprint.inviteAccept();' style='position:absolute;z-index:502;top:0px;left:0px;'><img src='"+this.hburl+"&action=inviteimage&imageid="+this.invitationimage+"' alt='Live Chat' style='border:none;' /></a>";
            var invitecontent="<div style='position:relative'>"+inviteimage+"<a href='javascript:void(0)' onclick='hb_footprint.inviteDecline();' style='position:absolute;z-index:504;top:-15px;left:-15px;'><img src='"+this.hburlfull+"templates/hbchat/img/close.png' alt='Close' style='border:none;' /></a></div>";
            var element = document.createElement("div");
            element.style.position = 'absolute';
            switch(this.invitelocation) {
                case 'topright':
                    element.style.right='50px';
                    element.style.top='50px';
                    break;
                case 'bottomleft':
                    element.style.left='50px';
                    element.style.bottom='50px';
                    break;
                case 'bottomright':
                    element.style.right='50px';
                    element.style.bottom='50px';
                    break;
                case 'topleft':
                default:
                    element.style.left='50px';
                    element.style.top='50px';
                    break;
            }

            element.innerHTML = invitecontent;
            if(invitecontainer) {
                invitecontainer.style.display="none";
                invitecontainer.style.position="absolute";
                invitecontainer.style.left='0px';
                invitecontainer.style.top='0px';
                invitecontainer.style.zIndex = 500;
                invitecontainer.appendChild(element);

                window.onscroll=function(){
                    hb_footprint.scrollinvitation();
                };
            }

        };

        this.footprintonload=function(){
            //footprint image has been returned, check its width for actions
            var loop=true;
            switch(this.hbfootprintimage.width) {
                case 1:
                    if(!this.invitebuilt)
                        this.buildinvitation();
                    break;
                case 2:
                    //dept is no longer online
                    loop=false;
                    clearTimeout(this.footprintloop_id);
                    break;
                case 3:
                    //popup invitation
                    if(!this.chatting && !this.invited) {
                        this.inviteShow();
                    }
                    break;
            }
            if(loop)
                this.footprintloop_id= setTimeout("hb_footprint.footprinttrack()", 10000);
        };

        this.footprinttrack=function(){
            this.hbfootprintimage=new Image;
            this.hbfootprintimage.onload = function(){
                hb_footprint.footprintonload();
            };
            var v= this.analyticsval();
            var searchterm = v && v.utmctr?v.utmctr:'';

            this.hbfootprintimage.src = (this.hburl) + "&action=footprint&page="+(this.page)+"&page_title="+(this.page_title)+"&ref="+(this.referer)+"&os="+(this.os)+"&browser="+(this.browser) + "&rand="+this.getRandom()+"&initial="+this.footprintinitial+"&searchterm="+searchterm;
            this.footprintinitial=0;
        };

       


        this.footprinttrack();
        this.buildinvitation();
        this.checkChatStatus();
    };


    var hb_footprint = new hbfootprintREPLACE_UNIQUEID();
}

REPLACE_WIDGET