#!/usr/bin/env perl

use Test::More;
use Module::Find qw/ findallmod /;
use List::MoreUtils qw/ uniq /;

for my $mod ( uniq(
  findallmod( 'Alpaca::Field' ), findallmod( 'Alpaca' )
)) {
  use_ok $mod or BAIL_OUT "Can't load $mod";
}

done_testing;
