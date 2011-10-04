use strict;
use warnings;

use Test::Spec;

use_ok('Twist::Article');

use Twist::File;

describe 'article' => sub {
    it 'should load article' => sub {
        my $article = Twist::Article->new(
            file => Twist::File->new(
                path => 't/article/20110922T12:12:12-hello-there.pod'
            )
        );

        is($article->created,       'Thu, 22 Sep 2011');
        is($article->created->year, '2011');
        is($article->title,         'Hello');
        is_deeply($article->tags, [qw/foo bar baz/]);
        like($article->preview, qr{<p>Hello world!</p>});
        is($article->preview_link, 'Foobar');
        like($article->content, qr{<h1>Hello!</h1>});
    };
};

runtests unless caller;
