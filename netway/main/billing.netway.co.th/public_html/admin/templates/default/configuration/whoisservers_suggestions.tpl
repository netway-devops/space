<div class="container-fluid clear tabs tab-suggestions" style="margin-top:10px;">
    <div class="row">
        <div class="col-md-12">
            <table style="margin-bottom: 20px;" width="100%" cellspacing="0" cellpadding="10">
                <tr class="bordme">
                    <td align="right" width="205"><strong>Enable Domain Suggestions</strong></td>
                    <td>
                        <input name="configuration[EnableDomainSuggestions]" type="radio" value="on" {if $configuration.EnableDomainSuggestions == 'on'}checked{/if}> <strong>Yes</strong>,
                        show domain suggestions returned by suggestion engine selected below


                        <br/>
                        <input name="configuration[EnableDomainSuggestions]" type="radio" value="off" {if $configuration.EnableDomainSuggestions != 'on'}checked{/if}> <strong>No</strong>,
                        do not show domain suggestions
                    </td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Suggestions Engine</strong></td>
                    <td>

                        {if $suggestion_engines}
                            <select name="configuration[DomainSuggestionsEngine]" class="inp" style="width: 50%" >
                                {foreach from=$suggestion_engines item=engine key=mid}
                                    <option value="{$mid}" {if $configuration.DomainSuggestionsEngine == $mid}selected{/if}>{$engine}</option>
                                {/foreach}

                            </select>
                        {else}
                            No <a href="?cmd=managemodules&action=domain" target="_blank" >active domain registrar</a> module supports this feature
                        {/if}
                    </td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Max Sugested names per search</strong></td>
                    <td>
                        <input name="configuration[MaxDomainSuggestions]" type="number" value="{$configuration.MaxDomainSuggestions|default:10}" class="inp" size="3"/>

                    </td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Include adult results</strong>  <i class="vtip_description" title="Not all suggestion engines supports this feature"></i></td>
                    <td>
                        <input name="configuration[AdultDomainSuggestions]" type="radio" value="on" {if $configuration.AdultDomainSuggestions == 'on'}checked{/if}> <strong>Yes</strong>


                        <br/>
                        <input name="configuration[AdultDomainSuggestions]" type="radio" value="off" {if $configuration.AdultDomainSuggestions != 'on'}checked{/if}> <strong>No</strong>
                    </td>
                </tr>

                <tr class="bordme">
                    <td align="right" width="205"><strong>Limit results to following TLDs</strong> <i class="vtip_description" title="If none is selected results will contain all suggestions from Suggestion Engine"></i></td>
                    <td>
                        <select name="configuration[TLDDomainSuggestions][]" class="chosenedge" multiple id="TLDDomainSuggestions">
                            {foreach from=$tlds item=tld}
                                <option value="{$tld}" {if in_array($tld,$configuration.TLDDomainSuggestions)}selected{/if}>{$tld}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>

            </table>
        </div>
    </div>
    <div class="nicerblu" style="text-align:center">
        <input type="submit" value="Save Changes" name="save[suggestions]" style="font-weight:bold" class="btn btn-primary">
    </div>
</div>
{literal}
<script>
    $(document).ready(function(){

        $(".chosenedge").chosenedge({
            width: "50%",
            disable_search_threshold: 5,
            allow_single_deselect: true,
            display_disabled_options: false,
            enable_split_word_search: true,
            search_contains: true
        });

    });
</script>{/literal}