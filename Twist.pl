#!/usr/bin/env perl
use Dancer;
use lib path => dirname(__FILE__), 'lib';
use lib '/Users/vti/dev/bootylicious/lib';

set show_errors => 1;
set logger      => 'console';
set layout      => 'main';
set template    => 'template_toolkit';

load_app 'Twist';

dance;
