use strict;
use warnings;

use lib 'inc';
use ExtUtils::MakeMaker::Dist::Zilla::Develop;

# keep this code consistent with the [MakeMaker::Awesome] arguments in dist.ini
my @OBJECT = map { "${_}.o" } qw(
    CoreDump
    src/coredumper
    src/thread_lister
    src/elfcore
    src/linuxthreads
);

WriteMakefile(
    NAME => 'Devel::CoreDump',
    VERSION_FROM => 'lib/Devel/CoreDump.pm',
    INSTALLMAN1DIR => 'none',
    INSTALLMAN3DIR => 'none',
    NORECURS => 1,
    INC    => '-Isrc',
    clean  => { FILES => join(q{ }, @OBJECT) },
    OBJECT => join(q{ }, @OBJECT),
);

package MY;

sub const_cccmd {
    my $self = shift;
    my $orig = $self->SUPER::const_cccmd(@_);

    return '' unless $orig;

    $orig .= ' -o $@';
    return $orig;
}

use Devel::PPPort 3.36;
Devel::PPPort::WriteFile();
