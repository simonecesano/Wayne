package Wayne::Controller::Palettes;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Wayne::Controller::Palettes - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Wayne::Controller::Palettes in Palettes.');
}

use Cwd;
use Data::Dump qw/dump/; 
use List::AllUtils qw/sum/;

sub upload :Path('upload') {
    my ( $self, $c ) = @_;

    my $dir = getcwd;

    $c->log->info(keys $c->req->params);

    if ($c->req->params->{file}) {

	my $upload = $c->request->upload('file');
	my $filename = $upload->filename;
	my $target   = "$dir/palettes/$filename";
	$upload->copy_to($target);

	my $date = qx/date +%Y%m%d/;
	my $hist = qx/convert -colors 128 "$target" -format %c histogram:info:-/;

	my @hist = map { for ($_->[0]) { s/.+#/#/; s/ .+// }; $_ } sort { $b->[1] <=> $a->[1] } map { $_ = [ reverse split /:/ ]; $_->[1] += 0; $_ } split /\n/, $hist;
	my $sum  = sum map { $_->[1] } @hist;
	@hist = map { $_->[1] /= ($sum / 1000); @$_ } @hist[0..99]; 

	open my $fh, '>', "$dir/palettes/latest.pl";
	print $fh dump \@hist;
 	$c->res->body($c->uri_for('latest'));
    } else {
	$c->stash->{template} = 'palettes/upload.tt2';
	$c->forward('View::HTML');
    }
}

sub latest :Path('latest') {
    my ( $self, $c ) = @_;
    my $dir = getcwd;

    $c->stash->{palette} = do "$dir/palettes/latest.pl";
    $c->stash->{template} = 'palettes/latest.tt2';
    $c->forward('View::HTML');

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
