<section class="section-changebillingcycle">
    <div class="wbox">
        <div class="wbox_header">{$lang.changebillingcycle_widget}</div>
        <div class="wbox_content">
            {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
        </div>
        <div class="wbox_content">
            {if $notsupportedcycle}
                <p>{$lang.changebillingcycle_notsupported}</p>
            {elseif $unpaidinvoice}
                <p>{$lang.changebillingcycle_invoiceinfo}</p>
                <p>{$lang.manualrenew_unpaidinvoice}</p>
                <a href="{$ca_url}clientarea/invoice/{$unpaidinvoice.id}/" class="btn-link">{$unpaidinvoice|@invoice}</a>
            {else}
                <form action="" method="post">
                    <input type="hidden" name="make" value="submit"/>
                    <p>{$lang.changebillingcycle_guide}</p>

                    <table class="table stackable">
                        <tr>
                            <td width="250px">{$lang.bcycle}</td>
                            <td>{$service.total|price:$currency} / {$lang[$service.billingcycle]}</td>
                        </tr>
                        <tr>
                            <td width="250px">{$lang.newbcycle}</td>
                            <td>
                                <div class="row">
                                    <div class="col-12 col-md-10 col-lg-8">
                                        <select name="cnewcycle" class="form-control">
                                            {if $newcycles.h!=0}
                                                <option value="h">{$newcycles.h|price:$currency} {$lang.h}</option>{/if}
                                            {if $newcycles.d!=0}
                                                <option value="d">{$newcycles.d|price:$currency} {$lang.d}</option>{/if}
                                            {if $newcycles.w!=0}
                                                <option value="w">{$newcycles.w|price:$currency} {$lang.w}</option>{/if}
                                            {if $newcycles.m!=0}
                                                <option value="m">{$newcycles.m|price:$currency} {$lang.m}</option>{/if}
                                            {if $newcycles.q!=0}
                                                <option value="q">{$newcycles.q|price:$currency} {$lang.q}</option>{/if}
                                            {if $newcycles.s!=0}
                                                <option value="s">{$newcycles.s|price:$currency} {$lang.s}</option>{/if}
                                            {if $newcycles.a!=0}
                                                <option value="a">{$newcycles.a|price:$currency} {$lang.Annually}</option>{/if}
                                            {if $newcycles.b!=0}
                                                <option value="b">{$newcycles.b|price:$currency} {$lang.b}</option>{/if}
                                            {if $newcycles.t!=0}
                                                <option value="t">{$newcycles.t|price:$currency} {$lang.t}</option>{/if}
                                        </select>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>

                    {if $service.custom}
                        <p>{$lang.changebillingcycle_guide2}</p>
                    {/if}

                    {securitytoken}
                    <div class="d-flex flex-row align-items-center justify-content-start">
                        <input type="submit" class="btn btn-primary btn-w-100 btn-md-w-auto" value="{$lang.changebillingcycle_widget}" onclick="return confirm('{$lang.manualrenew_confirm}');"/>
                    </div>
                </form>
            {/if}
        </div>
    </div>
</section>


