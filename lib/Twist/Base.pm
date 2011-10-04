package Twist::Base;

use strict;
use warnings;

sub new {
    my $class = shift;
    $class = ref $class if ref $class;

    my $self = {@_};
    bless $self, $class;

    $self->BUILD;

    return $self;
}

sub BUILD { }

1;
