<form action="" name="" method="post" enctype="multipart/form-data">
    {if $action=='addcategory'}
        <input type="hidden" name="make" value="addcategory" id="addcategory"/>
    {else}
        <input type="hidden" name="make" value="editcategory"/>
        <input type="hidden" name="cat_id" id="category_id" value="{$category.id}"/>
    {/if}

    <table border="0" cellpadding="6" cellspacing="0" width="100%">
        <tbody>
            <tr class="step0">
                <td width="160" align="right"><strong>{$lang.Name}:</strong></td>
                <td width="400">
                    {hbinput value=$category.tag_name style="font-size: 16px !important; font-weight: bold;" class="inp" size="60" name="name" id="categoryname"}
                </td>
                <td></td>
            </tr>
        </tbody>
        <tbody id="hints">
            <tr >
                <td width="160" align="right" class="fs11">{$lang.orderpageurl} </td>
                <td class="fs11" colspan="2">
                    {if $action=='addcategory'}
                        <span>{$system_url}{$ca_url}cart/</span><span class="changemeurl">{$category.slug}</span>
                    {else}
                        <a href="{$system_url}{$ca_url}cart/{$category.slug}/" target="_blank">{$system_url}{$ca_url}cart/<span class="changemeurl">{$category.slug}</span>
                        </a>
                    {/if}
                    <input  name="slug" type="text" class="" value="{$category.slug}" id="category_slug_edit" style="display:none" />
                    <a class="editbtn" onclick="return HBServices.editslug(this)" href="#">{$lang.Edit}</a>
                </td>
            </tr>
        </tbody>
        <tbody id="template_descriptions" class="step1">
            {include file="services/ajax.templates.tpl" }
        </tbody>
        <tbody>
            {if "config:EnableQuote:on"|checkcondition }
                <tr class="step1">
                    <td width="160" align="right" valign="top" style="padding-top:12px;">
                        <strong>Order handler</strong>
                    </td>
                    <td valign="top">
                        <select name="options[order_handler]" class="inp" >
                            <option value="0">Regular order (default)</option>
                            <option {if "config:EnabledQuote:`$category.id`"|checkcondition}selected="selected"{/if} value="2">Generate draft (hide prices)</option>
                        </select>
                    </td>
                </tr>
            {/if}
            <tr class="step1">
                <td width="160" align="right"><strong>{$lang.Description}:</strong></td>
                <td colspan="2">
                    {if $category.description!=''}
                        {hbwysiwyg wrapper="div" value=$category.tag_description style="width:99%;" class="inp wysiw_editor" cols="100" rows="6" id="prod_desc" name="description"  featureset="simple"}
                    {else}
                        <a href="#" onclick="$(this).hide();
                                $('#prod_desc_c').show();
                                return false;"><strong>{$lang.adddescription}</strong></a>
                        <div id="prod_desc_c" style="display:none">{hbwysiwyg wrapper="div" value=$category.tag_description style="width:99%;" class="inp wysiw_editor" cols="100" rows="6" id="prod_desc" name="description" featureset="simple"}</div>
                    {/if}
                </td>
            </tr>
            <tr class="step1">
                <td width="160" align="right"><strong>{$lang.Advanced}:</strong></td>
                <td colspan="2">
                    <a href="#" onclick="$('#advanced_scenarios').show();
                            $(this).hide();
                            return false;">{$lang.show_advanced}</a>
                    <div id="advanced_scenarios" style="display:none">
                        <strong>{$lang.order_scenario}:</strong> <a class="editbtn" href="?cmd=configuration&action=orderscenarios" target="_blank">[?]</a>
                        <select name="scenario" class="inp">
                            {foreach from=$scenarios item=scenario name=scloop}
                                <option value="{$scenario.id}" {if $category.scenario_id==$scenario.id}selected="selected"{/if}>{$scenario.name}</option>
                            {/foreach}
                        </select>
                    </div>
                </td>
            </tr>
        </tbody>


    </table>

    <p align="center">
        {if $action=='addcategory'}
            <input type="submit" value="{$lang.addneworpage}" class=" btn btn-primary" disabled="disabled" id="submitbtn"/>
            <span class="orspace">{$lang.Or}</span> <a href="?cmd=services"  class="editbtn">{$lang.Cancel}</a>
        {else}
            <input type="submit" value="{$lang.savechanges}" class="submitme" />
            <span class="orspace">{$lang.Or}</span> 
            <a href="?cmd=services"  class="editbtn" onclick="$('#cinfo1').toggle();
                    $('#cinfo0').toggle();
                    return false;">{$lang.Cancel}</a>
        {/if}
    </p>
    {securitytoken}
</form>