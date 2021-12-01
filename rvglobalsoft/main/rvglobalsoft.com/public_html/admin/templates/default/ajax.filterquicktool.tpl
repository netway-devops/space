<a href="{$href}"  class="btn {if $currentfilter}btn-danger{else}btn-default{/if} btn-xs btn-is-filter" 
   style="margin-right: 10px" 
   onclick="return FilterModal.modal('{$loadid}',this);"><i class="fa fa-search-plus"></i> Filter Data</a>

<!-- Modal -->
<div class="modal fade" id="{$loadid|trim}" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Search / Filter</h4>

            </div>
            <div class="modal-body" ></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="return FilterModal.submit('{$loadid}');">Apply filter</button>
                <button type="button" class="btn btn-danger" onclick="return FilterModal.reset('{$loadid}');" {if !$currentfilter}style="display: none"{/if}>Reset filter</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

{literal}
<script>
    if(typeof launchfiltermodal !== 'function') {
       var launchfiltermodal =  function (target,el) {
           var src = $('#'+$.trim(target));
           var body = src.find('.modal-body');
           if($.trim(body.text())!='') {
               src.modal( );
           } else {
               ajax_update($(el).attr('href'),{},function(data){
                   body.html(data).find('input,select').addClass('form-control').filter('[type=submit]').parents('tr').eq(0).remove();
                   src.modal( );
               })
           }

           return false;

       };
    }
</script>
{/literal}