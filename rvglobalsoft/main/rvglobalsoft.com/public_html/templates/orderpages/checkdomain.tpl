{if $action=='whois'}
    {literal}
        <style type="text/css">
            *{
                background:#ffffff;
                color:#333333;
                font-family:Tahoma, Arial, "Lucida Sans";
                font-size:12px;
                line-height:16px;
            }
        </style>
    {/literal}
    {if $whois}
        {$whois}
    {/if}
{else }
    {if !$opconfig.template == 'hide'}
        <script type="text/javascript">
            {literal}
                function check_domain(form, updater) {
                    // clear errors
                    ajax_update('index.php?cmd=checkdomain&' + $(form).serialize(), {layer: 'ajax'}, updater, true);

                    return false;
                }
                $(document).ready(function() {
                    $('#bulksearch').click(function() {
                        if ($(this).hasClass('orig')) {
                            $(this).val("").removeClass('orig');

                        }
                    });
                });

            {/literal}
        </script>
        <link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}domains/domainstyles.css" />
    {/if}
    {if $category}
        {include file=$category.tpl}
    {/if}
{/if}