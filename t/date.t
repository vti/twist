#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 13;

use Twist::Date;

my $t = Twist::Date->new(epoch => 0);
is $t->timestamp              => '19700101T00:00:00';
is $t->epoch                  => 0;
is $t->year                   => 1970;
is $t->month                  => 1;
like $t->strftime('%a, %d %b %Y') => qr/^(Thu|Do), 01 Jan 1970$/;

$t = Twist::Date->new(timestamp => '19700101');
is $t->epoch     => 0;
is $t->timestamp => '19700101T00:00:00';

$t = Twist::Date->new(timestamp => '19700101T00:00:00');
is $t->epoch     => 0;
is $t->timestamp => '19700101T00:00:00';

$t = Twist::Date->new(timestamp => '19700101T010203');
is $t->epoch     => 3723;
is $t->timestamp => '19700101T01:02:03';

ok $t->is_date('19700101T00:00:00');
ok !$t->is_date('197001a1T00:00:00');
