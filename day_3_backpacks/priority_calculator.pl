#!/usr/bin/perl

use strict;

sub calc_priorities {
    my $priorities = 0;
    my $abc = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    foreach my $val (@_) 
    {
        $priorities += index($abc, $val) + 1;
    }

    return $priorities;
}

sub char_in_other_strings {
    my $origin = shift;
    my @spl = split(undef, $origin);
    my $contains_char = 1;
    foreach my $char (@spl) {
        foreach my $other_string (@_) {
            if (index($other_string, $char) == -1) {
                $contains_char = 0;
            }
        }

        if ($contains_char) {
            return $char;
        }

        $contains_char = 1;
    }


}

my $challenge = $ARGV[0];
unless ($challenge == 1 || $challenge == 2) {
    die 'unknown challenge';
}

my $filename = $ARGV[1];
my @values = ();
my @group = ();

open(FH, '<', $filename) or die $!;
while(<FH>)
{
    if ($challenge == 1) {
        my $first = substr($_, 0 , length($_) / 2);
        my $second = substr($_, length($_) / 2);

        push(@values, char_in_other_strings($first, $second));
    } elsif ($challenge == 2) {
        push(@group, $_);

        if (3 == @group) {
            push(@values, char_in_other_strings(@group));
            @group = ();
        }
    }
}
close(FH);

print calc_priorities(@values);
