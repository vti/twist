use strict;
use warnings;

use Test::Spec;

use_ok('Twist::Pager');

describe 'pager' => sub {
    it 'should find next page without offset' => sub {
        my $pager = Twist::Pager->new(path => 't/pager', limit => 2);

        is $pager->next, '20110923T12:12:12';
    };

    it 'should find next page with offset' => sub {
        my $pager = Twist::Pager->new(
            path   => 't/pager',
            limit  => 2,
            offset => '20110923T12:12:12'
        );

        is $pager->next, '20110921T12:12:12';
    };

    it 'should not find next when no pages available' => sub {
        my $pager = Twist::Pager->new(
            path   => 't/pager',
            limit  => 2,
            offset => '20110922T12:12:12'
        );

        ok not defined $pager->next;
    };

    it 'should not find prev page without offset' => sub {
        my $pager = Twist::Pager->new(path => 't/pager', limit => 2);

        ok not defined $pager->prev;
    };

    it 'should not find prev page when offset is not enough' => sub {
        my $pager = Twist::Pager->new(path => 't/pager', limit => 2, offset =>
            '20110924T12:12:12');

        ok not defined $pager->prev;
    };
};

runtests unless caller;
