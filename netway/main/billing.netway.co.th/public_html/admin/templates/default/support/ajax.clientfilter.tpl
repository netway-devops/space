<form id="clientfilterf" method="post">
{include file='clients/ajax.emailcriterias.tpl'}


    <center><input type="button" name="submit" class="btn btn-small btn-default" value="Get matching clients" style="font-weight: bold;" onclick="return submit_clientfilter()"/></center>
    {securitytoken}
</form>
{literal}
    <script>
    function submit_clientfilter() {
        var ret = "&ret=" + $('#clientfilter').data('return');
        $.post('?cmd=sendmessage'+ret+'&make=getids&'+$('#clientfilterf').serialize(),function(data){
           if(data.ids) {
               var to = $('#to'),
                   client_ids = $('#client_ids'),
                   client_search = $('#client-search');
               if (to.length > 0)
                   to.html(data.ids).height( to[0].scrollHeight - 12);
               if (client_ids.length > 0)
                   client_ids.val(data.ids);
               if (client_search.length > 0)
                   client_search.val(data.ids).trigger("chosen:updated");
           }
            $(document).trigger('close.facebox');
        });
        return false;
    }
    </script>
{/literal}