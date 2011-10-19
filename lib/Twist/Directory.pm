package Twist::Directory;

use strict;
use warnings;

use base 'Twist::Base';

use Try::Tiny;
use File::Spec;
use Storable;
use Time::HiRes qw(stat);

use Twist::File;

sub files {
    my $self = shift;

    if (my $files = $self->_load_cache) {
        return $files;
    }

    my $files = $self->_files;

    $self->_save_cache;

    return $files;
}

sub _files {
    my $self = shift;

    return @{$self->{files}} if $self->{files};

    my @files;
    opendir my $dh, $self->{path} or die "Can't open `$self->{path}`: $!";
    while (my $file = readdir $dh) {
        next if $file =~ m/^\./;

        $file = File::Spec->catfile($self->{path}, $file);
        next unless -f $file;

        push @files, $file;
    }
    close $dh;

    $self->{files} = [
        sort { $b->created->epoch <=> $a->created->epoch }
        map { Twist::File->new(path => $_) } @files
    ];

    return $self->{files};
}

sub _path_to_cache {
    my $self = shift;

    return File::Spec->catfile($self->{path}, '.cache');
}

sub _load_cache {
    my $self = shift;

    return unless -f $self->_path_to_cache;

    open my $fh, '<', $self->_path_to_cache or return;

    return try {
        my $cache = Storable::retrieve_fd($fh);

        my @stat = stat($self->{path});
        if ($cache->{mtime} ne $stat[9]) {
            return;
        }

        return $cache->{files};
    }
    catch {
        unlink $self->_path_to_cache;

        return;
    };
}

sub _save_cache {
    my $self = shift;

    my $files = $self->{files};

    open my $fh, '>', $self->_path_to_cache or return;

    try {
        my @stat = stat($self->{path});
        Storable::nstore_fd({files => $files, mtime => $stat[9]}, $fh);
    };

    return;
}

1;
