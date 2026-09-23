use NativeCall;

my class NetStruct is repr<CStruct> {  # UNCOVERABLE
    has Str            $.n_name;
    has CArray[Str]    $.n_aliases;  # UNCOVERABLE
    has uint32         $.n_addrtype;
    has uint32         $.n_net;

    sub HLLizeCArrayStr(\list) {  # UNCOVERABLE
        my @members;
        with list -> $members {
            for ^Inf {
                with $members[$_] -> $member {
                    @members.push($member)
                }
                else {
                    last
                }
            }
        }
        @members
    }

    multi method scalar(NetStruct:U: --> Nil) { }
    multi method scalar(NetStruct:D:) { $.n_name }

    multi method list(NetStruct:U:) { () }
    multi method list(NetStruct:D:) {
        ($.n_name,HLLizeCArrayStr($.n_aliases),$.n_addrtype,$.n_net)
    }
}

# actual NativeCall interfaces
sub _getnetbyname(Str --> NetStruct) is native is symbol<getnetbyname> {*}  # UNCOVERABLE
sub _getnetbyaddr(uint32, int32 --> NetStruct) is native is symbol<getnetbyaddr> {*}  # UNCOVERABLE
sub _getnetent(--> NetStruct) is native is symbol<getnetent> {*}  # UNCOVERABLE
sub _setnetent(int32) is native is symbol<setnetent> {*}  # UNCOVERABLE
sub _endnetent() is native is symbol<endnetent> {*}  # UNCOVERABLE

# actual exported subs
my proto sub getnetbyname(|) is export {*}
multi sub getnetbyname(Scalar:U, Str() $name) { _getnetbyname($name).scalar }
multi sub getnetbyname(Str() $name, :$scalar!)  # UNCOVERABLE
  is DEPRECATED('Scalar as first positional')
{
    _getnetbyname($name).scalar  # UNCOVERABLE
}
multi sub getnetbyname(Str() $name) { _getnetbyname($name).list }

my proto sub getnetbyaddr(|) is export {*}
multi sub getnetbyaddr(Scalar:U, Int:D $net, Int:D $addrtype) {
    my uint32 $nnet = $net;
    my  int32 $naddrtype = $addrtype;
    _getnetbyaddr($nnet,$naddrtype).scalar
}
multi sub getnetbyaddr(Int:D $net, Int:D $addrtype, :$scalar!)  # UNCOVERABLE
  is DEPRECATED('Scalar as first positional')
{
    my uint32 $nnet = $net;
    my  int32 $naddrtype = $addrtype;
    _getnetbyaddr($nnet,$naddrtype).scalar  # UNCOVERABLE
}
multi sub getnetbyaddr(Int:D $net, Int:D $addrtype) {
    my uint32 $nnet = $net;
    my  int32 $naddrtype = $addrtype;
    _getnetbyaddr($nnet,$naddrtype).list
}

my proto sub getnetent(|) is export {*}
multi sub getnetent(Scalar:U) { _getnetent().scalar }
multi sub getnetent(:$scalar!)  # UNCOVERABLE
  is DEPRECATED('Scalar as first positional')
{
    getnetent(Scalar)
}
multi sub getnetent() { getnetent(Scalar) }

my sub setnetent($stayopen) is export {
    my int32 $nstayopen = ?$stayopen;
    _setnetent($nstayopen);
    # this is apparently what Perl does, although not documented
    1  # UNCOVERABLE
}

my sub endnetent() is export {
    _endnetent;
    # this is apparently what Perl does, although not documented
    1  # UNCOVERABLE
}

# vim: expandtab shiftwidth=4
