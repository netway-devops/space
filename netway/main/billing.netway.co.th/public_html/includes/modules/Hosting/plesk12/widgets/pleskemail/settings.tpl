<br/>
{$lang.plesk_email_quota_desc1}
<br/>
<br/>
<label class="quotaquota">{$lang.plesk_email_quota}</label>
<textarea name="config[quota]" id="quotaquota" cols="30" rows="3" class="form-control">{$widget.config.quota|default:"custom"}</textarea>
<div class="clear"></div>
<br/>
{$lang.plesk_email_quota_desc2}
<br/>
{$lang.plesk_email_quota_desc3}
<ul>
    <li>{$lang.unlimited}</li>
    <li>100 {$lang.mb}</li>
    <li>200 {$lang.mb}</li>
    <li>400 {$lang.mb}</li>
    <li>2 {$lang.gb}</li>
    <li>4 {$lang.gb}</li>
</ul>
<br/>