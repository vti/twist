package Twist::TagCloud;

use strict;
use warnings;

use base 'Twist::Base';

use Twist::Articles;

sub BUILD {
    my $self = shift;
}

sub cloud {
    my $self = shift;

    my $cloud = {};
    my $articles = Twist::Articles->new(path => $self->{path})->find_all;

    foreach my $article (@$articles) {
        my $tags = $article->tags;
        foreach my $tag (@$tags) {
            $cloud->{$tag}++;
        }
    }

    return [sort { $a->{name} cmp $b->{name} }
          map { {name => $_, count => $cloud->{$_}} } keys %$cloud];
}

1;
