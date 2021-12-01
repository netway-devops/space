<div class="list-2" style="min-height: 20px;">
    <div class="row" style="margin-top: 15px; margin: 20px;">
        <div id="active-tags" class="col-sm-12 onetag ">
            {if $part == 'month'}
                {foreach from=$results item=result key=id}
                    <span style="background: {$tags[$result.tag_id].color}" id="atag{$tags[$result.tag_id].tag_id}" class="tag" onclick="disabledTag({$tags[$result.tag_id].tag_id})">{$tags[$result.tag_id].tag}</span>
                {/foreach}
            {/if}
            {if $part == 'year'}
                {foreach from=$tagopacity item=tag key=i}
                    <span style="background: {$tags[$i].color}" id="atag{$tags[$i].tag_id}" class="tag" onclick="disabledTag({$tags[$i].tag_id})">{$tags[$i].tag}</span>
                {/foreach}
            {/if}
        </div>
    </div>
</div>
<div class="row" style="margin-top: 0px;">
    <button id="disabled-tags-toggle" class="btn btn-default btn-xs" style="margin-left: 20px;">Toggle disabled tags</button>
</div>
<hr style="margin-top: 0px;">
<div  class="list-3" style="min-height: 30px;">
    <div class="row" style="margin-top: 15px; margin: 20px;">
        <div id="disabled-tags" class="col-sm-12 onetag" >
            {if $part == 'month'}
                {foreach from=$results item=result key=id}
                    <span style="background: {$tags[$result.tag_id].color}; display: none;" id="dtag{$tags[$result.tag_id].tag_id}" class="tag" onclick="activeTag({$tags[$result.tag_id].tag_id})">{$tags[$result.tag_id].tag}</span>
                {/foreach}
            {/if}
            {if $part == 'year'}
                {foreach from=$results item=result key=id}
                    {if $id == 'January'}
                        {foreach from=$result item=value key=i}
                            <span style="background: {$tags[$value.tag_id].color}; display: none;" id="dtag{$tags[$value.tag_id].tag_id}" class="tag" onclick="activeTag({$tags[$value.tag_id].tag_id})">{$tags[$value.tag_id].tag}</span>
                        {/foreach}
                    {/if}
                {/foreach}
            {/if}
        </div>
    </div>
</div>
<hr>
{literal}
<script>
    {/literal}
    {foreach from=$tags item=tag}
    {literal}
    var cookie = Cookies.get("DisableTag"+{/literal}{$tag.tag_id}{literal});
    if (cookie == {/literal}{$tag.tag_id}{literal}){
        disabledTag({/literal}{$tag.tag_id}{literal});
    }
    {/literal}
    {/foreach}
    {literal}
