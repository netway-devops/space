$( document ).ready(function() {
    $('.leftNav a:not(:contains("DNS"))').remove();
    $(".chosen").chosen({
        disable_search_threshold: 5,
        allow_single_deselect: true
    });
});