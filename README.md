[![Actions Status](https://github.com/lizmat/P5getnetbyname/workflows/test/badge.svg)](https://github.com/lizmat/P5getnetbyname/actions)

NAME
====

Raku port of Perl's getnetbyname() and associated built-ins

SYNOPSIS
========

    use P5getnetbyname;
    # exports getnetbyname, getnetbyaddr, getnetent, setnetent, endnetent

    say getnetbyaddr(Scalar, 127, 2);   # something akin to loopback

    my @result_byname = getnetbyname("loopback");

    my @result_byaddr = getnetbyaddr(|@result_byname[4,3]);

DESCRIPTION
===========

This module tries to mimic the behaviour of Perl's `getnetbyname` and associated built-ins as closely as possible in the Raku Programming Language.

It exports by default:

    endnetent getnetbyname getnetbyaddr getnetent setnetent

ORIGINAL PERL 5 DOCUMENTATION
=============================

    getnetbyname NAME
    getnetbyaddr ADDR,ADDRTYPE
    getnetent
    setnetent STAYOPEN
    endnetent
            These routines are the same as their counterparts in the system C
            library. In list context, the return values from the various get
            routines are as follows:

             # 0        1          2           3         4
             ( $name,   $aliases,  $addrtype,  $net      ) = getnet*

            In scalar context, you get the name, unless the function was a
            lookup by name, in which case you get the other thing, whatever it
            is. (If the entry doesn't exist you get the undefined value.)

PORTING CAVEATS
===============

This module depends on the availability of POSIX semantics. This is generally not available on Windows, so this module will probably not work on Windows.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

Source can be located at: https://github.com/lizmat/P5getnetbyname . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2018, 2019, 2020, 2021, 2022, 2023 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

