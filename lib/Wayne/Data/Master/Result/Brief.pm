package Wayne::Data::Master::Result::Brief;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';


__PACKAGE__->table_class('DBIx::Class::ResultSource::View');

__PACKAGE__->table('briefs');

__PACKAGE__->add_columns(
  "brief_id",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "article_name",
  { data_type => "varchar", is_nullable => 1, size => 30 },
  "marketing_division_name",
  { data_type => "varchar", is_nullable => 1, size => 26 },
  "business_unit_int_name",
  { data_type => "varchar", is_nullable => 1, size => 19 },
  "sports_category_name",
  { data_type => "varchar", is_nullable => 1, size => 15 },
  "upper_tooling_id",
  { data_type => "integer", is_nullable => 1 },
  "bottom_tooling_id",
  { data_type => "integer", is_nullable => 1 },
  "season",
  { data_type => "varchar", is_nullable => 1, size => 4 },
  "perforce",
  { data_type => "boolean", is_nullable => 1, size => 4 },
  "input",
  { data_type => "boolean", is_nullable => 1, size => 4 },
  "reference",
  { data_type => "boolean", is_nullable => 1, size => 4 },
);

__PACKAGE__->set_primary_key('brief_id');

__PACKAGE__->has_many
    (
     perforce_files => 'Wayne::Data::Master::Result::Perforce',
     { 'foreign.brief_id'  => 'self.brief_id' },
    );

1;
