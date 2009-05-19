use inc::Module::Install 0.78;

author 'Tomas Doran (t0m) <bobtfish@bobtfish.net>';
name 'Presentation-Refactoring_with_Moose';
all_from('lib/Presentation/Refactoring_with_Moose.pm');
license 'perl';

requires 'YAML';
requires 'namespace::autoclean';
requires 'Method::Signatures::Simple';
requires 'File::Slurp';
requires 'Moose';
requires 'MooseX::Types';
requires 'MooseX::Getopt';
requires 'Pod::S5' => '0.08';
requires 'Syntax::Highlight::Engine::Kate' => '0.04';
requires 'File::ShareDir' => '1.00';

install_share 'share';

auto_install;

postamble(<<EOF);
install ::
\t/usr/bin/env perl lib/Presentation/Refactoring_with_Moose.pm --install_slides
EOF

WriteAll();