</script>
{/literal}
<div style="padding-bottom: 20px;">
    {if $part == 'month'}
    {foreach from=$results item=result key=id}
        <div id="{$result.tag_id}" class="row ticket-graph">
            <div class="col-xs-2 text-right" style="padding-right: 0px; margin-left: 15px; width:15% !important;">{$result.tag}</div>
            <div class="col-xs-9" style="width: 75% !important;">
                <div style="background: {$result.color}; width: {$result.width}%; height: 17px; opacity: {$result.opacity}">
                    <span style="position:absolute; left: {$result.width}%; padding-left: {$result.padding}px;">{$result.quantity}</span>
                </div>
            </div>
        </div>
        <script>
            $('#atag{$result.tag_id}').css('opacity', {$result.opacity});
            $('#dtag{$result.tag_id}').css('opacity', {$result.opacity});
        </script>
    {/foreach}
    {elseif $part == 'year'}
    {foreach from=$results item=result key=key}
        <div class="row">
            <div class="col-xs-12" style="padding-left: 55px; padding-right: 55px;">
                <div class="panel panel-default">
                    <div id="month-{$key}" class="panel-heading" onclick="hidemonth('{$key}')"><span>{$key}</span><span id="plus{$key}" style="float: right; display: none;"><i class="fa fa-plus" aria-hidden="true"></i></span></div>
                    <div id="body-month-{$key}"class="panel-body">
                        {foreach from=$result item=value}
                            <div id="{$value.tag_id}" class="row" style="margin-top: 5px;">
                                <div class="col-xs-2 text-right">{$value.tag}</div>
                                <div class="col-xs-9">
                                    <div style="width: {$value.width}%; background: {$value.color}; height: 17px; opacity: {$value.opacity}">
                                        <span style="position:absolute; left: {$value.width}%; padding-left: {$value.padding}px;">{$value.quantity}</span>
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
    {/foreach}
        <script>
            {foreach from=$tagopacity item=tag key=id}
            $('#atag{$id}').css('opacity', {$tag});
            $('#dtag{$id}').css('opacity', {$tag});
            {/foreach}

            {foreach from=$sum item=value key=id}
            {if $value == 0}
            hidemonth('{$id}');
            {/if}
            {/foreach}
        </script>
    {elseif $part == 'nodata'}
        <div class="row" style="text-align: center">
            <h1>No Data to display</h1>
        </div>
    {/if}
    {if $filter == 'used'}
    {literal}
        <script>
            function excluded() {
                {/literal}
                {foreach from=$results item=result key=id}
                {if $result.quantity == 0}
                if (Cookies.get('DisableTag'+{$result.tag_id})){literal}{{/literal}
                    $('#dtag{$result.tag_id}').hide();
                    {literal}}else{{/literal}
                    $('#atag{$result.tag_id}').hide();
                    {literal}}{/literal}
                $('#tags-graph #{$result.tag_id}').hide();
                {else}
                if (Cookies.get('DisableTag'+{$result.tag_id})){literal}{{/literal}
                    $('#dtag{$result.tag_id}').show();
                    {literal}}else{{/literal}
                    $('#atag{$result.tag_id}').show();
                    {literal}}{/literal}
                {/if}
                {literal}
                if ($('#atag{/literal}{$result.tag_id}{literal}').hasClass('excluded')){
                    $('#tags-graph #{/literal}{$result.tag_id}{literal}').hide();
                }
                {/literal}
                {/foreach}
                {literal}
            }
            excluded();
        </script>
    {/literal}
    {elseif $filter == 'all'}
    {literal}
        <script>
            function activated(){
                {/literal}
                {foreach from=$tags item=tag}
                if (Cookies.get('DisableTag'+{$tag.tag_id})){literal}{{/literal}
                    $('#dtag{$tag.tag_id}').show();
                    {literal}}else{{/literal}
                    $('#atag{$tag.tag_id}').show();
                    {literal}}{/literal}
                {literal}
                if ($('#atag{/literal}{$tag.tag_id}{literal}').hasClass('excluded')){
                    $('#tags-graph #{/literal}{$tag.tag_id}{literal}').hide();
                }
                {/literal}
                {/foreach}
                {literal}
            } activated();
        </script>
    {/literal}
    {/if}
    {if $filter == 'usedYear'}
    {literal}
        <script>
            function excludedY() {
                {/literal}
                {foreach from=$tags item=tag}
                {if array_key_exists($tag.tag_id, $tagsExist)}
                if (Cookies.get('DisableTag'+{$tag.tag_id})){literal}{{/literal}
                    $('#dtag{$tag.tag_id}').show();
                    {literal}}else{{/literal}
                    $('#atag{$tag.tag_id}').show();
                    {literal}}{/literal}
                $('#tags-graph #{$tag.tag_id}').show();
                {else}
                if (Cookies.get('DisableTag'+{$tag.tag_id})){literal}{{/literal}
                    $('#dtag{$tag.tag_id}').hide();
                    {literal}}else{{/literal}
                    $('#atag{$tag.tag_id}').hide();
                    {literal}}{/literal}
                $('#tags-graph #{$tag.tag_id}').hide();
                {/if}
                {literal}
                if ($('#atag{/literal}{$tag.tag_id}{literal}').hasClass('excluded')){
                    $('#tags-graph #{/literal}{$tag.tag_id}{literal}').hide();
                }
                {/literal}
                {/foreach}
                {literal}
            }
            excludedY();
        </script>
    {/literal}
    {/if}
</div>
{literal}
    <script>
        $('#disabled-tags-toggle').click(function() {

            var cookie = Cookies.get("Disabled_tags");
            if (cookie == 'disabled'){
                Cookies.remove("Disabled_tags");
            }else{
                Cookies.set("Disabled_tags", 'disabled');
            }
            $('.list-3').toggle();
        });

        if (Cookies.get("Disabled_tags") == 'disabled'){
            $('.list-3').hide();
        }
    </script>
{/literal}