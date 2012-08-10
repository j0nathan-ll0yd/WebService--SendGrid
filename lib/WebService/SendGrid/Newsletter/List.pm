package WebService::SendGrid::Newsletter::List;
use utf8;
use Moose;
use MooseX::Method::Signatures;
use JSON::XS;

BEGIN { extends 'WebService::SendGrid::Newsletter'; }

=head1 See SendGrid Documentation
See http://docs.sendgrid.com/documentation/api/newsletter-api/lists/

Note that this module is List, not Lists.
=cut

method add (Str :$list, Str :$name?, ArrayRef :$columnname?) {
    my %data;
    $data{list} = $list;
    $data{name} = $name if $name;
    $data{columnname} = $columnname if $columnname;

    my $req = $self->_generate_request('/api/newsletter/lists/add.json', \%data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

method get (Str :$list?) {
    my %data;
    $data{list} = $list if $list;    

    my $req = $self->_generate_request('/api/newsletter/lists/get.json', \%data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

method delete (Str :$list?) {
    my %data;
    $data{list} = $list if $list;    

    my $req = $self->_generate_request('/api/newsletter/lists/delete.json', \%data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

1;
