<strong>Parameters:</strong>
<div class="p5"> {if $report.params}


        <div class="form-horizontal">
            {foreach from=$report.params item=pr key=kr}
                <div class="form-group">
                    <label for="{if $defaults.$kr.name}{$defaults.$kr.name}{else}{$kr}{/if}" class="col-sm-2 control-label">{if $defaults.$kr.name}{$defaults.$kr.name}{else}{$kr}{/if}

                    </label>
                    <div class="col-sm-{if $ajax}10{else}6{/if}">

                        {if $defaults.$kr.type=='date'}
                        <div class="searchform">
                            <div class="input-group datepicker">
                                <input type="text" value="{$defaults.$kr.value}" name="params[{$kr}]" class="form-control haspicker">

                                <span class="input-group-btn ">
                                        <button type="button"  class="btn btn-default dropdown-toggle dropdown-toggle"
                                                data-toggle="dropdown" ><span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu dropdown-menu-right">
                                            {foreach from=$date_variable key=variable item=varname}
                                                <li><a href="#" data-value="{$variable}">{$varname}</a></li>
                                            {/foreach}
                                        </ul>
                                        </span>
                                <span class="input-group-addon empty-addon"  ></span>
                            </div>
                        </div>

                        {elseif $defaults.$kr.type=='client'}

                            <select name="params[{$kr}]" class="form-control" load="clients" default="{$defaults.$kr.value}">
                            </select>


                        {elseif $defaults.$kr.type=='group_id'}

                            <select name="params[{$kr}]" class="form-control chosensearch"  id="params_{$kr}" >

                                <option value="0" {if $defaults.$kr.value == 0}selected="selected"{/if}>None</option>
                                {foreach from=$clientgroups item=group}
                                    <option value="{$group.id}" {if $defaults.$kr.value == $group.id}selected="selected"{/if}>{$group.name}</option>
                                {/foreach}

                            </select>


                        {elseif $defaults.$kr.type=='currency'}

                            <select name="params[{$kr}]" class="form-control  "  default="{$defaults.$kr.value}" >

                                {foreach from=$currencies item=cur}
                                    <option value="{$cur.id}" {if $defaults.$kr.value == $cur.id}selected="selected"{/if}>{$cur.iso}</option>
                                {/foreach}
                            </select>

                        {else}
                            <input name="params[{$kr}]" type="text" class="form-control" value="{$defaults.$kr.value}" />

                        {/if}






                    </div>
                </div>
            {/foreach}
            {literal}

            <script>
                $(document).ready(function () {
                    $('.chosensearch').chosensearch({width: '100%'});
                });
            </script>
            {/literal}
        </div>
        <div class="clear"></div>  {else}<em>none</em>  {/if}

</div>
{if $report.handler!='php'}
    <br/>
