package Twist::Preprocessor;

use strict;
use warnings;

use base 'Twist::Base';

sub BUILD {
    my $self = shift;

    $self->{cuttag}               ||= '[cut]';
    $self->{default_preview_link} ||= 'Keep reading';

    return $self;
}

sub parse {
    my $self = shift;
    my ($content) = @_;

    my $cuttag = quotemeta $self->{cuttag};

    my ($preview, $preview_link) = ('', '');

    if ($content =~ s{^(.*?)\r?\n$cuttag(?: (.*?))?\r?\n}{}s) {
        $preview = $1;
        $preview_link = $2 || $self->{default_preview_link};
    }

    return {
        preview      => $preview,
        preview_link => $preview_link,
        content      => $content
    };
}

1;
