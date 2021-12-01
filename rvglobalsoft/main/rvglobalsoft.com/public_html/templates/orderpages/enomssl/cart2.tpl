<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}enomssl/style.css" />
<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}enomssl/facebox/facebox.css" />
<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}enomssl/tipsy/tipsy.css" />
<script type="text/javascript" src="{$orderpage_dir}enomssl/facebox/facebox.js"></script>
<script type="text/javascript" src="{$orderpage_dir}enomssl/tipsy/tipsy.js"></script>
<script type="text/javascript">
    {literal}
        $(document).ready(function () {
            $('.tipsing').tipsy({gravity: 'w', html: true});
            
            $('.contacts-billing, .contacts-tech').toggle(!$('#biltech input').is(':checked'));
        });

        function sh_els(el) {
            if ($(el).is(':checked')) {
                $('.contacts-billing, .contacts-tech').slideUp();
            } else {
                $('.contacts-billing, .contacts-tech').slideDown();
            }
        }
        function submitmform(el) {
            $('#mform').submit();
            return false;
        }
    {/literal}
</script>

{if $logged!='1'}
    <div id="loginform" style="display:none">
        <center><form name="" action="" method="post">
                <div class="table-responsive">
                    <table border="0" cellpadding="0" cellspacing="0" width="80%" class="position-relative stackable enomssl-table">
                    <tr>
                        <td align="left" colspan="2">
                            <label for="username" class="styled">{$lang.email}</label>
                            <input name="username" value="{$submit.username}" class="styled" style="width:96%"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" colspan="2">
                            <label for="password"  class="styled">{$lang.password}</label>
                            <input name="password" type="password" class="styled"  style="width:96%"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="left"  >
                            <a href="{$ca_url}root&amp;action=passreminder" class="list_item" target="_blank">{$lang.passreminder}</a>
                        </td>
                        <td align="right">
                            <input type="hidden" name="action" value="login"/>
                            <input type="submit" value="{$lang.login}" class="padded btn" style="font-weight:bold"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                    </tr>
                </table>
                </div>
            </form>
        </center>
    </div>
{/if}


<form id="mform" action="" method="post">
    <div id="celeft">
        <input type="hidden" name="continue" value="1" />
        {include file='enomssl/cprogress.tpl'}

        <h3>{$lang.en_step3}</h3>

        <div class="form-container row">
            {foreach from=$contacts item=group key=type}
                {if $group.type == 'group'}
                    <div class="grid-6 col-12 col-md-6 contacts contacts-{$type}">
                        <div class="wbox">
                            <div class="wbox_header">
                                {if $group.name}{$group.name}
                                {elseif $lang[$group.lang]}{$lang[$group.lang]}
                                {else}{$type|capitalize}
                                {/if}
                            </div>
                            <div class="wbox_content" >
                                {include file="../common/sslcerts/contactforms.tpl" forms=$group.forms}
                            </div>
                        </div>
                    </div>
                {else}

                    <div class="grid-12" id="biltech">
                        <div class="wbox">
                            <div class="wbox_header">{$lang.en_billtech}</div>
                            <div class="wbox_content" >
                                <input type="checkbox" value="1" checked="checked" name="useadmin" onclick="sh_els(this)"/> {$lang.en_copybill}
                            </div>
                        </div>
                    </div>
                {/if}
            {/foreach}
        </div>

    </div>

    <div class="orderbox2 orderbox12">
        <div class="table-responsive">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="position-relative stackable enomssl-table">
            <td width="33%" align="left">
                <div class="step-info">
                    <div>{$lang.field_marked_required}</div>
                    {if $logged!='1'}
                        <a href="#" onclick="{literal}$.facebox({div: '#loginform'});return false;{/literal}">{$lang.login}</a> {$lang.en_tofill}
                    {/if}
                </div>
            </td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td style="padding:20px 10px;height:14px;"  width="70%">
                            &nbsp;&nbsp;
                        </td>
                        <td class="csubmit {if $customdata.cn=='' || !$customdata.cn}disabled{/if}" id="submiter">
                            <a href="#" onclick="return submitmform(this)">{$lang.continue}</a>
                        </td>
                    </tr>
                </table>
            </td>
        </table>
        </div>
    </div>
</div>
</form>
<div class="clear"></div>
