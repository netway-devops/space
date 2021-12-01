<div class="row">
    <div class="col-md-12 mainleftcol mainrightcol">
        <div class="box  box-solid">
            <div class="box-header">
                <h3 class="box-title">Configurations</h3>
            </div>
            <div class="box-body" id="config_mgr">
                {include file="ajax.itemconfigs.tpl"}
            </div>
            <div class="box-footer">
                <a href="?cmd=dedimgr&action=itemconfigedit&item_id={$item.id}&id=new" onclick="return showEditConfig(this);" class="btn btn-sm btn-success">
                    <span class="fa fa-file-o"></span>
                    New Configuration
                </a>
                <a href="?cmd=dedimgr&action=itemconfigdiff&item_id={$item.id}" target="_blank" class="btn btn-default btn-sm ">
                    <span class="fa fa-files-o"></span>
                    Compare Configurations
                </a>
            </div>
        </div>
    </div>
</div>
{literal}
    <script>
        function showEditConfig(el) {
            var href = $(el).attr('href');
            var dialog = bootbox.dialog({
                message: ' ',
                title: $(el).text(),
                show: false,
                size: 'large',
                buttons: {
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-default'
                    },
                    confirm: {
                        label: $(el).text(),
                        className: 'btn-success',
                        callback: function (e) {
                            dialog.find('form').submit();
                            return true;
                        }
                    }
                }
            });
            $.post(href,{},function(data){
                dialog.find(".bootbox-body").html(data);
                dialog.modal('show');
            });
            return false;
        }
    </script>
{/literal}