$(window).on('load resize', function(){
    $window = $('#reseller-frame').parent().parent();


    var geth=function(){
        return $window.height();
    };
    $('#reseller-frame').parent().height(geth);
    $('#reseller-frame').height(geth);
});
var ifrh = function () {
    var iframeId = document.getElementById('reseller-frame');
    return iframeId.contentWindow.document.body.scrollHeight;
};

function iframeLoaded() {
    // cross-origin frame issue
    // $('#reseller-frame').parent().height(ifrh);
    // $('#reseller-frame').height(ifrh);
}