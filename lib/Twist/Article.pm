package Twist::Article;

use strict;
use warnings;

use base 'Twist::Base';

use Twist::File;
use Twist::Preprocessor;
use Twist::Renderer;

sub BUILD {
    my $self = shift;

    $self->{preprocessor} ||= Twist::Preprocessor->new;
    $self->{renderer}     ||= Twist::Renderer->new;

    $self->{default_author} ||= 'Anonymous';
}

sub author {
    my $self = shift;

    return $self->_metadata->{author} || $self->{default_author};
}

sub slug { shift->{file}->filename }

sub created  { shift->{file}->created }
sub modified { shift->{file}->modified }

sub title {
    my $self = shift;

    return $self->_metadata->{title};
}

sub tags {
    my $self = shift;

    my $tags = $self->_metadata->{tags};

    return [] unless $tags;

    return [map { s/^\s+//; s/\s+$//; $_ } split ',' => $tags];
}

sub preview {
    my $self = shift;

    return $self->{preview} if $self->{preview};

    return $self->{preview} = $self->{renderer}
      ->render($self->{file}->format, $self->_data->{preview});
}

sub preview_link {
    my $self = shift;

    return $self->_data->{preview_link};
}

sub content {
    my $self = shift;

    return $self->{content} if $self->{content};

    return $self->{renderer}
      ->render($self->{file}->format, $self->_data->{content});
}

sub _data {
    my $self = shift;

    return $self->{data} if defined $self->{data};

    my $data = $self->{file}->slurp;

    $data =~ s/^(.*?): (.*?)\n\n//ms;

    my $preprocessed = $self->{preprocessor}->parse($data);

    return $self->{data} = $preprocessed;
}

sub _metadata {
    my $self = shift;

    my $metadata = {};

    my $content = $self->{file}->slurp;

    while ($content =~ s/^(.*?): (.*)\n?//) {
        my ($key, $value) = (lc($1), $2);

        $metadata->{$key} = $value;
    }

    return $metadata;
}

1;
