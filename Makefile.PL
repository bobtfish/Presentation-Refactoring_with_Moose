use inc::Module::Install 0.78;

author 'Tomas Doran (t0m) <bobtfish@bobtfish.net>';
name 'Presentation-Refactoring_with_Moose';
all_from('lib/Presentation/Refactoring_with_Moose.pm');
license 'perl';

requires 'Pod::S5' => '0.08';

auto_install;
WriteAll();

