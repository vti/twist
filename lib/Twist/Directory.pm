package Twist::Directory;

use strict;
use warnings;

use base 'Twist::Base';

use File::Spec;

use Twist::File;

sub files {
    my $self = shift;

    my @files;
    opendir my $dh, $self->{path} or die "Can't open `$self->{path}`: $!";
    while (my $file = readdir $dh) {
        next if $file =~ m/^\./;

        $file = File::Spec->catfile($self->{path}, $file);
        next unless -f $file;

        push @files, Twist::File->new(path => $file);
    }
    close $dh;

    return [sort { $b->created->epoch <=> $a->created->epoch } @files];
}

1;
