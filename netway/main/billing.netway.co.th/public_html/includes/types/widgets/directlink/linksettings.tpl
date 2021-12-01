<label class="nodescr">Link URL</label>
<input type="text" class="w250" name="config[linkurl]" value="{$widget.config.linkurl}" style="width:450px"
       id="linklink"/>
<div class="clear"></div>

<br/>
<b>Note: You can customize your link using service variables</b><br/>
<span style="color:#555">
{literal}Example link url: http://testhostbill.com/myscript.php?username={$username}&password={$password}{/literal} will be generated with service-specific username &amp; password.</span>
<br/>
<a href="#" onclick="$(this).hide();$('#variables-list').show();return false"><b>View available variables</b></a>
<div id="variables-list" style="padding:15px 0px;display:none;">
    {literal}
        <code>{$id}</code>
        <code>{$slug}</code>
        <code>{$username}</code>
        <code>{$password}</code>
        <code>{$domain}</code>
        <code>{$client_id}</code>
        <code>{$product_id}</code>
        <code>{$server_id}</code>
        <code>{$security_token}</code>
    {/literal}
</div>
<br><br>
<p style ="color:red;">
    <a href="https://doc.clickup.com/p/h/jd8n-31145/846dfe7cf06aac7" target="_blank" style ="color:red;">
        <b>Click here</b>
    </a>
    <span>to learn how to get the apps configured values on the product and customer ordering form values.</span>
</p>
{literal}
    <style type="text/css">
        .variable-el {
            padding: 2px 5px;
            font-size: 11px;
            cursor: pointer;
            text-shadow: 0 1px 0 #FFFFFF;
            border: 1px #BBBBBB solid;
            background: #f2f2f2;
            float: left;
            margin-right: 10px;
            color: #464646;
            border-radius: 4px;
            text-shadow: 0 1px 0 #FFFFFF;
        }

        .variable-el:hover {
            border-color: #666;
        }
    </style>
    <script type="text/javascript">
        $('.variable-el').click(function () {
            $('#linklink').val($('#linklink').val() + "" + $.trim($(this).text()));
            return false;
        });
    </script>
{/literal}