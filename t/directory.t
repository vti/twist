use strict;
use warnings;

use Test::Spec;

use File::stat;
use Time::HiRes qw(usleep);

use_ok('Twist::Directory');

describe 'directory' => sub {
    it 'should load files' => sub {
        unlink 't/directory/.cache';

        my $dir = Twist::Directory->new(path => 't/directory');
        is($dir->files->[0]->filename, 'foo');
    };

    it 'should cache files' => sub {
        unlink 't/directory/.cache';

        my $dir = Twist::Directory->new(path => 't/directory');
        $dir->files;
        undef $dir;

        ok(-f 't/directory/.cache');

        unlink 't/directory/.cache';
    };

    it 'should reread directory when it changes' => sub {
        unlink 't/directory/.cache';

        my $dir = Twist::Directory->new(path => 't/directory');
        $dir->files;
        undef $dir;

        my $old_stat = stat 't/directory/.cache';

        usleep 10000;

        open my $fh, '>', 't/directory/new_file';
        print $fh 'foo';
        close $fh;

        $dir = Twist::Directory->new(path => 't/directory');
        $dir->files;
        undef $dir;

        my $new_stat = stat 't/directory/.cache';

        isnt($old_stat->size, $new_stat->size);

        unlink 't/directory/new_file';
    };
};

runtests unless caller;
