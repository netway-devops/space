{*
@@author:: HostBill team
@@name:: Bulk domain registration
@@description:: Use this template with TLDs you wish to offer registration for. You can also assign this orderpage to product you wish to offer domain with.
@@thumb:: images/bulk_domain_thumb.png
@@img:: images/bulk_domain_preview.png
*}
<script type="text/javascript">
    {literal}
        function check_domain2(form, updater) {
            // clear errors
            $(updater).addLoader();
            $.post('index.php?cmd=checkdomain&' + $(form).serialize(), {layer: 'ajax', justparse: '1', bulk: true, action: 'checkdomain'}, function (data) {
                $(updater).html('');
                var resp = parse_response(data);
                if (resp) {
                    $(updater).html(resp);
                    if (typeof ($().slideToElement) == 'function') {
                        $('body').slideToElement('searchresults');
                    }
                }
            });
            return false;
        }
        function runBulkSearch() {
            var domaincat = 0;
            if ($("#domain_cat").length)
                domaincat = $('#domain_cat').val();
            if ($('.status-row').length < 1)
                return;
            $('.status-row').each(function (n) {
                var tld = $(this).find('input[name=tlx]').val();
                var sld = $(this).find('input[name=slx]').val();
                ajax_update('index.php?cmd=checkdomain', {layer: 'ajax', 'singlecheck': true, action: 'checkdomain', domain_cat: domaincat, tld: tld, sld: sld}, '.status-row:eq(' + n + ')');

                {/literal}{if 'config:EnableDomainSuggestions:on'|checkcondition}{literal}
                if(n==0) {
                    ajax_update('?cmd=checkdomain&action=suggest', {
                        sld:sld,tld:tld,domain_cat:domaincat
                    }, '#suggestions');
                }
                {/literal}{/if}{literal}
            });

        }
    {/literal}
</script>
<div class="container-step1 container-transfer bulkregister">
    <div class="step1">
        <h1 class="title06">
            {if $category}{$category.name}
            {else}{$lang.bulksearch}
            {/if}
        </h1>
        <span class="name-enter">
            {if $category.description}{$category.description}
            {else}{$lang.enterdomainsdesc}
            {/if}
        </span>
        <div class="cleart"></div>
        <form action="" method="post" onsubmit='return check_domain2(this, "#updater");'>
            <input type="hidden" name="domain_cat" value="{$domain_cat}" id="domain_cat"/>
            <div class="part1 modern">
                <div class="textarea-top"></div>
                <textarea name="sld" rows="5" cols="50" id="bulksearch" class="orig">{if $check}{$bulkcheck}{else}{$lang.enterfewdomains}{/if}</textarea>
                <div class="textarea-bottom"></div>
                <div class="button-container">
                    <div class="button05">
                        <div><input type="submit" value="{$lang.checkbtn}" />
                        </div>
                    </div>
                    <div class="button04">
                        <div>
                            <input type="submit" onclick="window.location = '{$ca_url}checkdomain/';
                                    return false;" 
                                   value="{$lang.singlesearch}" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="part2">
                <ul>
                    {foreach from=$tld item=tldname name=ttld}
                        <li>
                            <label>
                                <input type="checkbox" name="tld[]" value="{$tldname}" 
                                       {if $smarty.foreach.ttld.first || $bulkchecktld[$tldname]}checked="checked"{/if} 
                                       class="tld_register" />
                                <span>{$tldname}</span>
                            </label>
                        </li>
                    {/foreach}
                </ul>
                <div class="cleart"></div>
            </div>
        </form>
        <div class="cleart"></div>

        <form action="{$ca_url}cart&amp;step=1&amp;cat_id=register" method="post">
            <input type="hidden" name="tld_cat" value="{$category.id}" /> 
            <input type="hidden" name="ref"  value="1"/>
            <a name="searchresults"></a>
            <div id="updater">{include file='ajax.checkdomainnew.tpl'}</div>
        </form>

        <div class="line2"></div>
        {include file="domainpricing.tpl"}
    </div>
</div>