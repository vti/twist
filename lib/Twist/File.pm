package Twist::File;

use strict;
use warnings;

use base 'Twist::Base';

use Encode ();
use File::stat;
use File::Basename ();

use Twist::Date;

sub path {
    my $self = shift;

    return $self->{path};
}

sub created {
    my $self = shift;

    my ($prefix) = File::Basename::basename($self->path) =~ m/^(.*?)-/;

    if ($prefix && Twist::Date->is_date($prefix)) {
        return Twist::Date->new(timestamp => $prefix);
    }
    else {
        return $self->modified;
    }
}

sub modified {
    my $self = shift;

    return Twist::Date->new(epoch => $self->_stat->mtime);
}

sub filename {
    my $self = shift;

    my $filename = File::Basename::basename($self->path);

    my ($prefix) = $filename =~ m/^(.*?)-/;
    if ($prefix && Twist::Date->is_date($prefix)) {
        $filename =~ s/^$prefix-//;
    }

    $filename =~ s/\.[^\.]+$//;

    return $filename;
}

sub format {
    my $self = shift;

    my $filename = File::Basename::basename($self->path);

    if ($filename =~ m/\.([^\.]+)$/) {
        return $1;
    }

    return '';
}

sub slurp {
    my $self = shift;

    my $slurp = do { local $/; open my $fh, '<', $self->path or die $!; <$fh> };

    return Encode::decode('UTF-8', $slurp);
}

sub _stat {
    my $self = shift;

    return $self->{stat} if $self->{stat};

    return $self->{stat} = stat $self->path;
}

1;
