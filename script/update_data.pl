use lib 'lib';
use Wayne::Data::Master;
use Data::Section::Simple;

my $c = Wayne::Data::Master->connect('dbi:SQLite:/Users/cesansim/Desktop/apps/Wayne/data/master.db');

for (qw/Perforce Input Reference/) {
    my $s = sub {
	my $m = $c->resultset($_)->search;
	for ($m->all) { $_->update_brief_id; }
    };
    $c->txn_do($s);
}

__DATA__

