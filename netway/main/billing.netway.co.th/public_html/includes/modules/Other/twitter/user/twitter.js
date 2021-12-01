(function ($, window) {

    function replaceURLWithHTMLLinks(text) {
        if(!text)
            return text;

        var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[.][a-z]{2,4}[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
        text = text.replace(exp, '<a target="_blank" href="$1">$1</a>') || '';
        text = text.replace(/@(\w+)/ig, '<a target="_blank" class="mention" href="https://twitter.com/$1">@$1</a>');
        text = text.replace(/#(\w+)/ig, '<a target="_blank" class="tag" href="https://twitter.com/hashtag/$1?src=hash">#$1</a>');

        return text;
    }

    function fetchBox() {
        var tweetBox = $('#tweets');
        if (!tweetBox.length) {
            tweetBox = $('<div id="tweets"></div>');

            if ($('#cont > *:not(br):last').is('center'))
                $('#cont center:last').before(tweetBox);
            else
                $('#cont').append(tweetBox);
        }
        return tweetBox;
    }

    window.renderTweets = function (data) {

        var html = '';
        if (data.tweets && data.tweets.length) {
            data.tweets.map(function (t) {
                html += '<span class="annoucement_date">Published: ' + t.date + '</span>' +
                    '<span class="act">' +
                    '<a target="_blank" class="twitter reply" href="http://twitter.com/intent/tweet?in_reply_to=' + t.id + '">reply</a>' +
                    '<a target="_blank" class="twitter retweet" href="http://twitter.com/intent/retweet?tweet_id=' + t.id + '">retweet</a>' +
                    '<a target="_blank" class="twitter favorite" href="http://twitter.com/intent/favorite?tweet_id=' + t.id + '">favorite</a>' +
                    '</span>' +
                    '<p>' + replaceURLWithHTMLLinks(t.text) + '</p>'
            })
        }

        fetchBox().html(
            '<h2 id="tweetsh" style="vertical-align: super;">' +
            '<img style="margin: 0px; padding: 0px; float: left;" src="includes/modules/Other/twitter/user/twitter.png" alt="" />' +
            '<span>Twitter Updates</span>' +
            '</h2>' +
            html +
            '<p style="text-align: right; margin-right: 32px;">' +
            '<a target="_blank" href="http://twitter.com/' + data.username + '">' +
            '<img src="includes/modules/Other/twitter/user/follow.png" alt="" />' +
            '</a>' +
            '</p>'
        );
    };

})(jQuery, window)

