package WebService::SendGrid::Newsletter::Schedule;
use utf8;
use Moose;
use MooseX::Method::Signatures;
use JSON::XS;

BEGIN { extends 'WebService::SendGrid::Newsletter'; }

=head1 See SendGrid documentation
See http://docs.sendgrid.com/documentation/api/newsletter-api/schedule/
=cut

method add (Str :$name, Str :$at?, Str :$after?) {
    my %data;
    $data{name} = $name;
    $data{at} = $at if $at;
    $data{after} = $after if $after;

    my $req = $self->_generate_request('/api/newsletter/schedule/add.json', \%data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

method get (Str :$name) {
    my %data;
    $data{name} = $name;

    my $req = $self->_generate_request('/api/newsletter/schedule/get.json', \%data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

method delete (Str :$name) {
    my %data;
    $data{name} = $name;

    my $req = $self->_generate_request('/api/newsletter/schedule/delete.json', \%data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

1;
