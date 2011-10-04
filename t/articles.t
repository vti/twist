use strict;
use warnings;

use Test::Spec;

use_ok('Twist::Articles');

describe 'articles' => sub {
    it 'should find article' => sub {
        my $dir = Twist::Articles->new(path => 't/articles');

        my $article = $dir->find(slug => 'hello-there');
        like($article->content, qr{<p>Hello world!</p>});
    };

    it 'should find all articles' => sub {
        my $dir = Twist::Articles->new(path => 't/articles');

        my $articles = $dir->find_all;
        is(@$articles, 4);
    };

    it 'should find all articles with limit' => sub {
        my $dir = Twist::Articles->new(path => 't/articles');

        my $articles = $dir->find_all(limit => 2);
        is(@$articles, 2);
    };

    it 'should find all articles with correct offset' => sub {
        my $dir = Twist::Articles->new(path => 't/articles');

        my $articles = $dir->find_all(offset => '20110924T12:12:12', limit => 1);
        is(@$articles, 1);
        is($articles->[0]->slug, 'very-good');
    };
};

runtests unless caller;
