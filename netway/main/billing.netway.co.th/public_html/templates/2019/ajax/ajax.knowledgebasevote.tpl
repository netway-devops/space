<div class="bordered-section my-4 p-3 d-flex flex-row justify-content-between align-items-center">
    <div class="vote-article d-flex flex-row align-items-center">
        <div class="mr-2">{$lang.article_helpful}</div><br>
        <div class="mr-2 px-2 vote-article-btn vote-article-dislike" data-make="downvotes">
            <i class="material-icons mr-2">mood_bad</i>
            {$lang.dislike}
            <span class="ml-2 downvotes">{$article.downvotes}</span>
        </div>
        <div class="mr-2 px-2 vote-article-btn vote-article-like" data-make="upvotes">
            <i class="material-icons mr-2">mood</i>
            {$lang.like}
            <span class="ml-2 upvotes">{$article.upvotes}</span>
        </div>
    </div>

    <div>
        <i class="material-icons icon-info-color mr-2">visibility</i>
        {$lang.views}:
        {$article.views}
    </div>
</div>
{literal}
<script>
    $('.vote-article-btn').on('click', function () {
        var make = $(this).data('make');
        $.post('?cmd=knowledgebase&action=add_vote',
            {
                article_id: {/literal}{$article.id}{literal},
                make: make,
                security_token: {/literal}'{$security_token}'{literal}
            }, function (result) {
                parse_response(result);
                $('#knowledgebase_vote').html(result);
            });
    });
</script>
{/literal}