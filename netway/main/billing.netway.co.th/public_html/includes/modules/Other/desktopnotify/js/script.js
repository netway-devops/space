var DesktopEvent = {
    push: function(e){
        if (!Notify.needsPermission) {
            doNotification();
        } else if (Notify.isSupported()) {
            Notify.requestPermission(function(){ doNotification(); }, function(){});
        }
        function onClickNotification() {
            if(typeof(e.url) !== "undefined" && e.url!='') {
                window.location=e.url;
            }
        }
        function doNotification() {
            var myNotification = new Notify(e.subject, {
                body: e.body,
                icon: "https://www-cdn.hostbillapp.com/image/logo_small2.png",
                notifyClick: onClickNotification
            });
            myNotification.show();
        }
    },
    time: 0,
    poll: function() {
        if(!DesktopEvent.time) {
            DesktopEvent.time = window.setInterval(function(){
                ajax_update('index.php');
            },10000);
        }
    },
    pushlist: function(list) {
        for(var i in list) {
            DesktopEvent.push(list[i]);
        }
    },
    test: function(e) {
        DesktopEvent.sound('../includes/modules/Other/desktopnotify/sounds/light.mp3');
        DesktopEvent.push({
            subject: "Success!",
            body: "Desktop notifications works!",
            url: ""
        });
        return false;
    },
    sound: function (path) {
        var sound = new Howl({
            src: [path]
        });
        sound.play();
    }
};