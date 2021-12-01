{if $contacts}
    {assign var=flag value='0'}
    <label style="margin-top: 15px;">Notify Secondary Contacts (Optional)</label>
    <table id="scroll_table" class="contact_table table glike whitetable scroll hover" cellspacing="0" cellpadding="3" border="0" width="100%" style="border: 1px solid #efefef">
        <thead>
        <tr>
            <th style="width: 20px;"><input class="check_all" type="checkbox"></th>
            <th class="sort_element"><a href="#">Contact</a></th>
            <th class="sort_element"><a href="#">First Name</a></th>
            <th class="sort_element"><a href="#">Last Name</a></th>
            <th class="sort_element"><a href="#">Email Address</a></th>
            <th class="sort_element"><a href="#">Billing Notifications</a></th>
            <th class="sort_element"><a href="#">Support Notifications</a></th>
        </tr>
        </thead>
        <tbody>
        {foreach from=$contacts item=contact}
            {assign var=ccheck value=false}
            {if $submit}
                {if in_array($contact.id, $submit.secondary)}
                    {assign var=ccheck value=true}
                    {if !$contact.privilages.support.emails && !$contact.privilages.support.full}
                        {assign var=flag value='256'}
                    {/if}
                {/if}
            {else}
                {if $contact.privilages.support.emails || $contact.privilages.support.full}{assign var=ccheck value=true}{/if}
            {/if}
            <tr {if $ccheck}class="checkedRow"{/if}>
                <td style="width: 20px"><input class="check_contact contact-{$contact.id}" value="{$contact.id}" name="secondary[]" type="checkbox" {if $ccheck}checked{/if}></td>
                <td><a href="?cmd=clients&action=showprofile&id={$contact.id}" target="_blank">{$contact.id}</a></td>
                <td style="padding-left: 10px;"><a href="?cmd=clients&action=showprofile&id={$contact.id}" target="_blank">{$contact.firstname}</a></td>
                <td style="padding-left: 13px;"><a href="?cmd=clients&action=showprofile&id={$contact.id}" target="_blank">{$contact.lastname}</a></td>
                <td style="padding-left: 16px;">{$contact.email}</td>
                <td style="padding-left: 19px;">{if $contact.privilages.billing.emails || $contact.privilages.billing.full}<b>{$lang.Enabled}</b>{else}{$lang.Disabled}{/if}</td>
                <td style="padding-left: 21px;">{if $contact.privilages.support.emails || $contact.privilages.support.full}<b>{$lang.Enabled}</b>{else}{$lang.Disabled}{/if}</td>
            </tr>
        {/foreach}
        </tbody>
    </table>
    <input type="hidden" name="flag" value="{$flag}">
    {literal}
    <script>
        $(function () {
            var table = $('.contact_table'),
                check_contact = $('.check_contact');

            var row = table.find('tbody tr').length;
            if (row < 6) {
                var htr = table.find('tbody tr').height(),
                    h = row * htr;
                table.find('tbody').height(h + 1);
            }

            var contacts = check_contact.map(function () {
                if ($(this).prop('checked'))
                    return $(this).val();
            }).toArray();

            table.closest('form').on('submit', function () {
                var c = check_contact.map(function () {
                    if ($(this).prop('checked'))
                        return $(this).val();
                }).toArray();

                if (!compareArrays(contacts, c))
                    $('input[name=flag]').val('256');
            });

            function compareArrays(arr1, arr2) {
                return $(arr1).not(arr2).length === 0 && $(arr2).not(arr1).length === 0
            }

            $('select[name=contact_id]').on('change', function () {
                $('.check_contact').each(function () {
                    if ($(this).prop('disabled')) {
                        $(this).prop('disabled', false).prop('checked', false).closest('tr').removeClass('checkedRow');
                    }
                });
                var contact_id = $(this).val();
                $('.contact-' + contact_id).prop('checked', true).prop('disabled', true).closest('tr').addClass('checkedRow');
            });

            var contact_id =  $('select[name=contact_id]').val();
            $('.contact-' + contact_id).prop('checked', true).prop('disabled', true).closest('tr').addClass('checkedRow');

            $('.check_all').on('change', function () {
                if ($(this).prop('checked')) {
                    $('.check_contact').each(function () {
                        if (!$(this).prop('disabled')) {
                            $(this).prop('checked', true);
                            $(this).closest('tr').addClass('checkedRow');
                        }
                    });
                } else {
                    $('.check_contact').each(function () {
                        if (!$(this).prop('disabled')) {
                            $(this).prop('checked', false);
                            $(this).closest('tr').removeClass('checkedRow');
                        }
                    });
                }
            });

            check_contact.on('change', function () {
               if ($(this).prop('checked'))
                   $(this).closest('tr').addClass('checkedRow');
               else
                   $(this).closest('tr').removeClass('checkedRow');
            });

            jQuery.fn.sortElements = (function(){
                var sort = [].sort;
                return function(comparator, getSortable) {
                    getSortable = getSortable || function(){return this;};
                    var placements = this.map(function(){
                        var sortElement = getSortable.call(this),
                            parentNode = sortElement.parentNode,
                            nextSibling = parentNode.insertBefore(
                                document.createTextNode(''),
                                sortElement.nextSibling
                            );

                        return function() {
                            if (parentNode === this) {
                                throw new Error(
                                    "You can't sort elements if any one is a descendant of another."
                                );
                            }
                            parentNode.insertBefore(this, nextSibling);
                            parentNode.removeChild(nextSibling);
                        };
                    });

                    return sort.call(this, comparator).each(function(i){
                        placements[i].call(getSortable.call(this));
                    });
                };
            })();

            $('.sort_element')
                .each(function(){
                    var th = $(this),
                        thIndex = th.index(),
                        inverse = false;

                    th.click(function(){
                        table.find('td').filter(function(){
                            return $(this).index() === thIndex;
                        }).sortElements(function(a, b){
                            return $.text([a]) > $.text([b]) ?
                                inverse ? -1 : 1
                                : inverse ? 1 : -1;
                        }, function(){
                            return this.parentNode;
                        });
                        inverse = !inverse;
                    });
                });
            });
    </script>{/literal}
{/if}