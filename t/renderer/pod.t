use strict;
use warnings;

use Test::Spec;

use_ok('Twist::Renderer::Pod');

describe 'renderer' => sub {
    my $renderer;

    before each => sub {
        $renderer = Twist::Renderer::Pod->new;
    };

    it 'should render pod' => sub {
        is($renderer->render("=head1 Foo"), "\n<h1>Foo</h1>\n");
    };

    it 'should format code' => sub {
        is($renderer->render("    this is code"), "\n<pre>this is code</pre>\n");
    };
};

runtests unless caller;
