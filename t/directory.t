use strict;
use warnings;

use Test::Spec;

use_ok('Twist::Directory');

describe 'directory' => sub {
    it 'should load files' => sub {
        my $dir = Twist::Directory->new(path => 't/directory');
        is($dir->files->[0]->filename, 'foo');
    };
};

runtests unless caller;
