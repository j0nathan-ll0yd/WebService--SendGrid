package WebService::SendGrid;
use Moose;
use MooseX::Method::Signatures;

with 'WebService::Dispatcher::Curl';

has 'api_user' => (
  is       => 'rw',
  isa      => 'Str',
  required => 1,
  default  => 'webmaster@lifegames.org'
);
has 'api_key' => (
  is       => 'rw',
  isa      => 'Str',
  required => 1,
  default  => 'b5l2v2v3970f16gJRL80'
);
has 'api_uri' => (is => 'ro', isa => 'Str', default => 'https://sendgrid.com/api/mail.send.json');

1;
