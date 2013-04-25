use strict;
use warnings;

use Test::More;

use Getopt::Mini later=>1;

{
    my %args = getopt( argv=>[ '-data', '99', '--foo', '11', '-foo', 22 ] );
    is $args{data}, 99, 'first arg';
    is join( ' ',@{$args{foo}} ), '11 22', 'push args';
}

{
    my %args = getopt( argv=>[ '-d', '11', '22', '-h', '--foo', 22, '-d' ] );
    ok exists( $args{d} ), 'defined arg doesnt eat bareword';
    is join(' ',@{$args{''}}), '11 22', 'bare middle';
}
{
    my %args = getopt( argv=>[ 'loose', '-d', '-f' ] );
    ok exists( $args{d} ), 'defined arg';
    ok grep( /loose/, $args{''} ), 'bareword';
}
{
    my %args = getopt( argv=>[ 'loose', '--port', '1..200', '-fp', '--n', 500 ] );
    ok exists( $args{n} ), 'defined arg';
    is $args{n} ,  500, 'last arg';
}
{
    my %args = getopt( hungry_flags=>1, argv=>[ 'loose', '-s', 2, '--port', '1..200', '-fp', '-n', 500 ] );
    ok exists( $args{n} ), 'defined arg hungry';
    is $args{s} ,  2, 'arg hungry';
    is $args{n} ,  500, 'last arg hungry';
}

done_testing;