<strong>Conditions: {if !$report.state.conditions}<a href="#" onclick="$(this).hide();$('#conditions').slideDown();return false;" class="btn btn-default btn-xs">Click here to add</a>{/if}</strong>
<div class="p5" id="conditions" {if !$report.state.conditions}style="display:none"{/if}>

    <table border="0" cellspacing="0" cellpadding="3" id="trtable" {if $ajax}width="100%" {/if}>
        <tr>
            <td width="120">Column:</td>
            <td width="70">Operator:</td>
            <td width="120">Value:</td>
            <td width="14"></td>
        </tr>

        {if !$report.state.conditions}
            <tr id="tr0">
                <td ><select name="conditions[0][column]" class="columner form-control">
                        <option value="">Select column</option>
                        {foreach from=$report.default_columns item=column}
                            <option value="{$column}">{$column}</option>
                        {/foreach}
                    </select></td>
                <td ><select name="conditions[0][operator]" class="form-control">
                        <option value=">">Bigger than &gt;</option>
                        <option value="<">Less than &lt;</option>
                        <option value="=">Equals =</option>
                        <option value="!=">Other than !=</option>
                    </select></td>
                <td ><input type="text" name="conditions[0][constant]" value="" class="form-control" /></td>
                <td><a onclick="tr_remove_row(this); return false" class="btn btn-xs btn-default" href="#"><i class="fa fa-close"></i></a></td>
            </tr>
        {else}
            {foreach from=$report.state.conditions key=k item=c}
                <tr id="tr{$k}">
                    <td ><select name="conditions[{$k}][column]" class="columner form-control">
                            <option value="">Select column</option>
                            {foreach from=$report.default_columns item=column}
                                <option value="{$column}" {if $c.column==$column}selected="selected"{/if}>{$column}</option>
                            {/foreach}
                        </select></td>
                    <td ><select name="conditions[{$k}][operator]" class="form-control">
                            <option value=">" {if $c.operator==">"}selected="selected"{/if}>Bigger than &gt;</option>
                            <option value="<" {if $c.operator=="<"}selected="selected"{/if}>Less than &lt;</option>
                            <option value="=" {if $c.operator=="="}selected="selected"{/if}>Equals =</option>
                            <option value="!=" {if $c.operator=="!="}selected="selected"{/if}>Other than !=</option>
                        </select></td>
                    <td ><input type="text" name="conditions[{$k}][constant]" value="{$c.constant}" class="form-control" /></td>
                    <td><a onclick="tr_remove_row(this); return false" class="btn btn-xs btn-default" href="#"><i class="fa fa-close"></i></a></td>
                </tr>
            {/foreach}
        {/if}

    </table>
    <a href="#" class="btn btn-xs btn-default" onclick="tr_add_row(); return false;">Add new condition</a>

</div>
{/if}
{literal}
<script>
    function tr_remove_row(el) {
        if ($('#trtable tr').length>2) {
            $(el).parents('tr').eq(0).remove();
        } else {
            $(el).parents('tr').eq(0).find('input, select').val('');
        }

    }
    function tr_add_row() {
        var t = $('#trtable tr:last');
        if(!t.attr('id')) {
            return false;
        }
        var prev = t.attr('id').replace(/[^0-9]/g,'');
        next = parseInt(prev)+1;
        var nw = t.clone();
        nw.attr('id','tr'+next);
        nw.find('input, select').each(function(){
            var n =$(this).attr('name');
            n=n.replace("["+prev+"]","["+next+"]");
            $(this).attr('name',n).val('');
        });

        $('#trtable').append(nw);
        return false;
    }
    $(function() {
        $( "#sortablea" ).sortable({
            connectWith: ['#sortableb'],
            update: sortablestop
        });
        $( "#sortableb" ).sortable({
            connectWith: ['#sortablea']
        });


        $('.datepicker .dropdown-menu a').click(function(){
            var val = $(this).data('value');
            var p = $(this).parents('.datepicker');
            $('.dropdown-toggle',p).dropdown('toggle');
            $('.haspicker',p).val(val);;

            return false;
        });
    });
    function sortablestop(event,ui) {
        $('#sortableb input').attr('name','export[]');
        $('#sortablea input').attr('name','columns[]');


        $('#sortablea input').each(function(){
            var v = $(this).val();
            if($('#trtable tr select.columner option:selected[value="'+v+'"]').length) {
                $('#trtable tr select.columner option:selected[value="'+v+'"]').parent().parent().parent().find('a.rembtn').click();
            }
            $('#trtable tr select.columner option[value="'+v+'"]').remove();
        });
        $('#sortableb input').each(function(){
            var v = $(this).val();
            if($('#trtable tr select.columner option[value="'+v+'"]').length<1) {
                $('#trtable tr select.columner').append('<option value="'+v+'">'+v+'</option>');
            }
        });

    }
    function prswitch(el) {
        $('#subwiz_opt span').removeClass('active');
        $(el).parent().addClass('active');
    }

</script>{/literal}