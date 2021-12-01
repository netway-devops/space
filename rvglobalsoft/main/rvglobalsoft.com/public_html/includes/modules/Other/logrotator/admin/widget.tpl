<div class="row" style="margin-top:10px">
    <div class="col-md-12">
        <div class="box box-primary  ">
            <div class="box-header form-inline">
                <div class="form-group col-md-offset-2">
                    <label for="exampleInputName2">Archive tables available</label>
                    <select class="form-control" name="tables[{$logtable}]" id="logrotate">
                        <option value="">Current</option>
                        {foreach from=$logtables item=tbl}
                            <option value="{$tbl}" {if $logtable_current==$tbl}selected="selected"{/if}>{$tbl}</option>
                        {/foreach}
                    </select>
                    <button type="submit" class="btn btn-default btn-small" onclick="return logrotate_switch('{$logtable}');">Switch table</button>

                </div>



            </div>

        </div>
    </div>
</div>
{literal}
<script>
    function logrotate_switch(tbl) {
        var v = $('#logrotate').val();
        $.post("?cmd=logrotator&action=settable",{ table: v, base: tbl},function(){
            window.location.reload();
        });
        return false;
    };
</script>{/literal}