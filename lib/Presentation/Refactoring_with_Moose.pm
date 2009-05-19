package # Hide from PAUSE
    Presentation::Refactoring_with_Moose;
use Pod::S5;
use File::ShareDir qw/dist_dir/;
use Moose;
use MooseX::Types::Moose qw/Str Bool/;
use Method::Signatures::Simple;
use File::Slurp qw/read_file/;
use File::Temp qw/tempfile/;
use namespace::autoclean;

with 'MooseX::Getopt';

has pod_filename => ( isa => Str, is => 'ro', lazy_build => 1 );

method _build_pod_filename {
    my $fn = $0;
    $fn =~ s/\.p(lm)/.pod/;
    return $fn;
}

has html_filename => ( isa => Str, is => 'ro', lazy_build => 1 );

method _build_html_filename {
    $self->_s5_dir . '/index.html';
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
    my $filename = $self->html_filename;
    my $fh;
    open($fh, '>', $filename) or die;
    print $fh $self->_change_location($s5->process($self->_slurp_pod));
    close($fh);
    my $uri = "file://$filename";
    if (0) {
        exec('firefox', $uri);
    }
    else {
        print "$uri\n";
    }
}

method _dist_name {
    my $dist = ref($self);
    $dist =~ s/::/-/g;
    return $dist;
}

method _s5_dir {
    dist_dir($self->_dist_name);
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

