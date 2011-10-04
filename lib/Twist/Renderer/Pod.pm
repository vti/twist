package Twist::Renderer::Pod;

use strict;
use warnings;

use base 'Twist::Base';

use Pod::Simple::HTML;

sub render {
    my $self = shift;
    my ($pod) = @_;

    $pod = "=pod\n\n$pod\n\n=cut";

    my $parser = Pod::Simple::HTML->new;
    $parser->force_title('');
    $parser->html_header_before_title('');
    $parser->html_header_after_title('');
    $parser->html_footer('');

    my $output;
    $parser->output_string(\$output);
    $parser->parse_string_document($pod);

    $output =~ s/<a name='___top' class='dummyTopAnchor'\s*?><\/a>\n//g;
    $output =~ s/<a class='u'.*?name=".*?"\s*>(.*?)<\/a>/$1/sg;

    return $output;
}

1;
