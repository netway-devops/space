<link rel="stylesheet" href="includes/types/widgets/servicenotes/style.css" type="text/css" />
<section class="section-servicenotes">
    <div class="wbox">
        <div class="wbox_header">{$lang.Notes}</div>
        <div class="wbox_content">
            {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
        </div>
        <div class="wbox_content1">
            <div>
                {foreach from=$notes item=note}
                    <div class="alert alert-info m-10 pb-25 alert-relative" role="alert">
                        {$note.note}
                        <div class="topright">{$note.date|dateformat}</div>
                    </div>
                    {foreachelse}
                    <section class="py-4 text-center text-muted m-10">
                        {$lang.nothing}
                    </section>
                {/foreach}
            </div>
        </div>
    </div>
</section>