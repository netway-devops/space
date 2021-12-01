<section class="section-account-header">
    <h1>{$lang.transfers}</h1>
</section>
<section class="section-account">
    <div class="table-responsive table-borders table-radius">
        <table class="table tickets-table position-relative stackable">
            <thead>
            <tr>
                <th>{$lang.type}</th>
                <th>{$lang.name}</th>
                <th>{$lang.from|ucfirst}</th>
                <th>{$lang.date}</th>
                <th width="200"></th>
            </tr>
            </thead>
            <tbody id="updater">
                {include file='ajax/ajax.transfers.tpl'}
            </tbody>
        </table>
    </div>
</section>