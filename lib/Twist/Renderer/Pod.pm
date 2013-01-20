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

    $output =~
      s{<pre>(.*?)</pre>}
       {
           my $t = $1;
           my $attr = '';

           #if ($t =~ s/^\s*# no-run//) {
               #$attr .= qq( class="code");
           #}

           $t =~ s|^[^\S\n]{4}||gms;

           qq{<pre$attr>$t</pre>}
       }msge;

    return $output;
}

1;
