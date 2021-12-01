<label class="nodescr">Link URL</label>
                    <input type="text" class="w250" name="config[linkurl]" value="{$widget.config.linkurl}" style="width:450px" id="linklink"/>
                    <div class="clear"></div>

                    <br/>
<b>Note: You can customize your link using service variables</b><br/>
<span style="color:#555">
{literal}Example link url: http://testhostbill.com/myscript.php?username={$username}&password={$password}{/literal} will be generated with service-specific username &amp; password.</span>
<br/>
<a href="#" onclick="$(this).hide();$('#variables-list').show();return false"><b>View available variables</b></a>
<div id="variables-list" style="padding:15px 0px;display:none;">{literal}
    <span class="variable-el">{$username}</span>
    <span class="variable-el">{$password}</span>
    <span class="variable-el">{$domain}</span>
    <span class="variable-el">{$client_id}</span>
    
{/literal}

    <div class="clear"></div>
</div>
{literal}
<style type="text/css">
    .variable-el {
        padding:2px 5px;
        font-size:11px;
        cursor:pointer;
        text-shadow:0 1px 0 #FFFFFF;
        border:1px #BBBBBB solid;
        background:#f2f2f2;
        float:left;
        margin-right:10px;
        color:#464646;
         border-radius: 4px;
        text-shadow:0 1px 0 #FFFFFF;
    }
    .variable-el:hover {
    border-color:#666;
    }
</style>
<script type="text/javascript">
    $('.variable-el').click(function(){
        $('#linklink').val($('#linklink').val()+""+$.trim($(this).text()));
            return false;
    });
</script>
{/literal}