package Wayne::Data::Master::Result::Input;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';


__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table('input');

__PACKAGE__->add_columns(
    'path' => {
	       'default_value' => undef,
	       'data_type' => 'varchar',
	       'size' => '1024',
	       'is_foreign_key' => 0,
	       'name' => 'path',
	       'is_auto_increment' => 0,
	       'is_nullable' => 0
	      },
     "brief_id",
     { data_type => "varchar", is_nullable => 1, size => 32 },
);

sub update_brief_id {
    my $self = shift;
    my $path = $self->path;
    $path =~ /\D(\d{8,8})\D/;
    $self->brief_id($1);
    $self->update;
}

__PACKAGE__->set_primary_key('path');

__PACKAGE__->meta->make_immutable;


1;
