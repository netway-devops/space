if(typeof(hb_footprint)=="undefined") {
    //footprint object
    var hbfootprintREPLACE_UNIQUEID = function() {
        this.hburl ="REPLACE_HBURLindex.php?cmd=hbchat";
        this.getRandom = function () {
            var date = new Date() ;
            return date.getTime() ;
        }
        this.startChat= function() {
            return window.open(this.hburl+'&action=popup',this.getRandom(),'scrollbars=no,resizable=yes,menubar=no,location=no,screenX=50,screenY=100,width=484,height=530');
        };
    };
    var hb_footprint = new hbfootprintREPLACE_UNIQUEID();
}
