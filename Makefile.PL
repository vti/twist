use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Twist',
    AUTHOR       => q{YOUR NAME <youremail@example.com>},
    VERSION_FROM => 'lib/Twist.pm',
    ABSTRACT     => 'YOUR APPLICATION ABSTRACT',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
        ? ('LICENSE' => 'perl')
        : ()),
    PL_FILES  => {},
    PREREQ_PM => {
        'Test::More'             => 0,
        'YAML'                   => 0,
        'Dancer'                 => 1.3030,
        'Dancer::Template::Caml' => 0
    },
    dist  => {COMPRESS => 'gzip -9f', SUFFIX => 'gz',},
    clean => {FILES    => 'Twist-*'},
);
