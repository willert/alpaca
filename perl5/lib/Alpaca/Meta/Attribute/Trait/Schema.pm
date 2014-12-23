package Alpaca::Meta::Attribute::Trait::Schema;

use 5.010;
use Moose::Role;
Moose::Util::meta_attribute_alias('AlpacaSchema');

with 'Alpaca::Meta::Attribute::Trait::Generic';

1;
