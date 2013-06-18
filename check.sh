#!/bin/bash
# Demo for test

# test or [] is a bultin which evaluates an expr and return a status(0
# for success, 1 for fail). The return status can be combined with && and ||.
# && means continue until fail, || means continue until succeed.


# 3 -gt 4 return fail, the || will continue until fail.
test 3 -gt 4 || echo "false"
test 4 -gt 3 && echo "true"

# test and [] are the same
[ 3 -gt 4 ] || echo "false"

# test can used to evaluate a lot of expressions. For example...

# arithmetic(integer) test: [-eq, -ne, -lt, -le, -gt, -ge], which means [equal,
# not equal, less than, less than or equal, greater than, greater than or equal
test 4 -gt 3; echo $?

# string comparison: [=, !=, <, >, -z, -n], which means[equal, not equal,
# less than, greater than, is empty, is not empty]. Note that since ">" and "<"
# is used for redirection, they have to be escaped.

test "abc" = "abc"; echo $?
test "abc" != "def"; echo $?
test "abc" \< "def"; echo $?
test "def" \> "abc"; echo $?
test -z ""; echo $?
test -n "abc"; echo $?


# file tests: [-d, -e, -f, -h, -p, -r, -s, -S, -w, -N], see man test
test -f data/check/this_is_a_file; echo $?
test -d data/check/this_is_a_dir; echo $?
test -h data/check/this_is_a_link; echo $?


# We can also combine tests(Note this is different from status combination with
# "&&" and "||", which is used to combine the return status of various tests)
# using [-a, -o, !], which means [logical AND, logical OR, logical inverse].
# "(" and ")" can be used to group expressions to override the default precedence.
# however, they need to be escaped with "\" or "'" or '"'.
test "a" != "$HOME" -a 4 -gt 3; echo $?
# escape with "\"
[ ! \( "a" = "$HOME" -o 3 -gt 4 \) ]; echo $?
# mix the escape operator together is OK but no recommended.
[ ! \( "a" = "$HOME" -o "(" 3 -gt 4 ')' ")" ]; echo $?
#   ---                 ----       ----  ---

# "(())" and "[[]]" are keywords for a more convenient/natural way to make test.

# "(())" evaluates an arithmetic(integer) expression and sets the exit status to 1 if
# the expression evaluates to 0, or to 0 if the expression evaluates to
# a non-zero value. And there is no need to escape '(' and ')'. It also provides
# some powerful syntax like let command provides(like C arithmetic, logical,
# and bitwise operations)

let x=2 y=2**3 z=y*3; echo $? $x $y $z
(( w=(y/x) + ( (~ ++x) & 0x0f) )); echo $? $x $y $w


# "[[]]" allows more natural syntax for filename and string tests. We combine
# the tests in "[[]]" using parentheses and logical operations(&&,||) without
# escaping. Also, it provides wildcard globbing.
[[ "abc def .d,x--" == a[abc]*\ ?d* ]]; echo $?

# Although we can do arithmetic comparison in "[[]]", it's not recommended. Use
# "(())" instead.

# if check the return status(0 for succeed, 1 for failed).


