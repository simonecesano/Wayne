package Wayne::Controller::Upload::Data;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

__PACKAGE__->config(namespace => 'u/d');

=head1 NAME

Wayne::Controller::Upload::Data - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
   my ( $self, $c ) = @_;
   $c->response->body($self->_app->path_to('root', 'uploads'));
}

sub p4changes :Path('p4Changes') :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body('Matched Wayne::Controller::Upload::Data in Upload::Data.');
}

sub p4files :Path('p4files') :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{model} = "Foo::Bar";
    $c->stash->{filename} = 'p4files';
    $c->stash->{transform} = sub { 
	my @data = split /\n/, shift;
	return \@data 
    };
    $c->detach('process_upload');
    $c->response->body('Matched Wayne::Controller::Upload::Data in Upload::Data.');
}


use Cwd;
use POSIX qw(strftime);
use feature 'current_sub';

sub process_upload :Private {
    my ($self, $c) = @_;
    if ($c->req->params->{file}) {
	my $upload = $c->request->upload('file');

	my ($action) = ($c->action =~ /.+\/(.+)/);
	my $filename = sprintf "%s-%s.%s", $action, (strftime "%Y%m%d-%H%M%S", localtime), 'txt';
	my $target   = $self->_app->path_to('root', 'uploads', $filename);
	$upload->copy_to($target);

	my $data = $c->stash->{transform}->($upload->slurp);
	my $m = $c->model($c->stash->{model});

	$m->search->delete;
	$m->populate($data);
    } else {
	# application error
    }
} 




=encoding utf8

=head1 AUTHOR

Cesano, Simone

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
