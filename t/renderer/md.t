use strict;
use warnings;

use Test::Spec;

use_ok('Twist::Renderer::Md');

describe 'renderer' => sub {
    my $renderer;

    before each => sub {
        $renderer = Twist::Renderer::Md->new;
    };


    it 'should render markdown' => sub {
        is($renderer->render("[Overview](#overview)(and simple text)"), "<p><a href=\"#overview\">Overview</a>(and simple text)<\/p>\n");
    };

    it 'should change ampersand' => sub {
        is($renderer->render("AT&T"), "<p>AT&amp;T<\/p>\n");
    };
};

runtests unless caller;
