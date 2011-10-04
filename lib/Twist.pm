package Twist;
use Dancer ':syntax';

use Twist::Archive;
use Twist::Article;
use Twist::Articles;
use Twist::Pager;
use Twist::Preprocessor;
use Twist::Renderer;

our $VERSION = '0.1';

my $articles_root = File::Spec->catfile(setting('appdir'), 'articles');
my $drafts_root   = File::Spec->catfile(setting('appdir'), 'drafts');

my $preprocessor = Twist::Preprocessor->new;
my $renderer     = Twist::Renderer->new;

before_template sub {
    my $tokens = shift;

    my $config = $tokens->{settings}->{twist};

    $config->{base} ||= uri_for '/';
    $config->{generator} ||= "Twist $VERSION";
    $config->{footer}
      ||= q{Powered by <a href="http://github.com/vti/twist">Twist</a>};
};

get '/' => sub {
    my $timestamp = params->{timestamp};

    my $articles = Twist::Articles->new(
        path         => $articles_root,
        article_args => {default_author => setting('twist')->{author}}
      )->find_all(
        offset => $timestamp,
        limit  => setting('twist')->{page_limit}
      );

    my $pager = Twist::Pager->new(
        path   => $articles_root,
        offset => $timestamp,
        limit  => setting('twist')->{page_limit}
    );

    template 'index' => {articles => $articles, pager => $pager};
};

get '/index.rss' => sub {
    my $timestamp = params->{timestamp};

    my $articles = Twist::Articles->new(
        path         => $articles_root,
        article_args => {default_author => setting('twist')->{author}}
    )->find_all(limit => setting('twist')->{page_limit});

    template
      'rss/articles' =>
      {pub_date => $articles->[0]->created->to_rss, articles => $articles},
      {layout   => 'rss'};
};

get '/articles/:year/:month/:slug.html' => sub {
    my $year  = params->{year};
    my $month = params->{month};
    my $slug  = params->{slug};

    my $article = Twist::Articles->new(
        path         => $articles_root,
        article_args => {default_author => setting('twist')->{author}}
    )->find(slug => $slug);

    if (!$article) {
        status 'not_found';
        return template 'not_found';
    }

    template 'article' => {article => $article};
};

get '/drafts/:slug.html' => sub {
    my $slug = params->{slug};

    my $article = Twist::Articles->new(
        path         => $drafts_root,
        article_args => {default_author => setting('twist')->{author}}
    )->find(slug => $slug);

    if (!$article) {
        status 'not_found';
        return template 'not_found';
    }

    template 'draft' => {article => $article};
};

get '/archive.html' => sub {
    my $years = Twist::Archive->new(
        path         => $articles_root,
        article_args => {default_author => setting('twist')->{author}}
    )->archive;

    template 'archive' => {years => $years};
};

get '/tags.html' => sub {
    my $tag_cloud = Twist::TagCloud->new(path => $articles_root);

    template 'tags' => {tags => $tag_cloud->cloud};
};

get '/tags/:tag.html' => sub {
    my $timestamp = params->{timestamp};
    my $tag       = params->{tag};

    my $articles = Twist::Articles->new(
        path         => $articles_root,
        article_args => {default_author => setting('twist')->{author}}
      )->find_all(
        tag    => $tag,
        offset => $timestamp,
        limit  => setting('twist')->{page_limit}
      );

    template 'tag' => {articles => $articles, tag => $tag};
};

get '/tags/:tag.rss' => sub {
    my $timestamp = params->{timestamp};
    my $tag       = params->{tag};

    my $articles = Twist::Articles->new(path => $articles_root)->find_all(
        tag   => $tag,
        limit => setting('twist')->{page_limit}
    );

    template
      'rss/tag' => {
        articles => $articles,
        tag      => $tag
      },
      {layout => 'rss'};
};

true;
