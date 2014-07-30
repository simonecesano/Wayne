use lib 'lib';
use Wayne::Data::Master;
use Data::Section::Simple;
use Data::Dump qw/dump/;

my $c = Wayne::Data::Master->connect('dbi:SQLite:/Users/cesansim/Desktop/apps/Wayne/data/master.db');

$c->txn_do
    (sub {
	 for (qw/Perforce Input Reference/) {
	     my $m = $c->resultset($_)->search;
	     for ($m->all) { $_->update_brief_id; }
	 };
     });

my @cols = qw/brief_id article_name marketing_division_name business_unit_int_name sports_category_name upper_tooling_id bottom_tooling_id season/;

my $r = $c->resultset('Master')->search({}, { columns => \@cols, group_by => [qw/brief_id/] });
$r->result_class('DBIx::Class::ResultClass::HashRefInflator');

$c->txn_do
    (sub { 
	 my $b = $c->resultset('Brief');
	 $b->search->delete;
	 $b->populate([ $r->all ]);
	 $b->search->update({ perforce => 0, input => 0, reference => 0});
	 
	 for (qw/Perforce Input Reference/) {
	     $b->search({ brief_id => { -in => $c->resultset($_)->get_column('brief_id')->as_query } })->update({ $_ => 1 });
	 }
     });
