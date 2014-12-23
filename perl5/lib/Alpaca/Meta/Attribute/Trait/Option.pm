package Alpaca::Meta::Attribute::Trait::Option;

use 5.010;
use Moose::Role;
Moose::Util::meta_attribute_alias('AlpacaOption');

with 'Alpaca::Meta::Attribute::Trait::Generic';

1;
