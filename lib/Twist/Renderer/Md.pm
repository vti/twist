package Twist::Renderer::Md;

use strict;
use warnings;

use base 'Twist::Base';

use Text::Markdown;

sub render {
    my $self = shift;
    my ($md) = @_;

 
  	my $parser = Text::Markdown->new;
	my $output = $parser->markdown($md);

    return $output;
}

1;
