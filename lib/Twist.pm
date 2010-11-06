package Twist;
use Dancer ':syntax';

use Bootylicious;

my $b = Bootylicious->new(
    config => {
        articles_root => path(dirname(__FILE__), '..', 'articles'),
        drafts_root   => path(dirname(__FILE__), '..', 'drafts'),
        pages_root    => path(dirname(__FILE__), '..', 'pages'),
    }
);

our $VERSION = '0.1';

set template => 'template_toolkit' => {ANYCASE => 0};

get '/'      => \&index;
get '/index' => \&index;

before_template sub {
    my $tokens = shift;

    $tokens->{b} = $b;
    $tokens->{c} = $b->config;
    $tokens->{h} = $b->helpers;
    $tokens->{u} = $b->url;
    $tokens->{r} = $b->renderer;
};

sub index {
    my $pager = $b->get_articles;

    template 'index' => {
        pager    => $pager,
        articles => $pager->articles
    };
}

get '/articles/:year' => sub {
    my $year = params->{year};

    my $archive = $b->get_archive(year => $year);

    template 'articles' => {archive => $archive};
};

get '/articles/:year/:month' => sub {
    my $year  = params->{year};
    my $month = params->{month};

    my $archive = $b->get_archive(year => $year, month => $month);

    template 'articles' => {archive => $archive};
};

get '/articles/:year/:month/:name' => sub {
    my $article =
      $b->get_article(params->{year}, params->{month}, params->{name});

    return status 'not_found' unless $article;

    template 'article' => {article => $article};
};

get '/tags' => sub {
    my $tags = $b->get_tags;

    template 'tags' => {tags => $tags};
};

get '/tag/:name' => sub {
    my $tag = $b->get_tag(params->{name});

    return status 'not_found' unless $tag;

    template 'tag' => {tag => $tag};
};

true;
