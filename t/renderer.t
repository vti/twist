use strict;
use warnings;

use Test::Spec;

use_ok('Twist::Renderer');

describe 'renderer' => sub {
    my $renderer;

    before each => sub {
        $renderer = Twist::Renderer->new;
    };

    it 'should render load correct renderer' => sub {
        is($renderer->render('pod', "=head1 Foo"), "\n<h1>Foo</h1>\n");
    };

    it 'should render die on incorrect renderer' => sub {
        eval { $renderer->render('foo', "123") };
        ok($@);
    };
};

runtests unless caller;
