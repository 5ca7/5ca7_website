#!/usr/bin/perl
#!/usr/local/bin/perl -Tw
use strict;
use CGI::Pretty qw/:standard/;

use constant TITLE => 'Dice Rolling';
my $_rolls = param('rolls');
my $_sides = param('sides');

my ($rolls) = $_rolls =~ /^(\d+)$/;
my ($sides) = $_sides =~ /^(\d+)$/;

my $show_result = '';

if ($rolls && $sides) {
    my $result = roll_dice($rolls, $sides);
    $show_result = p("${rolls}d${sides} result: $result");
}

sub roll_dice {
    my ($rolls, $sides) = @_;
    my $total = 0;
    $total += roll($sides) for 1 .. $rolls;
    return $total;
}

sub roll {
    my $sides = shift;
    return int(rand($sides)) + 1;
}

print
    header,
    start_html(-title => TITLE),
      h1(TITLE),
      hr,
      $show_result,
      start_form,
        table(
          Tr([
              td(['Number of rolls: ', textfield(-name => 'rolls')]),
          ]),
          Tr([
              td(['Number of sides: ', textfield(-name => 'sides')]),
          ]),
        ),
        submit(-value => 'Roll!'),
      end_form,
      hr,
    end_html;