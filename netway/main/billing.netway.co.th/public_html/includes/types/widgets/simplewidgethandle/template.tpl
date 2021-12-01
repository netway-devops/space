{php}
$templatePath   = $this->get_template_vars('widget');
include($templatePath['template'] .'.php');
{/php}

<link rel="stylesheet" href="includes/types/widgets/simplewidgethandle/style.css" type="text/css" />
<section class="section-servicenotes">
    <div class="wbox">
        <div class="wbox_header">{$lang.Notes}</div>
        <div class="wbox_content1">
            <div>
                <section class="py-4 text-center text-muted m-10">
                    {$lang.nothing}
                </section>
            </div>
        </div>
    </div>
</section>