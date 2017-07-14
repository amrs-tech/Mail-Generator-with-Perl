#!/usr/bin/perl
use strict;
  use warnings;
  use Email::Send;
  use Email::Send::Gmail;
  use Email::Simple::Creator;

use CGI;


# Create the CGI object
my $query = new CGI;

# Output the HTTP header
print $query->header();

# Process form if submitted; otherwise display it
if ( $query->param("submit") )
{
  my $sende = $query->param('fmail');
  my $receiver = $query->param('tmail');
  my $pass = $query->param('pass');
  my $sub = $query->param('sub');
  my $body = $query->param('body');


 
# print $form;

  my $email = Email::Simple->create(
      header => [
          From    => $sende,
          To      => $receiver,
          Subject => $sub,
      ],
      body => $body,

  );

  my $sender = Email::Send->new(
      {   mailer      => 'Gmail',
          mailer_args => [
              username => $sende,
              password => $pass,
          ]
      }
  );
  eval { $sender->send($email) };
  die "Error sending email: $@" if $@;
  print "<br><b>Email Sent !</b><br>";
  print "<br>";
  print "<a href = '/sample.html'>Click here to go to Form page</a>";
}

else
{
  print "Error !";
}