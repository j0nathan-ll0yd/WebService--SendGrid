package WebService::SendGrid::Newsletter::Recipient;
use utf8;
use Moose;
use MooseX::Method::Signatures;
use JSON::XS;

BEGIN { extends 'WebService::SendGrid::Newsletter'; }

=head1 See SendGrid documentation
See http://docs.sendgrid.com/documentation/api/newsletter-api/recipients/

Note that this module is Recipient, not Recipients.

The delete method is untested.
=cut

method add (Str :$name, ArrayRef|Str :$list) {
    my %data;
    $data{name} = $name;
    $data{list} = $list;

    my $req = $self->_generate_request('/api/newsletter/recipients/add.json', \%data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

method get (Str :$name) {
    my %data;
    $data{name} = $name;

    my $req = $self->_generate_request('/api/newsletter/recipients/get.json', \%data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

method delete (Str :$name, ArrayRef|Str :$list) {
    my %data;
    $data{name} = $name;
    $data{list} = $list;

    my $req = $self->_generate_request('/api/newsletter/recipients/delete.json', \%data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

1;
