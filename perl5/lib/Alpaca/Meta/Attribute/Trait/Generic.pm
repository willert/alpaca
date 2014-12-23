package Alpaca::Meta::Attribute::Trait::Generic;

use 5.010;
use Moose::Role;

has description => (
  is        => 'rw',
  isa       => 'Str',
  predicate => 'has_description',
);


no Moose::Role;

1;
