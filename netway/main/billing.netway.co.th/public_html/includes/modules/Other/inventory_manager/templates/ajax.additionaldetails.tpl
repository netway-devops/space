<div style="min-height:400px" class="col-sm-12">
    <h3>Additional details:</h3>
    <form class="form-horizontal" action="" method="post">
        {foreach from=$fields item=field}
            {assign var=fvalue value=""}
            {foreach from=$field_values item=fvalues}
                {if $fvalues.ifield_id == $field.id}
                    {assign var=fvalue value=$fvalues.value}
                {/if}
            {/foreach}
            <div class="form-group" style="display:flex; margin-bottom: 10px;">
                <div class="col-sm-2">
                    <label>{$field.name}</label>
                </div>
                <div class="col-sm-10">
                    {if $field.type == 'input'}
                        <input style="margin: 0;" type="text" class="form-control" name="field[{$field.id}]" value="{$fvalue}">
                    {elseif $field.type == 'textarea'}
                        <textarea style="margin: 0;" class="form-control" style="height: auto;" name="field[{$field.id}]">{$fvalue}</textarea>
                    {elseif $field.type == 'date'}
                        <input style="margin: 0;" type="date" class="form-control" name="field[{$field.id}]" value="{$fvalue}">
                    {/if}
                    <small class="form-text text-muted">{$field.description}</small>
                </div>
            </div>
        {foreachelse}
            <div class="alert alert-warning" role="alert">Custom fields not found</div>
        {/foreach}
    </form>
</div>