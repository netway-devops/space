{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'clientarea/invoices.tpl.php');
{/php}

{*

    Browse invoices history

*}
<div class="text-block clear clearfix">
  <h5>{$lang.invoices|capitalize}</h5>

  <div class="clear clearfix">
      <div class="table-box">
          <div class="table-header">
          {if ($acc_balance && $acc_balance>0) ||  $enableFeatures.deposit!='off' }
              <div class="right-btns">
                  {if $acc_balance && $acc_balance>0 && $enableFeatures.bulkpayments!='off'}
                  <form method="post" action="index.php" class="no-margin" style="display:inline-block; vertical-align:top">
                      <input type="hidden" name="action" value="payall"/>
                      <input type="hidden" name="cmd" value="clientarea"/>
                      <button class="clearstyle green-custom-btn btn"><i class="icon-success"></i> {$lang.paynowdueinvoices}</button>
                  {securitytoken}</form>
                  {/if}
                  {if $enableFeatures.deposit!='off' }
                      <a href="{$ca_url}clientarea&action=addfunds" class="clearstyle grey-custom-btn btn" style="display:inline-block; margin-left:10px;"><i class="icon-grey-add"></i> {$lang.addfunds}</a>
                  {/if}
              </div>
              <p class="small-txt">Invoice Due:  <b>{$acc_balance|price:$currency}</b></p>
          {/if}
          </div>
          {if $invoices}
          <a href="{$ca_url}clientarea&amp;action=invoices" id="currentlist" style="display:none" updater="#updater"></a>
          <table class="table table-striped table-hover">
              <tr class="table-header-row">
                  <th><a href="{$ca_url}clientarea&amp;action=invoices&amp;orderby=status|ASC"  class="sortorder">{$lang.status}</a></th>
                  <th class="cell-border"><a href="{$ca_url}clientarea&amp;action=invoices&amp;orderby=id|ASC" class="sortorder">{$lang.invoicenum}</a></th>
                  <th class="w15 cell-border"><a href="{$ca_url}clientarea&amp;action=invoices&amp;orderby=total|ASC"  class="sortorder">{$lang.total}</a></th>
                  <th class="w15 cell-border"><a href="{$ca_url}clientarea&amp;action=invoices&amp;orderby=date|ASC"  class="sortorder">{$lang.invoicedate}</a></th>
                  <th class="w15 cell-border"><a href="{$ca_url}clientarea&amp;action=invoices&amp;orderby=duedate|ASC"  class="sortorder">{$lang.duedate}</a></th>
                  <th class="w10 cell-border"></th>
              </tr>
                <tbody id="updater">
                    {include file='ajax/ajax.invoices.tpl'}
                </tbody>
          </table>
      </div>
  </div>
</div>

<div class="clear"></div>
  <div class="right p19 pt0" style="margin:0 20px 0 0">
      <div class="pagelabel left ">{$lang.page}</div>
      <div class="btn-group right" data-toggle="buttons-radio" id="pageswitch">
          {section name=foo loop=$totalpages}
              <button class="btn {if $smarty.section.foo.iteration==1}active{/if}">{$smarty.section.foo.iteration}</button>
           {/section}
      </div>
      <input type="hidden" id="currentpage" value="0" />


</div>
<div class="clear"></div>
{else}
<h3 class="p19">{$lang.nothing}</h3>
{/if}
