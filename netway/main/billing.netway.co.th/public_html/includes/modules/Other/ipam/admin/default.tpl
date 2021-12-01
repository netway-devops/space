<link type="text/css" href="{$moduledir}stylesheet.css" rel="stylesheet" />
<link type="text/css" href="{$template_dir}js/gui.elements.css" rel="stylesheet" />
<script type="text/javascript" src="{$template_dir}js/gui.elements.js"></script>
<script type="text/javascript" src="{$template_dir}js/jquery.elastic.source.js"></script>
<script type="text/javascript" src="{$moduledir}js/jquery.mask.min.js"></script>
<script type="text/javascript" src="{$moduledir}scripts.js"></script>

<div class="newhorizontalnav"  id="newshelfnav">
    <div class="list-1">
        <ul>
            <li class="list-1elem"><a href="#">IPAM</a></li>
            <li class="list-1elem"><a href="#">VLANs</a></li>
            <li class="list-1elem"><a href="#">Options</a></li>
            <li class="list-1elem"><a href="#">Reverse DNS</a></li>
            <li class="list-1elem"><a href="#">Audit Log</a></li>
            <li class="list-1elem"><a href="#">RWhois</a></li>
            <li class="list-1elem"><a href="#">RIPE</a></li>
        </ul>
    </div>
</div>

<div class="pagecont" >
    {include file="ajax.default.tpl"}
</div><!-- main -->
<div class="pagecont" style="display:none">
    {include file="ajax.vlan.tpl" servers=$vlangroups}
</div><!-- main -->

<div class="pagecont " style="display:none">
    {include file='tabs/settings.tpl'}

</div><!-- opt -->


<div class="pagecont" style="display:none">
    {include file='tabs/reversedns.tpl'}
</div>
<!-- Audit logs -->
<div class="pagecont" style="display:none">
    {include file="ajax.auditlogs.tpl" }
</div>

<!-- RWhois -->
<div class="pagecont" style="display:none">
    {include file='tabs/rwhois.tpl'}
</div>
<!-- RIPE -->
<div class="pagecont" style="display:none">
    {include file='tabs/ripe.tpl'}
</div>
{if $action=='default' && $showall && $group}
    {literal}
        <script>$(document).ready(function() {{/literal}
                    groupDetails('{$group.id}')
        {literal}  });</script>{/literal}
    {/if}

{literal}
<script>$(document).ready(function() {
        $('#newshelfnav').TabbedMenu({elem:'.pagecont',picker:'.list-1elem',aclass:'active'{/literal}{if $picked_tab},picked:{$picked_tab}{/if}{literal}});

    });</script>{/literal}