<tr>
    <td align="right"  valign="top" style="padding-top:12px;">
        {if $category.contains !== 'categories' || $parent_id}
            <div class="category_contains category_contains-products">
                <strong>{$lang.ordertype}</strong>
            </div>
        {/if}
    </td>
    <td valign="top">
        {if $category.contains !== 'categories' || $parent_id}
            <div class="category_contains category_contains-products" id="template_wizard">
                <select name="ptype"  class="inp template" style="font-weight:bold;font-size:14px !important; height: auto;">
                    {if $action=='addcategory'}
                        <option value="0" selected="selected">{$lang.selectone}</option>
                    {/if}
                    {foreach from=$ptypes item=lptype}
                        <option value="{$lptype.id}" {if $category.ptype_id==$lptype.id || (!$category.ptype_id && $ptype==$lptype.id)}selected="selected"{/if}>
                            {assign var="descr" value="_hosting"}
                            {assign var="bescr" value=$lptype.lptype}
                            {assign var="baz" value="$bescr$descr"}
                            {if $lang.$baz}{$lang.$baz}
                            {else}{$lptype.type}
                            {/if}
                        </option>
                    {/foreach}
                </select>
                {if $countinactive}<div class="fs11 tabb" >Note: There are <b>{$countinactive}</b> inactive order types, you can enable them by activating related
                        <a href="?cmd=managemodules&action=hosting" target="_blank">hosting modules</a>
                    </div>
                {/if}
            </div>
        {/if}
    </td>
    {if $action!='addcategory'}
        <td rowspan="3" class="gallery" valign="top">
            {foreach from=$templates item=t name=lop}
                <div id="oo_{$t.hash}" style="display:none" class="gal_slide">
                    {if $t.thumb}
                        <div class="gal_itm">
                            <img src="{$system_url}{$t.thumb}" class="thumb" />
                            {if $t.img} <a class="preview" href="{$system_url}{$t.img}" target="_blank">{$lang.Preview}</a>
                            {/if}
                            {if $t.config}<a class="edit" href="{$system_url}{$t.img}" onclick="return HBServices.customize()">Customize</a>
                            {/if}
                        </div>
                    {/if}
                    <h1 class="hh1">
                        {if $t.typespecific}
                            {if $t.name}{$t.name}
                            {else}{$lang.typespecificcheckout}
                            {/if}
                        {elseif $t.name}{$t.name}
                        {elseif $lang[$t.template]}{$lang[$t.template]}
                        {else}{$t.template}
                        {/if}
                    </h1>
                    {$t.description}
                </div>
            {/foreach}
        </td>
    </tr>
    <tr>
        <td width="200" align="right" valign="top" style="padding-top:20px;">
            <strong>{$lang.ordertemplate}</strong>
        </td>
        <td valign="top" style="padding-top:10px;font-size:13px">
            <div class="shownice" style="padding:10px 0px;margin-bottom:5px"> 
                <b>
                    To get more templates visit:
                    <a class="external" target="_blank" href="https://hostbillapp.com/features/order-pages/" >Here</a>
                </b>
            </div>
            Or choose existing: 
            <div id="wiz_options">
                <ul class="opage-list">
                    {foreach from=$templates key=templ item=t name=lop}
                        <li {if $t.hash==$selected.hash}class="activated"{/if} >
                            <input type="radio" name="otype" value="{$t.file}" id="o_{$t.hash}" />
                            <img src="{$system_url}{$t.thumb}" class="thumb" />
                            <label for="o_{$templ}" {if $t.custom==true}class="tpl-custom"{/if}>
                                {if $t.custom==true}
                                    {if $t.name}{$t.name}
                                    {else}{$lang.typespecificcheckout}
                                    {/if}
                                {elseif $t.name}{$t.name}
                                {elseif $lang.$templ}{$lang.$templ}
                                {else}{$templ}
                                {/if}
                            </label>
                        </li>
                    {/foreach}
                </ul>
            </div>
        </td>
    </tr>
    {if $premade}
        <tr class="category_contains category_contains-products">
            <td align="right"><strong>{$lang.premadeproducts}</strong></td>
            <td colspan="2" id="subwiz_opt">
                <span><input type="radio" name="premade" value="0" id="premade00" onclick="HBServices.prswitch('x', this);"/> <label for="premade00">{$lang.none}</label> </span>
                    {foreach from=$premade item=pr key=k name=fpremade}
                    <span {if $smarty.foreach.fpremade.first}class="active"{/if}>
                        <input type="radio" name="premade" value="{$pr.file}" id="premade{$k}"  {if $smarty.foreach.fpremade.first}checked="checked"{/if} onclick="HBServices.prswitch('{$k}', this);"/>
                        <label for="premade{$k}">{$pr.name}</label>
                    </span>
                {/foreach}
            </td>
        </tr>
        <tr class="category_contains category_contains-products">
            <td align="right"></td>
            <td colspan="2">
                {foreach from=$premade item=pr key=k name=fpremade}
                    <div class="pr_desc" {if !$smarty.foreach.fpremade.first} style="display:none" {/if} id="pr_desc{$k}">
                        {$pr.description}
                    </div>
                {/foreach}
            </td>
        </tr>
    {/if}
{/if}
