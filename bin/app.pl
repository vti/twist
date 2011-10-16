#!/usr/bin/env perl

$SIG{TERM} = $SIG{INT} = sub {exit 0};

use Dancer;

use Twist;

dance;
