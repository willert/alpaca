#!/usr/bin/env perl

use Test::More;
use Module::Find qw/ findallmod /;
use List::MoreUtils qw/ uniq /;

use Alpaca::Form;

my $form = Alpaca::Form->new({
  title => "What do you think of Alpaca?",
  properties => [
    name => {
      type  => "string",
      title => "Name"
    },
    ranking => {
      type  => "string",
      title => "Ranking",
      enum  => [
        'excellent', 'not too shabby', 'alpaca built my hotrod'
      ]
    }
  ]
});

use Data::Dumper;
printf STDERR "[Dumper] at create-form.t line 27: %s\n",
  Dumper( $form );


pass "He's alive, Jim!";

done_testing;
