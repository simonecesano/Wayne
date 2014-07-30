package Wayne::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__
    ->config
    ({
      INCLUDE_PATH
      => [
	  Wayne->path_to( 'root', 'src' ),
	  Wayne->path_to( 'root', 'lib' )
	 ],
      EVAL_PERL => 1,
      ERROR        => 'error.tt2',
      TIMER        => 0,
      render_die   => 1,
});

1;
