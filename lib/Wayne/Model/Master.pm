package Wayne::Model::Master;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'Wayne::Data::Master',
    
    connect_info => {
        dsn => 'dbi:SQLite:/Users/cesansim/Desktop/apps/Wayne/data/master.db',
        user => '',
        password => '',
    }
);

1;
