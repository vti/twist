use strict;
use warnings;

use Test::Spec;

use_ok('Twist::Preprocessor');

describe 'preprocessor' => sub {
    my $preprocessor;

    before each => sub {
        $preprocessor = Twist::Preprocessor->new;
    };

    it 'should parse article' => sub {
        is_deeply(
            $preprocessor->parse("Hello there\n[cut] Foobar\nAnd here"),
            {   preview      => 'Hello there',
                preview_link => 'Foobar',
                content      => 'And here'
            }
        );
    };

    it 'should parse article without preview_link' => sub {
        is_deeply(
            $preprocessor->parse("Hello there\n[cut]\nAnd here"),
            {   preview      => 'Hello there',
                preview_link => 'Keep reading',
                content      => 'And here'
            }
        );
    };

    it 'should parse article without preview' => sub {
        is_deeply(
            $preprocessor->parse("Hello there"),
            {   preview      => '',
                preview_link => '',
                content      => 'Hello there'
            }
        );
    };
};

runtests unless caller;
