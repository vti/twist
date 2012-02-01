use strict;
use warnings;
use utf8;

use Test::Spec;

use_ok('Twist::File');

describe 'file' => sub {
    it 'should load file' => sub {
        my $file = Twist::File->new(path => 't/file/foo');

        ok($file->created);
        ok($file->modified);
        is($file->filename, 'foo');
        is($file->slurp, "Hello world!\n");
    };

    it 'should return filename without date and extention' => sub {
        my $file = Twist::File->new(path => 't/file/20110922T121212-hello-there.pod');

        is($file->filename, 'hello-there');
    };

    it 'should return correct creation date' => sub {
        my $file = Twist::File->new(path => 't/file/20110922T121212-hello-there.pod');

        is($file->created, 'Thu, 22 Sep 2011');
    };

    it 'should return correct creation date without time' => sub {
        my $file = Twist::File->new(path => 't/file/20110922-hello.pod');

        is($file->created, 'Thu, 22 Sep 2011');
    };

    it 'should return correct format' => sub {
        my $file = Twist::File->new(path => 't/file/20110922T121212-hello-there.pod');

        is($file->format, 'pod');
    };

    it 'should correctly slurp utf8' => sub {
        my $file = Twist::File->new(path => 't/file/20110922T121212-юникод.pod');

        is($file->slurp, "Привет.\n");
    };
};

runtests unless caller;
