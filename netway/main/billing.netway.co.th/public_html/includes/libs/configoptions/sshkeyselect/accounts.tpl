{foreach from=$c.data item=cit}
    {assign var="keys" value=$cit|json_decode}
{/foreach}
{foreach from=$c.items item=itm}
<div class="ssh-key-list ssh-key-list-{$id}">
    <select name="custom[{$kk}][{$itm.id}][]" multiple id="custom_field_{$id}">
        {foreach from=$c.ssh_keys item=key}
            <option value="{$key.id}"
                    data-key="{$key.key|escape}"
                    data-name="{$key.name|escape}"
                    {if in_array($key.id, $keys)}selected{/if}
            >#{$key.id} - {$key.name}</option>
        {/foreach}
    </select>
</div>
{/foreach}
{literal}
    <script>
        $(function () {
            var id = {/literal}'{$id}',{literal}
                select = $('#custom_field_' + id),
                tpl = '<textarea style="font-family: monospace; resize: none; cursor:pointer; min-height: 100px; min-width: 100%;" readonly>%s</textarea>'

            select.chosenedge({
                width: "100%"
            });

            function showKey(index){
                var sshkey = select.children().eq(index).data();

                bootbox.alert({
                    title: "Key: " + sshkey.name,
                    message: tpl.replace('%s', sshkey.key),
                    size: 'large',
                }).on('shown.bs.modal', function (e, dialog) {
                    $('textarea', dialog).on('click', function () {
                        this.select()
                    })
                });
            }
            var overlay = $('<div class="search-choice-overlay" style="position: absolute;"></div>'),
                container = $('.ssh-key-list-' + id);

            overlay.on('click', function(){
                console.log(this)
                showKey(this.dataset.index);
            })

            container.on('mouseenter', '.search-choice', function (e) {
                overlay.appendTo(container)
                var box = this.getBoundingClientRect(),
                    cbox = container[0].getBoundingClientRect();

                overlay.css({
                    top: box.top - cbox.top,
                    left: box.left - cbox.left,
                    width: box.width - 18,
                    height: box.height
                })

                console.log(e)
                overlay[0].dataset.index = $(e.target).closest('.search-choice')
                    .find('.search-choice-close').data('option-array-index');
            })
        })
    </script>
{/literal}
{once}
{literal}
    <style>
        .ssh-key-list{
            position: relative;
        }
        .ssh-key-list .search-choice-overlay{
            cursor: pointer;
        }
    </style>
{/literal}
{/once}
