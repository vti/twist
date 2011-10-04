package Twist::Renderer;

use strict;
use warnings;

use base 'Twist::Base';

use Class::Load;

sub render {
    my $self = shift;
    my ($format, $string) = @_;

    my $renderer_class = 'Twist::Renderer::' . ucfirst $format;
    Class::Load::load_class($renderer_class);

    return $renderer_class->new->render($string);
}

1;
