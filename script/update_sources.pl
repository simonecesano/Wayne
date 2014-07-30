use lib 'lib';
use Wayne::Data::Master;
use Data::Section::Simple;
use Data::Dump qw/dump/;

$\ = "\n";
$|++;

my $s = {
	 Reference => 'find "/Volumes/Footwear/Reference" -type d',
	 Input     => 'find "/Volumes/3ddesign_01$/prod/Input_FBX" -type d',
	 Perforce  => 'p4 files "//library/Footwear/Reference/Project/..."'
};

my $c = Wayne::Data::Master->connect('dbi:SQLite:/Users/cesansim/Desktop/apps/Wayne/data/master.db');


for (keys $s) {
    my $p = $s->{$_};
    open my $fh, "$p | ";
    my @data = ([qw/path brief_id/], map { chop; /\D(\d{8,8})\D/; my $i = $1; [ $_, $i ] } (<$fh>));
    print $_;
    print -1 + scalar @data;
    $c->txn_do
	(sub {
	     $c->resultset($_)->search->delete;
	     $c->resultset($_)->populate(\@data);
	     });
    print $c->resultset($_)->search->count;
} 
