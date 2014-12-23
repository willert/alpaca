package Alpaca::Form;

use Moose;
use Types::Standard qw(:all);
use Alpaca::Types qw(:all);
use Module::Find qw/ useall /;

BEGIN { useall 'Alpaca::Field' }

has fields => (
  is       => 'ro',
  isa      => AlpacaFieldList,
  init_arg => 'properties',
  traits   => [qw/ Array /],
  default  => sub{[]},
  handles  => {
    add_field => 'push',
  },
  coerce => 1,
);


__PACKAGE__->meta->make_immutable;
no Moose;

1;
