use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Twist',
    AUTHOR       => q{vti <vti@cpan.org>},
    VERSION_FROM => 'lib/Twist.pm',
    ABSTRACT     => 'Twist',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
        ? ('LICENSE' => 'perl')
        : ()),
    PL_FILES  => {},
    PREREQ_PM => {
        'Class::Load'            => 0,
        'Dancer'                 => 1.3030,
        'Dancer::Template::Caml' => 0.009002,
        'Test::Spec'             => 0,
        'YAML'                   => 0,
        'Test::Spec'             => 0,
    },
    dist  => {COMPRESS => 'gzip -9f', SUFFIX => 'gz',},
    clean => {FILES    => 'Twist-*'},
);
