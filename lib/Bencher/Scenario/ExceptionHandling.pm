package Bencher::Scenario::ExceptionHandling;

use 5.034;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $scenario = {
    summary => 'Benchmark various ways to do exception handling in Perl',
    participants => [
        {
            name => "builtin-try",
            description => <<'MARKDOWN',

Requires perl 5.34+.

MARKDOWN
            code_template => q|use feature 'try'; use experimental 'try'; try { <code_try:raw> } catch($e) { <code_catch:raw> }|,
            # TODO: finally block (in 5.36)
        },

        {
            name => "naive-eval",
            description => <<'MARKDOWN',

MARKDOWN
            code_template => q|eval { <code_try:raw> }; if ($@) { <code_catch:raw> }|,
        },

        {
            name => "eval-localize-die-signal-and-eval-error",
            description => <<'MARKDOWN',

MARKDOWN
            code_template => q|{ local $@; local $SIG{__DIE__}; eval { <code_try:raw> }; if ($@) { <code_catch:raw> } }|,
        },

        {
            name => "Try::Tiny",
            module => 'Try::Tiny',
            description => <<'MARKDOWN',

MARKDOWN
            code_template => q|use Try::Tiny; try { <code_try:raw> } catch { <code_catch:raw> }|,
        },
    ],
    precision => 7,
    datasets => [
        {name=>'empty try, empty catch', args=>{code_try=>'', code_catch=>''}},
        {name=>'die in try, empty catch', args=>{code_try=>'die', code_catch=>''}},
    ],
};

1;
# ABSTRACT:

=head1 DESCRIPTION

Keywords: try-catch, eval, die

TODO: benchmark other try-catch modules.
