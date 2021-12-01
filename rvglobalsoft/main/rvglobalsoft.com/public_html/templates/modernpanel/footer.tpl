            </section>
        </div>
        <!-- End of Main Container -->

        <!-- Footer -->
        <footer class="center-area">
            <div class="footer-underline">
                <div class="underline-bold"></div>
            </div>

            <ul class="nav nav-pills footer-nav">
                <li><a href="{$ca_url}">{$lang.homepage}</a></li>
                <li><a href="{$ca_url}cart/">{$lang.order}</a></li>
                <li><a href="{$ca_url}{if $enableFeatures.kb!='off'}knowledgebase/{else}tickets/new/{/if}">{$lang.support}</a></li>
                <li><a href="{$ca_url}clientarea/">{$lang.clientarea}</a></li>
                {if $enableFeatures.affiliates!='off'}
                    <li><a href="{$ca_url}affiliates/">{$lang.affiliates}</a></li>
                {/if}
            </ul>

            <div class="footer-copyrights pull-right">
                &copy; 2012 {$business_name}
            </div>
        </footer>
        <!-- End of Footer -->
        {userfooter}
    </body>
</html>
