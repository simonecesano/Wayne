use utf8;
package Wayne::Data::Master::Result::Master;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Wayne::Data::Master::Result::Master

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

__PACKAGE__->table("master");

__PACKAGE__->add_columns(
  "brief_id",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "model_id",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "article_nr",
  { data_type => "varchar", is_nullable => 1, size => 26 },
  "article_name",
  { data_type => "varchar", is_nullable => 1, size => 30 },
  "colour_combination_name",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "brand_name",
  { data_type => "varchar", is_nullable => 1, size => 8 },
  "marketing_division_name",
  { data_type => "varchar", is_nullable => 1, size => 26 },
  "business_unit_int_name",
  { data_type => "varchar", is_nullable => 1, size => 19 },
  "product_line_name",
  { data_type => "varchar", is_nullable => 1, size => 19 },
  "business_segment_name",
  { data_type => "varchar", is_nullable => 1, size => 25 },
  "key_category_name",
  { data_type => "varchar", is_nullable => 1, size => 21 },
  "sports_category_name",
  { data_type => "varchar", is_nullable => 1, size => 15 },
  "category_marketing_line_name",
  { data_type => "varchar", is_nullable => 1, size => 30 },
  "product_division_name",
  { data_type => "varchar", is_nullable => 1, size => 26 },
  "upper_tooling_id",
  { data_type => "integer", is_nullable => 1 },
  "bottom_tooling_id",
  { data_type => "integer", is_nullable => 1 },
  "season",
  { data_type => "varchar", is_nullable => 1, size => 4 },
);

__PACKAGE__->meta->make_immutable;


1;
