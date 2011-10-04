use strict;
use warnings;

use Test::More;

use Dancer::Test;

{
    package MyApp;
    use Dancer;

    setting appdir => 't';
    load_app 'Twist';

    setting appdir => 't';

}

my $response = dancer_response GET => '/';

use Data::Dumper;
warn Dumper($response);

done_testing;
