package Wayne::Model::Charts;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model::Adaptor';

__PACKAGE__->config( class => 'Path::Tiny' );

use Cwd;
my $dir = getcwd;

sub prepare_arguments {
    my ($self, $c) = @_; # $app sometimes written as $c
    my $dir = $c->config->{root};
    return { root => "$dir/src/chart" };

}

sub mangle_arguments {
    my ($self, $args) = @_;
    return $args->{root}; # now the args are a plain list
}

__PACKAGE__->meta->make_immutable;

1;
