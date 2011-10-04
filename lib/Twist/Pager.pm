package Twist::Pager;

use strict;
use warnings;

use base 'Twist::Base';

use Twist::Articles;

sub BUILD {
    my $self = shift;

    $self->{articles} = Twist::Articles->new(path => $self->{path})->find_all;

    if ($self->{offset}) {
        my $i;
        for ($i = 0; $i < @{$self->{articles}}; $i++) {
            next
              unless $self->{articles}->[$i]->created->timestamp
                  le $self->{offset};
            last;
        }

        $self->{current} = $i;
    }
    else {
        $self->{current} = 0;
    }
}

sub prev {
    my $self = shift;

    my $prev = $self->{current} - $self->{limit};

    return if $prev < 0;

    return $self->{articles}->[$prev]->created->timestamp;
}

sub next {
    my $self = shift;

    my $next = $self->{current} + $self->{limit};

    return if $next >= @{$self->{articles}};

    return $self->{articles}->[$next]->created->timestamp;
}

1;
