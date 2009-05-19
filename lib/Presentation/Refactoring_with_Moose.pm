package # Hide from PAUSE
    Presentation::Refactoring_with_Moose;
use Pod::S5;
use File::ShareDir qw/dist_dir/;
use Moose;
use MooseX::Types::Moose qw/Str/;
use Method::Signatures::Simple;
use File::Slurp qw/read_file/;
use namespace::autoclean;

with 'MooseX::Getopt';

has pod_filename => ( isa => Str, is => 'ro', lazy_build => 1 );

method _build_pod_filename {
    my $fn = $0;
    $fn =~ s/\.p(lm)/.pod/;
    return $fn;
}

method _slurp_pod {
    read_file($self->pod_filename);
}

method run {
    my $s5 = new Pod::S5(
              theme    => 'default',
              author   => 'root',
              creation => '1.1.1979',
              where    => 'Perl Republic',
              company  => 'Perl Inc.',
              name     => 'A slide about perl');
    print $self->_change_location($s5->process($self->_slurp_pod));
}

method _dist_name {
    my $dist = ref($self);
    $dist =~ s/::/-/g;
    return $dist;
}

method _s5_dir {
    dist_dir($self->_dist_name) . '/s5';
}

sub _change_location {
    my ($self, $text) = @_;
    my $s5_dir = $self->_s5_dir();
    $text =~ s#(href|src)="ui/#$1="file://$s5_dir/ui/#g;
    return $text;
}

__PACKAGE__->meta->make_immutable;
__PACKAGE__->new_with_options->run unless caller;
1;

