use strict;
use warnings;

use Test::Spec;

use_ok('Twist::TagCloud');

describe 'tag_cloud' => sub {
    it 'should return tags' => sub {
        my $tag_cloud = Twist::TagCloud->new(path => 't/tags');

        is_deeply(
            $tag_cloud->cloud,
            [   {name => 'bar',    count => 1},
                {name => 'baz',    count => 3},
                {name => 'foo',    count => 2},
                {name => 'single', count => 1}
            ]
        );
    };
};

runtests unless caller;
