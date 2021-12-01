<div style="display: block;">
    <div style="height: 55px;">
        <span class="grey right vote_article_padding">{$lang.article_helpful}</span><br>
        <span class="right vote_article vote_article_dislike" style="padding: 4px;" data-id="{$article.id}" data-make="downvotes">
        <span class="vote_article_padding" style="font-size: 12px;">&#9785;</span>{$lang.dislike}<span class="vote_article_padding downvotes">{$article.downvotes}</span>
    </span>
        <span class="right vote_article vote_article_like" data-id="{$article.id}" data-make="upvotes">
        <span style="font-size: 18px;">&#9786;</span>{$lang.like}<span class="vote_article_padding upvotes">{$article.upvotes}</span>
    </span>
    </div>
    <div>
        <span class="grey right vote_article_padding">{$lang.views}: {$article.views}</span>
    </div>
</div>

{literal}
    <script>
        $('.vote_article').on('click', function () {
            var make = $(this).data('make');
            $.post('?cmd=knowledgebase&action=add_vote',
                {
                    article_id: $(this).data('id'),
                    make: make,
                    security_token: {/literal}'{$security_token}'{literal}
                }, function (result) {
                    parse_response(result);
                    $('#knowledgebase_vote').html(result);
                });
        });
    </script>
{/literal}