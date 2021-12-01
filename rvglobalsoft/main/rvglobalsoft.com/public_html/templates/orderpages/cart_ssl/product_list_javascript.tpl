{literal}

<script type="text/javascript">
        $(document).ready(function () {
            (function ($) {
                $('#filter').keyup(function () {
                    var rex = new RegExp($(this).val(), 'i');
                    $('.searchable tr').hide();
                    $('.searchable tr').filter(function () {
                        return rex.test($(this).text());
                    }).show();

                })
               window.setInterval(function(){
                  $('.promotion').toggleClass('blink');
               }, 700);

        }(jQuery));

});
</script>
{/literal}