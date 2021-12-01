<script type="text/javascript">
{literal}
$(document).ready( function () {
    $('#editAdmin').submit( function () {
        $.post('?cmd=servicecataloghandle&action=assignTeam', $('#editAdmin').serializeObject(), function (data) {
            $('#editAdmin')[0].submit();
        });
        return false;
    });
});
{/literal}
</script>

<form id="editAdmin" name="" action="" method="post" style="padding: 10px">
    <input name="make" value="{$action}" type="hidden"/>
    <input name="staffId" value="{$details.id}" type="hidden"/>

    <div class="panel panel-default">
        <div class="panel-heading">
            <strong>{$lang.generalsettings}</strong>
        </div>
        <div class="panel-body">

        <table border="0" width="100%" cellpadding="6" cellspacing="0" style="padding:5px"> 
        <tr valign="top">
            <td width="50%">

            <div class="row">
                <div class="form-group col-md-6">
                    <label>{$lang.firstname}</label>
                    <input type="text" name="firstname" value="{$details.firstname}" class="form-control"/>
                </div>

                <div class="form-group col-md-6">
                    <label>{$lang.lastname}</label>
                    <input type="text" name="lastname" value="{$details.lastname}" class="form-control"/>
                </div>

                <div class="form-group col-md-6">
                    <label>{$lang.Email}</label>
                    <input type="text" name="email" value="{$details.email}" class="form-control"/>
                </div>

                <div class="form-group col-md-6">
                    <label>{$lang.Username}</label>
                    <input type="text" name="username" value="{$details.username}" class="form-control"/>
                </div>
                <div class="form-group col-md-6">
                    <label>{$lang.Password}</label>
                    <input type="password" name="password" value="{$details.repeatpass}" class="form-control"/>

                </div>
                <div class="form-group col-md-6">
                    <label>{$lang.repeatpass}</label>
                    <input type="password" name="password2" value="{$details.repeatpass}" class="form-control"/>
                </div>
            </div>

                </td>
                <td width="50%">
                    <table border="0" width="100%" cellpadding="6" cellspacing="0" style="padding:5px" class="sectionbody">
                    <tr>
                        <td colspan="2" class="sectionhead_ext">ข้อมูลสำหรับ Service Catalog</td>
                    </tr>
                    <tr>
                        <td width="100">Team:</td>
                        <td>
                            <select name="teamId">
                                <option value="0">None</option>
                                {foreach from=$aTeam item="v" key="k"}
                                <option value="{$k}" {if $aStaff.team_id == $k} selected="selected" {/if}>{$v}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Level:</td>
                        <td>
                            <select name="level">
                                <option value="0">None</option>
                                <option value="1" {if $aStaff.level == 1} selected="selected" {/if}>1</option>
                                <option value="2" {if $aStaff.level == 2} selected="selected" {/if}>2</option>
                                <option value="3" {if $aStaff.level == 3} selected="selected" {/if}>3</option>
                            </select>
                        </td>
                    </tr>
                    </table>
                    
                    
                    <table border="0" width="100%" cellpadding="6" cellspacing="0" style="padding:5px" class="sectionbody">
                    <tr>
                        <td><strong>Escalation Policy (เงื่อนไขในการส่งต่องาน support ticket )</strong></td>
                    </tr>
                    <tr>
                        <td>
                            1. เร่งด่วนสุดสุด<br />
