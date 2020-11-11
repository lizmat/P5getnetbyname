use v6.*;
use Test;
use P5getnetbyname;

my @supported = <
  endnetent getnetbyname getnetbyaddr getnetent setnetent
>.map: '&' ~ *;

plan @supported * 2;

for @supported {
    ok defined(::($_)),              "is $_ imported?";
    nok P5getnetbyname::{$_}:exists, "is $_ NOT externally accessible?";
}

# vim: expandtab shiftwidth=4
