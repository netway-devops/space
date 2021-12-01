<h1>{$lang.tickets|capitalize}</h1>
<h5 class="my-5">{$lang.mytickets_desc}</h5>

<section class="section-tickets">
    <div class="nav-tabs-wrapper">
        <ul class="nav nav-tabs d-flex justify-content-between align-items-center flex-wrap" role="tablist">
            <li>
                <ul class="nav nav-slider">
                    <li class="nav-item active"><a class="nav-link nav-link-slider" href="#" data-sorter="filter[status]">{$lang.all}</a></li>
                    <li class="nav-item"><a class="nav-link nav-link-slider" href="#Open" data-sorter="filter[status]">{$lang.Open}</a></li>
                    <li class="nav-item"><a class="nav-link nav-link-slider" href="#Answered" data-sorter="filter[status]">{$lang.Answered}</a></li>
                </ul>
            </li>
            <li>
                <ul class="nav">
                    <li>
                        <a class="btn btn-success btn-sm pull-right" href="{$ca_url}tickets/new/">{$lang.createnew}</a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>

    <a href="{$ca_url}tickets/" id="currentlist" style="display:none" updater="#updater"></a>
    <input type="hidden" id="currentpage" value="0" />
    <div class="table-responsive table-borders table-radius">
        <table class="table tickets-table position-relative stackable">
            <thead>
            <tr>
                <th><a href="{$ca_url}tickets/&orderby=id|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.Ticket} #</a></th>
                <th><a href="{$ca_url}tickets/&orderby=subject|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.subject}</a></th>
                <th><a href="{$ca_url}tickets/&orderby=status|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i> {$lang.status}</a></th>
                <th class="noncrucial"><a href="{$ca_url}tickets/&orderby=name|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.department}</a></th>
                <th><a href="{$ca_url}tickets/&orderby=date|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.date}</a></th>
                <th width="100" class="noncrucial"></th>
            </tr>
            </thead>
            <tbody id="updater">
            {include file='ajax.tickets.tpl'}
            </tbody>
        </table>
    </div>
    {include file="components/pagination.tpl"}
</section>