<textarea name="escalation_policy_1" cols="80" rows="7" readonly="readonly">
{literal}
ตลอด 24 ชั่วโมง 7 วัน
1. สถานะ hangout ของ {$owner} online อยู่: ให้ chat ถาม
2. สถานะ hangout ของ {$owner} offline อยู่: โทรหาที่ เบอร์ภายใน [[xxx]] หรือ เบอร์ [[[xxx-xxx-xxxx]]]
3. กรณีติดต่อไม่ได้ ให้ติดต่อ {$manager}: โทรหาที่ เบอร์ภายใน {{xxx}} หรือ เบอร์ {{{xxx-xxx-xxxx}}}
4. ถ้ายังติดต่อไม่ได้อีก ให้ติดต่อ CEO: โทรหาที่ เบอร์ภายใน 1444 หรือ เบอร์ 081-622-8276
5. ถ้ายังติดต่อไม่ได้อีก หา เบอร์โทรใน http://hr.netwaygroup.com/symfony/web/index.php/directory/viewDirectory/reset/1 ติดต่อหาผู้รับผิดชอบให้ได้
{/literal}
</textarea>
<div>
2. สถานะ hangout ของ {$owner} offline อยู่: โทรหาที่ เบอร์ภายใน <input type="text" name="tel21" value="{$aStaff.policy_1_21}" size="10" /> หรือ เบอร์ <input type="text" name="tel22" value="{$aStaff.policy_1_22}" size="20" /><br />
3. กรณีติดต่อไม่ได้ ให้ติดต่อ {$manager}: โทรหาที่ เบอร์ภายใน <input type="text" name="tel31" value="{$aStaff.policy_1_31}" size="10" /> หรือ เบอร์ <input type="text" name="tel32" value="{$aStaff.policy_1_32}" size="20" />
</div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            2. เร่งด่วน<br />
<textarea name="escalation_policy_2" cols="80" rows="5" readonly="readonly">
{literal}
1. สถานะ hangout ของ {$owner} online อยู่: ให้ chat ถาม
2. สถานะ hangout ของ {$manager} online อยู่: ให้ chat ถาม
3. สถานะ hangout ของ {$owner} offline อยู่ และไม่เกิน เที่ยงคืน: โทรหาที่ เบอร์ภายใน xxxx หรือ เบอร์ xxx-xxx-xxxx
4. สถานะ hangout ของ {$manager} offline อยู่ และไม่เกิน เที่ยงคืน: โทรหาที่ เบอร์ภายใน xxxx หรือ เบอร์ xxx-xxx-xxxx
5. ให้ทำการ reassign ticket มาที่ {$owner} และ {$manager}
{/literal}
</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            3. รอได้<br />
<textarea name="escalation_policy_3" cols="80" rows="3" readonly="readonly">
{literal}
- ให้ทำการ reassign ticket มาที่ {$owner}
{/literal}
</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            {literal}{$variable} เป็นตัวแปรที่ให้ข้อมูลแบบ dynamic ห้ามแก้ไข{/literal}
                        </td>
                    </tr>
                    </table>
                    
                </td>
            </tr>
            </table>


            <div class="form-group">
                <label>{$lang.Signature}</label>
                {if !$details.signature}<a href="#" onclick="$(this).hide();
                    $('#signature').show();
                    return false;"><strong>{$lang.signatureadd}</strong></a>
                {/if}
                <textarea name="signature" id="signature" class="form-control"
                          style="{if !$details.signature};display:none;{/if}">{$details.signature}</textarea>

            </div>

            {if $fields}
                {foreach from=$fields key=f item=fv}
                    {if $f == '2faenable'}
                        <div class="checkbox">
                            <label>
                                <input name="{$f}" type="checkbox"
                                       value="1" {if $details[$f]=='1'} checked="checked "{/if} />
                                {$fv.name}
                            </label>
                        </div>
                        {continue}
                    {/if}
                    {if $fv.type=='input'}
                        <div class="form-group">
                            <label>{$fv.name}</label>
                            <input type="text" name="{$f}" value="{$details[$f]}" class="form-control"/>
                        </div>
                    {elseif $fv.type=='checkbox'}
                        <div class="checkbox">
                            <label>
                                <input name="{$f}" type="checkbox"
                                       value="1" {if $details[$f]=='1'} checked="checked "{/if} />
                                {$fv.name}
                            </label>
                        </div>
                    {elseif $fv.type=='select'}
                        <div class="form-group">
                            <label>{$fv.name}</label>
                            <select name="{$f}" class="form-control">
                                {foreach from=$fv.default item=i}
                                    <option value="{$i}" {if $details[$f]==$i}selected="selected"{/if}>{$i|lang}</option>
                                {/foreach}
                            </select>
                        </div>
                    {/if}
                {/foreach}
            {/if}

            {if $action!='myaccount'}
                {if $teams}
                    <div class="form-group">
                        <label>Assigned Team</label>
                        <input name="teams[]" value="-1" type="hidden"/>
                        <select name="teams[]" multiple class="form-control group-assign">
                            {foreach from=$teams item=team}
                                <option value="{$team.id}"
                                        {if in_array($team.id, $details.teams)}selected{/if}>{$team.name}</option>
                            {/foreach}
                        </select>
                    </div>
                {/if}
                {if $details.id}
                    <div class="form-group">
                        <label>{$lang.Status}</label>
                        <div style="font-size: 1.2em">
                            <label>
                                <input type="radio" name="status" value="Active"
                                       {if $details.status == 'Active'}checked{/if} hidden="">
                                <span class="label-livemode label label-success-invert"
                                      data-value="Active">Active</span>
                            </label>
                            <label>
                                <input type="radio" name="status" value="Inactive"
                                       {if $details.status == 'Inactive'}checked{/if} hidden="">
                                <span class="label-livemode label label-default-invert"
                                      data-value="Inactive">Inactive</span>
                            </label>
                        </div>
                    </div>
                {/if}
            {/if}
        </div>
        <div class="panel-footer">
            <button type="submit" value="1" name="save" class="btn btn-primary">{$lang.savechanges}</button>
            <span
                    class="orspace">{$lang.Or} <a href="?cmd=editadmins" class="editbtn">{$lang.Cancel}</a></span>
        </div>
    </div>

    <div class="staff-options">
        {if $action!='myaccount'}
            {include file="staff/acl.tpl"}
            {include file="staff/notify.tpl"}
        {/if}

    </div>


    {securitytoken}
</form>