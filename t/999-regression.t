use v6;

use Test;
use Perl6::Parser;

my $pt = Perl6::Parser.new;
my $*VALIDATION-FAILURE-FATAL = True;
my $*FACTORY-FAILURE-FATAL = True;

subtest {
	plan 2;

	my $source = Q:to[_END_];
say <closed open>;
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
#say $pt.dump-tree($tree);
	ok $pt.validate( $p ), Q{valid};
	is $pt.format( $tree ), $source, Q{formatted};
}, Q{say <closed open>};

my @quantities = flat (99 ... 1), 'No more', 99;

subtest {
	plan 2;

	my $source = Q:to[_END_];
my @quantities = flat (99 ... 1), 'No more', 99;
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
#say $pt.dump-tree($tree);
	ok $pt.validate( $p ), Q{valid};
	is $pt.format( $tree ), $source, Q{formatted};
}, Q{flat (99 ... 1)};

subtest {
	plan 2;

	my $source = Q:to[_END_];
sub foo( $a is copy ) { }
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
#say $pt.dump-tree($tree);
	ok $pt.validate( $p ), Q{valid};
	is $pt.format( $tree ), $source, Q{formatted};
}, Q{flat (99 ... 1)};

subtest {
	plan 2;

	my $source = Q:to[_END_];
grammar Foo {
    token TOP { ^ <exp> $ { fail } }
}
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
#say $pt.dump-tree($tree);
	ok $pt.validate( $p ), Q{valid};
	is $pt.format( $tree ), $source, Q{formatted};
}, Q{flat (99 ... 1)};

subtest {
	plan 2;

	my $source = Q:to[_END_];
grammar Foo {
    rule exp { <term>+ % <op> }
}
_END_
	my $p = $pt.parse( $source );
	my $tree = $pt.build-tree( $p );
#say $pt.dump-tree($tree);
	ok $pt.validate( $p ), Q{valid};
	is $pt.format( $tree ), $source, Q{formatted};
}, Q{flat (99 ... 1)};

done-testing;

# vim: ft=perl6
