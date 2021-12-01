{if $cmd=='productaddons'}
    <tr>
        <td align="right" valign="top" width="160"><strong>Module</strong></td>
        <td>
            <strong style="font-size: 14px">{$addon.modulename}</strong>
            <br/>{$addon.moduledescription}
        </td>
    </tr>
    <tr>
        <td></td>
        <td id="subloader">
            {if $options}
                <table border="0" width="70%" class="editor-container">

                    {foreach from=$options item=conf key=k name=checker}
                        <tr {if $smarty.foreach.checker.iteration%2=='1'}{/if}>

                            {assign var="baz" value=$k}
                            <td align="right" width="160" style="vertical-align: top; padding-top: 5px;">
                                <strong>{if $lang.$baz}{$lang.$baz}{else}{$baz}{/if}:</strong>
                                {if $conf.description}
                                    <a class="vtip_description" title="{$conf.description}"
                                       {if $conf.variable}id="config_{$conf.variable}_descr"{/if}></a>
                                    <br/>
                                {/if}
                            </td>
                            <td style="" width="">
                                {if $conf.type=='input'}
                                    {include file='moduleconfig/ajax.input.tpl'}
                                {elseif $conf.type=='loadable'}
                                    {include file='moduleconfig/ajax.loadable.tpl'}
                                {elseif $conf.type=='loadablemultiple'}
                                    {include file='moduleconfig/ajax.loadablemultiple.tpl'}
                                {elseif $conf.type=='loadablebox'}
                                    {include file='moduleconfig/ajax.loadablebox.tpl'}
                                {elseif $conf.type=='loadablecheck'}
                                    {include file='moduleconfig/ajax.loadablecheck.tpl'}
                                {elseif $conf.type=='check'}
                                    {include file='moduleconfig/ajax.check.tpl'}
                                {elseif $conf.type=='select'}
                                    {include file='moduleconfig/ajax.select.tpl'}
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                </table>
            {/if}
        </td>
    </tr>
{/if}
